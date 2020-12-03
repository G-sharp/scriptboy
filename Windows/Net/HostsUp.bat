echo off
REM HostsUp, a tool to update hosts
REM Author: Gsharp
REM Date: 2020-12-03

set hosts= %SystemRoot%\System32\drivers\etc\hosts
set hostsback= %SystemRoot%\System32\drivers\etc\hosts_backup
set outfile= %hosts%
:entrypoint
    cls
    set choice=""
	echo *************************************
	echo *      Welcome to HostsUp v1.0      
	echo *           Author:Gsharp           
	echo * Choose What you want:             
	echo *	I: Insert one rule               
	echo *	R: Recovery the hosts            
    echo *	P: Print the newest hosts        
    echo *	B: Backup the hosts	             
	echo *	PB:Print the backup hosts        
	echo *	F  Flush Dns  
 	echo *	Q: Exit                          
	echo *************************************
	set /p choice= Your choice: 
    if %choice% == I  goto reinput
    if %choice% == R  call :recovery
    if %choice% == P  (set outfile=%hosts% 
	call :print)
    if %choice% == B  call :backup
    if %choice% == F  call :flush
    if %choice% == PB (set outfile=%hostsback% 
	call :print)
    if %choice% == Q  goto end
pause
goto entrypoint
:flush
ipconfig /flushdns
if ERRORLEVEL 0 echo Flush success!
goto :eof
:print
    cls
	echo Print %outfile% as follow:
	echo -------------------------------
	type %outfile%
goto :eof

:recovery
	xcopy /Y %hostsback% %hosts%
    if ERRORLEVEL 0 echo success recovery
goto :eof

:confirm 
    set msg=
	set /p msg= Confirm please: Server=%Server% Ip=%Ip% (Y/N)?
	if %msg% == Y goto writein
	if %msg% == y goto writein
	if %msg% == "" goto writein
	goto reinput

:reinput
    echo input your rule:
	set /p Server=Server: 
	set /p Ip=IP: 
	goto confirm

:writein
	set /p confirm=Write in (Y/N)?
	if not %confirm% == Y goto reinput
	call :backup
	echo %Ip%  %Server%  | tee >> %hosts%
    if ERRORLEVEL 0 echo write success!
	pause > null
	goto entrypoint

:backup 
    xcopy /Y %hosts% %hostsback%
	if ERRORLEVEL 0 echo backup success! hosts to %hostsback% 
goto :eof

:end
	echo Bye!
	pause
