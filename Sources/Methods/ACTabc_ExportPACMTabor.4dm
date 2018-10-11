//%attributes = {}
  //ACTabc_ExportPACMTabor

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

ARRAY TEXT:C222(at_CodBanc;0)
ARRAY TEXT:C222(at_CodEmp;0)
ARRAY TEXT:C222(at_CodConv;0)
_O_ARRAY STRING:C218(1;as_TipoReg;0)
ARRAY TEXT:C222(at_IdServ;0)
ARRAY REAL:C219(ar_Monto;0)
ARRAY TEXT:C222(at_FechaFact;0)
ARRAY TEXT:C222(at_FechaVenc;0)
ARRAY LONGINT:C221(aIDsPersonas;0)
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
		INSERT IN ARRAY:C227(at_CodBanc;1;1)
		INSERT IN ARRAY:C227(at_CodEmp;1;1)
		INSERT IN ARRAY:C227(at_CodConv;1;1)
		INSERT IN ARRAY:C227(as_TipoReg;1;1)
		INSERT IN ARRAY:C227(at_IdServ;1;1)
		INSERT IN ARRAY:C227(ar_Monto;1;1)
		INSERT IN ARRAY:C227(at_FechaFact;1;1)
		INSERT IN ARRAY:C227(at_FechaVenc;1;1)
		INSERT IN ARRAY:C227(aIDsPersonas;1;1)
		aIDsPersonas{1}:=[Personas:7]No:1
		at_CodBanc{1}:=ST_RigthChars ("000"+[Personas:7]ACT_ID_Banco_Cta:48;3)
		at_CodEmp{1}:="000"
		at_CodConv{1}:="001"
		as_TipoReg{1}:="D"
		at_IdServ{1}:=ST_LeftChars (ST_Uppercase ([Personas:7]ACT_RUTTitutal_Cta:50)+(" "*23);23)
		ar_Monto{1}:=$FieldPtr->
		at_FechaFact{1}:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"00")
		$diaFecha:=ST_Boolean2Str ((cb_DiaApdo=1);String:C10([Personas:7]ACT_DiaCargo:61;"00");String:C10(vl_DiaApdo;"00"))
		at_FechaVenc{1}:=String:C10(vl_AñoApdo;"0000")+String:C10(vl_MesApdo;"00")+$diaFecha
	Else 
		ar_Monto{$linea}:=ar_Monto{$linea}+$FieldPtr->
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aidsAvisos);"Recopilando información para archivo PAC...")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAC";$fileName)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo PAC...")
For ($i;1;Size of array:C274(ar_Monto))
	$line:=at_CodBanc{$i}+at_CodEmp{$i}+at_CodConv{$i}+as_TipoReg{$i}+at_IdServ{$i}+(" "*10)+ST_RigthChars (("0"*9)+String:C10(ar_Monto{$i});9)+"00"+at_FechaFact{$i}+at_FechaVenc{$i}+("."*10)+"\r"
	IO_SendPacket ($ref;$line)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(ar_Monto);"Generando archivo PAC...")
End for 
$montoTotal:=ST_RigthChars ("000000000"+String:C10(AT_GetSumArray (->ar_Monto));9)
$numTrans:=ST_RigthChars ("000000"+String:C10(Size of array:C274(ar_Monto));6)
$footer:="001"+at_CodEmp{1}+at_CodConv{1}+"T"+(" "*33)+$montoTotal+"00"+$numTrans+("."*20)+"\r"
IO_SendPacket ($ref;$footer)
CLOSE DOCUMENT:C267($ref)
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
vnumTransPAC:=String:C10(Size of array:C274(ar_Monto))

ARRAY TEXT:C222(at_CodBanc;0)
ARRAY TEXT:C222(at_CodEmp;0)
ARRAY TEXT:C222(at_CodConv;0)
_O_ARRAY STRING:C218(1;as_TipoReg;0)
ARRAY TEXT:C222(at_IdServ;0)
ARRAY REAL:C219(ar_Monto;0)
ARRAY TEXT:C222(at_FechaFact;0)
ARRAY TEXT:C222(at_FechaVenc;0)
ARRAY LONGINT:C221(aIDsPersonas;0)
ARRAY LONGINT:C221(aidsAvisos;0)