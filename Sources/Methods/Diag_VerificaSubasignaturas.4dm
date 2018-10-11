//%attributes = {}
  //Diag_VerificaSubasignaturas

C_BLOB:C604($blob)
C_POINTER:C301($nilPointer)
C_TEXT:C284($email)
C_BOOLEAN:C305($sendMail)



If (Application type:C494=4D Remote mode:K5:5)
	CD_Dlog (0;__ ("La verificación se ejecutará en el servidor. Si se detectan problemas recibirá un correo electrónico en la cuenta: ")+<>tUSR_CurrentUserEmail+__ ("\r\rAdicionalmente se registrará el resultado de la verificación en el Registro de Actividades."))
	$p:=Execute on server:C373(Current method name:C684;128000;Current method name:C684;<>tUSR_CurrentUserEmail)
	
	
Else 
	EVS_LoadStyles 
	PERIODOS_Init 
	
	If (Application type:C494=4D Server:K5:6)
		If (<>bXS_esServidorOficial)  //20150429 ASM Ticket 144325 
			$email:=""
			If (Count parameters:C259>=1)
				$email:=$1
			End if 
			$sendMail:=True:C214
			If (Count parameters:C259=2)
				$sendMail:=$2
			End if 
			If ($email="")
				USR_GetGroupMemberList (-15001)
				For ($i;1;Size of array:C274(<>aMembersID))
					$id:=<>aMembersID{$i}
					KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]No:1;->$id)
					$email:=$email+[xShell_Users:47]email:20+","
				End for 
				$email:=Substring:C12($email;1;Length:C16($email)-1)
			End if 
		Else 
			$sendMail:=True:C214
			$email:="qa@colegium.com"
		End if 
	Else 
		$email:=""
		If (Count parameters:C259>=1)
			$email:=$1
		End if 
		$sendMail:=False:C215
		If (Count parameters:C259=2)
			$sendMail:=$2
		End if 
		If ($email="")
			$email:=<>tUSR_CurrentUserEmail
		End if 
	End if 
	
	CREATE EMPTY SET:C140([xxSTR_Subasignaturas:83];"huerfanas")
	
	ALL RECORDS:C47([Asignaturas:18])
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando vínculos entre Asignaturas y Subasignaturas"))
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
			AS_PropEval_Lectura ("P"+String:C10($iPeriodos))
			
			For ($iEvals;1;12)
				If (alAS_EvalPropSourceID{$iEvals}<0)
					READ WRITE:C146([xxSTR_Subasignaturas:83])
					QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1;*)
					QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12=$iPeriodos;*)
					QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=$iEvals)
					$todoBien:=False:C215
					Case of 
						: ((Records in selection:C76([xxSTR_Subasignaturas:83])=1) & ([xxSTR_Subasignaturas:83]Name:2=atAS_EvalPropSourceName{$iEvals}))
							  //todo bien
							$todoBien:=True:C214
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
								  //ASsev_InitArrays 
								  //$offset:=0
								  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
								  //For ($j;1;Size of array(aRealSubEvalArrPtr))
								  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;aRealSubEvalArrPtr{$j})
								  //End for 
								  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalP1)
								  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalControles)
								  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalPresentacion)
								  //MONO TICKET 187315 
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
							If (Records in selection:C76([xxSTR_Subasignaturas:83])>0)
								KRL_DeleteSelection (->[xxSTR_Subasignaturas:83];False:C215)
								$vinculosIncorrectos:=True:C214
								$error:="ALERTA: Mas de una asignatura vinculada. Se reestableció el vínculo privilegiando"+" la subasignatura con evaluaciones registradas."
								$text:="["+String:C10([Asignaturas:18]Numero:1)+"]"+"\t"+[Asignaturas:18]denominacion_interna:16+"\t"+[Asignaturas:18]Curso:5+"\t"+atSTR_Periodos_Nombre{$iPeriodos}+"\t"+String:C10($iEvals)+"\t"+$error+"\r"
								TEXT TO BLOB:C554($text;$blob;Mac text without length:K22:10;*)
							End if 
						Else 
							ADD TO SET:C119([xxSTR_Subasignaturas:83];"vinculadas")
							If (Not:C34($todoBien))
								alAS_EvalPropSourceID{$iEvals}:=[xxSTR_Subasignaturas:83]LongID:7
								atAS_EvalPropSourceName{$iEvals}:=[xxSTR_Subasignaturas:83]Name:2
								[xxSTR_Subasignaturas:83]Periodo:12:=$iPeriodos
								[xxSTR_Subasignaturas:83]Columna:13:=$iEvals
								SAVE RECORD:C53([xxSTR_Subasignaturas:83])
								$reconstruirPropiedades:=True:C214
							End if 
							
					End case 
				End if 
			End for 
			If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
				AS_PropEval_Escritura ($iPeriodos)
			Else 
				  //20170530 RCH Si la conf no varía, se guarda solo cuando se está en el último período.
				  //AS_PropEval_Escritura (0)
				If ($iPeriodos=Size of array:C274(atSTR_Periodos_Nombre))
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
	
	
	If ($vinculosIncorrectos)
		$folderPath:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ST)+"Diagnósticos"+Folder separator:K24:12+"Auto diagnósticos"+Folder separator:K24:12
		SYS_CreatePath ($folderPath)
		$fileName:=$folderPath+"Vínculos incorrectos entre asignaturas y subasignaturas "+DTS_Get_GMT_TimeStamp +".txt"  //MONO 207084
		$ref:=Create document:C266($fileName;"TEXT")
		CLOSE DOCUMENT:C267($ref)
		BLOB TO DOCUMENT:C526(document;$blob)
		$msg:="Se detectaron vínculos corruptos entre asignaturas y una o más subasignaturas. Un"+" Reporte detallado fue guardado en:\r "+$fileName+"\r\r\r"
		LOG_RegisterEvt ($msg)
		
		If (Application type:C494=4D Server:K5:6)
			If ($sendMail)
				$resultado:=SOPORTE_EnviaMailIncidente ($email;$msg;"D";$blob)
			End if 
			LOG_RegisterEvt (__ ("Se detectaron vínculos corruptos entre asignaturas y una o más subasignaturas. Un reporte detallado se encuentra disponible en:\r\r ")+$fileName)
		Else 
			  //$msg:="Se detectaron vínculos corruptos entre asignaturas y una o más subasignaturas. Un"+" reporte detallado se encuentra disponible en:\r\r "+$fileName
			$executeCode:=CD_Dlog (0;__ ("Se detectaron vínculos corruptos entre asignaturas y una o más subasignaturas. Un reporte detallado se encuentra disponible en:\r\r ")+$fileName)
		End if 
		
	Else 
		LOG_RegisterEvt ("Se ejecutó la verificación de vínculos entre asignaturas y subasignaturas sin que"+" se detectara ningún problema.")
		If ((Application type:C494=4D Remote mode:K5:5) | (Not:C34(Is compiled mode:C492)))
			CD_Dlog (0;__ ("Se ejecutó la verificación de vínculos entre asignaturas y subasignaturas sin que se detectara ningún problema."))
		End if 
	End if 
End if 


