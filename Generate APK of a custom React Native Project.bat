@echo off
:: echo %ERRORLEVEL%
for /D %%p in ("android\app\src\main\res\drawable-*") do (
  rmdir "%%p" /Q /S
)
:: SOURCE1: https://superuser.com/questions/691072/delete-several-directories-with-a-common-prefix-at-the-command-prompt
:: SOURCE2: https://stackoverflow.com/questions/2591758/batch-script-loop

cd android
call gradlew clean
:: echo %ERRORLEVEL%
:: 'call' proceeds with next command, if the current one fails with any error.
cd ..

:: TO RESOLVE: Release APK Not Updating With JavaScript Code:
:: SOURCE: https://stackoverflow.com/questions/45441217/release-apk-not-updating-with-javascript-code
:: del android\app\src\main\assets\index.android.*
:: start cmd /c react-native bundle --platform android --dev false --entry-file index.js --bundle-output android\app\src\main\assets\index.android.bundle --assets-dest android\app\src\main\res

cd android
:: SOURCE: https://stackoverflow.com/questions/1164049/batch-files-error-handling
call gradlew assembleRelease
cd ..

echo generated apk in: 
echo android/app/build/outputs/apk/debug/
echo OR
cmd /k echo android/app/build/outputs/apk/release/app-release.apk
:: TODO: https://stackoverflow.com/questions/2048509/how-to-echo-with-different-colors-in-the-windows-command-line
:: cmd /k echo "Error in gradlew assembleRelease!"
