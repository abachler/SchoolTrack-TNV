//%attributes = {}
  // Método: BMK_OnEventCall
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 12/10/09, 09:30:22
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vbBMK_Active;$execute)
C_TEXT:C284(vtBMK_taskName;vtBMK_Script)
  // Código principal

  //Case of 
  //: ((modifiers=(Command key mask +Shift key mask )) & (keycode=Character code("b")))
  //$execute:=True
  //: ((modifiers=(Control key mask +Shift key mask )) & (keycode=Character code("b")))
  //$execute:=True
  //End case 
  //
  //If ($execute)
If ((<>vbBMK_Active) & (vtBMK_taskName#""))
	BMK_ShowResults (vtBMK_taskName)
Else 
	vtBMK_Script:=""
	vtBMK_taskName:=""
	$wRef:=Open form window:C675("BMK_Activate";0;On the left:K39:2;At the top:K39:5)
	SET WINDOW TITLE:C213("Benchmarking")
	DIALOG:C40("BMK_Activate")
	CLOSE WINDOW:C154
	
	If (OK=1)
		If (vtBMK_Script#"")
			BMK_Switch (True:C214)
			vtBMK_Script:="BMK_LocalExecutionTimer(True)"+"\r"+vtBMK_Script+"\r"+"BMK_LocalExecutionTimer(False)"
			EXE_Execute (vtBMK_Script)
			BMK_ShowResults (vtBMK_taskName)
		Else 
			BMK_Switch (True:C214)
		End if 
	End if 
End if 
  //Else 
  //FILTER EVENT
  //End if 




