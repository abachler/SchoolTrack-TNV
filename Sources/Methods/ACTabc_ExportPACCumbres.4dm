//%attributes = {}
  //ACTabc_ExportPACCumbres

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_POINTER:C301($FieldPtr)
C_TEXT:C284($fileName;$folderPath;$filePath;$filePath2;$line;$line2;$rut;$col1;$monto;$fecha;$numTrans;$moneda)
C_LONGINT:C283($i;$Apdo;$linea;$y)
C_TIME:C306($ref;$ref2)
C_TEXT:C284($diaFecha;$montoTotal;$header)
C_REAL:C285($montoNum;$montoTotalNum;$val;$EnPeso;$montoX)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

_O_ARRAY STRING:C218(3;aCodigo;0)
_O_ARRAY STRING:C218(2;aRUTPAC1;0)
_O_ARRAY STRING:C218(8;aRUTPAC2;0)
_O_ARRAY STRING:C218(5;aCeros;0)
_O_ARRAY STRING:C218(6;aFechaCargo;0)
_O_ARRAY STRING:C218(4;aMonto1;0)
_O_ARRAY STRING:C218(6;aMonto2;0)
ARRAY TEXT:C222(aNombreFlia;0)
ARRAY LONGINT:C221(aidsAvisos;0)
ARRAY LONGINT:C221(aIDsPersonas;0)

LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aidsAvisos;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recopilando información para archivo PAC...")
For ($i;1;Size of array:C274(aidsAvisos))
	GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aidsAvisos{$i})
	$moneda:=[ACT_Avisos_de_Cobranza:124]Moneda:17
	$Apdo:=Find in field:C653([Personas:7]No:1;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
	If ($Apdo#-1)
		GOTO RECORD:C242([Personas:7];$Apdo)
	Else 
		REDUCE SELECTION:C351([Personas:7];0)
	End if 
	$linea:=Find in array:C230(aIDsPersonas;[Personas:7]No:1)
	If ($linea=-1)
		AT_Insert (1;1;->aCodigo;->aRUTPAC1;->aRUTPAC2;->aCeros;->aFechaCargo;->aMonto1;->aMonto2;->aNombreFlia;->aIDsPersonas)
		aIDsPersonas{1}:=[Personas:7]No:1
		aCodigo{1}:=ST_RigthChars ("000000"+[Personas:7]ACT_ID_Banco_Cta:48;3)
		$rut:=ST_Uppercase ([Personas:7]ACT_RUTTitutal_Cta:50)
		If (Length:C16($rut)>8)
			aRUTPAC2{1}:=Substring:C12($rut;Length:C16($rut)-8+1)
			$col1:=Substring:C12($rut;1;Length:C16($rut)-8)
			vText:=$col1
			ST_Pad_String (->vText;2;Character code:C91("0");False:C215)
			aRUTPAC1{1}:=vText
		Else 
			aRUTPAC1{1}:="00"
			vText:=$rut
			ST_Pad_String (->vText;8;Character code:C91("0");False:C215)
			aRUTPAC2{1}:=vText
		End if 
		aCeros{1}:="00000"
		$diaFecha:=ST_Boolean2Str ((cb_DiaApdo=1);String:C10([Personas:7]ACT_DiaCargo:61;"00");String:C10(vl_DiaApdo;"00"))
		aFechaCargo{1}:=Substring:C12(String:C10(vl_AñoApdo);3)+String:C10(vl_MesApdo;"00")+$diaFecha
		
		Case of 
			: ($moneda#"Peso Chileno")
				$val:=ACTut_fValorDivisa ("UF Cumbres")
				$EnPeso:=Round:C94(($FieldPtr->*$val);0)
				$monto:=String:C10($EnPeso)
			Else 
				$monto:=String:C10($FieldPtr->)
		End case 
		
		If (Length:C16($monto)>6)
			aMonto2{1}:=Substring:C12($monto;Length:C16($monto)-6+1)
			$col1:=Substring:C12($monto;1;Length:C16($monto)-6)
			vText:=$col1
			ST_Pad_String (->vText;4;Character code:C91("0");False:C215)
			aMonto1{1}:=vText
		Else 
			aMonto1{1}:="0000"
			vText:=$monto
			ST_Pad_String (->vText;6;Character code:C91("0");False:C215)
			aMonto2{1}:=vText
		End if 
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
		KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
		ORDER BY:C49([Familia:78];[Familia:78]Nombre_de_la_familia:3;>)
		FIRST RECORD:C50([Familia:78])
		aNombreFlia{1}:=ST_GetCleanString ([Familia:78]Nombre_de_la_familia:3)
	Else 
		$monto:=aMonto1{$linea}+aMonto2{$linea}
		
		Case of 
			: ($moneda#"Peso Chileno")
				$val:=ACTut_fValorDivisa ("UF Cumbres")
				$EnPeso:=Round:C94(($FieldPtr->*$val);0)
				$montoX:=$EnPeso
			Else 
				$montoX:=$FieldPtr->
		End case 
		
		$montoNum:=Num:C11($monto)+$montoX
		$monto:=String:C10($montoNum)
		If (Length:C16($monto)>6)
			aMonto2{$linea}:=Substring:C12($monto;Length:C16($monto)-6+1)
			$col1:=Substring:C12($monto;1;Length:C16($monto)-6)
			vText:=$col1
			ST_Pad_String (->vText;4;Character code:C91("0");False:C215)
			aMonto1{$linea}:=vText
		Else 
			aMonto1{$linea}:="0000"
			vText:=$monto
			ST_Pad_String (->vText;6;Character code:C91("0");False:C215)
			aMonto2{$linea}:=vText
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aidsAvisos);"Recopilando información para archivo PAC...")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAC";$fileName)
$ref2:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAC";"INTERNO"+$fileName)

$fecha:=Substring:C12(String:C10(Year of:C25(vd_Fecha3);"0000");3)+String:C10(Month of:C24(vd_Fecha3);"00")+String:C10(Day of:C23(vd_Fecha3);"00")
$numTrans:=ST_RigthChars ("0000000000"+String:C10(Size of array:C274(aCodigo));10)
$montoTotalNum:=0
For ($y;1;Size of array:C274(aMonto1))
	$monto:=aMonto1{$y}+aMonto2{$y}
	$montoTotalNum:=$montoTotalNum+Num:C11($monto)
End for 
vtotalPAC:=String:C10($montoTotalNum;"|Despliegue_ACT")
$montoTotal:=ST_RigthChars ("000000000000"+String:C10($montoTotalNum);12)
$header:="0900010000"+"0798816608"+"001"+$fecha+$numTrans+$montoTotal+"\r"
IO_SendPacket ($ref;$header)
IO_SendPacket ($ref2;$header)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo PAC...")
For ($i;1;Size of array:C274(aCodigo))
	$line:=aCodigo{$i}+aRUTPAC1{$i}+aRUTPAC2{$i}+(" "*12)+aCeros{$i}+aRUTPAC1{$i}+aRUTPAC2{$i}+aFechaCargo{$i}+aMonto1{$i}+aMonto2{$i}+"\r"
	$line2:=aCodigo{$i}+aRUTPAC1{$i}+aRUTPAC2{$i}+(" "*12)+aCeros{$i}+aRUTPAC1{$i}+aRUTPAC2{$i}+aFechaCargo{$i}+aMonto1{$i}+aMonto2{$i}+aNombreFlia{$i}+"\r"
	IO_SendPacket ($ref;$line)
	IO_SendPacket ($ref2;$line2)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aCodigo);"Generando archivo PAC...")
End for 
CLOSE DOCUMENT:C267($ref)
CLOSE DOCUMENT:C267($ref2)
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
vnumTransPAC:=String:C10(Size of array:C274(aCodigo))

AT_Initialize (->aCodigo;->aRUTPAC1;->aRUTPAC1;->aCeros;->aFechaCargo;->aMonto1;->aMonto2;->aNombreFlia;->aIDsPersonas;->aidsAvisos)