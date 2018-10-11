//%attributes = {}
  //XS_ShellSetup

$vi_VSisDefined:=Num:C11(PREF_fGet (0;"VirtualStructureDefined";"0"))
If ($vi_VSisDefined=0)
	$prefRef:="XS_CFG@"
	$recNum:=Find in field:C653([xShell_Prefs:46]Reference:1;$prefRef)
	If ($recNum>=0)
		$vi_VSisDefined:=1
		PREF_Set (0;"VirtualStructureDefined";"1")
	End if 
End if 

Case of 
	: (($vi_VSisDefined=0) & (Is compiled mode:C492))
		ALERT:C41("A parecer la base de datos está corrupta.\\La aplicación se cerrará ahora.\r\rPor fa"+"vor pongáse en contacto con el departamento de soporte.")
		QUIT 4D:C291
		
	: (($vi_VSisDefined=0) & (Not:C34(Is compiled mode:C492)))
		XS_Settings 
		
	: ((Macintosh option down:C545 | Windows Alt down:C563) & Shift down:C543 & (Macintosh command down:C546 | Windows Ctrl down:C562))
		XS_Settings 
		
End case 