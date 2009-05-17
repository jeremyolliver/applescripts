(*
Finder Folder Notifier. Notifies the user via Growl (if available) or a popup dialog
of any new items (files or folders) that have been added to the folder this script is
attached to. The user can quickly jump to these files if desired

This script is partly based off an Apple sample script, which displayed and alert dialog.
I have modified this script for Growl support and to improve the usefulness of the display message

Author - Jeremy Olliver
*)
property projects_directory : "~/projects"

try
	-- -- set message to "Enter the name of the project to open: "
	-- set the_folder to choose folder with prompt "Choose the project to open:" default location path to home folder with invisibles with multiple selections allowed with showing package contents

	-- set the_result to display dialog "Choose project to open:" ¬
	-- 	default answer "project_name" ¬
	-- 	with icon 1 ¬
	-- 	buttons {"Cancel", "Open"} ¬
	-- 	default button "Open"
	-- set button_pressed to button returned of the_result
	-- set text_typed to text returned of the_result
	-- if button_pressed is "Open" then
		-- action for default button button goes here
		-- tell application "System Events"
		-- 	set isTerminalRunning to (count of (every process whose name is "Terminal")) > 0
		-- end tell
		-- 
		-- if isTerminalRunning then
		-- 	display alert "Terminal Running"
		-- else
		-- 	display alert "Terminal not detected"
		-- end if
		
		tell application "Terminal"
			activate
			do script "cd ~/projects/planhq" -- always opens a new window, even if Terminal is already open. [Hence it's use in place of activate]
			set the position of window 1 to {0, 20} -- Move the window to the top left
			tell application "System Events"
				keystroke "t" using {command down} -- open new tab
				if UI elements enabled then
					tell process "Terminal"
			       tell menu bar 1
			           tell menu bar item "Window"
			               click menu item "Maximize"
			           end tell
			       end tell
			   end tell
					-- click button 2 of window 1 -- Maximize the window
				else
					display alert "UI scripting disabled"
				end if
			end tell
			-- do script "cd ~/projects/planhq && mate ."
			-- do script ""
		end tell
	-- end if
end try