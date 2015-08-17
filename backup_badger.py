from datetime import datetime
from os.path import join, expanduser
home = expanduser("~")

time_string = str(datetime.now()).replace(" ", "_").replace(":", ".")
#out = join(home, "badger_backups/badger_backups_"+ time_string)
out = join(home, "Badger/backups/backup_"+ time_string)

import subprocess, os, time
get_url = "meteor mongo --url badger.gamestartschool.org"
print "Getting credentials for backup: " + out
result = subprocess.check_output(get_url, stdin=subprocess.PIPE, shell=True)
result 				= result.replace("mongodb://", "")
user, result 		= result.split(":", 1)
password, result 	= result.split("@", 1)
host, database 		= result.split("/", 1)

#remoteDump = 'mongodump -u %s -p %s -h %s -d %s -o "%s"' % (user, password, host, database.strip(), out)
localDump = "mongodump -h localhost:3001 -d meteor -o %s" % (out)
#DANGER# restore = "mongorestore -u %s -p %s -h %s -d %s --drop %s\\%s" % (user, password, host, database.strip(), out, database.strip())
#localRestore = 'mongorestore -h localhost:3001 -d meteor --drop C:/Users/gamestart/Badger/backups/backup_2015-08-12_21.00.06.128000/meteor'


subprocess.check_output(localDump, stdin=subprocess.PIPE, shell=True)
print "Complete."