Case of 
	: (Form event:C388=On Load:K2:1)
		PV SET COMMAND STATUS:P13000:31 (xView;pv cmd file save template:K12281:12;0)
		PV ON COMMAND:P13000:21 (xView;pv cmd file save:K12281:10;"QR_SaveReport")
		PV ON COMMAND:P13000:21 (xView;pv cmd file save as:K12281:11;"QR_SaveReportAS")
		PV ON COMMAND:P13000:21 (xView;pv cmd file open:K12281:9;"QR_OpenReport")
		PV SET AREA PROPERTY:P13000:5 (xView;pv saving dialog:K12256:38;pv value off:K12278:30)
		
		If (BLOB size:C605([xShell_Reports:54]xReportData_:29)>0)
			PV BLOB TO AREA:P13000:13 (xView;[xShell_Reports:54]xReportData_:29)
			PV UPDATE DYNAMIC AREA:P13000:142 (xView)
			PV GOTO CELL:P13000:149 (xView;1;1)
			PV SELECT CELL:P13000:174 (xView;1;1;pv selection reduce:K12277:3)
		End if 
		
		vx_Blob:=PV Area to blob:P13000:14 (xView)
		
	: (Form event:C388=On Plug in Area:K2:16)
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		vx_Blob2:=PV Area to blob:P13000:14 (xView)
		$result:=API Compare Blobs (vx_Blob;vx_Blob2;0)
		
		If ($result=0)
			$result:=CD_Dlog (0;__ ("¿Desea guardar las modificaciones en este documento antes de cerrar?");__ ("");__ ("Guardar");__ ("No guardar");__ ("Cancelar"))
			Case of 
				: ($result=1)
					QR_SaveReport 
					ACCEPT:C269
				: ($result=2)
					CANCEL:C270
				: ($result=3)
					  //nada
			End case 
		Else 
			CANCEL:C270
		End if 
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 