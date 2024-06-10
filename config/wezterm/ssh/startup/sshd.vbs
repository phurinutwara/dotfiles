Set wshell=wscript.createobject("wscript.shell")
wshell.run "C:\Windows\System32\wsl.exe",0
wshell.run "C:\Windows\System32\wsl.exe  -c 'sudo /usr/sbin/service ssh start'",0
Set wshell=Nothing