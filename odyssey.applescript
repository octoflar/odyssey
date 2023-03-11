## @file odyssey.applescript
## Launches the default web browser.
## @author Ralf Quast
## @date 2023
## @copyright GPL
on run
	set appIDs to {"com.vivaldi.vivaldi", "com.google.chrome"}
	
	repeat with theId in appIDs
		if isDefaultHandler(theId, "https") then
			try
				callUp(theId)
				return
			on error
				-- ignore
			end try
		end if
	end repeat
	
	tell application "Safari" to activate
end run

on callUp(theId)
	tell application "Finder"
		set theApp to name of (get application file id theId)
	end tell
	tell application theApp to activate
end callUp

on isDefaultHandler(theId, scheme)
	set pattern to "'LSHandlerRoleAll=\"" & theId & "\";LSHandlerURLScheme=" & scheme & ";'"
	try
		do shell script Â
			"defaults read ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist | tr -d [:blank:][:cntrl:] | grep -q " & pattern
		return true
	on error
		return false
	end try
end isDefaultHandler
