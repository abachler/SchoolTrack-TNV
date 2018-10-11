//%attributes = {}
  //SRACTbol_CargaDatosTercero

C_LONGINT:C283($id_tercero;$bol)
C_POINTER:C301($varPtr)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 

Case of 
	: ($vt_accion="LimpiaVars")
		$bol:=$ptr1->
		$varPtr:=Get pointer:C304("vtACT_SRbol_TerNombre"+String:C10($bol))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("vtACT_SRbol_RUTTer"+String:C10($bol))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("vtACT_SRbol_TerRSocial"+String:C10($bol))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("vtACT_SRBol_TerGiro"+String:C10($bol))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("alACT_SRbol_TerDireccion"+String:C10($bol))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("vtACT_SRBol_TerComuna"+String:C10($bol))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("atACT_SRbol_TerCiudad"+String:C10($bol))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("atACT_SRbol_TerFono"+String:C10($bol))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("atACT_SRbol_TerMail"+String:C10($bol))
		$varPtr->:=""
		
	: ($vt_accion="DeclaraVars")
		C_TEXT:C284(vtACT_SRbol_TerNombre1;vtACT_SRbol_TerNombre2;vtACT_SRbol_TerNombre3;vtACT_SRbol_TerNombre4)
		C_TEXT:C284(vtACT_SRbol_RUTTer1;vtACT_SRbol_RUTTer2;vtACT_SRbol_RUTTer3;vtACT_SRbol_RUTTer4)
		C_TEXT:C284(vtACT_SRbol_TerRSocial1;vtACT_SRbol_TerRSocial2;vtACT_SRbol_TerRSocial3;vtACT_SRbol_TerRSocial4)
		C_TEXT:C284(vtACT_SRBol_TerGiro1;vtACT_SRBol_TerGiro2;vtACT_SRBol_TerGiro3;vtACT_SRBol_TerGiro4)
		C_TEXT:C284(alACT_SRbol_TerDireccion1;alACT_SRbol_TerDireccion2;alACT_SRbol_TerDireccion3;alACT_SRbol_TerDireccion4)
		C_TEXT:C284(vtACT_SRBol_TerComuna1;vtACT_SRBol_TerComuna2;vtACT_SRBol_TerComuna3;vtACT_SRBol_TerComuna4)
		C_TEXT:C284(atACT_SRbol_TerCiudad1;atACT_SRbol_TerCiudad2;atACT_SRbol_TerCiudad3;atACT_SRbol_TerCiudad4)
		C_TEXT:C284(atACT_SRbol_TerFono1;atACT_SRbol_TerFono2;atACT_SRbol_TerFono3;atACT_SRbol_TerFono4)
		C_TEXT:C284(atACT_SRbol_TerMail1;atACT_SRbol_TerMail2;atACT_SRbol_TerMail3;atACT_SRbol_TerMail4)
		
	: ($vt_accion="LlenaVars")
		$id_tercero:=$ptr1->
		$bol:=$ptr2->
		QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=$id_tercero)
		$varPtr:=Get pointer:C304("vtACT_SRbol_TerNombre"+String:C10($bol))
		$varPtr->:=[ACT_Terceros:138]Nombre_Completo:9
		$varPtr:=Get pointer:C304("vtACT_SRbol_RUTTer"+String:C10($bol))
		$varPtr->:=[ACT_Terceros:138]RUT:4
		$varPtr:=Get pointer:C304("vtACT_SRbol_TerRSocial"+String:C10($bol))
		$varPtr->:=[ACT_Terceros:138]Razon_Social:3
		$varPtr:=Get pointer:C304("vtACT_SRBol_TerGiro"+String:C10($bol))
		$varPtr->:=[ACT_Terceros:138]Giro:8
		$varPtr:=Get pointer:C304("alACT_SRbol_TerDireccion"+String:C10($bol))
		$varPtr->:=[ACT_Terceros:138]Direccion:5
		$varPtr:=Get pointer:C304("vtACT_SRBol_TerComuna"+String:C10($bol))
		$varPtr->:=[ACT_Terceros:138]Comuna:6
		$varPtr:=Get pointer:C304("atACT_SRbol_TerCiudad"+String:C10($bol))
		$varPtr->:=[ACT_Terceros:138]Ciudad:7
		$varPtr:=Get pointer:C304("atACT_SRbol_TerFono"+String:C10($bol))
		$varPtr->:=[ACT_Terceros:138]Telefono:11
		$varPtr:=Get pointer:C304("atACT_SRbol_TerMail"+String:C10($bol))
		$varPtr->:=[ACT_Terceros:138]EMail:13
		
End case 