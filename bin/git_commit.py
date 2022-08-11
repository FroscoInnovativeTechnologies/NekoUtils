#!usr/bin/python3
import subprocess

def runc(cmd):
	return subprocess.getoutput(cmd)

files = input("Files to commit> ")
message = input("Commit -m> ")

runc(f"git add {files}")
runc(f"git commit -m '{message}'")
runc("git push")
