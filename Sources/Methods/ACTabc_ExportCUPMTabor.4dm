//%attributes = {}
  //ACTabc_ExportCUPMTabor

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

ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
$NumApds:=0
$id:=IT_UThermometer (1;0;"Generando información para archivo CUP...")
While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
	USE SET:C118("AvisosTodos")
	If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApod")
		DIFFERENCE:C122("AvisosTodos";"selectionApod";"AvisosTodos")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
		FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
		$NumApds:=$NumApds+1
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		$MontoApo:=0
		$MontoApo:=Sum:C1($FieldPtr->)
		$MontoApo:=Round:C94($MontoApo/[Personas:7]ACT_NoCuotasCup:80;0)
		$fecha:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")
		$text:=("0"*6)+("0"*21)+ST_RigthChars ("000000000"+Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1);9)+ST_Uppercase (ST_RigthChars ("0"+Substring:C12([Personas:7]RUT:6;Length:C16([Personas:7]RUT:6);1);1))+ST_LeftChars ([Personas:7]Apellidos_y_nombres:30+(" "*60);60)+ST_LeftChars ([Personas:7]ACT_DireccionEC:67+(" "*58);58)+ST_LeftChars ([Personas:7]ACT_ComunaEC:68+(" "*20);20)
		$text:=$text+(" "*30)+(" "*30)+(" "*40)+(" "*60)+(" "*58)+(" "*20)+(" "*30)+ST_RigthChars ("000000000"+Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1);9)+ST_Uppercase (ST_RigthChars ("0"+Substring:C12([Personas:7]RUT:6;Length:C16([Personas:7]RUT:6);1);1))+ST_LeftChars ([Personas:7]Apellidos_y_nombres:30+(" "*60);60)+ST_LeftChars ([Personas:7]ACT_DireccionEC:67+(" "*58);58)+ST_LeftChars ([Personas:7]ACT_ComunaEC:68+(" "*20);20)
		$text:=$text+(" "*9)+(" "*1)+(" "*60)+(" "*58)+(" "*20)+(" "*30)+(" "*30)+(" "*40)+(" "*60)+(" "*58)+(" "*20)+(" "*30)+(" "*40)+ST_RigthChars ("0000"+String:C10([Personas:7]ACT_NoCuotasCup:80);4)+"001"+ST_RigthChars ("0000000000"+String:C10($MontoApo);10)+"0000"+"M"+"N"+ST_RigthChars (("0"*8)+$fecha;8)+("0"*15)+"\r"
		IO_SendPacket ($ref;$text)
	End if 
	USE SET:C118("AvisosTodos")
End while 
IT_UThermometer (-2;$id)
vnumTransCUP:=String:C10($NumApds)
CLOSE DOCUMENT:C267($ref)

CLEAR SET:C117("AvisosTodos")
CLEAR SET:C117("selectionApod")