//%attributes = {}
  //ACTabc_ExportPATCiaMSeminario

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_POINTER:C301($FieldPtr)
C_TEXT:C284($fileName;$folderPath;$filePath;$line)
C_LONGINT:C283($i;$Apdo;$linea)
C_TIME:C306($ref)
C_BOOLEAN:C305($cond)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vtotalPAT:=String:C10(Sum:C1($FieldPtr->);"|Despliegue_ACT")
vfechaPAT:=String:C10(Current date:C33(*);7)

_O_ARRAY STRING:C218(2;aIndicador;0)
ARRAY REAL:C219(aMonto;0)
ARRAY TEXT:C222(aNumTarjeta;0)
_O_ARRAY STRING:C218(5;aVencTarjeta;0)
ARRAY TEXT:C222(aNombre;0)
_O_ARRAY STRING:C218(5;aNum;0)
ARRAY TEXT:C222(aRUT;0)
ARRAY LONGINT:C221(aidsPersonas;0)
ARRAY LONGINT:C221(aidsAvisos;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aidsAvisos;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recopilando información para archivo PAT...")
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
		AT_Insert (1;1;->aIndicador;->aMonto;->aNumTarjeta;->aNombre;->aRUT;->aVencTarjeta;->aidsPersonas)
		INSERT IN ARRAY:C227(aNum;1;1)
		aidsPersonas{1}:=[Personas:7]No:1
		aIndicador{1}:="V"
		aMonto{1}:=$FieldPtr->
		aNumTarjeta{1}:=Replace string:C233([Personas:7]ACT_Numero_TC:54;"_";"")
		$cond:=(([Personas:7]ACT_MesVenc_TC:57#"") & ([Personas:7]ACT_AñoVenc_TC:58#""))
		aVencTarjeta{1}:=[Personas:7]ACT_MesVenc_TC:57+ST_Boolean2Str ($cond;"/")+Substring:C12([Personas:7]ACT_AñoVenc_TC:58;3)
		aNombre{1}:=[Personas:7]ACT_Titular_TC:55
		aRUT{1}:=ST_Uppercase ([Personas:7]ACT_RUTTitular_TC:56)
		aNum{1}:=Substring:C12(String:C10(Year of:C25(Current date:C33(*)));3;2)
	Else 
		aMonto{$linea}:=aMonto{$linea}+$FieldPtr->
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aidsAvisos);"Recopilando información para archivo PAT...")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAT";$fileName)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo PAT...")
SORT ARRAY:C229(aIndicador;aMonto;aNumTarjeta;aVencTarjeta;aNombre;aRUT;>)
For ($i;1;Size of array:C274(aIndicador))
	$line:=aIndicador{$i}+ST_RigthChars ((" "*13)+String:C10(aMonto{$i});13)+ST_LeftChars (aNumTarjeta{$i}+(" "*19);19)+ST_LeftChars (aVencTarjeta{$i}+"     ";5)
	$line:=$line+(" "*8)+ST_LeftChars (aNombre{$i}+(" "*40);40)+ST_LeftChars ("Colegiatura Mensual                                        ";40)+(" "*10)
	$line:=$line+ST_LeftChars (ST_RigthChars ("0000000000"+aRUT{$i};10)+(" "*20);20)+(" "*11)+ST_LeftChars (aNum{$i}+(" "*15);15)+"\r"
	IO_SendPacket ($ref;$line)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aIndicador);"Generando archivo PAT...")
End for 
CLOSE DOCUMENT:C267($ref)
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
vnumTransPAT:=String:C10(Size of array:C274(aIndicador))

AT_Initialize (->aIndicador;->aMonto;->aNumTarjeta;->aNombre;->aRUT;->aVencTarjeta;->aidsPersonas;->aidsAvisos)
_O_ARRAY STRING:C218(5;aNum;0)