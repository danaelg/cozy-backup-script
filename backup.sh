#!/bin/bash
#version : 2.4

FOLDER= #ADD YOUR OWN BACKUP FOLDER

#Starting backup
cozy_management backup

#Mounting the backup folder
mount $FOLDER

#moving the backup archive to backup folder
mv /var/lib/cozy/backups/cozy-$(date +%Y-%m-%d-)* $FOLDER

#Every 25th day of the month, it remove old backups (of the last month) to free up some storage
if [ $(date +%d) -ge 25 ]; then #If it is the 25th day or later
    VAR=$(date +%m) #Get the today's date into a variable

        case $VAR in
                01 ) #If it is january
                        VAR=$(date +%Y) #We get the today's year to decrement it by 1 (because if it's january 2017 we want to delete backups from decembre 2016)
                        VAR="$((10#$VAR - 1))-12"
                        rm $FOLDER/cozy-$VAR\-*
                        ;;

                02 | 03 | 04 | 05 | 06 | 07 | 08 | 09 | 10 ) #Case of the month which begin with a 0. We include october because, if we are on October (10) we want to delete backups from September (09)
                        VAR=$((10#$VAR - 1)) #removing the 0 of the month to decrement by one
                        VAR=0$VAR #we put back the 0
                        rm $FOLDER/cozy-$(date +%Y-)$VAR\-* #Deletion of the backups
                        ;;

                11 | 12 ) #The other cases
                        VAR=$((10#$VAR - 1)) #Decrement the month by one
                        rm $FOLDER/cozy-$(date +%Y-)$VAR\-* #Deletion of the backups
                        ;;

               * ) #In case something goes wrong
                        echo "ERROR ! The deletion of old cozy backups didn't work"
                        exit 100;
                        ;;
        esac
fi

#unmounting backup folder
umount $FOLDER

#End
exit 0;
