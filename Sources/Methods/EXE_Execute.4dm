//%attributes = {}
  // EXE_Execute()
  //
  //
  // creado por: Alberto Bachler Klein: 17-01-17, 18:06:51
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_BOOLEAN:C305($2)
C_TEXT:C284($3)

C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)
C_POINTER:C301($7)
C_POINTER:C301($8)
C_POINTER:C301($9)
C_POINTER:C301($10)
C_POINTER:C301($11)

C_BOOLEAN:C305($b_benchMark;$b_registroEnLog)
C_LONGINT:C283($l_ms)
C_TEXT:C284($t_respuesta;$t_string2Execute;$t_mensajeError)

C_TEXT:C284(vt_ErrorEjecucionScript)
vt_ErrorEjecucionScript:=""

If (False:C215)
	C_TEXT:C284(EXE_Execute ;$0)
	C_TEXT:C284(EXE_Execute ;$1)
	C_BOOLEAN:C305(EXE_Execute ;$2)
	C_TEXT:C284(EXE_Execute ;$3)
	C_POINTER:C301(EXE_Execute ;$4)
	C_POINTER:C301(EXE_Execute ;$5)
	C_POINTER:C301(EXE_Execute ;$6)
	C_POINTER:C301(EXE_Execute ;$7)
	C_POINTER:C301(EXE_Execute ;$8)
	C_POINTER:C301(EXE_Execute ;$9)
	C_POINTER:C301(EXE_Execute ;$10)
	C_POINTER:C301(EXE_Execute ;$11)
End if 

$t_onErrCallMethod:=Method called on error:C704
ON ERR CALL:C155("ERR_EventoError")

$b_registroEnLog:=True:C214

$t_string2Execute:=$1
Case of 
	: (Count parameters:C259=2)  // se llama desde SR_ExecuteScript y hace que no se registren los llamados...
		$b_registroEnLog:=$2
		
	: (Count parameters:C259=3)
		$b_registroEnLog:=$2
		$t_registeredClient:=$3
End case 

If ($b_registroEnLog)
	LOG_RegisterEvt ("Ejecución de código:"+$t_string2Execute;0;0)
End if 

$t_string2Execute:=SR_VerificaCodigo ($t_string2Execute)


  // sustituciones por cambios de nombres de campo
EXE_ReplaceString ("generales";"[Asignaturas]AsgConsol_ID";"[Asignaturas]Consolidacion_Madre_Id";->$t_string2Execute)
EXE_ReplaceString ("generales";"[Asignaturas]Consolida_en";"[Asignaturas]Consolidacion_Madre_Nombre";->$t_string2Execute)
EXE_ReplaceString ("generales";"[Asignaturas]Es_Consolidante";"[Asignaturas]Consolidacion_EsConsolidante";->$t_string2Execute)
EXE_ReplaceString ("generales";"[Asignaturas]ConsDec";"[Asignaturas]Consolidacion_Metodo";->$t_string2Execute)
EXE_ReplaceString ("generales";"[MPA_AsignaturasMatrices]CFG_Final_VariableSegunPeriodo";"[MPA_AsignaturasMatrices]CFG_Comp_VariableSegunPeriodo";->$t_string2Execute)
EXE_ReplaceString ("generales";"[Alumnos_Observaciones]";"[Alumnos_ObsOrientacion]";->$t_string2Execute)
EXE_ReplaceString ("generales";"C_INTEGER";"C_LONGINT";->$t_string2Execute)

  // sustituciones por cambios de nombre en métodos
EXE_ReplaceString ("generales";"AS_ReadEvalProperties";"AS_PropEval_Lectura";->$t_string2Execute)
EXE_ReplaceString ("arreglos";"ARRAY STRING";"ARRAY TEXT";->$t_string2Execute)
EXE_ReplaceString ("generales";"_o_C_INTEGER";"C_LONGINT";->$t_string2Execute)

$b_benchMark:=Macintosh command down:C546 & (Macintosh option down:C545 | Windows Alt down:C563)
If ($b_benchMark)
	$l_ms:=Milliseconds:C459
End if 

$t_string2Execute:=ST Get plain text:C1092($t_string2Execute)  // por si el código proviene de un objeto multi-estilo
$t_string2Execute:="<!--#4DCODE\r"+$t_string2Execute+"\r-->"
Case of 
	: (Count parameters:C259<=3)
		PROCESS 4D TAGS:C816($t_string2Execute;$t_respuesta)
	: (Count parameters:C259=4)
		PROCESS 4D TAGS:C816($t_string2Execute;$t_respuesta;$4->)
	: (Count parameters:C259=5)
		PROCESS 4D TAGS:C816($t_string2Execute;$t_respuesta;$4->;$5->)
	: (Count parameters:C259=6)
		PROCESS 4D TAGS:C816($t_string2Execute;$t_respuesta;$4->;$5->;$6->)
	: (Count parameters:C259=7)
		PROCESS 4D TAGS:C816($t_string2Execute;$t_respuesta;$4->;$5->;$6->;$7)
	: (Count parameters:C259=8)
		PROCESS 4D TAGS:C816($t_string2Execute;$t_respuesta;$4->;$5->;$6->;$7->;$8->)
	: (Count parameters:C259=9)
		PROCESS 4D TAGS:C816($t_string2Execute;$t_respuesta;$4->;$5->;$6->;$7->;$8->;$9->)
	: (Count parameters:C259=10)
		PROCESS 4D TAGS:C816($t_string2Execute;$t_respuesta;$4->;$5->;$6->;$7->;$8->;$9->;$10->)
	: (Count parameters:C259=11)
		PROCESS 4D TAGS:C816($t_string2Execute;$t_respuesta;$4->;$5->;$6->;$7->;$8->;$9->;$10->;$11->)
End case 
If ($b_benchMark)
	$l_ms:=Milliseconds:C459-$l_ms
	ALERT:C41("Tiempo de ejecución: "+String:C10($l_ms)+"ms")
End if 

ON ERR CALL:C155($t_onErrCallMethod)

Case of 
	: (error#0)
		If ((Not:C34(Is compiled mode:C492)) | (Caps lock down:C547))
			$t_error:="Error en formula en "+Current method name:C684+":\r"+ERROR FORMULA
			If (Application type:C494=4D Server:K5:6)
				If ($t_registeredClient#"")
					EXECUTE ON CLIENT:C651($t_registeredClient;"ModernUI_Notificacion";__ ("Error en ejecución de scripts");$t_error)
				End if 
			Else 
				ALERT:C41($t_error)
			End if 
			ERROR FORMULA:=""
			ERROR METHOD:=""
			ERROR LINE:=0
			ERROR:=0
		End if 
		OK:=0
		
	: (vt_ErrorEjecucionScript#"")
		$t_mensajeError:=vt_ErrorEjecucionScript
		OK:=0
		
	Else 
		$t_mensajeError:=""
		OK:=1
End case 

ON ERR CALL:C155($t_onErrCallMethod)



$0:=$t_mensajeError


