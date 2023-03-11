## @file odyssey.applescript
## Launches the default web browser.
## @author Ralf Quast
## @date 2023
## @copyright GPL
global config

on run
	set config to readConfig("~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist")
	
	set appIDs to {"com.vivaldi.vivaldi", "com.google.chrome"}
	
	repeat with theId in appIDs
		if isDefaultHandler(theId, "https") and isDefaultHandler(theId, "http") then
			try
				activateTheApp(theId)
				return
			on error
				-- ignore
			end try
		end if
	end repeat
	
	tell application "Safari" to activate
end run

on activateTheApp(theId)
	tell application "Finder"
		set theApp to name of (get application file id theId)
	end tell
	tell application theApp to activate
end activateTheApp

on readConfig(path)
	return do shell script "defaults read " & path & " | tr -d [:blank:][:cntrl:]"
end readConfig

on isDefaultHandler(theId, scheme)
	return config contains "LSHandlerRoleAll=\"" & theId & "\";LSHandlerURLScheme=" & scheme & ";"
end isDefaultHandler
