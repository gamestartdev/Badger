from os.path import join, expanduser
home = expanduser("~")
out = join(home, "dump2")

import subprocess, os, time
get_url = "meteor mongo --url badger.gamestartschool.org"
result = subprocess.check_output(get_url, stdin=subprocess.PIPE, shell=True)
result 				= result.replace("mongodb://", "")
user, result 		= result.split(":", 1)
password, result 	= result.split("@", 1)
host, database 		= result.split("/", 1)

dump = "mongodump -u %s -p %s -h %s -d %s -o %s" % (user, password, host, database.strip(), out)
localDump = "mongodump -h localhost:3001 -d meteor -o %s" % (out)

restore = "mongorestore -u %s -p %s -h %s -d %s --drop %s\\%s" % (user, password, host, database.strip(), out, database.strip())
localRestore = "mongorestore -h localhost:3001 -d meteor --drop %s/badger_gamestartschool_org" % (out)


#print dump
#subprocess.check_output(dump, stdin=subprocess.PIPE, shell=True)

subprocess.check_output(localRestore, stdin=subprocess.PIPE, shell=True)
