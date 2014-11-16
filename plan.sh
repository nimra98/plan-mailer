#! /bin/bash

### CONFIG ###
URL="http://fsg-preetz.de/downloads/protected/vertretungsplan.html"
CLASS="Q1B"
TMP="plan.tmp"
OLD="plan.old"
SUBJECT="Neuer Eintrag im Vertretungsplan!\nContent-Type: text/html"
MAIL="anton.bracke.com@gmail.com"
##############

wget "$URL" -q -O "$TMP"

ENTRY=$(grep -i "$CLASS" "$TMP")

if grep -q -i "$CLASS" "$TMP"
then
	echo "found"
	DAY=$(cat $TMP | grep "<p class=\"Titel\">")
	DAY=$(echo $DAY | tr -d '\n')
	echo "day: $DAY"
	echo "entry: $ENTRY"
    # code if found
	if grep -q -i "$DAY :-:-: $ENTRY" "$OLD"
	then
		echo "already mailed!"
	else
		echo $ENTRY | mail -s "$SUBJECT" "$MAIL"
		#wget http://google.de -q -O /dev/null > /dev/null >2 /dev/null
		echo "$DAY :-:-: $ENTRY" >> "$OLD"
		echo "mailed new entry!"
	fi
fi
rm "$TMP"

