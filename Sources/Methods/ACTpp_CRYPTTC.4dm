//%attributes = {}
  //ACTpp_CRYPTTC

C_LONGINT:C283(viACT_campoModificable)
C_TEXT:C284($vt_accion;$1;$vt_retorno)
C_LONGINT:C283($vl_var1;$vl_var2;$vl_var3;$vl_var4)
C_POINTER:C301($ptr1;$ptr2;$ptr3;$ptr4)
C_BOOLEAN:C305($result)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
If (Count parameters:C259>=5)
	$ptr4:=$5
End if 

Case of 
	: ($vt_accion="GetVars")
		$vl_var1:=16969
		$vl_var2:=26969
		$vl_var3:=6969
		$vl_var4:=9696
		
		$ptr1->:=$vl_var1
		$ptr2->:=$vl_var2
		$ptr3->:=$vl_var3
		$ptr4->:=$vl_var4
		
	: ($vt_accion="CryptAllDocPago")
		C_LONGINT:C283($uther)
		ACTpp_CRYPTTC ("GetVars";->$vl_var1;->$vl_var2;->$vl_var3;->$vl_var4)
		$uther:=IT_UThermometer (1;0;__ ("Verificando datos. Un momento por favor..."))
		READ WRITE:C146([ACT_Documentos_de_Pago:176])
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]TC_Numero:17#"")
		APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]TC_Numero:17:=CRYPT_Encrypt ([ACT_Documentos_de_Pago:176]TC_Numero:17;$vl_var1;$vl_var2;$vl_var3;$vl_var4;Length:C16([ACT_Documentos_de_Pago:176]TC_Numero:17)))
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
		IT_UThermometer (-2;$uther)
		
	: ($vt_accion="CryptAll")
		C_LONGINT:C283($uther)
		ACTpp_CRYPTTC ("GetVars";->$vl_var1;->$vl_var2;->$vl_var3;->$vl_var4)
		$uther:=IT_UThermometer (1;0;__ ("Verificando datos. Un momento por favor..."))
		READ WRITE:C146([Personas:7])
		QUERY:C277([Personas:7];[Personas:7]ACT_Numero_TC:54#"")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Numero_TC:54:=CRYPT_Encrypt ([Personas:7]ACT_Numero_TC:54;$vl_var1;$vl_var2;$vl_var3;$vl_var4;Length:C16([Personas:7]ACT_Numero_TC:54)))
		KRL_UnloadReadOnly (->[Personas:7])
		IT_UThermometer (-2;$uther)
		
	: ($vt_accion="xxACT_GetDecryptTC")
		ACTpp_CRYPTTC ("GetVars";->$vl_var1;->$vl_var2;->$vl_var3;->$vl_var4)
		If ($ptr1->#"")
			  //$vt_retorno:=CRYPT_Decrypt ($ptr1->;$vl_var1;$vl_var2;$vl_var3;$vl_var4)
			Case of 
				: (Table:C252($ptr1)=Table:C252(->[Personas:7]))
					  //Ticket 116401
					If (Field:C253($ptr1)=Field:C253(->[Personas:7]ACT_Numero_TC:54))
						$vt_retorno:=USR_DecryptPassword ([Personas:7]ACT_xPass:91)
					Else 
						$vt_retorno:=USR_DecryptPassword ([Personas:7]ACT_xPass_TD:109)
					End if 
				: (Table:C252($ptr1)=Table:C252(->[ACT_Documentos_de_Pago:176]))
					  //Ticket 116401
					If (Field:C253($ptr1)=Field:C253(->[ACT_Documentos_de_Pago:176]TC_Numero:17))
						$vt_retorno:=USR_DecryptPassword ([ACT_Documentos_de_Pago:176]xPass:49)
					Else 
						$vt_retorno:=USR_DecryptPassword ([ACT_Documentos_de_Pago:176]xPass_TD:73)
					End if 
				: (Table:C252($ptr1)=Table:C252(->[ACT_Terceros:138]))
					  //127351
					If (Field:C253($ptr1)=Field:C253(->[ACT_Terceros:138]RC_NumTD:66))
						$vt_retorno:=USR_DecryptPassword ([ACT_Terceros:138]RC_xPass:72)
					Else 
						$vt_retorno:=USR_DecryptPassword ([ACT_Terceros:138]xPass:58)
					End if 
			End case 
		End if 
		
	: ($vt_accion="xxACT_GetDecryptTCWithFormat")
		If ($ptr1->#"")
			$vt_retorno:=ACTpp_CRYPTTC ("xxACT_GetDecryptTC";$ptr1)
			$vt_retorno:=ACTpp_CRYPTTC ("AplicaFormato";->$vt_retorno)
		End if 
		
	: ($vt_accion="AplicaFormato")
		If ($ptr1->#"")
			$vt_retorno:=(("X")*4)+" "+Substring:C12($ptr1->;Length:C16($ptr1->)-3;Length:C16($ptr1->))
		End if 
		
	: ($vt_accion="xxACT_SetCryptTC")
		ACTpp_CRYPTTC ("GetVars";->$vl_var1;->$vl_var2;->$vl_var3;->$vl_var4)
		If ($ptr1->#"")
			  //$vt_retorno:=CRYPT_Encrypt ($ptr1->;$vl_var1;$vl_var2;$vl_var3;$vl_var4;Length($ptr1->))
			$ptr2->:=USR_EncryptPassWord ($ptr1->)
			$vt_retorno:=ACTpp_CRYPTTC ("AplicaFormato";$ptr1)
		End if 
		
	: ($vt_accion="onLoadDocPago")
		$ptr1->:=ACTpp_CRYPTTC ("xxACT_GetDecryptTCWithFormat";->[ACT_Documentos_de_Pago:176]TC_Numero:17)
		
	: ($vt_accion="onLoadDocPagoDebito")  // Ticket 116401
		$ptr1->:=ACTpp_CRYPTTC ("xxACT_GetDecryptTCWithFormat";->[ACT_Documentos_de_Pago:176]TD_Numero:69)
		
	: ($vt_accion="onLoad")
		$ptr1->:=ACTpp_CRYPTTC ("xxACT_GetDecryptTCWithFormat";$ptr2)
		$ptr2->:=ACTpp_CRYPTTC ("xxACT_GetDecryptTC";$ptr2)
		viACT_campoModificable:=0
		ACTpp_CRYPTTC ("seteaEstadoObjetosForm";->viACT_campoModificable;$ptr1)
		
	: ($vt_accion="SolicitaContraseña")
		$vt_retorno:="0"
		If ($ptr1->#"")
			If (<>lUSR_CurrentUserID>=0)
				If ((Milliseconds:C459-vlACT_Milisegundos)>=60000)
					vb_solicitaUsuario:=True:C214
					vt_Message:="Ingrese la contraseña de su usuario."+"\r\r"+"La contraseña tendrá validez durante los sig"+"uientes 60 segundos si es que no realiza más modificaciones en el campo Número de"+" Tarjeta de Crédito."
					WDW_OpenFormWindow (->[xShell_Users:47];"Emergencia";-1;4)
					DIALOG:C40([xShell_Users:47];"Emergencia")
					CLOSE WINDOW:C154
					If (Ok=1)
						vlACT_Milisegundos:=Milliseconds:C459
					Else 
						$vt_retorno:="1"
					End if 
				Else 
					vlACT_Milisegundos:=Milliseconds:C459
				End if 
			End if 
		End if 
		
	: ($vt_accion="OnDataChange")
		If (viACT_campoModificable=1)
			If ($ptr1->#"")
				$ptr2->:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";$ptr2;$ptr3)
				ACTpp_CRYPTTC ("onLoad";$ptr1;$ptr2)
				vbSpell_StopChecking:=True:C214
			End if 
		End if 
		
	: ($vt_accion="onClicked")
		If (viACT_campoModificable=0)
			$result:=USR_GetMethodAcces ("ACTpp_CRYPTTC")
			viACT_campoModificable:=Num:C11(Not:C34($result))
			If (viACT_campoModificable=0)
				viACT_campoModificable:=Num:C11(ACTpp_CRYPTTC ("SolicitaContraseña";$ptr1))
				If (viACT_campoModificable=0)
					viACT_campoModificable:=1
					$ptr1->:=$ptr2->
					  //$ptr2->:=""
					GOTO OBJECT:C206($ptr1->)
					HIGHLIGHT TEXT:C210($ptr1->;Length:C16($ptr1->)+1;Length:C16($ptr1->)+1)
					LOG_RegisterEvt ("Acceso al número de tarjeta de crédito del apoderado "+[Personas:7]Apellidos_y_nombres:30)
				Else 
					viACT_campoModificable:=0
				End if 
			Else 
				viACT_campoModificable:=0
			End if 
			ACTpp_CRYPTTC ("seteaEstadoObjetosForm";->viACT_campoModificable;$ptr1)
		End if 
		
	: ($vt_accion="seteaEstadoObjetosForm")
		IT_SetEnterable ($ptr1->=1;0;$ptr2)
		  // Ticket 116401
		RESOLVE POINTER:C394($ptr2;$t_NomVariable;$l_NumTabla;$l_NumCampo)
		  //If ($t_NomVariable="vt_noTarjetaDebito")
		  //OBJECT SET VISIBLE(*;"padlockUnlocked1";$ptr1->=1)
		  //OBJECT SET VISIBLE(*;"padlockLocked1";$ptr1->=0)
		  //Else 
		  //OBJECT SET VISIBLE(*;"padlockUnlocked";$ptr1->=1)
		  //OBJECT SET VISIBLE(*;"padlockLocked";$ptr1->=0)
		  //End if 
		Case of 
			: ($t_NomVariable="vt_noTarjetaDebito")
				OBJECT SET VISIBLE:C603(*;"padlockUnlocked1";$ptr1->=1)
				OBJECT SET VISIBLE:C603(*;"padlockLocked1";$ptr1->=0)
			: ($t_NomVariable="vtACT_NumTD")
				OBJECT SET VISIBLE:C603(*;"padlockUnlocked2";$ptr1->=1)
				OBJECT SET VISIBLE:C603(*;"padlockLocked2";$ptr1->=0)
			Else 
				OBJECT SET VISIBLE:C603(*;"padlockUnlocked";$ptr1->=1)
				OBJECT SET VISIBLE:C603(*;"padlockLocked";$ptr1->=0)
		End case 
		
	: ($vt_accion="TCFromReport")
		$result:=USR_GetMethodAcces ("ACTpp_CRYPTTC";0)
		If (($ptr2->) & ($result))
			$vt_retorno:=ACTpp_CRYPTTC ("xxACT_GetDecryptTC";$ptr1)
		Else 
			$vt_retorno:=ACTpp_CRYPTTC ("xxACT_GetDecryptTCWithFormat";$ptr1)
		End if 
		
	: ($vt_accion="onLoadPagos")
		$ptr1->:=ACTpp_CRYPTTC ("xxACT_GetDecryptTCWithFormat";->[Personas:7]ACT_Numero_TC:54)
		viACT_campoModificable:=0
		ACTpp_CRYPTTC ("seteaEstadoObjetosFormPagos";->viACT_campoModificable;$ptr1)
		
	: ($vt_accion="onClickedPagos")
		If (viACT_campoModificable=0)
			$result:=USR_GetMethodAcces ("ACTpp_CRYPTTC")
			viACT_campoModificable:=Num:C11(Not:C34($result))
			If (viACT_campoModificable=0)
				viACT_campoModificable:=1
				$ptr1->:=""
				GOTO OBJECT:C206($ptr1->)
			Else 
				viACT_campoModificable:=0
			End if 
			ACTpp_CRYPTTC ("seteaEstadoObjetosFormPagos";->viACT_campoModificable;$ptr1)
		End if 
		
	: ($vt_accion="seteaEstadoObjetosFormPagos")
		IT_SetEnterable ($ptr1->=1;0;$ptr2)
		
		OBJECT SET VISIBLE:C603(*;"Unlocked";$ptr1->=1)
		OBJECT SET VISIBLE:C603(*;"Locked";$ptr1->=0)
		
		
End case 
$0:=$vt_retorno