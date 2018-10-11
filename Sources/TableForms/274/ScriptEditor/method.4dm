  // Método: Método de Formulario: [XShell_ReportObjLib_Clases]ScriptEditor
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 28/07/10, 07:29:38
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
  //Método de Formulario: [XShell_ReportObjLib_Clases]ScriptEditor
Case of 
	: (Form event:C388=On Load:K2:1)
		hl_Scripts:=New list:C375
		APPEND TO LIST:C376(hl_Scripts;"Inicio";1)
		APPEND TO LIST:C376(hl_Scripts;"Cuerpo";2)
		APPEND TO LIST:C376(hl_Scripts;"Fin";3)
		SELECT LIST ITEMS BY POSITION:C381(hl_Scripts;1)
		vl_CurrentScriptType:=1
		vt_code:=[XShell_ReportObjLib_Clases:274]Script_Inicio:7
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		Case of 
			: (vl_CurrentScriptType=1)  //inicio
				If (vt_code#[XShell_ReportObjLib_Clases:274]Script_Inicio:7)
					$answer:=CD_Dlog (0;__ ("Modificaste el script de Inicio.\r\r¿Quieres guardar los cambios antes de cerrar?");__ ("");__ ("Guardar");__ ("No");__ ("Cancelar"))
					Case of 
						: ($answer=3)
							
						: ($answer=2)
							CANCEL:C270
							
						: ($answer=1)
							[XShell_ReportObjLib_Clases:274]Script_Inicio:7:=vt_code
							SAVE RECORD:C53([XShell_ReportObjLib_Clases:274])
							ACCEPT:C269
					End case 
				End if 
				
			: (vl_CurrentScriptType=2)  //Cuerpo
				If (vt_code#[XShell_ReportObjLib_Clases:274]Script_Cuerpo:8)
					$answer:=CD_Dlog (0;__ ("Modificaste el script de Cuerpo.\r\r¿Quieres guardar los cambios antes de cerrar");__ ("");__ ("Guardar");__ ("No");__ ("Cancelar"))
					Case of 
						: ($answer=3)
							
						: ($answer=2)
							CANCEL:C270
							
						: ($answer=1)
							[XShell_ReportObjLib_Clases:274]Script_Cuerpo:8:=vt_code
							SAVE RECORD:C53([XShell_ReportObjLib_Clases:274])
							ACCEPT:C269
					End case 
				End if 
				
			: (vl_CurrentScriptType=3)  //Fin
				If (vt_code#[XShell_ReportObjLib_Clases:274]Script_Fin:9)
					$answer:=CD_Dlog (0;__ ("Modificaste el script de Fin.\r\r¿Quieres guardar los cambios antes de cerrar");__ ("");__ ("Guardar");__ ("No");__ ("Cancelar"))
					Case of 
						: ($answer=3)
							
						: ($answer=2)
							CANCEL:C270
							
						: ($answer=1)
							[XShell_ReportObjLib_Clases:274]Script_Fin:9:=vt_code
							SAVE RECORD:C53([XShell_ReportObjLib_Clases:274])
							ACCEPT:C269
					End case 
					
				Else 
					
				End if 
		End case 
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 




