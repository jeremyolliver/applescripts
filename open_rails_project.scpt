(*
This script is for handling the repetitive task of Opening a code project in the terminal and given text editor
This version of the script also opens the project in additional tabs and starts the rails console + server.

This streamlines my usual workflow for opening a project which is: Open Terminal; cd to my project directory;
open the project in my text editor ("mate ."); open two more additional terminal tabs, switching to the project
and starting rails server and consoles in those tabs.
This script turns that workflow into: hit keyboard shortcut; enter project name to open in a popup. Done.

CUSTOMISATION:
You should change the projects_directory property here if you don't keep your code in ~/projects/ (e.g. change to ~/workspace/)

INSTALLATION:
1. Add ^m (Control + m) as a shortcut for maximizing a window by opening System Prefs, accessing the Keyboard Shortcuts pane
and adding an entry for ^m with "Zoom" as the Menu title
2. Copy this script to ~/Library/Scripts/
3. Install Quicksilver if you haven't already (http://quicksilver.blacktree.com/) and add a trigger (keyboard shortcut) for launching this script
4. Profit from increased productivity

Author - Jeremy Olliver
*)
property projects_directory : "~/projects/" -- Set this to the path of the projects folder (include trailing slash)
property editor_cmd : "mate -w" -- TextMate command. Replace with command for your own editor if different

try
	-- The display dialog opens in Quicksilver, which is usually in the background, we should focus it first, so the popup is in the foreground
	activate application "Quicksilver" -- comment this out, if you're not using quicksilver to run the script
	
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
				tell process "Terminal"
					-- Open the rails console in a second tab
					keystroke "t" using {command down} -- open new tab
					keystroke "cd ~/projects/" & project & " && ruby script/console\n" -- Execute this command in the second tab
				
					-- Start the rails server in a third tab, this is optional
					-- keystroke "t" using {command down} -- open new tab
					-- keystroke "cd ~/projects/" & project & " && ruby script/server\n" -- Execute this command in the third tab
				
					keystroke "{" using {command down} -- toggle forward one tab (ie back to the first). so back to command line tab, whether we opted to have a rails server or not
					keystroke "m" using {control down} -- Maximize Terminal window. You'll need to add ^m as a keyboard shortcut for "Zoom" in System Prefs for this to work
				end tell
			end tell
		end tell
	end if
end try