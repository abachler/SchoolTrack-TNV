//%attributes = {}
  // BBL_dcCreateCopy()
  // Por: Alberto Bachler: 17/09/13, 12:26:16
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_campoFuenteBarCode)


READ ONLY:C145([BBL_Registros:66])
SCAN INDEX:C350([BBL_Registros:66]No_Registro:25;1;<)
Mti_BarCode:=[BBL_Registros:66]No_Registro:25+1
CREATE RECORD:C68([BBL_Registros:66])
[BBL_Registros:66]Número_de_item:1:=[BBL_Items:61]Numero:1
[BBL_Registros:66]ID:3:=SQ_SeqNumber (->[BBL_Registros:66]ID:3)
[BBL_Registros:66]No_Registro:25:=SQ_SeqNumber (->[BBL_Registros:66]No_Registro:25)
$y_campoFuenteBarCode:=Field:C253(Table:C252(->[BBL_Registros:66]);<>lBBL_refCampoBarcodeDocumento)
[BBL_Registros:66]Número_de_copia:2:=[BBL_Items:61]Copias:24+1
[BBL_Registros:66]Fecha_de_ingreso:5:=Current date:C33
[BBL_Registros:66]Creado_por:16:=<>tUSR_CurrentUser
[BBL_Registros:66]StatusID:34:=Disponible
BBLreg_GeneraCodigoBarra 
SAVE RECORD:C53([BBL_Registros:66])
SQ_RestauraSecuencias (->[BBL_Registros:66]No_Registro:25)
READ ONLY:C145([BBL_Registros:66])
SCAN INDEX:C350([BBL_Registros:66]No_Registro:25;1;<)
Mti_BarCode:=[BBL_Registros:66]No_Registro:25+1
[BBL_Items:61]Copias:24:=[BBL_Items:61]Copias:24+1
[BBL_Items:61]Copias_disponibles:43:=[BBL_Items:61]Copias_disponibles:43+1
If ([BBL_Registros:66]Número_de_copia:2>[BBL_Items:61]UltimoNumeroDeCopia:49)
	[BBL_Items:61]UltimoNumeroDeCopia:49:=[BBL_Registros:66]Número_de_copia:2
End if 
SAVE RECORD:C53([BBL_Items:61])

