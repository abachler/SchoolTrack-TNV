//%attributes = {}
  //ACTabc_ExportCUPStMargarets_Old

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_TEXT:C284($folderPath;$fileName;$text;$filePath;$fecha)
C_LONGINT:C283($cuota;$prevIDApdo)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_REAL:C285($uf;$valor;$valorInt;$valorDec)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=String:C10(Sum:C1($FieldPtr->);"|Despliegue_ACT")

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Personas:7])
ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
vnumTransCUP:=String:C10(Records in selection:C76([ACT_Avisos_de_Cobranza:124]))
FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
$prevIDApdo:=0
$text:=""
While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
	If ([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3#$prevIDApdo)
		$cuota:=1
		$prevIDApdo:=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
	End if 
	If ([Personas:7]ACT_CiudadEC:69="")
		[Personas:7]ACT_CiudadEC:69:="NO INFORMA"
	End if 
	$fecha:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")
	$uf:=ACTut_fValorUF ([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
	$valor:=Round:C94($FieldPtr->/$uf;2)
	$valorInt:=Int:C8($valor)
	$valorDec:=Dec:C9($valor)
	$text:="000"+"3491099"+"000000000"+String:C10($valorInt;"00")+String:C10($valorDec*100;"00")+"00"+$fecha+ST_RigthChars ("0000000000"+Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1);10)+(" "*10)
	$text:=$text+ST_RigthChars ("000"+String:C10($cuota);3)+ST_RigthChars ("0000000000"+Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1);9)+Substring:C12([Personas:7]RUT:6;Length:C16([Personas:7]RUT:6))
	$text:=$text+ST_LeftChars ([Personas:7]Apellidos_y_nombres:30+(" "*50);50)+ST_LeftChars ([Personas:7]ACT_DireccionEC:67+(" "*50);50)+ST_LeftChars ([Personas:7]ACT_CiudadEC:69+(" "*30);30)+"1"+"\r"
	IO_SendPacket ($ref;$text)
	NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
	$cuota:=$cuota+1
End while 
CLOSE DOCUMENT:C267($ref)
