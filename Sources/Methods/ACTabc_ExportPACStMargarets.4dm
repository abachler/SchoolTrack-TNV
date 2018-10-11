//%attributes = {}
  //ACTabc_ExportPACStMargarets

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_POINTER:C301($FieldPtr)
C_TEXT:C284($fileName;$folderPath;$filePath;$line;$numTrans)
C_LONGINT:C283($i;$Apdo;$linea)
C_TIME:C306($ref)
C_TEXT:C284($fecha;$montoTotal;$header;$fechaCargo)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vtotalPAC:=String:C10(Sum:C1($FieldPtr->);"|Despliegue_ACT")

_O_ARRAY STRING:C218(15;aRUTPAC;0)
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
		AT_Insert (1;1;->aRUTPAC;->aMonto;->aidsPersonas)
		aidsPersonas{1}:=[Personas:7]No:1
		aRUTPAC{1}:=ST_Uppercase (ST_RigthChars ("000000000"+[Personas:7]ACT_RUTTitutal_Cta:50;9))
		aMonto{1}:=$FieldPtr->
	Else 
		aMonto{$linea}:=aMonto{$linea}+$FieldPtr->
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aidsAvisos);"Recopilando información para archivo PAC...")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAC";$fileName)

EM_ErrorManager ("Clear")
$fecha:=String:C10(Year of:C25(vd_Fecha3);"0000")+String:C10(Month of:C24(vd_Fecha3);"00")+String:C10(Day of:C23(vd_Fecha3);"00")
$fechaCargo:=String:C10(vl_AñoApdo;"0000")+String:C10(vl_MesApdo;"00")+String:C10(vl_DiaApdo;"00")
$numTrans:=ST_RigthChars ("0000000000"+String:C10(Size of array:C274(aRUTPAC)+1);8)
$montoTotal:=ST_RigthChars ("000000000000"+String:C10(AT_GetSumArray (->aMonto));12)
$header:="03006C"+$fecha+$numTrans+$montoTotal+$fechaCargo+(" "*8)+"\r"
IO_SendPacket ($ref;$header)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo PAC...")
For ($i;1;Size of array:C274(aRUTPAC))
	$line:="1"+"00000000000"+Substring:C12(aRUTPAC{$i};1;Length:C16(aRUTPAC{$i})-1)+Substring:C12(aRUTPAC{$i};Length:C16(aRUTPAC{$i}))
	$line:=$line+ST_RigthChars ("0000000000"+String:C10(aMonto{$i});12)+"00"+(" "*15)+"\r"
	IO_SendPacket ($ref;$line)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aRUTPAC);"Generando archivo PAC...")
End for 
CLOSE DOCUMENT:C267($ref)
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
vnumTransPAC:=String:C10(Size of array:C274(aRUTPAC))

AT_Initialize (->aRUTPAC;->aMonto;->aidsAvisos;->aidsPersonas)