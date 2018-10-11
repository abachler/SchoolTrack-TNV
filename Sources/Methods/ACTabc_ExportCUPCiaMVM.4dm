//%attributes = {}
  //ACTabc_ExportCUPCiaMVM

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($folderPath;$fileName;$text;$filePath;$vt_fecha)
C_TEXT:C284($vt_nomEmpresa;$vt_ctaCteEmpresa)
C_LONGINT:C283($vl_correlativo;$vl_noCuotas;$vl_contador;$vl_proc;$i)
C_REAL:C285($vr_MontoApo;$vr_montoTotal)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_DATE:C307($vd_fecha)
C_LONGINT:C283($vl_day;$vl_mes;$vl_agno)

READ ONLY:C145([Personas:7])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Familia:78])

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))


vFechaCUP:=String:C10(Current date:C33(*);7)

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)

ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
$vl_correlativo:=0
$vl_contador:=0
$vr_montoTotal:=0
$vl_correlativo:=Num:C11(PREF_fGet (0;"CorrelativoCUP"+<>gRolBD;String:C10($vl_correlativo)))
$text:=""
$text:="1"+"0841"+"0817103006"+String:C10(Day of:C23(Current date:C33(*));"00")+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Year of:C25(Current date:C33(*));"0000")+(" "*167)+"\r"
IO_SendPacket ($ref;$text)
$vl_proc:=IT_UThermometer (1;0;"Exportando información. Por favor espere un momento...")
While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
	USE SET:C118("AvisosTodos")
	If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
		DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
		While ((Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)<3) & (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124]))))
			NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
		End while 
		$vl_day:=Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
		$vl_mes:=[ACT_Avisos_de_Cobranza:124]Mes:6
		$vl_agno:=[ACT_Avisos_de_Cobranza:124]Agno:7
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		$vr_MontoApo:=0
		$vr_MontoApo:=Sum:C1($FieldPtr->)
		If ([Personas:7]ACT_NoCuotasCup:80#0)
			$vr_MontoApo:=Round:C94($vr_MontoApo/[Personas:7]ACT_NoCuotasCup:80;0)
			$vl_noCuotas:=[Personas:7]ACT_NoCuotasCup:80
		Else 
			$vr_MontoApo:=Round:C94($vr_MontoApo/10;0)
			$vl_noCuotas:=10
		End if 
		QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
		USE SET:C118("selectionApdo")
		$vl_correlativo:=$vl_correlativo+1
		For ($i;1;$vl_noCuotas)
			$vl_contador:=$vl_contador+1
			USE SET:C118("selectionApdo")
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=$vl_mes;*)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Agno:7=$vl_agno)
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;<)
				$vd_fecha:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
			Else 
				$vd_fecha:=ACTut_fFechaValida (DT_GetDateFromDayMonthYear ($vl_day;$vl_mes;$vl_agno))
			End if 
			$vt_fecha:=String:C10(Day of:C23($vd_fecha);"00")+String:C10(Month of:C24($vd_fecha);"00")+String:C10(Year of:C25($vd_fecha);"0000")
			$text:="2"+ST_RigthChars (("0"*9)+ST_Uppercase ([Personas:7]RUT:6);9)+ST_RigthChars (("0"*9);9)+ST_RigthChars (("0"*9)+String:C10($i);9)+ST_RigthChars (("0"*10)+ST_Uppercase ([Personas:7]RUT:6);10)+ST_LeftChars ([Personas:7]Apellidos_y_nombres:30+(" "*40);40)+ST_LeftChars ([Personas:7]ACT_DireccionEC:67+(" "*40);40)+ST_LeftChars ([Personas:7]ACT_ComunaEC:68+(" "*20);20)+ST_LeftChars ([Personas:7]ACT_CiudadEC:69+(" "*20);20)+"1"+ST_RigthChars (("0"*10)+String:C10($vr_MontoApo);10)+"00000"+$vt_fecha+"N"+"N"+(" "*6)+"\r"
			IO_SendPacket ($ref;$text)
			$vl_mes:=$vl_mes+1
			If ($vl_mes=13)
				$vl_mes:=1
				$vl_agno:=$vl_agno+1
			End if 
			$vr_montoTotal:=$vr_montoTotal+$vr_MontoApo
		End for 
	End if 
	USE SET:C118("AvisosTodos")
End while 
IT_UThermometer (-2;$vl_proc)
vnumTransCUP:=String:C10($vl_contador)
vtotalCUP:=String:C10($vr_montoTotal;"|Despliegue_ACT")
$text:="4"+ST_RigthChars (("0"*6)+String:C10($vl_contador);6)+ST_RigthChars (("0"*10)+String:C10(Num:C11(vtotalCUP));10)+("0"*5)+(" "*168)
IO_SendPacket ($ref;$text)
CLOSE DOCUMENT:C267($ref)

CLEAR SET:C117("AvisosTodos")
CLEAR SET:C117("selectionApdo")
PREF_Set (0;"CorrelativoCUP"+<>gRolBD;String:C10($vl_correlativo))