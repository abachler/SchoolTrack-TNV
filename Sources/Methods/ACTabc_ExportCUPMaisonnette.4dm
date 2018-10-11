//%attributes = {}
  //ACTabc_ExportCUPMaisonnette

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($folderPath;$fileName;$text;$filePath;$fecha)
C_TEXT:C284($vt_nomEmpresa;$vt_ctaCteEmpresa)
C_LONGINT:C283($noCuotas)
C_REAL:C285($MontoApo)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_day;$vl_mes;$vl_agno;$i)
C_DATE:C307($vd_fecha)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=String:C10(Sum:C1($FieldPtr->);"|Despliegue_ACT")

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)

ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
vnumTransCUP:=String:C10(Records in selection:C76([ACT_Avisos_de_Cobranza:124]))
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
$text:=""

  //'busco los primeros montos, no. de cuotas para la línea encabezado
USE SET:C118("AvisosTodos")
If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
	QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
	QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
	$MontoApo:=Sum:C1($FieldPtr->)
	If ([Personas:7]ACT_NoCuotasCup:80#0)
		$MontoApo:=Round:C94($MontoApo/[Personas:7]ACT_NoCuotasCup:80;0)
		$noCuotas:=[Personas:7]ACT_NoCuotasCup:80
	Else 
		$MontoApo:=Round:C94($MontoApo/10;0)
		$noCuotas:=10
	End if 
End if 

$vt_nomEmpresa:="FUND. EDUCACIONAL LA MAISONNETTE"
$vt_ctaCteEmpresa:="13517970"

$text:="1"+ST_LeftChars ($vt_nomEmpresa+(" "*37);37)+ST_RigthChars (("0"*8)+$vt_ctaCteEmpresa;8)+"10"+"0"+ST_RigthChars (("0"*9)+String:C10($MontoApo);9)+"000"+ST_RigthChars (("0"*2)+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5));2)+Substring:C12(String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5));3;2)+"01"+ST_RigthChars (("0"*2)+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5));2)+ST_RigthChars (("0"*11)+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1-1);11)+"\r"
IO_SendPacket ($ref;$text)

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
		$MontoApo:=Sum:C1($FieldPtr->)
		If ([Personas:7]ACT_NoCuotasCup:80#0)
			$MontoApo:=Round:C94($MontoApo/[Personas:7]ACT_NoCuotasCup:80;0)
			$noCuotas:=[Personas:7]ACT_NoCuotasCup:80
		Else 
			$MontoApo:=Round:C94($MontoApo/10;0)
			$noCuotas:=10
		End if 
		KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;[Alumnos:2]curso:20;>)
		For ($i;1;$noCuotas)
			USE SET:C118("selectionApdo")
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=$vl_mes;*)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Agno:7=$vl_agno)
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;<)
				$vd_fecha:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
			Else 
				$vd_fecha:=ACTut_fFechaValida (DT_GetDateFromDayMonthYear ($vl_day;$vl_mes;$vl_agno))
			End if 
			$fecha:=String:C10(Day of:C23($vd_fecha);"00")+String:C10(Month of:C24($vd_fecha);"00")+String:C10(Year of:C25($vd_fecha);"0000")
			$fecha:=Substring:C12($fecha;1;4)+Substring:C12($fecha;7;2)
			$text:="2"+ST_RigthChars (("0"*11)+[Alumnos:2]numero_de_matricula:51;11)+ST_LeftChars ([Personas:7]Apellidos_y_nombres:30+(" "*20);20)+ST_RigthChars (("0"*9)+String:C10($MontoApo);9)+"000"+ST_RigthChars (("0"*3)+String:C10($i);3)+ST_RigthChars (("0"*11)+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1);11)+$fecha+"01"+(" "*14)+"\r"
			IO_SendPacket ($ref;$text)
			$vl_mes:=$vl_mes+1
			If ($vl_mes=13)
				$vl_mes:=1
				$vl_agno:=$vl_agno+1
			End if 
		End for 
	End if 
	USE SET:C118("AvisosTodos")
End while 
CLOSE DOCUMENT:C267($ref)

CLEAR SET:C117("AvisosTodos")
CLEAR SET:C117("selectionApdo")