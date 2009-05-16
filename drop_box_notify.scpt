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
		
		tell application "GrowlHelperApp"
			-- Make a list of all the notification types 
			-- that this script will ever send:
			set the allNotificationsList to {"File Added Notification"}
			
			-- Make a list of the notifications 
			-- that will be enabled by default.      
			-- Those not enabled by default can be enabled later 
			-- in the 'Applications' tab of the growl prefpane.
			set the enabledNotificationsList to {"File Added Notification"}
			
			-- send the Growl notification
			-- Register our script with growl.
			-- You can optionally (as here) set a default icon 
			-- for this script's notifications.
			register as application "Finder Notifier" all notifications allNotificationsList default notifications enabledNotificationsList icon of application "Finder"
			
			--	Send a Notification...
			notify with name "File Added Notification" title msg_title description "This is a test AppleScript notification." application name "Finder Notifier"
			
		end tell
		
		-- set alert_message to ("Folder Actions Alert:" & return & return) as Unicode text
		-- if the item_count is greater than 1 then
		-- 	set alert_message to alert_message & (the item_count as text) & " new items have "
		-- else
		-- 	set alert_message to alert_message & "One new item has "
		-- end if
		-- set alert_message to alert_message & "been placed in folder " & «data utxt201C» & the folder_name & «data utxt201D» & "."
		-- set the alert_message to (the alert_message & return & return & "Would you like to view the added items?")
		
		-- 	display dialog the alert_message buttons {"Yes", "No"} default button 2 with icon 1 giving up after dialog_timeout
		-- 	set the user_choice to the button returned of the result
		-- 	
		-- 	if user_choice is "Yes" then
		-- 		tell application "Finder"
		-- 			--go to the desktop 
		-- 			activate
		-- 			--open the folder
		-- 			open this_folder
		-- 			--select the items
		-- 			reveal the added_items
		-- 		end tell
		-- 	end if
	end try
end adding folder items to