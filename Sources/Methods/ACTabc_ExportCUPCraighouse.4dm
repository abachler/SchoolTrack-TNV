//%attributes = {}
  //ACTabc_ExportCUPCraighouse

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($folderPath;$fileName;$text;$filePath;$fecha1;$fecha;$fecha2)
C_LONGINT:C283($cuota;$prevIDApdo;$prevIDCta;$noCuotas;$i)
C_REAL:C285($MontoApo)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vnumTipo1)
C_REAL:C285($vr_montoTotalEntero;$vr_montoTotalDecimal)
C_TEXT:C284($vt_montoSTR;$vt_entero;$vt_decimal)
C_LONGINT:C283(vl_idUt)

ARRAY LONGINT:C221(al_idItems;0)

READ ONLY:C145([Personas:7])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=String:C10(Sum:C1($FieldPtr->);"|Despliegue_ACT")

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)

vnumTransCUP:=""

  //al_idItems
vl_idUt:=IT_UThermometer (1;0;"Exportando archivo cuponera. Un momento por favor...")
$fecha1:=String:C10(Year of:C25(Current date:C33(*));"0000")+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00")
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
FIRST RECORD:C50([ACT_Cargos:173])
While (Not:C34(End selection:C36([ACT_Cargos:173])))
	APPEND TO ARRAY:C911(al_idItems;[ACT_Cargos:173]ID:1)
	NEXT RECORD:C51([ACT_Cargos:173])
End while 
REDUCE SELECTION:C351([ACT_Cargos:173];0)

$text:=""

$text:="190"+"0521"+(" "*9)+(" "*8)+"3"+"001"+ST_LeftChars ("COLEGIATURA"+(" "*12);12)+(" "*160)+"\r"
IO_SendPacket ($ref;$text)
  //$text:="190"+"0521"+(" "*9)+(" "*8)+"3"+"002"+ST_LeftChars ("MATRICULA"+(" "*12);12)+(" "*160)+"\r"
  //IO_SendPacket ($ref;$text)
  //$text:="190"+"0521"+(" "*9)+(" "*8)+"3"+"003"+ST_LeftChars ("SEGURO"+(" "*12);12)+(" "*160)+"\r"
  //IO_SendPacket ($ref;$text)
$text:="190"+"0521"+(" "*9)+(" "*8)+"4"+"001"+ST_LeftChars ("PAGO FUERA VCTO., QUEDA AFECTO A"+(" "*32);32)+(" "*3)+(" "*137)+"\r"
IO_SendPacket ($ref;$text)
$text:="190"+"0521"+(" "*9)+(" "*8)+"4"+"002"+ST_LeftChars ("MULTA, REAJUSTE E INTERESES"+(" "*32);32)+(" "*3)+(" "*137)+"\r"
IO_SendPacket ($ref;$text)

While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
	USE SET:C118("AvisosTodos")
	If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionCta")
		DIFFERENCE:C122("AvisosTodos";"selectionCta";"AvisosTodos")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		
		FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"avisosDeCta")
		
		$MontoApo:=0
		$MontoApo:=ACTabc_SelectionItem2Export (2;"avisosDeCta")
		If ($MontoApo>0)
			$vnumTipo1:=$vnumTipo1+1
			
			$text:="190"+"0521"+ST_RigthChars (("0"*9)+ST_Uppercase ([Personas:7]RUT:6);9)+(" "*8)+"1"+(" "*12)+(" "*12)+"0"+"2"+ST_LeftChars (ST_Uppercase ([Personas:7]Apellidos_y_nombres:30)+(" "*35);35)+ST_LeftChars (ST_Uppercase ([Personas:7]ACT_DireccionEC:67)+(" "*40);40)+ST_LeftChars (ST_Uppercase ([Personas:7]ACT_ComunaEC:68)+(" "*15);15)+ST_LeftChars (ST_Uppercase ([Personas:7]ACT_CiudadEC:69)+(" "*15);15)+"1"+(" "*43)+"\r"
			IO_SendPacket ($ref;$text)
			$MontoApo:=Round:C94($MontoApo/10;2)
			$noCuotas:=10
			$vt_montoSTR:=Replace string:C233(String:C10($MontoApo);".";",")
			$vt_entero:=Substring:C12($vt_montoSTR;1;Position:C15(",";$vt_montoSTR)-1)
			$vt_decimal:=ST_LeftChars (Substring:C12($vt_montoSTR;Position:C15(",";$vt_montoSTR)+1)+"00";2)
			
			For ($i;1;$noCuotas)
				vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
				$vr_montoTotalEntero:=$vr_montoTotalEntero+Num:C11($vt_entero)
				$vr_montoTotalDecimal:=$vr_montoTotalDecimal+Num:C11($vt_decimal)
				USE SET:C118("avisosDeCta")
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=$i+2)
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6;>)
				$fecha:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")
				$text:="190"+"0521"+ST_RigthChars (("0"*9)+ST_Uppercase ([Personas:7]RUT:6);9)+(" "*8)+"2"+ST_RigthChars ("000"+String:C10($i);3)+ST_RigthChars ("000"+String:C10($noCuotas);3)+ST_RigthChars (("0"*10)+$vt_entero;10)+ST_LeftChars ($vt_decimal+"00";2)+("0"*8)+"00"+$fecha+"001"+"002"+"000"+("0"*10)+"00"+"000"+("0"*10)+"00"+"000"+("0"*10)+"00"+"000"+("0"*10)+"00"+"000"+("0"*10)+"00"+"000"+("0"*10)+"00"+"000"+(" "*40)+"\r"
				IO_SendPacket ($ref;$text)
			End for 
		End if 
		CLEAR SET:C117("avisosDeCta")
		USE SET:C118("AvisosTodos")
	End if 
	USE SET:C118("AvisosTodos")
End while 
$text:="190"+"0521"+(" "*9)+(" "*8)+"9"+$fecha1+ST_RigthChars (("0"*10)+String:C10($vr_montoTotalEntero);10)+ST_LeftChars (String:C10($vr_montoTotalDecimal)+("0"*4);4)+ST_RigthChars (("0"*9)+String:C10($vnumTipo1);9)+ST_RigthChars (("0"*9)+vnumTransCUP;9)+ST_RigthChars (("0"*9)+"1";9)+ST_RigthChars (("0"*9)+"2";9)+(" "*117)+"\r"
IO_SendPacket ($ref;$text)
CLOSE DOCUMENT:C267($ref)

CLEAR SET:C117("AvisosTodos")
CLEAR SET:C117("selectionCta")
IT_UThermometer (-2;vl_idUt)