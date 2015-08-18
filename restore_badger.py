import subprocess, os, time
localRestore = 'mongorestore -h localhost:3001 -d meteor --drop C:/Users/gamestart/Badger/backups/backup_2015-08-17_15.36.32.137000/meteor'
subprocess.check_output(localRestore, stdin=subprocess.PIPE, shell=True)
print "Complete."