(*
This script is for handling the repetitive task of Opening a code project in the terminal and given text editor

Recommended to use with Quicksilver

Author - Jeremy Olliver
*)
property projects_directory : "~/projects/" -- Set this to the path of the projects folder (include trailing slash)
property editor_cmd : "mate -w" -- The command line

try
	set the_result to display dialog ¬
		"Choose project to open:" default answer ¬
		"project_name" with icon 1 ¬
		buttons {"Cancel", "Open"} ¬
		default button "Open"
	set button_pressed to button returned of the_result
	set project to text returned of the_result
	if button_pressed is "Open" then
		display dialog "Opening " & project
		tell application "Terminal"
			activate
			do script "cd " & projects_directory & project -- always opens a new window, even if Terminal is already open. [Hence it's use in place of activate]
			tell application "System Events"
				keystroke "t" using {command down} -- open new tab
				keystroke "cd ~/projects/" & project & " && " & editor_cmd & " ." -- Execute this command in the second tab
			end tell
		end tell
		-- Maximize the Window
		tell application "Terminal" to copy (run script "tell application \"Finder\" to desktop's window's bounds") to bounds of window 1
	end if
end try