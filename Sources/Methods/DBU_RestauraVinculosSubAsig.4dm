//%attributes = {}
  //DBU_RestauraVinculosSubAsig

C_BLOB:C604($blob)
C_POINTER:C301($nilPointer)

EVS_LoadStyles 
PERIODOS_Init 

CREATE EMPTY SET:C140([xxSTR_Subasignaturas:83];"huerfanas")

ALL RECORDS:C47([Asignaturas:18])
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Detectando vínculos corruptos entre Asignaturas y Subasignaturas"))
$text:=""
$vinculosIncorrectos:=False:C215
$text:="Nº Asignatura"+"\t"+"Asignatura"+"\t"+"Curso"+"\t"+"Periodo"+"\t"+"Columna"+"\t"+"Descripción del error"+"\r"+$text
TEXT TO BLOB:C554($text;$blob;Mac text without length:K22:10)
$vinculosIncorrectos:=False:C215
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i})
	QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1)
	CREATE SET:C116([xxSTR_Subasignaturas:83];"todas")
	CREATE EMPTY SET:C140([xxSTR_Subasignaturas:83];"vinculadas")
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	For ($iPeriodos;1;Size of array:C274(atSTR_Periodos_Nombre))
		$reconstruirPropiedades:=False:C215
		atSTR_Periodos_Nombre:=$iPeriodos
		AS_PropEval_Lectura ("";$iPeriodos)
		
		For ($iEvals;1;12)
			If (alAS_EvalPropSourceID{$iEvals}<0)
				READ WRITE:C146([xxSTR_Subasignaturas:83])
				QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1;*)
				QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12=$iPeriodos;*)
				QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=$iEvals)
				Case of 
					: ((Records in selection:C76([xxSTR_Subasignaturas:83])=1) & ([xxSTR_Subasignaturas:83]Name:2=atAS_EvalPropSourceName{$iEvals}))
						  //todo bien
					: ((Records in selection:C76([xxSTR_Subasignaturas:83])=1) & ([xxSTR_Subasignaturas:83]Name:2#atAS_EvalPropSourceName{$iEvals}))
						QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1;*)
						QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12=$iPeriodos;*)
						QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=0;*)
						QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Name:2=atAS_EvalPropSourceName{$iEvals})
						
					: (Records in selection:C76([xxSTR_Subasignaturas:83])>1)
						QUERY SELECTION:C341([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Name:2=atAS_EvalPropSourceName{$iEvals})
						
					: (Records in selection:C76([xxSTR_Subasignaturas:83])=0)
						  //procesado en el case de abajo
				End case 
				
				Case of 
					: (Records in selection:C76([xxSTR_Subasignaturas:83])=0)
						CREATE RECORD:C68([xxSTR_Subasignaturas:83])
						[xxSTR_Subasignaturas:83]LongID:7:=-[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{$iEvals}
						[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Periodo:12:=$iPeriodos
						[xxSTR_Subasignaturas:83]Columna:13:=$iEvals
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
						ADD TO SET:C119([xxSTR_Subasignaturas:83];"vinculadas")
						alAS_EvalPropSourceID{$iEvals}:=[xxSTR_Subasignaturas:83]LongID:7
						atAS_EvalPropSourceName{$iEvals}:=[xxSTR_Subasignaturas:83]Name:2
						$vinculosIncorrectos:=True:C214
						$reconstruirPropiedades:=True:C214
						$error:="ERROR: Subasignatura inexistente. La subasignatura fue creada."
						$text:="["+String:C10([Asignaturas:18]Numero:1)+"]"+"\t"+[Asignaturas:18]denominacion_interna:16+"\t"+[Asignaturas:18]Curso:5+"\t"+atSTR_Periodos_Nombre{$iPeriodos}+"\t"+String:C10($iEvals)+"\t"+$error+"\r"
						TEXT TO BLOB:C554($text;$blob;Mac text without length:K22:10;*)
						
						
					: (Records in selection:C76([xxSTR_Subasignaturas:83])>1)
						CREATE SET:C116([xxSTR_Subasignaturas:83];"temp")
						ARRAY LONGINT:C221($aSubAsigRecNums;0)
						LONGINT ARRAY FROM SELECTION:C647([xxSTR_Subasignaturas:83];$aSubAsigRecNums;"")
						$goodRecNum:=-1
						For ($iSubAsg;1;Size of array:C274($aSubAsigRecNums))
							READ WRITE:C146([xxSTR_Subasignaturas:83])
							GOTO RECORD:C242([xxSTR_Subasignaturas:83];$aSubAsigRecNums{$iSubAsg})
							  //MONO TICKET 187315
							  //ASsev_InitArrays 
							  //$offset:=0
							  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
							  //For ($j;1;Size of array(aSubEvalArrPtr))
							  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;aRealSubEvalArrPtr{$j})
							  //End for 
							  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalP1)
							  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalControles)
							  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalPresentacion)
							ARRAY REAL:C219(aRealSubEvalP1;0)
							OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalP1;"aRealSubEvalP1")
							
							$sumSubasignatura:=AT_GetSumArray (->aRealSubEvalP1;True:C214)
							If ($sumSubasignatura>0)
								ADD TO SET:C119([xxSTR_Subasignaturas:83];"vinculadas")
								alAS_EvalPropSourceID{$iEvals}:=[xxSTR_Subasignaturas:83]LongID:7
								atAS_EvalPropSourceName{$iEvals}:=[xxSTR_Subasignaturas:83]Name:2
								[xxSTR_Subasignaturas:83]Periodo:12:=$iPeriodos
								[xxSTR_Subasignaturas:83]Columna:13:=$iEvals
								SAVE RECORD:C53([xxSTR_Subasignaturas:83])
								$goodRecNum:=Record number:C243([xxSTR_Subasignaturas:83])
								$reconstruirPropiedades:=True:C214
								REMOVE FROM SET:C561([xxSTR_Subasignaturas:83];"temp")
							End if 
						End for 
						If ($goodRecNum<0)
							USE SET:C118("temp")
							REDUCE SELECTION:C351([xxSTR_Subasignaturas:83];1)
							REMOVE FROM SET:C561([xxSTR_Subasignaturas:83];"temp")
						End if 
						USE SET:C118("temp")
						CLEAR SET:C117("temp")
						KRL_DeleteSelection (->[xxSTR_Subasignaturas:83];False:C215)
						$vinculosIncorrectos:=True:C214
						$error:="ALERTA: Mas de una asignatura vinculada. Se reestableció el vínculo privilegiando"+" la subasignatura con evaluaciones registradas."
						$text:="["+String:C10([Asignaturas:18]Numero:1)+"]"+"\t"+[Asignaturas:18]denominacion_interna:16+"\t"+[Asignaturas:18]Curso:5+"\t"+atSTR_Periodos_Nombre{$iPeriodos}+"\t"+String:C10($iEvals)+"\t"+$error+"\r"
						TEXT TO BLOB:C554($text;$blob;Mac text without length:K22:10;*)
						
					Else 
						ADD TO SET:C119([xxSTR_Subasignaturas:83];"vinculadas")
						alAS_EvalPropSourceID{$iEvals}:=[xxSTR_Subasignaturas:83]LongID:7
						atAS_EvalPropSourceName{$iEvals}:=[xxSTR_Subasignaturas:83]Name:2
						[xxSTR_Subasignaturas:83]Periodo:12:=$iPeriodos
						[xxSTR_Subasignaturas:83]Columna:13:=$iEvals
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
						$reconstruirPropiedades:=True:C214
						
				End case 
			End if 
		End for 
		If ($reconstruirPropiedades)
			If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
				AS_PropEval_Escritura ($l_Periodos)
			Else 
				AS_PropEval_Escritura (0)
			End if 
		End if 
	End for 
	
	DIFFERENCE:C122("todas";"vinculadas";"huachas")
	UNION:C120("huerfanas";"huachas";"huerfanas")
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Detectando vínculos corruptos entre Asignaturas y Subasignaturas"))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

USE SET:C118("huerfanas")
SET_ClearSets ("todas";"vinculadas";"huachas";"huerfanas")
READ WRITE:C146([xxSTR_Subasignaturas:83])
APPLY TO SELECTION:C70([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Columna:13:=0)
UNLOAD RECORD:C212([xxSTR_Subasignaturas:83])
READ ONLY:C145([xxSTR_Subasignaturas:83])
  //KRL_DeleteSelection (->[xxSTR_Subasignaturas])


If ($vinculosIncorrectos)
	$msg:="Se detectaron vínculos corruptos entre "+String:C10(Records in set:C195("asignaturas"))+" asignaturas y una o más subasignaturas .\rEl detalle puede ser consultado en el t"+"exto de"+"l r"+"eporte"
	$msg:=$msg+"\r\rEs posible reconstruir los vínculos pero las notas de las subasignaturas daña"+"das no podrán ser recuperadas."
	$msg:=$msg+"\r\rSi desea reconstruir los vínculos dañados le recomendamos vivamente hacer un re"+"spaldo de su base de datos y ejecutar nuevamente este comando antes de utilizar l"+"a opc"+"ión de reparación"
	$executeCode:=CD_ReportProblem ("*";$msg;$blob)
End if 
