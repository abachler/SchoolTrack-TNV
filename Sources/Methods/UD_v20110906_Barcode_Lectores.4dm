//%attributes = {}
  // MÉTODO: UD_v20110906_Barcode_Lectores
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/09/11, 10:17:55
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // UD_v20110906_Barcode_Lectores()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL
  //20110906 RCH Se agrega termometro
C_LONGINT:C283($vl_proc)

READ WRITE:C146([BBL_Lectores:72])
ALL RECORDS:C47([BBL_Lectores:72])

$vl_proc:=IT_UThermometer (1;0;"Verificando códigos de barra")
QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Código_de_barra:10="*@")
QUERY SELECTION BY FORMULA:C207([BBL_Lectores:72];Picture size:C356([BBL_Lectores:72]CodigoBarra_Imagen:36)=0)


ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];$aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando códigos de barra faltantes...")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([BBL_Lectores:72])
	GOTO RECORD:C242([BBL_Lectores:72];$aRecNums{$i})
	$barCodeType:="Code39"
	$createchecksum:=False:C215
	$showchecksum:=False:C215
	$printCode:=True:C214
	[BBL_Lectores:72]CodigoBarra_Imagen:36:=Barcode_creaCodigo ($barCodeType;Replace string:C233([BBL_Lectores:72]Código_de_barra:10;"*";"");$createchecksum;$showchecksum;$printCode)
	[BBL_Lectores:72]CodigoBarra_Imagen:36:=[BBL_Lectores:72]CodigoBarra_Imagen:36*0.8
	SAVE RECORD:C53([BBL_Lectores:72])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
IT_UThermometer (-2;$vl_proc)
  //20110906 RCH Se agrega descarga de registro
KRL_UnloadReadOnly (->[BBL_Lectores:72])
