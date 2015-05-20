import subprocess, os, time
get_url = "meteor mongo --url badger.gamestartschool.org"
result = subprocess.check_output(get_url, stdin=subprocess.PIPE, shell=True)
result 				= result.replace("mongodb://", "")
user, result 		= result.split(":", 1)
password, result 	= result.split("@", 1)
host, database 		= result.split("/", 1)

dump = "mongodump -u %s -p %s -h %s -d %s /bu" % (user, password, host, database)
print dump
subprocess.check_output(dump, stdin=subprocess.PIPE, shell=True)

#restore = "mongorestore -u client -h c0.meteor.m0.mongolayer.com:27017 -d myapp_meteor_com -p 'password' folder/"