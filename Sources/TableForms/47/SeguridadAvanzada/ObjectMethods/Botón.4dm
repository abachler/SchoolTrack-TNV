C_OBJECT:C1216($ob_Configuracion)
C_LONGINT:C283($l_Valor;$l_resp)

$y_proximoInicio:=OBJECT Get pointer:C1124(Object named:K67:5;"Casilla_ProximoInicio")
If ($y_proximoInicio->=1)
	$l_resp:=CD_Dlog (0;"Se marcó la opción de cambio de contraseña en el próximo inicio de sesión para todos los usuarios";"";"Aceptar";"Cancelar")
	If ($l_resp=1)
		  //cambiar campo en todos los usuarios. caducacion de contrseña.
		ALL RECORDS:C47([xShell_Users:47])
		READ WRITE:C146([xShell_Users:47])
		SELECTION TO ARRAY:C260([xShell_Users:47];$al_RecNum)
		For ($i;1;Size of array:C274($al_RecNum))
			GOTO RECORD:C242([xShell_Users:47];$al_RecNum{$i})
			[xShell_Users:47]CambiarPassw_proximaSesion:26:=True:C214
			SAVE RECORD:C53([xShell_Users:47])
		End for 
		KRL_UnloadReadOnly (->[xShell_Users:47])
	End if 
End if 
$ob_Configuracion:=OB_Create 
OB_SET_Text ($ob_Configuracion;"GuardaObjeto";"accion")
$ob_Configuracion:=STR_SegAvanzada (->$ob_Configuracion)
PREF_SetObject (0;"PreferenciaContraseñas";$ob_Configuracion)

  //ABC192154 
$l_Valor:=al_ListaMinMAY{0}+al_ListaMinNum{0}
If ($l_Valor<=al_ListaMaxC{0})
	CANCEL:C270  //cerrar ventana
Else 
	If ($l_Valor>15)
		$l_Valor:=15
	End if 
	$l_resp:=CD_Dlog (0;"La suma entre la cantidad de caracteres mayúsculas ("+String:C10(al_ListaMinMAY{0})+") y numéricos ("+String:C10(al_ListaMinNum{0})+") supera la longitud mínima ("+String:C10(al_ListaMaxC{0})+") ingresada."+"\r"+"\r"+"¿Desea aumentar la longitud mínima a "+String:C10($l_Valor)+"?";"";"Aceptar";"Cancelar")
	If ($l_resp=1)
		al_ListaMaxC{0}:=$l_Valor
		al_ListaMinNum{0}:=0
		al_ListaMinMAY{0}:=0
	End if 
End if 
