REM SOOURCE:
REM https://developer.android.com/studio/run/emulator-commandline
REM to list all the available emulators.
REM %LocalAppData%\Android\Sdk\emulator\emulator -list-avds

%LocalAppData%\Android\Sdk\emulator\emulator -avd Nexus_5X_API_30
OR
cmd /k %USERPROFILE%\AppData\Local\Android\Sdk\emulator\emulator -avd Pixel_2_API_30 -netdelay none -netspeed full -gpu host

@REM -gpu auto|host (hardware) | angle_indirect (software, Windows only, uses DirectX instead of OpenGL) | swiftshader_indirect (software) | guest (lowest performance)
@REM https://developer.android.com/studio/run/emulator-acceleration#accel-graphics

