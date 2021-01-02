@echo off
title gclone-mod-1.1 is the best, batch file edited by Tomyummmm, original by RoshanConnor Yo yo

color 0b
echo Hey Sexy! Wanna clone some TBs?
echo This version uses gclone-mod-1.1, updated and maintained by me (Tomyummmm) here: https://github.com/tomyummmm/gclone
echo ----------------------------------------------------------------------------------------------------------------------
echo Configured Team Drives
gclone-mod-1.1 listremotes
echo ----------------------------------------------------------------------------------------------------------------------
echo off


:menu
echo.
echo 1) COPY - Copy files from source to dest, skipping already copied.
echo 2) MOVE - Move files from source to dest.
echo 3) SYNC - Make source and dest identical, modifying destination only.
echo 4) SIZE - Return the total size and number of objects in remote:path.
echo 5) CHECK - Check if the files in the source and destination match.
echo 6) LIST
echo 7) DELETE / PURGE - Remove path / contents.
echo 8) DEDUPE - Interactively find duplicate files and delete/rename them.
echo 9) REMOVE EMPTY FOLDERS
echo 10) EMPTY TRASH
echo N) NCDU - Explore a remote with a text based user interface.
echo M) MD5SUM - Produces an md5sum file for all the objects in the path.
echo C) CONFIG - Enter an interactive configuration session.
echo A) ADVANCED - For experienced users only, command line.
echo Q) EXIT
echo.
set /P option="Choose your Mode: "
if %option% == 1 (goto copy)
if %option% == 2 (goto move)
if %option% == 3 (goto sync)
if %option% == 4 (goto size)
if %option% == 5 (goto check)
if %option% == 6 (goto list)
if %option% == 7 (goto delete)
if %option% == 8 (goto dedp)
if %option% == 9 (goto rmdi)
if %option% == 10 (goto empt)
if /I %option% == N (goto ncdu)
if /I %option% == M (goto md5)
if /I %option% == C (goto config)
if /I %option% == A (goto adv)
if /I %option% == Q (EXIT)
echo Invalid input!
goto menu
echo.


:copy
echo.
set /P src="[Enter Source Folder / TeamDrive] "
echo ----------------------------------------------------------------------------------------------------------------------
set /P dst="[Enter Destination Folder / TeamDrive] "
gclone-mod-1.1 copy %src% %dst% --transfers 50 --tpslimit-burst 50 --checkers 10 -vP --stats-one-line --stats=10s --ignore-existing --drive-server-side-across-configs --drive-chunk-size 128M --drive-acknowledge-abuse --drive-keep-revision-forever --fast-list
echo.
pause
goto menu



:move
echo.
set /P src="[Enter Source Folder / TeamDrive] "
echo ----------------------------------------------------------------------------------------------------------------------
set /P dst="[Enter Destination Folder / TeamDrive] "
gclone-mod-1.1 move %src% %dst% --transfers 50 --tpslimit-burst 50 --checkers 10 -vP --stats-one-line --stats=10s --ignore-existing --drive-server-side-across-configs --drive-chunk-size 128M --drive-acknowledge-abuse --drive-keep-revision-forever --fast-list
echo.
pause
goto menu


:sync
echo.
set /P src="[Enter Source Folder / TeamDrive] "
echo ----------------------------------------------------------------------------------------------------------------------
set /P dst="[Enter Destination Folder / TeamDrive] "
gclone-mod-1.1 sync %src% %dst% --transfers 50 --tpslimit-burst 50 --checkers 10 -vP --stats-one-line --stats=10s --drive-server-side-across-configs --drive-chunk-size 128M --drive-acknowledge-abuse --drive-keep-revision-forever --fast-list
echo.
pause
goto menu


:check
echo.
echo 1) size         Only compare the sizes, not the hashes as well. Use this for a quick check.
echo 2) default      Compares sizes and hashes (MD5 or SHA1) and logs a report of files which don't match. Very slow.
echo 3) download     Download the data from both remotes and check them against each other on the fly. This can be useful for remotes that don't support hashes or if you really want to check all the data.
echo.
set /P checktype="Type of Check? "
set /P src="[Enter Source Folder / TeamDrive] "
echo ----------------------------------------------------------------------------------------------------------------------
set /P dst="[Enter Destination Folder / TeamDrive] "
if %checktype% == 1 (gclone-mod-1.1 check %src% %dst% -P --drive-server-side-across-configs --fast-list --size-only)
if %checktype% == 2 (gclone-mod-1.1 check %src% %dst% -P --drive-server-side-across-configs --fast-list)
if %checktype% == 3 (gclone-mod-1.1 check %src% %dst% -P --drive-server-side-across-configs --fast-list --download)
echo.
pause
goto menu


:size
echo.
set /P src="[Enter Folder / TeamDrive] "
gclone-mod-1.1 size %src% --fast-list
echo.
pause
goto menu


:list
echo.
echo ----------------------------------------------------------------------------------------------------------------------
echo Configured Team Drives
gclone-mod-1.1 listremotes
echo ----------------------------------------------------------------------------------------------------------------------
echo.
echo 1) ls           List the objects in the path with size and path.
echo 2) lsd          List all directories/containers/buckets in the path.
echo 3) lsf          List directories and objects in remote:path formatted for parsing
echo 4) lsjson       List directories and objects in the path in JSON format.
echo 5) lsl          List the objects in path with modification time, size and path.
echo 6) tree         List the contents of the remote in a tree like fashion.
echo Q) Return to menu
echo.
set /P listtype="Type of List? "
if /I %listtype% == Q (goto menu)
set /P remote="[Enter Folder / TeamDrive] "
echo.
if %listtype% == 1 (gclone-mod-1.1 ls %remote%)
if %listtype% == 2 (gclone-mod-1.1 lsd %remote%)
if %listtype% == 3 (gclone-mod-1.1 lsf %remote%)
if %listtype% == 4 (gclone-mod-1.1 lsjson %remote%)
if %listtype% == 5 (gclone-mod-1.1 lsl %remote%)
if %listtype% == 6 (gclone-mod-1.1 tree %remote%)
echo.
pause
goto menu


:delete
echo.
echo 1) delete          Remove the contents of path.
echo 2) deletefile      Remove a single file from remote.
echo 3) purge           Remove the path and all of its contents.
echo.
set /P deletetype="Type of Delete? "
set /P remote="[Enter Folder / TeamDrive] "
echo.
if %deletetype% == 1 (gclone-mod-1.1 delete %remote% -vP --stats-one-line --stats=15s --fast-list)
if %deletetype% == 2 (gclone-mod-1.1 deletefile %remote% -vP --stats-one-line --stats=15s --fast-list)
if %deletetype% == 3 (gclone-mod-1.1 purge %remote% -vP --stats-one-line --stats=15s --fast-list)
echo.
pause
goto menu


:dedp
echo.
set /P src="[Enter Folder / TeamDrive] "
set /P choice="Do you want to do a dry run? (y/n) "
if /I %choice%==y (goto drd)
if /I %choice%==n (goto nodrd)
echo.


:drd
echo ----------------------------------------------------------------------------------------------------------------------
gclone-mod-1.1 dedupe --dedupe-mode newest %src% -v --dry-run --fast-list
echo ----------------------------------------------------------------------------------------------------------------------
echo off
echo.
set /P choice="Proceed with Dedupe? (y/n) "
if /I %choice%==y (goto nodrd)
if /I %choice%==n (goto menu)
echo.



:nodrd
echo ----------------------------------------------------------------------------------------------------------------------
set /P choice="Do you want to PERMANENTLY delete the duplicates? (y - Permanent / n - Send to trash bin) "
if /I %choice%==y (gclone-mod-1.1 dedupe --dedupe-mode newest %src% -v --drive-use-trash=false --fast-list)
if /I %choice%==n (gclone-mod-1.1 dedupe --dedupe-mode newest %src% -v --fast-list)
echo.
pause
goto menu


:rmdi
echo.
set /P src="[Enter Folder / TeamDrive] "
set /P choice="Do you want to do a dry run? (y/n) "
if /I %choice%==y (goto drr)
if /I %choice%==n (goto nodrr)
echo.


:drr
echo ----------------------------------------------------------------------------------------------------------------------
gclone-mod-1.1 rmdirs %src% -v --fast-list --dry-run
echo ----------------------------------------------------------------------------------------------------------------------
echo off
echo.
set /P choice="Proceed with Removal of Empty Folders? (y/n) "
if /I %choice%==y (goto nodrr)
if /I %choice%==n (goto menu)
echo.


:nodrr
echo ----------------------------------------------------------------------------------------------------------------------
set /P choice=Do you want to PERMANENTLY delete empty folders? (y - Permanent / n - Send to trash bin)
if /I %choice%==y (gclone-mod-1.1 rmdirs %src% -v --drive-use-trash=false --fast-list)
if /I %choice%==n (gclone-mod-1.1 rmdirs %src% -v --fast-list)
echo.
pause
goto menu


:empt
echo.
set /P src="[Enter TeamDrive ID] "
echo ----------------------------------------------------------------------------------------------------------------------
set /P choice="Do you want to do a dry run? (y/n) "
if /I %choice%==y (goto emptdr)
if /I %choice%==n (goto emptnodr)


:emptdr
echo ----------------------------------------------------------------------------------------------------------------------
gclone-mod-1.1 delete %src% -vP --drive-trashed-only --drive-use-trash=false --fast-list --dry-run
echo ----------------------------------------------------------------------------------------------------------------------
echo off
echo.
set /P choice="Proceed to empty trash? (y/n) "
if /I %choice%==y (goto emptnodr)
if /I %choice%==n (goto menu)


:emptnodr
set /P choice="Are you sure? (y/n) "
if /I %choice%==y (gclone-mod-1.1 delete %src% -vP --drive-trashed-only --drive-use-trash=false --fast-list)
if /I %choice%==n (goto menu)
echo.
pause
goto menu

:ncdu
echo.
set /P src="[Enter Folder / TeamDrive] "
echo ----------------------------------------------------------------------------------------------------------------------
gclone-mod-1.1 ncdu %src% --fast-list
echo ----------------------------------------------------------------------------------------------------------------------
echo.
goto menu


:md5
echo.
echo ----------------------------------------------------------------------------------------------------------------------
set /P remote="[Enter Folder / TeamDrive] "
echo.
gclone-mod-1.1 md5sum %remote% --fast-list
echo ----------------------------------------------------------------------------------------------------------------------
echo.
pause
goto menu


:config
echo.
echo ----------------------------------------------------------------------------------------------------------------------
gclone-mod-1.1 config
echo ----------------------------------------------------------------------------------------------------------------------
echo.
goto menu

:adv
echo.
echo ----------------------------------------------------------------------------------------------------------------------
echo Command line interface for gclone-mod-1.1
echo Enter your commands and flags, gclone-mod-1.1 is automatically typed for you. e.g. --help OR ls remote:
echo Enter Q to return to menu.
echo.
set /P choice="Command / flags: "
if /I %choice% == Q (goto menu)
echo.
gclone-mod-1.1 %choice%
echo.
goto adv