//%attributes = {}
  //ACTabc_ExportPACCiaMApo

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_POINTER:C301($FieldPtr)
C_TEXT:C284($fileName;$folderPath;$filePath;$line;$fecha;$numTrans)
C_LONGINT:C283($i;$Apdo;$linea)
C_TIME:C306($ref)
C_TEXT:C284($diaFecha;$montoTotal;$footer)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vtotalPAC:=String:C10(Sum:C1($FieldPtr->);"|Despliegue_ACT")

_O_ARRAY STRING:C218(3;aCodigo;0)
_O_ARRAY STRING:C218(15;aRUTPAC;0)
_O_ARRAY STRING:C218(15;aRUTPAC3;0)
_O_ARRAY STRING:C218(8;aFechaCargoCM;0)
ARRAY REAL:C219(aMonto;0)
ARRAY LONGINT:C221(aidsPersonas;0)
ARRAY LONGINT:C221(aidsAvisos;0)

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
		AT_Insert (1;1;->aCodigo;->aRUTPAC;->aMonto;->aidsPersonas;->aRUTPAC3)
		INSERT IN ARRAY:C227(aFechaCargoCM;1;1)
		aidsPersonas{1}:=[Personas:7]No:1
		aCodigo{1}:=ST_RigthChars ("000000"+[Personas:7]ACT_ID_Banco_Cta:48;3)
		aRUTPAC{1}:=ST_Uppercase (ST_RigthChars ("00000000000"+[Personas:7]ACT_RUTTitutal_Cta:50;11))
		aRUTPAC3{1}:=ST_Uppercase (ST_RigthChars ("          "+[Personas:7]ACT_RUTTitutal_Cta:50;10))
		$diaFecha:=ST_Boolean2Str ((cb_DiaApdo=1);String:C10([Personas:7]ACT_DiaCargo:61;"00");String:C10(vl_DiaApdo;"00"))
		aFechaCargoCM{1}:=String:C10(vl_AñoApdo;"0000")+String:C10(vl_MesApdo;"00")+$diaFecha
		aMonto{1}:=$FieldPtr->
	Else 
		aMonto{$linea}:=aMonto{$linea}+$FieldPtr->
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aidsAvisos);"Recopilando información para archivo PAC...")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAC";$fileName)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo PAC...")
For ($i;1;Size of array:C274(aCodigo))
	$line:=aCodigo{$i}+"366001D"+aRUTPAC{$i}+(" "*12)+aRUTPAC3{$i}
	$line:=$line+ST_RigthChars ("000000000"+String:C10(aMonto{$i});9)+"00"+aFechaCargoCM{$i}+aFechaCargoCM{$i}
	$line:=$line+("."*(80-Length:C16($line)))+"\r"
	IO_SendPacket ($ref;$line)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aCodigo);"Generando archivo PAC...")
End for 
$montoTotal:=ST_RigthChars ("000000000"+String:C10(AT_GetSumArray (->aMonto));9)
$numTrans:=ST_RigthChars ("000000"+String:C10(Size of array:C274(aCodigo));6)
$footer:="001366001T"+(" "*33)+$montoTotal+"00"+$numTrans+"N0.................."+"\r"
IO_SendPacket ($ref;$footer)
CLOSE DOCUMENT:C267($ref)
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
vnumTransPAC:=String:C10(Size of array:C274(aCodigo))

AT_Initialize (->aCodigo;->aRUTPAC;->aMonto;->aidsAvisos;->aidsPersonas;->aRUTPAC3)
_O_ARRAY STRING:C218(8;aFechaCargoCM;0)