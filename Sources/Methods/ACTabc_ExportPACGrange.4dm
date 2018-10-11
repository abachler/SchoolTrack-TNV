//%attributes = {}
  //ACTabc_ExportPACGrange

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_POINTER:C301($FieldPtr)
C_TEXT:C284($fileName;$folderPath;$filePath;$line;$fecha;$numTrans)
C_LONGINT:C283($i;$Apdo;$linea)
C_TIME:C306($ref)
C_TEXT:C284($diaFecha;$montoTotal;$header)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vtotalPAC:=String:C10(Sum:C1($FieldPtr->);"|Despliegue_ACT")

_O_ARRAY STRING:C218(8;aFechaCargoSI;0)
_O_ARRAY STRING:C218(15;aMaternoPAC;0)
_O_ARRAY STRING:C218(15;aPaternoPAC;0)
_O_ARRAY STRING:C218(15;aNombresPAC;0)
_O_ARRAY STRING:C218(15;aCuentaPAC;0)
_O_ARRAY STRING:C218(3;aCodigo;0)
_O_ARRAY STRING:C218(5;aCodPAC;0)
ARRAY REAL:C219(aMonto;0)
ARRAY LONGINT:C221(aidsAvisos;0)
ARRAY LONGINT:C221(aidsPersonas;0)

LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aidsAvisos;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recopilando información para archivo PAC...")
For ($i;1;Size of array:C274(aidsAvisos))
	GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aidsAvisos{$i})
	$Apdo:=Find in field:C653([Personas:7]No:1;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
	If ($Apdo#-1)
		GOTO RECORD:C242([Personas:7];$Apdo)
	Else 
		REDUCE SELECTION:C351([Personas:7];0)
	End if 
	$linea:=Find in array:C230(aidsPersonas;[Personas:7]No:1)
	If ($linea=-1)
		AT_Insert (1;1;->aFechaCargoSI;->aMaternoPAC;->aPaternoPAC;->aNombresPAC;->aCuentaPAC;->aCodigo;->aCodPAC;->aMonto;->aidsPersonas)
		aidsPersonas{1}:=[Personas:7]No:1
		$diaFecha:=ST_Boolean2Str ((cb_DiaApdo=1);String:C10([Personas:7]ACT_DiaCargo:61;"00");String:C10(vl_DiaApdo;"00"))
		aFechaCargoSI{1}:=$diaFecha+String:C10(vl_MesApdo;"00")+String:C10(vl_AñoApdo;"0000")
		vText:=[Personas:7]ACT_Apellido_Paterno_Cta:74
		If (Length:C16(vText)>15)
			aPaternoPAC{1}:=Substring:C12(vText;1;15)
		Else 
			ST_Pad_String (->vText;15;Character code:C91(" ");True:C214)
			aPaternoPAC{1}:=vText
		End if 
		vText:=[Personas:7]ACT_Apellido_Materno_Cta:75
		If (Length:C16(vText)>15)
			aMaternoPAC{1}:=Substring:C12(vText;1;15)
		Else 
			ST_Pad_String (->vText;15;Character code:C91(" ");True:C214)
			aMaternoPAC{1}:=vText
		End if 
		vText:=[Personas:7]ACT_Nombres_Cta:76
		If (Length:C16(vText)>15)
			aNombresPAC{1}:=Substring:C12(vText;1;15)
		Else 
			ST_Pad_String (->vText;15;Character code:C91(" ");True:C214)
			aNombresPAC{1}:=vText
		End if 
		aCuentaPAC{1}:=ST_RigthChars ("000000000000000"+[Personas:7]ACT_Numero_Cta:51;15)
		aCodigo{1}:=ST_RigthChars ("000000"+[Personas:7]ACT_ID_Banco_Cta:48;3)
		vText:=[Personas:7]ACT_CodMandatoPAC:62
		ST_Pad_String (->vText;5;Character code:C91("0");False:C215)
		aCodPAC{1}:=vText
		aMonto{1}:=$FieldPtr->
	Else 
		aMonto{$linea}:=aMonto{$linea}+$FieldPtr->
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aidsAvisos);"Recopilando información para archivo PAC...")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAC";$fileName)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo PAC...")
For ($i;1;Size of array:C274(aFechaCargoSI))
	$line:=aFechaCargoSI{$i}+aPaternoPAC{$i}+aMaternoPAC{$i}+aNombresPAC{$i}+aCuentaPAC{$i}+aCodigo{$i}+aCodPAC{$i}+ST_RigthChars ("0000000000"+String:C10(aMonto{$i});10)+"\r"
	IO_SendPacket ($ref;$line)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aFechaCargoSI);"Generando archivo PAC...")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
CLOSE DOCUMENT:C267($ref)

vnumTransPAC:=String:C10(Size of array:C274(aCodigo))
AT_Initialize (->aFechaCargoSI;->aMaternoPAC;->aPaternoPAC;->aNombresPAC;->aCuentaPAC;->aCodigo;->aCodPAC;->aMonto;->aidsPersonas;->aidsAvisos)