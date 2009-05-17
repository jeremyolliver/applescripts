(*
This script is for handling the repetitive task of Opening a code project in the terminal and given text editor
This version of the script also opens the project in additional tabs and starts the rails console + server

Recommended to use with Quicksilver

Author - Jeremy Olliver
*)
property projects_directory : "~/projects/" -- Set this to the path of the projects folder (include trailing slash)
property editor_cmd : "mate -w" -- your editor command

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
			-- Change to project directory and open the project with our editor
			do script "cd ~/projects/" & project & " && " & editor_cmd & " ."
			tell application "System Events"
				-- Open the rails console in a second tab
				keystroke "t" using {command down} -- open new tab
				keystroke "cd ~/projects/" & project & " && ruby script/console\n" -- Execute this command in the second tab
				
				-- Start the rails server in a third tab
				keystroke "t" using {command down} -- open new tab
				keystroke "cd ~/projects/" & project & " && ruby script/server\n" -- Execute this command in the third tab
				
			end tell
		end tell
		-- Maximize the Terminal Window
		tell application "Terminal" to copy (run script "tell application \"Finder\" to desktop's window's bounds") to bounds of window 1
	end if
end try