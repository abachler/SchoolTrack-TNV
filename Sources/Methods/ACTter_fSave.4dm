//%attributes = {}
  //ACTter_fSave
C_BOOLEAN:C305($b_noValidarNiMostrarMsj)
C_BOOLEAN:C305(vb_guardarCambios)  //20180310 RCH

$b_noValidarNiMostrarMsj:=False:C215

$0:=0
If (Count parameters:C259>=1)
	$b_noValidarNiMostrarMsj:=$1
End if 

If ((USR_checkRights ("M";->[ACT_Terceros:138])) | ($b_noValidarNiMostrarMsj))
	  //If (KRL_RegistroFueModificado (->[ACT_Terceros]) | (campopropio))  //ABC 198018 ///20180123
	
	  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
	If (KRL_RegistroFueModificado (->[ACT_Terceros:138]) | (vb_guardarCambios))
		C_BOOLEAN:C305($vb_continue)
		If ([ACT_Terceros:138]Es_empresa:2)
			If (([ACT_Terceros:138]Razon_Social:3#"") & ([ACT_Terceros:138]RUT:4#""))
				$vb_continue:=True:C214
			End if 
		Else 
			If (([ACT_Terceros:138]Apellido_Paterno:16#"") & ([ACT_Terceros:138]Nombres:18#"") & (([ACT_Terceros:138]RUT:4#"") | ([ACT_Terceros:138]Identificador_Nacional2:20#"") | ([ACT_Terceros:138]Identificador_Nacional3:21#"") | ([ACT_Terceros:138]Pasaporte:25#"")))
				$vb_continue:=True:C214
			End if 
		End if 
		If ($vb_continue)
			If ([ACT_Terceros:138]Id:1=0)
				[ACT_Terceros:138]Id:1:=SQ_SeqNumber (->[ACT_Terceros:138]Id:1)
				  //While (Find in field([ACT_Terceros]Id;[ACT_Terceros]Id)>0)
				While (Find in field:C653([ACT_Terceros:138]Id:1;[ACT_Terceros:138]Id:1)#-1)  //20150609 RCH
					[ACT_Terceros:138]Id:1:=SQ_SeqNumber (->[ACT_Terceros:138]Id:1)  //20131015 RCH
				End while 
			End if 
			If (vtACT_NumTC#"")
				[ACT_Terceros:138]PAT_NumTC:36:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";->[ACT_Terceros:138]PAT_NumTC:36;->[ACT_Terceros:138]xPass:58)
				vtACT_NumTC:=""
			End if 
			ACTter_ActualizaNombreCompleto 
			If (Is new record:C668([ACT_Terceros:138]))
				LOG_RegisterEvt ("Creación del tercero "+[ACT_Terceros:138]Nombre_Completo:9+".")
			End if 
			
			  //20180102 RCH
			  //ACTpp_DireccionDeFacturacion ("GuardaTerceroDesdeInput")//20180310 RCH Se pasa código a botones
			
			SAVE RECORD:C53([ACT_Terceros:138])
			$0:=1
		Else 
			If (Not:C34($b_noValidarNiMostrarMsj))
				$ignore:=CD_Dlog (0;__ ("Faltan datos para grabar."))
			End if 
			$0:=-1
		End if 
	End if 
End if 