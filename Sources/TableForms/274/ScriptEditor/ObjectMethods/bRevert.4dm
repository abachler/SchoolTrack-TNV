  // Método: Método de Objeto: [XShell_ReportObjLib_Clases].ScriptEditor.bRevert
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 28/07/10, 08:07:44
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

Case of 
	: (vl_CurrentScriptType=1)
		vt_code:=[XShell_ReportObjLib_Clases:274]Script_Inicio:7
		
	: (vl_CurrentScriptType=2)
		vt_code:=[XShell_ReportObjLib_Clases:274]Script_Cuerpo:8
		
	: (vl_CurrentScriptType=3)
		vt_code:=[XShell_ReportObjLib_Clases:274]Script_Fin:9
		
End case 


