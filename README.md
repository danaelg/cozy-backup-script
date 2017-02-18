# cozy-backup-script
A bash script that use cozy_management backup to backup the whole database of cozy V2 and move it into a backup folder 
and finaly remove old backup from backup folder

## How does it work ?
This script use cozy_management tool you can install on your cozy server : https://github.com/cozy/python_cozy_management <br>
It uses `cozy_management backup` command which create an archive of the whole database of your cozy (with applications's data, 
calendar etc...)
After created the archive the script move it (and not copy) into a backup folder declared in the `FOLDER` variable.
Finaly it removes backups from the last month as of the 25th day of the month by checking the date with the `date` command

##How to use it ?
* You need to have cozy_management installed on your server, if you don't, check the repo : https://github.com/cozy/python_cozy_management
* Change the `FOLDER` variable in the first line of the script

##FAQ
* I don't want to remove old backups, I want to keep EVERY backup how to do it ?
  > just remove the if loop from if (l. 17) to fi (l. 43)

* Why wait to the 25th day of the month to remove backups instead of always remove the oldest backup (for example it's 1st February,
so you remove the backup of the 1st January)

  >The script was upagraded according to my needs so I start to create a backup archive every day, then I added to moving command
and finaly a needed to remove old backup, so I created this system which works very well. Maybe one day I will change the
system, but it's not expected for now

* Cozy team is developping cozy V3, what your script will become ?
  >As soon as cozy v3 is available and stable for self-hosting I will update the script. But as I don't know how cozy v3 will work
  I have no idea how to do the same script with this new version. Wait and see

## What is Cozy?

![Cozy Logo](https://raw.github.com/cozy/cozy-setup/gh-pages/assets/images/happycloud.png)

[Cozy](http://cozy.io) is a platform that brings all your web services in the
same private space.  With it, your web apps and your devices can share data
easily, providing you with a new experience. You can install Cozy on your own
hardware where no one profiles you.

## Community

You can reach the Cozy Community by:

* Chatting with us on IRC #cozycloud on irc.freenode.net
* Posting on our [Forum](https://forum.cozy.io/)
* Posting issues on the [Github repos](https://github.com/cozy/)
* Mentioning us on [Twitter](http://twitter.com/mycozycloud)
