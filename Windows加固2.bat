
@echo off

chcp 936

echo TANOVO-CHECK>%~dp0\JianCha@1.txt

echo  ---user list status--- >>%~dp0\JianCha@1.txt
net user & net localgroup administrators >>%~dp0\JianCha@1.txt

echo.>>%~dp0\JianCha@1.txt
echo ---------------------------------passowrd policy----------------------- >>%~dp0\JianCha@1.txt
net accounts>>%~dp0\JianCha@1.txt

echo.>>%~dp0\JianCha@1.txt
echo ---------------------------------share------------------------------->>%~dp0\JianCha@1.txt
net share>>%~dp0\JianCha@1.txt

REM XP系统不支持
echo ---------------------------------hotfix InstalledOn--------------------------->>%~dp0\JianCha@1.txt
wmic qfe get hotfixid,InstalledOn,InstalledBy>>%~dp0\JianCha@1.txt

REM REM XP系统使用
REM echo ---------------------------------hotfix InstalledOn--------------------------->>%~dp0\JianCha@1.txt
REM wmic qfe >>%~dp0\JianCha@1.txt


echo ---------------------------------port LISTEN---------------------------------->>%~dp0\JianCha@1.txt
netstat -ano | find "LISTEN">>%~dp0\JianCha@1.txt

echo ---------------------------------system policy-------------------------------->>%~dp0\JianCha@1.txt
Auditpol.exe /get /category:*>>%~dp0\JianCha@1.txt

REM 英文版本
echo ---------------------------------user,password Expired------------------------
echo administrator's user,password   
net user administrator|find "expires" 
echo guest's user,password
net user guest|find "expires"
REM 英文版本
echo ---------------------------------user active----------------------------------
echo administrator's status
net user administrator|find "active"
echo guest's status
net user guest|find "active"

REM REM 中文版本
REM echo ---------------------------------user,password Expired------------------------>>%~dp0\JianCha@1.txt
REM echo administrator's user,password>>%~dp0\JianCha@1.txt
REM net user administrator|find "到期" >>%~dp0\JianCha@1.txt
REM echo guest's user,password>>%~dp0\JianCha@1.txt
REM net user guest|find "到期">>%~dp0\JianCha@1.txt
REM REM 中文版本
REM echo ---------------------------------user active---------------------------------->>%~dp0\JianCha@1.txt
REM echo administrator's status>>%~dp0\JianCha@1.txt
REM net user administrator|find "启用">>%~dp0\JianCha@1.txt
REM echo guest's status>>%~dp0\JianCha@1.txt
REM net user guest|find "启用">>%~dp0\JianCha@1.txt

echo ---------------------------------system install------------------------------->>%~dp0\JianCha@1.txt
systeminfo|find "OS">>%~dp0\JianCha@1.txt

echo ---------------------------------service-------------------------------------->>%~dp0\JianCha@1.txt
net start>>%~dp0\JianCha@1.txt

echo ---------------------------------screen_Saver--------------------------------->>%~dp0\JianCha@1.txt
echo if screensaveractive == 1 , screen_Saver is active>>%~dp0\JianCha@1.txt
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaveaAtive>>%~dp0\JianCha@1.txt
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaverIsSecure>>%~dp0\JianCha@1.txt
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaveTimeOut>>%~dp0\JianCha@1.txt

secedit /export /cfg LocalGroupPolicy&type LocalGroupPolicy >>%~dp0\JianCha@1.txt


echo -----firewall-in-rules----- >>%~dp0\JianCha@1.txt
netsh advfirewall firewall show rule name=all dir=in type=dynamic status=enabled >>%~dp0\JianCha@1.txt
echo -----firewall-out-rules----- >>%~dp0\JianCha@1.txt
netsh advfirewall firewall show rule name=all dir=out type=dynamic status=enabled >>%~dp0\JianCha@1.txt


pause
