
ARRAY TEXT:C222($at_notifications;0)
For ($i;1;Size of array:C274(<>atXS_ModuleNames))
	If ([xShell_Users:47]ReceiveNotifications_Modules:22 ?? <>alXS_ModuleRef{$i})
		APPEND TO ARRAY:C911($at_notifications;"!"+Char:C90(18)+<>atXS_ModuleNames{$i})
	Else 
		APPEND TO ARRAY:C911($at_notifications;<>atXS_ModuleNames{$i})
	End if 
End for 

APPEND TO ARRAY:C911($at_notifications;"-")

If (([xShell_Users:47]Receive_email:21) | ([xShell_Users:47]ReceiveNotifications_Modules:22 ?? 0))
	APPEND TO ARRAY:C911($at_notifications;"!"+Char:C90(18)+__ ("Correos electrónicos"))
Else 
	APPEND TO ARRAY:C911($at_notifications;__ ("Correos electrónicos"))
End if 



$t_menuItems:=AT_array2text (->$at_notifications;";")
$l_selectedItem:=Pop up menu:C542($t_menuItems)

Case of 
	: ($l_selectedItem=0)
		
	: ($l_selectedItem=Size of array:C274($at_notifications))
		If ([xShell_Users:47]Receive_email:21)
			[xShell_Users:47]Receive_email:21:=False:C215
			[xShell_Users:47]ReceiveNotifications_Modules:22:=[xShell_Users:47]ReceiveNotifications_Modules:22 ?- 0
		Else 
			[xShell_Users:47]Receive_email:21:=True:C214
			[xShell_Users:47]ReceiveNotifications_Modules:22:=[xShell_Users:47]ReceiveNotifications_Modules:22 ?+ 0
		End if 
	Else 
		$l_moduleBit:=<>alXS_ModuleRef{$l_selectedItem}
		If ([xShell_Users:47]ReceiveNotifications_Modules:22 ?? $l_moduleBit)
			[xShell_Users:47]ReceiveNotifications_Modules:22:=[xShell_Users:47]ReceiveNotifications_Modules:22 ?- $l_moduleBit
		Else 
			[xShell_Users:47]ReceiveNotifications_Modules:22:=[xShell_Users:47]ReceiveNotifications_Modules:22 ?+ $l_moduleBit
		End if 
End case 




