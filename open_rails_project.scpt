(*
This script is for handling the repetitive task of Opening a code project in the terminal and given text editor
This version of the script also opens the project in additional tabs and starts the rails console + server.

This streamlines my usual workflow for opening a project which is: Open Terminal; cd to my project directory;
open the project in my text editor ("mate ."); open two more additional terminal tabs, switch to the project
and start rails server and consoles in those tabs.

USAGE:
Use a Quicksilver (http://quicksilver.blacktree.com/) trigger to assign this script to a hotkey
The script will prompt you to enter which project you wish to open, and will automatically open the project in
the Terminal with a rails console and server in two other terminal tabs, and open the project in your text editor
(default is TextMate here, set the command for your editor of choice).

Author - Jeremy Olliver
*)
property projects_directory : "~/projects/" -- Set this to the path of the projects folder (include trailing slash)
property editor_cmd : "mate -w" -- TextMate command. Replace with command for your own editor if different

try
	set the_result to display dialog ¬
		"Choose project to open:" default answer ¬
		"project_name" with icon 1 ¬
		buttons {"Cancel", "Open"} ¬
		default button "Open"
	set button_pressed to button returned of the_result
	set project to text returned of the_result
	if button_pressed is "Open" then
		tell application "Terminal"
			activate
			-- Change to project directory and open the project with our editor
			do script "cd ~/projects/" & project & " && " & editor_cmd & " ."
			-- The above command opens TextMate, we'll need to switch focus back to Terminal
			tell application "System Events"
				-- Open the rails console in a second tab
				tell process "Terminal" to keystroke "t" using {command down} -- open new tab
				tell process "Terminal" to keystroke "cd ~/projects/" & project & " && ruby script/console\n" -- Execute this command in the second tab
				
				-- Start the rails server in a third tab
				-- tell process "Terminal" to keystroke "t" using {command down} -- open new tab
				-- tell process "Terminal" to keystroke "cd ~/projects/" & project & " && ruby script/server\n" -- Execute this command in the third tab
				
			end tell
		end tell
		-- Maximize the Terminal Window
		tell application "Terminal" to copy (run script "tell application \"Finder\" to desktop's window's bounds") to bounds of window 1
	end if
end try