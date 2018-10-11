//%attributes = {}
  // UD_v20130825_BarcodeLectores()
  // Por: Alberto Bachler: 17/09/13, 13:46:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_crearCheckSum;$b_imprimirCodigo;$b_mostrarCheckSum)
_O_C_INTEGER:C282($i_registros;$i)
C_TEXT:C284($t_fuenteCodigoBarra;$t_tipoCodigoBarra)


ARRAY LONGINT:C221($al_RecNums;0)
READ WRITE:C146([xxBBL_Preferencias:65])
ALL RECORDS:C47([xxBBL_Preferencias:65])
FIRST RECORD:C50([xxBBL_Preferencias:65])
If ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=0)
	If ([xxBBL_Preferencias:65]PatronBCode_UseRut:37)
		[xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33:=Field:C253(->[BBL_Lectores:72]RUT:7)
	Else 
		[xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33:=Field:C253(->[BBL_Lectores:72]ID:1)
	End if 
	SAVE RECORD:C53([xxBBL_Preferencias:65])
	UNLOAD RECORD:C212([xxBBL_Preferencias:65])
End if 
BBL_LeePrefsCodigosBarra 


$t_tipoCodigoBarra:="Code39"
$b_crearCheckSum:=False:C215
$b_mostrarCheckSum:=False:C215
$b_imprimirCodigo:=True:C214

ARRAY LONGINT:C221($al_RecNums;0)
ALL RECORDS:C47([BBL_Lectores:72])
LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];$al_RecNums;"")

$l_idTermometro:=IT_Progress (1;0;0;"Verificando códigos de barra de lectores...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([BBL_Lectores:72])
	GOTO RECORD:C242([BBL_Lectores:72];$al_RecNums{$i_registros})
	[BBL_Lectores:72]BarCode_SinFormato:38:=Replace string:C233([BBL_Lectores:72]BarCode_SinFormato:38;"*";"")
	If ([BBL_Lectores:72]BarCode_SinFormato:38="")
		BBLpat_GeneraCodigoBarra 
	Else 
		[BBL_Lectores:72]CodigoBarra_Imagen:36:=Barcode_creaCodigo ($t_tipoCodigoBarra;[BBL_Lectores:72]BarCode_SinFormato:38;$b_crearCheckSum;$b_mostrarCheckSum;$b_imprimirCodigo)
	End if 
	SAVE RECORD:C53([BBL_Lectores:72])
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[BBL_Lectores:72])

