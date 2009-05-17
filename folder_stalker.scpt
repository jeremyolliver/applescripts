(*
Finder Folder Notifier. Notifies the user via Growl (if available) or a popup dialog
of any new items (files or folders) that have been added to the folder this script is
attached to. The user can quickly jump to these files if desired

This script is partly based off an Apple sample script, which displayed and alert dialog.
I have modified this script for Growl support and to improve the usefulness of the display message

Author - Jeremy Olliver
*)

property dialog_timeout : 30 -- set the amount of time before dialogs auto-answer.

on adding folder items to this_folder after receiving added_items
	try
		tell application "Finder"
			--get the name of the folder
			set the folder_name to the name of this_folder
		end tell
		
		-- find out how many new items have been placed in the folder
		set the item_count to the number of items in the added_items
		--create the alert string
		set msg_title to (the item_count as text) & (" New ") as Unicode text
		if the item_count is greater than 1 then
			set msg_title to msg_title & ("items")
		else
			set msg_title to msg_title & ("item")
		end if
		set msg_title to msg_title & (" in ") & the folder_name
		
		tell application "System Events"
			set isGrowlRunning to (count of (every process whose name is "GrowlHelperApp")) > 0
		end tell
		
		-- Set Message Body to the list of added files
		set msg_body to ("")
		set counter to 0
		repeat with added_item in added_items
			tell application "Finder" to set file_name to (name of added_item)
			set msg_body to msg_body & file_name
			set counter to counter + 1
			if counter < item_count then
				set msg_body to (msg_body & return) as Unicode text
			end if
		end repeat
				
		if isGrowlRunning then
			-- Send notification to growl
			tell application "GrowlHelperApp"
				-- Make a list of all the notification types that this script will ever send:
				set the allNotificationsList to {"File Added Notification"}
				
				-- Make a list of the notifications that will be enabled by default.      
				-- Those not enabled by default can be enabled later in the 'Applications' tab of the growl prefpane.
				set the enabledNotificationsList to {"File Added Notification"}
				
				-- Register our script with growl.
				register as application "Finder Notifier" all notifications allNotificationsList default notifications enabledNotificationsList icon of application "Finder"
				
				-- send the Growl notification
				notify with name "File Added Notification" title msg_title description msg_body application name "Finder Notifier"
				
			end tell
		else
			-- Growl isn't running. Send notification via lame finder popup
			set full_message to (msg_title & return & return & msg_body & return & return & "Would you like to view the added items?") as Unicode text
			
			display dialog the full_message buttons {"Yes", "No"} default button 2 with icon 1 giving up after dialog_timeout
			set the user_choice to the button returned of the result
			
			if user_choice is "Yes" then
				tell application "Finder"
					--go to the desktop 
					activate
					--open the folder
					open this_folder
					--select the items
					reveal the added_items
				end tell
			end if
		end if
	-- For Debugging we can turn this on, otherwise the script will die silently
	-- on error errorMessage number errorNumber from offendingObject partial result resultList
	-- 	display dialog "Error Occured"
	end try
end adding folder items to