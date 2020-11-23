property QUARANTINE_KEY : "59"
property GET_QUARANTINE_COMMAND_START : "ls -l -@ '"
property GET_QUARANTINE_COMMAND_END : "' | tr '\\n' ' ' | sed 's/.*com\\.apple\\.quarantine\\s*\\(\\d*\\)/ \\1/' | awk '{$1=$1};1'"

on adding folder items to this_folder after receiving added_items
  set settingsPath to (the POSIX path of (path to home folder)) & "Library/Application Support/WhereToDrop/app.settings"
  set settings to read settingsPath using delimiter linefeed
  set enabled to first item of settings
  if enabled is "false"
    return
  end if

  set redirectDirectory to second item of settings

    repeat with i from 1 to length of added_items
        set current_item to item i of added_items
        set quarantine_type to getQuarantineType(POSIX path of current_item)
        if quarantine_type is equal to QUARANTINE_KEY then
            moveFile(current_item, POSIX file redirectDirectory as alias)
        end if
    end repeat
end adding folder items to

on moveFile(move_file, destination_dir)
    tell application "Finder"
        move move_file to destination_dir with replacing
    end tell
end moveFile

on getQuarantineType(file_path)
    return do shell script GET_QUARANTINE_COMMAND_START & file_path & GET_QUARANTINE_COMMAND_END
end getQuarantineType
