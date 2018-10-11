//%attributes = {}
  // UD_v20130828_BarcodeRegistros()
  // Por: Alberto Bachler: 17/09/13, 13:48:31
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_elemento;$l_IdMedia;$l_numeroEnBarCode;$l_proceso)
C_TEXT:C284($t_prefijo)


BBLdbu_ResuelveDuplicasBarcodes 


ARRAY LONGINT:C221($al_RecNums;0)
READ WRITE:C146([xxBBL_Preferencias:65])
ALL RECORDS:C47([xxBBL_Preferencias:65])
FIRST RECORD:C50([xxBBL_Preferencias:65])
[xxBBL_Preferencias:65]Registro_CampoFuenteBarcode:27:=Field:C253(->[BBL_Registros:66]No_Registro:25)
SAVE RECORD:C53([xxBBL_Preferencias:65])
UNLOAD RECORD:C212([xxBBL_Preferencias:65])
BBL_LeePrefsCodigosBarra 


$t_tipoCodigoBarra:="Code39"
$b_crearCheckSum:=False:C215
$b_mostrarCheckSum:=False:C215
$b_imprimirCodigo:=True:C214


LONGINT ARRAY FROM SELECTION:C647([BBL_Registros:66];$al_RecNums;"")
$l_proceso:=IT_Progress (1;0;0;"Verificando códigos de barra de dosumentos...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([BBL_Registros:66])
	GOTO RECORD:C242([BBL_Registros:66];$al_RecNums{$i_registros})
	$l_indiceStatus:=Find in array:C230(<>aCpyStatus;[BBL_Registros:66]Status:10)
	If ($l_indiceStatus>0)
		[BBL_Registros:66]StatusID:34:=<>aCpyStatusId{$l_indiceStatus}
	End if 
	RELATE ONE:C42([BBL_Registros:66]Número_de_item:1)
	If ([BBL_Registros:66]Código_de_barra:20="")
		BBLreg_GeneraCodigoBarra 
	Else 
		$l_numeroEnBarCode:=Num:C11([BBL_Registros:66]Código_de_barra:20)
		Case of 
			: ([BBL_Registros:66]No_Registro:25=$l_numeroEnBarCode)
				[BBL_Registros:66]Barcode_Protegido:28:=False:C215
			: ([BBL_Registros:66]ID:3=$l_numeroEnBarCode)
				[BBL_Registros:66]Barcode_Protegido:28:=False:C215
		End case 
		[BBL_Registros:66]Barcode_SinFormato:26:=Replace string:C233([BBL_Registros:66]Barcode_SinFormato:26;"*";"")
		[BBL_Registros:66]CodigoBarra_Imagen:24:=Barcode_creaCodigo ($t_tipoCodigoBarra;[BBL_Registros:66]Barcode_SinFormato:26;$b_crearCheckSum;$b_mostrarCheckSum;$b_imprimirCodigo)
	End if 
	SAVE RECORD:C53([BBL_Registros:66])
	$l_proceso:=IT_Progress (0;$l_proceso;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_proceso:=IT_Progress (-1;$l_proceso)
KRL_UnloadReadOnly (->[BBL_Registros:66])

BBLdbu_AsignaLugaresItems 

