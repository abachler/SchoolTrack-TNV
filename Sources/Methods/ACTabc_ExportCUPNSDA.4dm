//%attributes = {}
  //ACTabc_ExportCUPNSDA

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($folderPath;$fileName;$text;$filePath;$fecha1;$fecha;$fecha2)
C_LONGINT:C283($cuota;$prevIDApdo;$prevIDCta;$noCuotas;$i)
C_REAL:C285($MontoApo)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vnumTipo1)
C_DATE:C307($vd_fecha)
C_LONGINT:C283($vl_day;$vl_mes;$vl_agno)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=String:C10(Sum:C1($FieldPtr->);"|Despliegue_ACT")

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)

ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
  //vnumTransCUP:=String(Records in selection([ACT_Avisos_de_Cobranza]))
vnumTransCUP:=""
$fecha1:=String:C10(Year of:C25(Current date:C33(*));"0000")+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00")
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
$text:=""
While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
	USE SET:C118("AvisosTodos")
	If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
		$vnumTipo1:=$vnumTipo1+1
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionCta")
		DIFFERENCE:C122("AvisosTodos";"selectionCta";"AvisosTodos")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
		While ((Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)<3) & (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124]))))
			NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
		End while 
		$vl_day:=Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
		$vl_mes:=[ACT_Avisos_de_Cobranza:124]Mes:6
		$vl_agno:=[ACT_Avisos_de_Cobranza:124]Agno:7
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		$MontoApo:=0
		$MontoApo:=Sum:C1($FieldPtr->)
		If ([Personas:7]ACT_NoCuotasCup:80#0)
			$MontoApo:=Round:C94($MontoApo/[Personas:7]ACT_NoCuotasCup:80;0)
			$noCuotas:=[Personas:7]ACT_NoCuotasCup:80
		Else 
			$MontoApo:=Round:C94($MontoApo/10;0)
			$noCuotas:=10
		End if 
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		$text:="0003790"+ST_RigthChars (("0"*8)+Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1);8)+ST_RigthChars ("0"+Substring:C12([Alumnos:2]RUT:5;Length:C16(ST_Uppercase ([Alumnos:2]RUT:5));1);1)+(" "*8)+"1"+(" "*12)+(" "*12)+"1"+"1"+ST_LeftChars (ST_Uppercase ([Personas:7]Apellidos_y_nombres:30)+(" "*35);35)+ST_LeftChars (ST_Uppercase ([Personas:7]ACT_DireccionEC:67)+(" "*40);40)+ST_LeftChars (ST_Uppercase ([Personas:7]ACT_ComunaEC:68)+(" "*15);15)+ST_LeftChars (ST_Uppercase ([Personas:7]ACT_CiudadEC:69)+(" "*15);15)+"1"+(" "*43)+"\r"
		IO_SendPacket ($ref;$text)
		
		For ($i;1;$noCuotas)
			vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
			USE SET:C118("selectionCta")
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=$vl_mes;*)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Agno:7=$vl_agno)
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;<)
				$vd_fecha:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
			Else 
				$vd_fecha:=ACTut_fFechaValida (DT_GetDateFromDayMonthYear ($vl_day;$vl_mes;$vl_agno))
			End if 
			$fecha:=String:C10(Year of:C25($vd_fecha);"0000")+String:C10(Month of:C24($vd_fecha);"00")+String:C10(Day of:C23($vd_fecha);"00")
			$text:="0003790"+ST_RigthChars (("0"*8)+Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1);8)+ST_RigthChars ("0"+Substring:C12(ST_Uppercase ([Alumnos:2]RUT:5);Length:C16([Alumnos:2]RUT:5);1);1)+(" "*8)+"2"+ST_RigthChars ("000"+String:C10($i);3)+ST_RigthChars ("000"+String:C10($noCuotas);3)+ST_RigthChars ("0000000000"+String:C10($MontoApo);10)+"00"+("0"*10)+$fecha+("0"*99)+(" "*40)+"\r"
			IO_SendPacket ($ref;$text)
			$vl_mes:=$vl_mes+1
			If ($vl_mes=13)
				$vl_mes:=1
				$vl_agno:=$vl_agno+1
			End if 
		End for 
		USE SET:C118("AvisosTodos")
		CLEAR SET:C117("selectionCta")
	End if 
	USE SET:C118("AvisosTodos")
End while 
$text:="0003790"+"999999999"+(" "*8)+"9"+$fecha1+ST_RigthChars (("0"*10)+Replace string:C233(Replace string:C233(vtotalCUP;".";"");",";"");10)+("0"*4)+ST_RigthChars (("0"*9)+String:C10($vnumTipo1);9)+ST_RigthChars (("0"*9)+vnumTransCUP;9)+("0"*9)+("0"*9)+(" "*117)+"\r"
IO_SendPacket ($ref;$text)
CLOSE DOCUMENT:C267($ref)

CLEAR SET:C117("AvisosTodos")