#!/bin/bash
#### Version 1.2
#### Message users to let them know they have updates waiting to install. Scope to smart group XX.
#### Will Pierce
#### January 14, 2015
#### Requirements
#### jamfHelper

## Create a log file for trouble shooting 
LOGFILE="$HOME/Library/Logs/RestartUpdateNeeded.log"
echo "------------------------------------------------------------" >> $LOGFILE
#Get the date and set it to variable the_date
the_date=`date "+%Y-%m-%d %r"`
# enter the date to the log file
echo "$the_date" >> $LOGFILE

## Var for the last time user restarted and hit yes, so we can show it to user
lastRestartUpdate=`defaults read /Library/Preferences/com.cm.imaging UpdatesRunDate`
## Check to see that it has run before 
if [[ '$lastRestartUpdate' != "The domain/default pair of (/Library/Preferences/com.cm.imaging, UpdatesRunDate) does not exist" ]]; then
   echo "Last restart update is unknown" >> $LOGFILE
   lastRestartUpdate='unknown'
else
lastRestartUpdate="$lastRestartUpdate"
   echo "Last restart update was $lastRestartUpdate" >> $LOGFILE
fi
echo "" >> $LOGFILE

## Create a variable for Apple update command. 86 the lines we dont need.
appleUpdates=`softwareupdate -l | tail -n+6 |  sed -e 's/^[ \t]*//' | sed '/^*/ d' | sed 's/[[:space:]]//g'`

## If there are no Apple updates then create new variable for noau set to No apple updates
if [ "$appleUpdates" == "" ];then
noau="No Apple Updates" 
echo "No Apple Updates" >> $LOGFILE
## If there are Apple updates set variable noau to nothing
else
noau=""
echo "----- Apple Updates: 
$appleUpdates" >> $LOGFILE
fi
echo "" >> $LOGFILE
## Check for JAMF waiting room, if so create variable for geting the results of waiting room command
if [ -d /Library/Application\ Support/JAMF/Waiting\ Room ];then
JAMF_WaitingRoom=`/bin/ls -1 /Library/Application\ Support/JAMF/Waiting\ Room/ 2> /dev/null | /usr/bin/grep -v ".cache.xml"`
echo "----- Waiting Room: 
$JAMF_WaitingRoom" >> $LOGFILE
fi
## If nothing in the waiting room create variable for no set it to No updates
if [ "$JAMF_WaitingRoom" == "" ];then
no="No updates"
echo "Nothing in the waiting room. No 3rd party updates" >> $LOGFILE
## if we have something in the waiting room set variable no to nothing
else
no=""
fi

echo "" >> $LOGFILE
################################################
# Create a JAMF Helper window
jhPath="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"

icon_folder="/Library/User Pictures"
logo_K="CM_Square.png"

## PREP MESSAGE

title="Important Action Required. Restart and click yes to finish installing important updates."
#heading="Important Action Required"

###### description
descrip="Available updates:
$JAMF_WaitingRoom
$appleUpdates

Mac OS can’t install updates while the system is running. Today at your convenience, please save your work, quit all applications, click the Apple icon in the top left of your screen & choose Restart, click yes when prompted. 

Your last restart & update was: $lastRestartUpdate
Best practice is to restart and click yes once a week.
You will get this message once a day until you do. 
If you have questions please contact the helpdesk.
EXT 6400 or helpdesk@collemcvoy.com

Thank you.
"
button_value="OK"

###### end description
# "$jhPath" -startlaunchd -windowType hud -title "$title" -heading "$heading" -description "$descrip" -button1 "I Understand" -lockHUD -icon "$icon_folder/$logo_K"

response=`"$jhPath" -startlaunchd -windowType hud -title "$title" -description "$descrip" -button1 "I Understand" -lockHUD -icon "$icon_folder/$logo_K"`
if [ $response == 0 ];then
echo "User clicked \"I Understand\"" >> $LOGFILE
else
echo "User closed window." >> $LOGFILE
fi

# Script spacer - adds a line of ------ to the end of the log session
## echo "------------------------------------------------------------" >> $LOGFILE
echo "" >> $LOGFILE

exit 0