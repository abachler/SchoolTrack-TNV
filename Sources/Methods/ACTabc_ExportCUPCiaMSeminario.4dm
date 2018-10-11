//%attributes = {}
  //ACTabc_ExportCUPCiaMSeminario

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($folderPath;$fileName;$text;$filePath;$fecha)
C_LONGINT:C283($cuota;$NumApds;$id)
C_REAL:C285($MontoApo)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))


vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=String:C10(Sum:C1($FieldPtr->);"|Despliegue_ACT")

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)

CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
$NumApds:=0
$id:=IT_UThermometer (1;0;"Generando información para archivo CUP...")
While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
	USE SET:C118("AvisosTodos")
	If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
		DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;>)
		FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
		$NumApds:=$NumApds+1
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Familia_RelacionesFamiliares:77]ID_Familia:2)
		$MontoApo:=0
		$MontoApo:=Sum:C1($FieldPtr->)
		$fecha:=String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"0000")
		$text:="  "+ST_RigthChars ((" "*9)+[Personas:7]RUT:6;9)+ST_LeftChars ([Personas:7]Apellidos_y_nombres:30+(" "*114);114)+ST_RigthChars (("0"*4)+[Familia:78]Codigo_interno:14;4)+ST_RigthChars ((" "*19)+String:C10($MontoApo);19)+" 10"+$fecha+"  00"+(" "*12)+"\r"
		IO_SendPacket ($ref;$text)
	End if 
	USE SET:C118("AvisosTodos")
End while 
IT_UThermometer (-2;$id)
vnumTransCUP:=String:C10($NumApds)
CLOSE DOCUMENT:C267($ref)

CLEAR SET:C117("AvisosTodos")
CLEAR SET:C117("selectionApdo")