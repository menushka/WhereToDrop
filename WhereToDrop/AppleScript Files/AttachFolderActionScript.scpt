property FOLDER_ACTION_NAME : "Downloads -> AirDropSorter"
property FOLDER_ACTION_DIR : (path to home folder as string) & "Downloads"
property FOLDER_ACTION_SCRIPT : "AirDropSorter.scpt"

tell application "System Events"
    if (count of (folder actions where name is FOLDER_ACTION_NAME)) is 0 then
        make new folder action at end of folder actions with properties {enabled:true, name:FOLDER_ACTION_NAME, path:FOLDER_ACTION_DIR}
        tell folder action FOLDER_ACTION_NAME to make new script at end of scripts with properties {name:FOLDER_ACTION_SCRIPT}
    end if
    set folder actions enabled to true
end tell
