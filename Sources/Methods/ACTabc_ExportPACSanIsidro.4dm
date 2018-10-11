//%attributes = {}
  //ACTabc_ExportPACSanIsidro

  //RCH Modificado 20090311
C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_POINTER:C301($FieldPtr)
C_TEXT:C284($fileName;$folderPath;$filePath;$line;$fecha;$numTrans)
C_LONGINT:C283($i;$Apdo;$linea)
C_TIME:C306($ref)
C_TEXT:C284($diaFecha;$montoTotal;$header)
C_DATE:C307($fechaDate)


$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))
C_POINTER:C301(vQR_Pointer1)
If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
	vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
Else 
	vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
End if 
vtotalPAC:=String:C10(Sum:C1($FieldPtr->);"|Despliegue_ACT")

_O_ARRAY STRING:C218(4;aIdentificador;0)
_O_ARRAY STRING:C218(45;aNombres;0)
_O_ARRAY STRING:C218(8;aRUTPACSD;0)
_O_ARRAY STRING:C218(1;aDV;0)
_O_ARRAY STRING:C218(3;aCodigo;0)
ARRAY REAL:C219(aMonto;0)
_O_ARRAY STRING:C218(8;aFechaCargoSI;0)
ARRAY REAL:C219(aUFs;0)
ARRAY REAL:C219(aValUF;0)
ARRAY TEXT:C222(aBanco;0)
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
		AT_Insert (1;1;->aIdentificador;->aNombres;->aRUTPACSD;->aDV;->aCodigo;->aMonto;->aFechaCargoSI;->aUFs;->aValUF;->aBanco;->aidsPersonas)
		aidsPersonas{1}:=[Personas:7]No:1
		vText:=[Personas:7]ACT_CodMandatoPAC:62
		ST_Pad_String (->vText;4;Character code:C91("0");False:C215)
		aIdentificador{1}:=vText
		vText:=[Personas:7]ACT_Titular_Cta:49
		If (Length:C16(vText)>45)
			aNombres{1}:=Substring:C12(vText;1;45)
		Else 
			ST_Pad_String (->vText;45;Character code:C91(" ");True:C214)
			aNombres{1}:=vText
		End if 
		aRUTPACSD{1}:=ST_RigthChars ("00000000"+Substring:C12([Personas:7]ACT_RUTTitutal_Cta:50;1;Length:C16([Personas:7]ACT_RUTTitutal_Cta:50)-1);8)
		aDV{1}:=ST_Uppercase (Substring:C12([Personas:7]ACT_RUTTitutal_Cta:50;Length:C16([Personas:7]ACT_RUTTitutal_Cta:50)))
		aCodigo{1}:=ST_RigthChars ("000000"+[Personas:7]ACT_ID_Banco_Cta:48;3)
		$diaFecha:=ST_Boolean2Str ((cb_DiaApdo=1);String:C10([Personas:7]ACT_DiaCargo:61;"00");String:C10(vl_DiaApdo;"00"))
		aFechaCargoSI{1}:=$diaFecha+String:C10(vl_MesApdo;"00")+String:C10(vl_AñoApdo;"0000")
		$fechaDate:=DT_GetDateFromDayMonthYear (Num:C11($diaFecha);vl_MesApdo;vl_AñoApdo)
		aMonto{1}:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMPago";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;vQR_Pointer1;$fechaDate))
		aValUF{1}:=Round:C94(ACTut_fValorUF ($fechaDate);2)
		aUFs{1}:=Round:C94(aMonto{1}/aValUF{1};2)
		aBanco{1}:=[Personas:7]ACT_Banco_Cta:47
	Else 
		$diaFecha:=ST_Boolean2Str ((cb_DiaApdo=1);String:C10([Personas:7]ACT_DiaCargo:61;"00");String:C10(vl_DiaApdo;"00"))
		aMonto{$linea}:=aMonto{$linea}+Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMPago";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;vQR_Pointer1;$fechaDate))
		$fechaDate:=DT_GetDateFromDayMonthYear (Num:C11($diaFecha);vl_MesApdo;vl_AñoApdo)
		aValUF{$linea}:=Round:C94(ACTut_fValorUF ($fechaDate);2)
		aUFs{$linea}:=Round:C94(aMonto{$linea}/aValUF{$linea};2)
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aidsAvisos);"Recopilando información para archivo PAC...")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAC";$fileName)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo PAC...")
For ($i;1;Size of array:C274(aIdentificador))
	$line:=aIdentificador{$i}+aNombres{$i}+aRUTPACSD{$i}+aDV{$i}+aCodigo{$i}+ST_RigthChars ("0000000000"+String:C10(aMonto{$i});8)+aFechaCargoSI{$i}+String:C10(aUFs{$i};"0#"+<>tXS_RS_DecimalSeparator+"00")+String:C10(aValUF{$i};"######"+<>tXS_RS_DecimalSeparator+"00")+aBanco{$i}+"\r"
	IO_SendPacket ($ref;$line)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aIdentificador);"Generando archivo PAC...")
End for 
CLOSE DOCUMENT:C267($ref)
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
vnumTransPAC:=String:C10(Size of array:C274(aIdentificador))

AT_Initialize (->aIdentificador;->aNombres;->aRUTPACSD;->aDV;->aCodigo;->aMonto;->aFechaCargoSI;->aUFs;->aValUF;->aBanco;->aidsAvisos;->aidsPersonas)