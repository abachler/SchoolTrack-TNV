//%attributes = {}
  //ACTabc_ExportCUPIAValdivia

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($folderPath;$fileName;$text;$filePath)
C_TEXT:C284($vt_codFecha;$vText1)
C_REAL:C285($MontoApo)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_DATE:C307($vd_fecha)
C_LONGINT:C283($i;$noCuotas)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Familia:78])
READ ONLY:C145([Familia_RelacionesFamiliares:77])

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
$text:=""
While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
	USE SET:C118("AvisosTodos")
	If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
		DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
		KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
		ORDER BY:C49([Familia:78];[Familia:78]Nombre_de_la_familia:3;>)
		KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
		If (Size of array:C274(<>al_NumeroNivelesActivos)>0)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29>=<>al_NumeroNivelesActivos{1};*)
			QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=<>al_NumeroNivelesActivos{Size of array:C274(<>al_NumeroNivelesActivos)})
		End if 
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;[Alumnos:2]curso:20;>)
		AT_DistinctsFieldValues (->[Alumnos:2]curso:20;->aQR_Text1)
		For ($i;1;Size of array:C274(aQR_Text1))
			aQR_Text1{$i}:=Substring:C12(aQR_Text1{$i};1;Position:C15("-";aQR_Text1{$i})-1)
		End for 
		$vText1:=AT_array2text (->aQR_Text1;"-")
		
		ARRAY REAL:C219(aQR_Real1;0)
		ARRAY LONGINT:C221(aQR_Longint1;0)
		ARRAY LONGINT:C221(aQR_Longint2;0)
		ARRAY INTEGER:C220(aQR_Integer1;0)
		ARRAY TEXT:C222(aQR_Text1;0)
		ARRAY DATE:C224(aQR_Date1;0)
		ARRAY DATE:C224(aQR_Date2;0)
		
		$noCuotas:=ACTabc_ObtieneMesesYAdeudado ("selectionApdo";->aQR_Longint2;->aQR_Integer1;->aQR_Text1;->aQR_Real1;$FieldPtr;->vd_FechaUF;->aQR_Date1;->aQR_Date2)
		
		For ($i;1;$noCuotas)
			USE SET:C118("selectionApdo")
			$vd_fecha:=aQR_Date2{$i}
			Case of 
				: (Day of:C23($vd_fecha)<=1)
					$vt_codFecha:="00"
				: (Day of:C23($vd_fecha)<=5)
					$vt_codFecha:="01"
				: (Day of:C23($vd_fecha)<=10)
					$vt_codFecha:="02"
				: (Day of:C23($vd_fecha)<=15)
					$vt_codFecha:="03"
				: (Day of:C23($vd_fecha)<=20)
					$vt_codFecha:="04"
				: (Day of:C23($vd_fecha)<=25)
					$vt_codFecha:="05"
				Else 
					$vt_codFecha:="06"
			End case 
			
			$vt_codFecha:="02"
			
			C_TEXT:C284($vt_codFamilia;$vt_apellYNombres;$vt_rut;$vt_numCuota;$vt_cantidadCuotas;$vt_montoCuota;$vt_direccion;$vt_curso;$vt_nomFamilia)
			$vt_codFamilia:=ST_RigthChars (("0"*6)+String:C10([Personas:7]No:1);6)
			$vt_apellYNombres:=ST_Uppercase (ST_LeftChars (ST_Uppercase ([Personas:7]Apellidos_y_nombres:30)+(" "*40);40))
			$vt_rut:=ST_RigthChars (("0"*9)+ST_Uppercase ([Personas:7]RUT:6);9)
			$vt_numCuota:=ST_RigthChars (("0"*2)+String:C10($i);2)
			$vt_cantidadCuotas:=ST_RigthChars (("0"*2)+"01";2)
			$vt_montoCuota:=ST_RigthChars (("0"*10)+String:C10(Round:C94(aQR_Real1{$i};0));10)
			$vt_direccion:=ST_LeftChars (ST_Uppercase ([Personas:7]ACT_DireccionEC:67)+(" "*39);39)
			$vt_curso:=ST_LeftChars ($vText1+(" "*6);6)
			$vt_nomFamilia:=ST_LeftChars (ST_Uppercase ([Familia:78]Nombre_de_la_familia:3)+(" "*40);40)
			
			vtotalCUP:=String:C10(Num:C11(vtotalCUP)+Num:C11($vt_montoCuota))
			
			$text:=$vt_codFamilia+$vt_apellYNombres+" "+$vt_rut+" "+$vt_codFecha+" "+$vt_numCuota+" "+$vt_cantidadCuotas+" "+$vt_montoCuota+" "+$vt_direccion+" "+$vt_curso+" "+$vt_nomFamilia+"\r"
			IO_SendPacket ($ref;$text)
			vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
		End for 
	End if 
	USE SET:C118("AvisosTodos")
End while 
CLOSE DOCUMENT:C267($ref)

vtotalCUP:=String:C10(Num:C11(vtotalCUP);"|Despliegue_ACT")
CLEAR SET:C117("AvisosTodos")
CLEAR SET:C117("selectionApdo")