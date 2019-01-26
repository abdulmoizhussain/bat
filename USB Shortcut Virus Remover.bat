REM << comments a line in batch files.
:: <<  Also comments a line in batch files.

echo off
set /p id=Enter USB drive letter:
attrib -h -r -s /s /d %id%:\*.*
