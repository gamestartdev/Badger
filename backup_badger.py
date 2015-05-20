import subprocess, os, time
get_url = "meteor mongo --url badger.gamestartschool.org"
result = subprocess.check_output(get_url, stdin=subprocess.PIPE, shell=True)
result 				= result.replace("mongodb://", "")
user, result 		= result.split(":", 1)
password, result 	= result.split("@", 1)
host, database 		= result.split("/", 1)

dump = "mongodump -u %s -p %s -h %s -d %s" % (user, password, host, database)
restore = "mongorestore -u %s -p %s -h %s -d %s %s" % (user, password, host, database, database)

print dump
subprocess.check_output(dump, stdin=subprocess.PIPE, shell=True)

# print restore
# subprocess.check_output(restore, stdin=subprocess.PIPE, shell=True)
