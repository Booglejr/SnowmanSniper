mkdir .\build
cd .\src
powershell Compress-Archive -Path . -DestinationPath ..\build\SnowmanSniper.love
cd ..
copy .\build_extras\win32\love.exe .\build\love.exe 
cd .\build
copy /b love.exe+SnowmanSniper.love "SnowmanSniper.exe"
del love.exe
cd ..
move .\build\SnowmanSniper.exe .\build_extras\win32\SnowmanSniper.exe
cd .\build_extras\win32
powershell Compress-Archive -Path . -DestinationPath ..\..\build\SnowmanSniper-win32.zip
