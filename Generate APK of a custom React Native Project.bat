echo off
call del android\app\src\main\assets\index.android.*
REM call rmdir /S /Q "android\app\src\main\res\drawable-*"
REM call for /d %G in ("android\app\src\main\res\drawable-*") do rd /s /q "%~G"
call cd android
call gradlew clean
call cd ..
react-native bundle --platform android --dev false --entry-file index.js --bundle-output android\app\src\main\assets\index.android.bundle --assets-dest android\app\src\main\res
call cd android
gradlew assembleRelease
cmd /k echo "generated apk in: android\app\build\outputs\apk\debug\"


