REM --- Move to this scripts location ---
pushd "%~dp0"

REM --- Print out environment variables for debugging ---
set

REM --- Ensure the VC_redist is installed for the Microsoft.Skype.Bots.Media Library ---
.\VC_redist.x64.exe /quiet /norestart

REM --- Delete existing certificate bindings and URL ACL registrations ---
netsh http delete sslcert ipport=0.0.0.0:9555
netsh http delete sslcert ipport=0.0.0.0:8555
netsh http delete urlacl url=https://+:8555/
netsh http delete urlacl url=https://+:9555/

REM --- Add new URL ACLs and certificate bindings ---
netsh http add urlacl url=https://+:8555/ sddl=D:(A;;GX;;;S-1-1-0)
netsh http add urlacl url=https://+:9555/ sddl=D:(A;;GX;;;S-1-1-0)
netsh http add sslcert ipport=0.0.0.0:9555 certhash=c8dc096b7f3a329d8967e61fe81cd137690ee9f4 appid={0d735ff4-9660-43e9-ae56-c1c05eda00b2}
netsh http add sslcert ipport=0.0.0.0:8555 certhash=c8dc096b7f3a329d8967e61fe81cd137690ee9f4 appid={0d735ff4-9660-43e9-ae56-c1c05eda00b2}

popd
exit /b 0