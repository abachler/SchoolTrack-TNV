//%attributes = {}
  // BBLpat_ConfigCodigosBarra()
  // Por: Alberto Bachler: 17/09/13, 13:27:26
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

_O_C_INTEGER:C282($i)
C_LONGINT:C283($l_campoAnterior;$l_Error;$l_indexIdentificador;$l_nuevoCampo;$l_opcionUsuario;$l_procesoProgreso)
C_TEXT:C284($t_campo;$t_campoAnterior;$t_nuevoCampo;$t_Textolog)

ARRAY LONGINT:C221($aRecNums;0)
If (False:C215)
	C_LONGINT:C283(BBLpat_ConfigCodigosBarra ;$1)
End if 
$l_indexIdentificador:=$1

If ($l_indexIdentificador=0)
	$t_nuevoCampo:=__ ("Identificador Interno")
	$l_nuevoCampo:=Field:C253(->[BBL_Lectores:72]ID:1)
Else 
	$t_nuevoCampo:=<>at_IDNacional_Names{$l_indexIdentificador}
	Case of 
		: ($l_indexIdentificador=1)
			$l_nuevoCampo:=Field:C253(->[BBL_Lectores:72]RUT:7)
		: ($l_indexIdentificador=2)
			$l_nuevoCampo:=Field:C253(->[BBL_Lectores:72]IDNacional_2:33)
		: ($l_indexIdentificador=3)
			$l_nuevoCampo:=Field:C253(->[BBL_Lectores:72]IDNacional_3:34)
	End case 
End if 

$l_campoAnterior:=[xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33
Case of 
	: ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=Field:C253(->[BBL_Lectores:72]ID:1))
		$t_campoAnterior:=__ ("Identificador interno")
	: ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=Field:C253(->[BBL_Lectores:72]RUT:7))
		$t_campoAnterior:=<>at_IDNacional_Names{1}
	: ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=Field:C253(->[BBL_Lectores:72]IDNacional_2:33))
		$t_campoAnterior:=<>at_IDNacional_Names{2}
	: ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=Field:C253(->[BBL_Lectores:72]IDNacional_3:34))
		$t_campoAnterior:=<>at_IDNacional_Names{3}
End case 

If ($l_campoAnterior#$l_nuevoCampo)
	[xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33:=$l_nuevoCampo
	SAVE RECORD:C53([xxBBL_Preferencias:65])
	<>lBBL_refCampoBarcodeLector:=[xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33
End if 

