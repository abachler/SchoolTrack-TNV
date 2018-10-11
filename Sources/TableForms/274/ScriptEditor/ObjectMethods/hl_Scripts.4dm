  // Método: Método de Objeto: [XShell_ReportObjLib_Clases].ScriptEditor.hl_Scripts
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 28/07/10, 07:37:26
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

C_LONGINT:C283($answer)
GET LIST ITEM:C378(Self:C308->;*;$scriptRef;$scriptType)

Case of 
	: (vl_CurrentScriptType=1)  //inicio
		If (vt_code#[XShell_ReportObjLib_Clases:274]Script_Inicio:7)
			$answer:=CD_Dlog (0;__ ("Modificaste el script de Inicio.\r\r¿Quieres guardar los cambios antes de cargar el script de ")+$scriptType+__ ("?");__ ("");__ ("Guardar");__ ("No");__ ("Cancelar"))
			Case of 
				: ($answer=3)
					SELECT LIST ITEMS BY POSITION:C381(hl_Scripts;vl_CurrentScriptType)
					$scriptRef:=vl_CurrentScriptType
					
				: ($answer=2)
					
				: ($answer=1)
					[XShell_ReportObjLib_Clases:274]Script_Inicio:7:=vt_code
					SAVE RECORD:C53([XShell_ReportObjLib_Clases:274])
			End case 
		End if 
		
	: (vl_CurrentScriptType=2)  //Cuerpo
		If (vt_code#[XShell_ReportObjLib_Clases:274]Script_Cuerpo:8)
			$answer:=CD_Dlog (0;__ ("Modificaste el script de Cuerpo.\r\r¿Quieres guardar los cambios antes de cargar el script de ")+$scriptType+__ ("?");__ ("");__ ("Guardar");__ ("No");__ ("Cancelar"))
			Case of 
				: ($answer=3)
					SELECT LIST ITEMS BY POSITION:C381(hl_Scripts;vl_CurrentScriptType)
					$scriptRef:=vl_CurrentScriptType
					
				: ($answer=2)
					
				: ($answer=1)
					[XShell_ReportObjLib_Clases:274]Script_Cuerpo:8:=vt_code
					SAVE RECORD:C53([XShell_ReportObjLib_Clases:274])
			End case 
		End if 
		
	: (vl_CurrentScriptType=3)  //Fin
		If (vt_code#[XShell_ReportObjLib_Clases:274]Script_Fin:9)
			$answer:=CD_Dlog (0;__ ("Modificaste el script de Fin.\r\r¿Quieres guardar los cambios antes de cargar el script de ")+$scriptType+__ ("?");__ ("");__ ("Guardar");__ ("No");__ ("Cancelar"))
			Case of 
				: ($answer=3)
					SELECT LIST ITEMS BY POSITION:C381(hl_Scripts;vl_CurrentScriptType)
					$scriptRef:=vl_CurrentScriptType
					
				: ($answer=2)
					
				: ($answer=1)
					[XShell_ReportObjLib_Clases:274]Script_Fin:9:=vt_code
					SAVE RECORD:C53([XShell_ReportObjLib_Clases:274])
			End case 
			
		End if 
End case 

If ($scriptRef#vl_CurrentScriptType)
	vl_CurrentScriptType:=$scriptRef
	Case of 
		: (vl_CurrentScriptType=1)
			vt_code:=[XShell_ReportObjLib_Clases:274]Script_Inicio:7
			
		: (vl_CurrentScriptType=2)
			vt_code:=[XShell_ReportObjLib_Clases:274]Script_Cuerpo:8
			
		: (vl_CurrentScriptType=3)
			vt_code:=[XShell_ReportObjLib_Clases:274]Script_Fin:9
			
	End case 
End if 

HIGHLIGHT TEXT:C210(vt_code;Length:C16(vt_code)+1;Length:C16(vt_code)+1)

