case $1 in
    "prd")
        case $2 in
            "css")
                start "" "%SYSTEMDRIVE%\Program Files\Git\git-bash.exe" -i -l -c "cd scss; echo 'Running on: '; pwd; echo 'Deleting [css/dist] ...'; rm -Rf ../css/dist; compass compile --output-style=compressed; exec bash"
            ;;
            "js")
                start "" "%SYSTEMDRIVE%\Program Files\Git\git-bash.exe" -i -l -c "echo 'Running on: '; pwd; echo 'Deleting [js/dist] ...'; rm -Rf js/dist; grunt --env=prod; exec bash"
            ;;
            *)
                start "" "%SYSTEMDRIVE%\Program Files\Git\git-bash.exe" -i -l -c "cd scss; echo 'Running on: '; pwd; echo 'Deleting [css/dist] ...'; rm -Rf ../css/dist; compass compile --output-style=compressed; exec bash"
                start "" "%SYSTEMDRIVE%\Program Files\Git\git-bash.exe" -i -l -c "echo 'Running on: '; pwd; echo 'Deleting [js/dist] ...'; rm -Rf js/dist; grunt --env=prod; exec bash"
            ;;
        esac
    ;;
    *) 
        case $1 in
            "css")
                start "" "%SYSTEMDRIVE%\Program Files\Git\git-bash.exe" -i -l -c "cd scss; echo 'Running on: '; pwd; compass watch; exec bash"
            ;;
            "js")
                start "" "%SYSTEMDRIVE%\Program Files\Git\git-bash.exe" -i -l -c "echo 'Running on: '; pwd; grunt; exec bash"
            ;;
            *)
                start "" "%SYSTEMDRIVE%\Program Files\Git\git-bash.exe" -i -l -c "echo 'Running on: '; pwd; grunt; exec bash"
                start "" "%SYSTEMDRIVE%\Program Files\Git\git-bash.exe" -i -l -c "cd scss; echo 'Running on: '; pwd; compass watch; exec bash"
            ;;
        esac
    ;;
esac
