//%attributes = {}
  //ACTabc_ExportCUPNewland

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_LONGINT:C283($k)

C_TEXT:C284($folderPath;$fileName;$text;$folderName)
C_LONGINT:C283($arrayAnterior;$cuota;$i;$j;$vnumTransCUP;$fileCounter;$mesAnterior)
C_REAL:C285($montoAnterior)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)

ARRAY POINTER:C280(aRNArrayPtrs;0)
ARRAY POINTER:C280(aCIArrayPtrs;0)
ARRAY POINTER:C280(aCFArrayPtrs;0)
ARRAY POINTER:C280(aMontosArrayPtrs;0)
ARRAY POINTER:C280(aFechasIniPtrs;0)
ARRAY LONGINT:C221(aPersonas;0)
ARRAY TEXT:C222(aDocs;0)

$folderName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""

C_POINTER:C301(vQR_Pointer1)
If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
	vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
Else 
	vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
End if 

$vnumTransCUP:=0

$folderPath:=ACTabc_CreaRutaCarpetas ("Archivos Bancarios"+Folder separator:K24:12+"CUP"+Folder separator:K24:12+Substring:C12($folderName;1;Position:C15(".";$folderName)-1)+Folder separator:K24:12)
CREATE FOLDER:C475($folderPath;*)


READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Personas:7])
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"avisosAño")
KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
LONGINT ARRAY FROM SELECTION:C647([Personas:7];aPersonas;"")
INSERT IN ARRAY:C227(aRNArrayPtrs;Size of array:C274(aRNArrayPtrs)+1;1)
INSERT IN ARRAY:C227(aCIArrayPtrs;Size of array:C274(aCIArrayPtrs)+1;1)
INSERT IN ARRAY:C227(aCFArrayPtrs;Size of array:C274(aCFArrayPtrs)+1;1)
INSERT IN ARRAY:C227(aMontosArrayPtrs;Size of array:C274(aMontosArrayPtrs)+1;1)
INSERT IN ARRAY:C227(aFechasIniPtrs;Size of array:C274(aFechasIniPtrs)+1;1)
aRNArrayPtrs{Size of array:C274(aRNArrayPtrs)}:=Bash_Get_Array_By_Type (Is longint:K8:6)
aCIArrayPtrs{Size of array:C274(aCIArrayPtrs)}:=Bash_Get_Array_By_Type (Is longint:K8:6)
aCFArrayPtrs{Size of array:C274(aCFArrayPtrs)}:=Bash_Get_Array_By_Type (Is longint:K8:6)
aMontosArrayPtrs{Size of array:C274(aMontosArrayPtrs)}:=Bash_Get_Array_By_Type (Is real:K8:4)
aFechasIniPtrs{Size of array:C274(aFechasIniPtrs)}:=Bash_Get_Array_By_Type (Is text:K8:3)

GOTO RECORD:C242([Personas:7];aPersonas{1})
USE SET:C118("avisosAño")
QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1)
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"delApdo")
USE SET:C118("delApdo")
$vnumTransCUP:=$vnumTransCUP+Records in selection:C76([ACT_Avisos_de_Cobranza:124])
ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6;>)
FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])

QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6<=3)
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"avisosASacar")
FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])

C_REAL:C285(vQR_Real1)
ARRAY LONGINT:C221(aQR_Longint1;0)
SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;aQR_Longint1)
vQR_Real1:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMEmsion";->aQR_Longint1;vQR_Pointer1;vd_FechaUF))
vtotalCUP:=String:C10(Num:C11(vtotalCUP)+vQR_Real1)
FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])

AT_Insert (0;1;aRNArrayPtrs{1};aCIArrayPtrs{1};aCFArrayPtrs{1};aMontosArrayPtrs{1};aFechasIniPtrs{1})
aRNArrayPtrs{1}->{Size of array:C274(aRNArrayPtrs{1}->)}:=Record number:C243([Personas:7])
aCIArrayPtrs{1}->{Size of array:C274(aCIArrayPtrs{1}->)}:=1
aCFArrayPtrs{1}->{Size of array:C274(aCFArrayPtrs{1}->)}:=1
aMontosArrayPtrs{1}->{Size of array:C274(aMontosArrayPtrs{1}->)}:=vQR_Real1
aFechasIniPtrs{1}->{Size of array:C274(aFechasIniPtrs{1}->)}:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"00")
$montoAnterior:=vQR_Real1
$arrayAnterior:=1
$mesAnterior:=[ACT_Avisos_de_Cobranza:124]Mes:6
$cuota:=1

DIFFERENCE:C122("delApdo";"avisosASacar";"delApdo")
$k:=3
While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
	$k:=$k+1
	USE SET:C118("delApdo")
	QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=$k)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"avisosASacar")
	DIFFERENCE:C122("delApdo";"avisosASacar";"delApdo")
	FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
	
	SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;aQR_Longint1)
	vQR_Real1:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMEmsion";->aQR_Longint1;vQR_Pointer1;vd_FechaUF))
	vtotalCUP:=String:C10(Num:C11(vtotalCUP)+vQR_Real1)
	FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
	
	If ((vQR_Real1=$montoAnterior) & ([ACT_Avisos_de_Cobranza:124]Mes:6#$mesAnterior))
		aCFArrayPtrs{$arrayAnterior}->{Size of array:C274(aCFArrayPtrs{$arrayAnterior}->)}:=aCFArrayPtrs{$arrayAnterior}->{Size of array:C274(aCFArrayPtrs{$arrayAnterior}->)}+1
		$montoAnterior:=vQR_Real1
		$mesAnterior:=[ACT_Avisos_de_Cobranza:124]Mes:6
	Else 
		If ([ACT_Avisos_de_Cobranza:124]Mes:6=$mesAnterior)
			aMontosArrayPtrs{$arrayAnterior}->{Size of array:C274(aMontosArrayPtrs{$arrayAnterior}->)}:=aMontosArrayPtrs{$arrayAnterior}->{Size of array:C274(aMontosArrayPtrs{$arrayAnterior}->)}+vQR_Real1
			$montoAnterior:=aMontosArrayPtrs{$arrayAnterior}->{Size of array:C274(aMontosArrayPtrs{$arrayAnterior}->)}
			$mesAnterior:=[ACT_Avisos_de_Cobranza:124]Mes:6
		Else 
			$cuota:=$cuota+1
			INSERT IN ARRAY:C227(aRNArrayPtrs;Size of array:C274(aRNArrayPtrs)+1;1)
			INSERT IN ARRAY:C227(aCIArrayPtrs;Size of array:C274(aCIArrayPtrs)+1;1)
			INSERT IN ARRAY:C227(aCFArrayPtrs;Size of array:C274(aCFArrayPtrs)+1;1)
			INSERT IN ARRAY:C227(aMontosArrayPtrs;Size of array:C274(aMontosArrayPtrs)+1;1)
			INSERT IN ARRAY:C227(aFechasIniPtrs;Size of array:C274(aFechasIniPtrs)+1;1)
			aRNArrayPtrs{Size of array:C274(aRNArrayPtrs)}:=Bash_Get_Array_By_Type (Is longint:K8:6)
			aCIArrayPtrs{Size of array:C274(aCIArrayPtrs)}:=Bash_Get_Array_By_Type (Is longint:K8:6)
			aCFArrayPtrs{Size of array:C274(aCFArrayPtrs)}:=Bash_Get_Array_By_Type (Is longint:K8:6)
			aMontosArrayPtrs{Size of array:C274(aMontosArrayPtrs)}:=Bash_Get_Array_By_Type (Is real:K8:4)
			aFechasIniPtrs{Size of array:C274(aFechasIniPtrs)}:=Bash_Get_Array_By_Type (Is text:K8:3)
			AT_Insert (0;1;aRNArrayPtrs{Size of array:C274(aRNArrayPtrs)};aCIArrayPtrs{Size of array:C274(aCIArrayPtrs)};aCFArrayPtrs{Size of array:C274(aCFArrayPtrs)};aMontosArrayPtrs{Size of array:C274(aMontosArrayPtrs)};aFechasIniPtrs{Size of array:C274(aFechasIniPtrs)})
			aRNArrayPtrs{Size of array:C274(aRNArrayPtrs)}->{Size of array:C274(aRNArrayPtrs{Size of array:C274(aRNArrayPtrs)}->)}:=Record number:C243([Personas:7])
			aCIArrayPtrs{Size of array:C274(aCIArrayPtrs)}->{Size of array:C274(aCIArrayPtrs{Size of array:C274(aCIArrayPtrs)}->)}:=$cuota
			aCFArrayPtrs{Size of array:C274(aCFArrayPtrs)}->{Size of array:C274(aCFArrayPtrs{Size of array:C274(aCFArrayPtrs)}->)}:=$cuota
			aMontosArrayPtrs{Size of array:C274(aMontosArrayPtrs)}->{Size of array:C274(aMontosArrayPtrs{Size of array:C274(aMontosArrayPtrs)}->)}:=vQR_Real1
			aFechasIniPtrs{Size of array:C274(aFechasIniPtrs)}->{Size of array:C274(aFechasIniPtrs{Size of array:C274(aFechasIniPtrs)}->)}:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"00")
			$montoAnterior:=vQR_Real1
			$arrayAnterior:=Size of array:C274(aCFArrayPtrs)
			$mesAnterior:=[ACT_Avisos_de_Cobranza:124]Mes:6
		End if 
	End if 
	USE SET:C118("delApdo")
End while 

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recopilando información...")
TRACE:C157
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;1/Size of array:C274(aPersonas))
For ($i;2;Size of array:C274(aPersonas))
	GOTO RECORD:C242([Personas:7];aPersonas{$i})
	USE SET:C118("avisosAño")
	QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"delApdo")
	USE SET:C118("delApdo")
	$vnumTransCUP:=$vnumTransCUP+Records in selection:C76([ACT_Avisos_de_Cobranza:124])
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
	$montoAnterior:=MAXLONG:K35:2*-1
	$arrayAnterior:=1
	$fileCounter:=1
	$mesAnterior:=MAXLONG:K35:2*-1
	$cuota:=0
	$k:=2
	While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
		$k:=$k+1
		USE SET:C118("delApdo")
		If ($k=3)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6<=$k)
		Else 
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=$k)
		End if 
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"avisosASacar")
		DIFFERENCE:C122("delApdo";"avisosASacar";"delApdo")
		FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			
			SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;aQR_Longint1)
			vQR_Real1:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMEmsion";->aQR_Longint1;vQR_Pointer1;vd_FechaUF))
			vtotalCUP:=String:C10(Num:C11(vtotalCUP)+vQR_Real1)
			FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
			
			If ((vQR_Real1=$montoAnterior) & ([ACT_Avisos_de_Cobranza:124]Mes:6#$mesAnterior))
				aCFArrayPtrs{$arrayAnterior}->{Size of array:C274(aCFArrayPtrs{$arrayAnterior}->)}:=aCFArrayPtrs{$arrayAnterior}->{Size of array:C274(aCFArrayPtrs{$arrayAnterior}->)}+1
				$montoAnterior:=vQR_Real1
				$mesAnterior:=[ACT_Avisos_de_Cobranza:124]Mes:6
			Else 
				If ([ACT_Avisos_de_Cobranza:124]Mes:6=$mesAnterior)
					aMontosArrayPtrs{$arrayAnterior}->{Size of array:C274(aMontosArrayPtrs{$arrayAnterior}->)}:=aMontosArrayPtrs{$arrayAnterior}->{Size of array:C274(aMontosArrayPtrs{$arrayAnterior}->)}+vQR_Real1
					$montoAnterior:=aMontosArrayPtrs{$arrayAnterior}->{Size of array:C274(aMontosArrayPtrs{$arrayAnterior}->)}
					$mesAnterior:=[ACT_Avisos_de_Cobranza:124]Mes:6
					NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
				Else 
					$cuota:=$cuota+1
					If ($fileCounter>Size of array:C274(aRNArrayPtrs))
						INSERT IN ARRAY:C227(aRNArrayPtrs;Size of array:C274(aRNArrayPtrs)+1;1)
						INSERT IN ARRAY:C227(aCIArrayPtrs;Size of array:C274(aCIArrayPtrs)+1;1)
						INSERT IN ARRAY:C227(aCFArrayPtrs;Size of array:C274(aCFArrayPtrs)+1;1)
						INSERT IN ARRAY:C227(aMontosArrayPtrs;Size of array:C274(aMontosArrayPtrs)+1;1)
						INSERT IN ARRAY:C227(aFechasIniPtrs;Size of array:C274(aFechasIniPtrs)+1;1)
						aRNArrayPtrs{Size of array:C274(aRNArrayPtrs)}:=Bash_Get_Array_By_Type (Is longint:K8:6)
						aCIArrayPtrs{Size of array:C274(aCIArrayPtrs)}:=Bash_Get_Array_By_Type (Is longint:K8:6)
						aCFArrayPtrs{Size of array:C274(aCFArrayPtrs)}:=Bash_Get_Array_By_Type (Is longint:K8:6)
						aMontosArrayPtrs{Size of array:C274(aMontosArrayPtrs)}:=Bash_Get_Array_By_Type (Is real:K8:4)
						aFechasIniPtrs{Size of array:C274(aFechasIniPtrs)}:=Bash_Get_Array_By_Type (Is text:K8:3)
						AT_Insert (0;1;aRNArrayPtrs{Size of array:C274(aRNArrayPtrs)};aCIArrayPtrs{Size of array:C274(aCIArrayPtrs)};aCFArrayPtrs{Size of array:C274(aCFArrayPtrs)};aMontosArrayPtrs{Size of array:C274(aMontosArrayPtrs)};aFechasIniPtrs{Size of array:C274(aFechasIniPtrs)})
						aRNArrayPtrs{Size of array:C274(aRNArrayPtrs)}->{Size of array:C274(aRNArrayPtrs{Size of array:C274(aRNArrayPtrs)}->)}:=Record number:C243([Personas:7])
						aCIArrayPtrs{Size of array:C274(aCIArrayPtrs)}->{Size of array:C274(aCIArrayPtrs{Size of array:C274(aCIArrayPtrs)}->)}:=$cuota
						aCFArrayPtrs{Size of array:C274(aCFArrayPtrs)}->{Size of array:C274(aCFArrayPtrs{Size of array:C274(aCFArrayPtrs)}->)}:=$cuota
						aMontosArrayPtrs{Size of array:C274(aMontosArrayPtrs)}->{Size of array:C274(aMontosArrayPtrs{Size of array:C274(aMontosArrayPtrs)}->)}:=vQR_Real1
						
						aFechasIniPtrs{Size of array:C274(aFechasIniPtrs)}->{Size of array:C274(aFechasIniPtrs{Size of array:C274(aFechasIniPtrs)}->)}:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"00")
					Else 
						AT_Insert (0;1;aRNArrayPtrs{$fileCounter};aCIArrayPtrs{$fileCounter};aCFArrayPtrs{$fileCounter};aMontosArrayPtrs{$fileCounter};aFechasIniPtrs{$fileCounter})
						aRNArrayPtrs{$fileCounter}->{Size of array:C274(aRNArrayPtrs{$fileCounter}->)}:=Record number:C243([Personas:7])
						aCIArrayPtrs{$fileCounter}->{Size of array:C274(aCIArrayPtrs{$fileCounter}->)}:=$cuota
						aCFArrayPtrs{$fileCounter}->{Size of array:C274(aCFArrayPtrs{$fileCounter}->)}:=$cuota
						aMontosArrayPtrs{$fileCounter}->{Size of array:C274(aMontosArrayPtrs{$fileCounter}->)}:=vQR_Real1
						aFechasIniPtrs{$fileCounter}->{Size of array:C274(aFechasIniPtrs{$fileCounter}->)}:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"00")
					End if 
					$arrayAnterior:=$fileCounter
					$fileCounter:=$fileCounter+1
					$montoAnterior:=vQR_Real1
					$mesAnterior:=[ACT_Avisos_de_Cobranza:124]Mes:6
				End if 
			End if 
			
		End if 
		USE SET:C118("delApdo")
		
	End while 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aPersonas))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
DOCUMENT LIST:C474($folderPath;aDocs)
For ($i;1;Size of array:C274(aDocs))
	DELETE DOCUMENT:C159($folderPath+aDocs{$i})
End for 
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivos...")

C_LONGINT:C283($registrosExportados)
For ($i;1;Size of array:C274(aRNArrayPtrs))
	$fileName:=$folderPath+"CUP"+String:C10($i)
	$ref:=Create document:C266($fileName)
	For ($j;1;Size of array:C274(aRNArrayPtrs{$i}->))
		$registrosExportados:=$registrosExportados+1
		GOTO RECORD:C242([Personas:7];aRNArrayPtrs{$i}->{$j})
		$text:="001990"+Substring:C12([Personas:7]RUT:6+(" "*21);1;21)+(" "*9)+" "+(" "*60)+(" "*346)+ST_Uppercase (ST_RigthChars ("0000000000"+Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1);9))+ST_RigthChars ("0"+Substring:C12([Personas:7]RUT:6;Length:C16([Personas:7]RUT:6));1)+ST_LeftChars ([Personas:7]Apellidos_y_nombres:30+(" "*60);60)+ST_LeftChars (<>vsACT_Direccion+(" "*58);58)
		$text:=$text+ST_LeftChars (<>vsACT_Comuna+(" "*20);20)+(" "*456)+ST_RigthChars ("0000"+String:C10(aCFArrayPtrs{$i}->{$j});4)+ST_RigthChars ("000"+String:C10(aCIArrayPtrs{$i}->{$j});3)+ST_RigthChars ("0000000000"+String:C10(aMontosArrayPtrs{$i}->{$j});10)+"0000"+"M"+"N"+aFechasIniPtrs{$i}->{$j}+(" "*14)
		$text:=$text+"\r"
		IO_SendPacket ($ref;$text)
	End for 
	CLOSE DOCUMENT:C267($ref)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aRNArrayPtrs))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
vtotalCUP:=String:C10(Num:C11(vtotalCUP);"|Despliegue_ACT")
vnumTransCUP:=String:C10($registrosExportados)
SET_ClearSets ("avisosAño";"delApdo";"avisosASacar")
For ($i;1;Size of array:C274(aRNArrayPtrs))
	Bash_Return_Variables (aRNArrayPtrs{$i};aCIArrayPtrs{$i};aCFArrayPtrs{$i};aMontosArrayPtrs{$i};aFechasIniPtrs{$i})
End for 
ARRAY POINTER:C280(aRNArrayPtrs;0)
ARRAY POINTER:C280(aCIArrayPtrs;0)
ARRAY POINTER:C280(aCFArrayPtrs;0)
ARRAY POINTER:C280(aMontosArrayPtrs;0)
ARRAY POINTER:C280(aFechasIniPtrs;0)
ARRAY LONGINT:C221(aPersonas;0)
ARRAY TEXT:C222(aDocs;0)