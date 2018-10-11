//%attributes = {}
  // AL_Transfert()
  // Por: Alberto Bachler K.: 14-05-14, 12:28:53
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_BOOLEAN:C305($b_nivelDestinoEsSistema;$b_nivelDestinoEsSubAnual;$b_nivelOrigenEsSistema;$b_nivelOrigenEsSubAnual;$b_nivelDestinoEsSistema;$promovido)
C_LONGINT:C283($l_nivelDeDestino;$l_nivelDeOrigen;$l_recNumAlumno;$l_resultado)
C_TEXT:C284($t_cursoDeDestino;$t_cursoDeOrigen;$t_llaveRegistro;$t_nivelDeOrigenNombre;$t_nivelDeDestinoNombre)
If (False:C215)
	C_TEXT:C284(AL_Transfert ;$1)
	C_TEXT:C284(AL_Transfert ;$2)
	C_LONGINT:C283(AL_Transfert ;$3)
	C_LONGINT:C283(AL_Transfert ;$4)
End if 

$t_cursoDeOrigen:=$1
$t_cursoDeDestino:=$2
$l_nivelDeOrigen:=$3
$l_nivelDeDestino:=$4

$l_recNumAlumno:=Record number:C243([Alumnos:2])

$l_resultado:=1

$t_nivelDeOrigenNombre:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelDeOrigen;->[xxSTR_Niveles:6]Nivel:1)
$t_nivelDeDestinoNombre:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelDeDestino;->[xxSTR_Niveles:6]Nivel:1)

$b_nivelOrigenEsSubAnual:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelDeOrigen;->[xxSTR_Niveles:6]Es_Nivel_SubAnual:50)
$b_nivelDestinoEsSubAnual:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelDeDestino;->[xxSTR_Niveles:6]Es_Nivel_SubAnual:50)

$b_nivelOrigenEsSistema:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelDeOrigen;->[xxSTR_Niveles:6]EsNivelSistema:10)
$b_nivelDestinoEsSistema:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelDeDestino;->[xxSTR_Niveles:6]EsNivelSistema:10)

vb_AsignaSituacionFinal:=True:C214
$t_llaveRegistro:=KRL_MakeStringAccesKey (-><>ginstitucion;-><>gYear;->$l_nivelDeOrigen;->[Alumnos:2]numero:1)
$promovido:=True:C214
Case of 
	: ($b_nivelDestinoEsSistema=False:C215)
		READ WRITE:C146([Cursos:3])
		GOTO RECORD:C242([Cursos:3];<>vl_dstClass)
		Case of 
				
				  //si el nivel de destino es inmediatamente siguiente al nivel actual y el nivel actual es subanual
			: ((($l_nivelDeDestino-$l_nivelDeOrigen)=-1) & ($b_nivelDestinoEsSubAnual))
				KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
				EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;$l_nivelDeOrigen)
				KRL_DeleteSelection (->[Alumnos_ComplementoEvaluacion:209])
				KRL_DeleteSelection (->[Alumnos_Calificaciones:208])
				KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
				KRL_DeleteRecord (->[Alumnos_SintesisAnual:210])
				KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
				[Alumnos:2]curso:20:=$t_cursoDeDestino
				[Alumnos:2]nivel_numero:29:=$l_nivelDeDestino
				[Alumnos:2]Nivel_Nombre:34:=$t_nivelDeDestinoNombre
				[Alumnos:2]Situacion_final:33:=""
				[Alumnos:2]no_de_lista:53:=[Cursos:3]LastNumber:12+1
				SAVE RECORD:C53([Alumnos:2])
				KRL_ReloadInReadWriteMode (->[Cursos:3])
				[Cursos:3]LastNumber:12:=[Cursos:3]LastNumber:12+1
				SAVE RECORD:C53([Cursos:3])
				AL_CreaRegistros 
				KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno)
				$t_llaveRegistro:=KRL_MakeStringAccesKey (-><>ginstitucion;-><>gYear;->[Alumnos:2]nivel_numero:29;->[Alumnos:2]numero:1)
				AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[Alumnos:2]nivel_numero:29;False:C215)
				AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]Curso:7;->[Alumnos:2]curso:20;True:C214)
				AL_CreateGradeRecords 
				
				  //si el nivel de destino es inmediatamente anterior al nivel actual y el nivel actual es subanual
			: ((($l_nivelDeDestino-$l_nivelDeOrigen)=1) & ($b_nivelOrigenEsSubAnual))
				KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
				[Alumnos:2]curso:20:=$t_cursoDeDestino
				[Alumnos:2]nivel_numero:29:=$l_nivelDeDestino
				[Alumnos:2]Nivel_Nombre:34:=$t_nivelDeDestinoNombre
				[Alumnos:2]Situacion_final:33:=""
				[Alumnos:2]no_de_lista:53:=[Cursos:3]LastNumber:12+1
				SAVE RECORD:C53([Alumnos:2])
				KRL_ReloadInReadWriteMode (->[Cursos:3])
				[Cursos:3]LastNumber:12:=[Cursos:3]LastNumber:12+1
				SAVE RECORD:C53([Cursos:3])
				
				AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]Promovido:91;->$promovido)
				AL_CreaRegistros 
				$t_llaveRegistro:=KRL_MakeStringAccesKey (-><>ginstitucion;-><>gYear;->[Alumnos:2]nivel_numero:29;->[Alumnos:2]numero:1)
				AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[Alumnos:2]nivel_numero:29;False:C215)
				AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]Curso:7;->[Alumnos:2]curso:20;True:C214)
				AL_CreateGradeRecords 
				
			: ([Alumnos:2]nivel_numero:29#[Cursos:3]Nivel_Numero:7)
				$l_recNumAlumno:=Record number:C243([Alumnos:2])
				AL_ClearCurrentInfo 
				KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
				[Alumnos:2]curso:20:=$t_cursoDeDestino
				[Alumnos:2]nivel_numero:29:=$l_nivelDeDestino
				[Alumnos:2]Nivel_Nombre:34:=$t_nivelDeDestinoNombre
				[Alumnos:2]Sección:26:=[Cursos:3]Ciclo:5
				[Alumnos:2]Situacion_final:33:=""
				[Alumnos:2]no_de_lista:53:=[Cursos:3]LastNumber:12+1
				SAVE RECORD:C53([Alumnos:2])
				KRL_ReloadInReadWriteMode (->[Cursos:3])
				[Cursos:3]LastNumber:12:=[Cursos:3]LastNumber:12+1
				SAVE RECORD:C53([Cursos:3])
				AL_CreaRegistros 
				$t_llaveRegistro:=KRL_MakeStringAccesKey (-><>ginstitucion;-><>gYear;->[Alumnos:2]nivel_numero:29;->[Alumnos:2]numero:1)
				KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno)
				AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[Alumnos:2]nivel_numero:29;False:C215)
				AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]Curso:7;->[Alumnos:2]curso:20;True:C214)
				AL_CreateGradeRecords 
				
			Else 
				[Alumnos:2]curso:20:=[Cursos:3]Curso:1
				[Alumnos:2]nivel_numero:29:=[Cursos:3]Nivel_Numero:7
				[Alumnos:2]Nivel_Nombre:34:=[Cursos:3]Nivel_Nombre:10
				[Alumnos:2]Sección:26:=[Cursos:3]Ciclo:5
				[Alumnos:2]Situacion_final:33:=""
				[Alumnos:2]no_de_lista:53:=[Cursos:3]LastNumber:12+1
				SAVE RECORD:C53([Alumnos:2])
				KRL_ReloadInReadWriteMode (->[Cursos:3])
				[Cursos:3]LastNumber:12:=[Cursos:3]LastNumber:12+1
				SAVE RECORD:C53([Cursos:3])
				AL_CreaRegistros 
				$t_llaveRegistro:=KRL_MakeStringAccesKey (-><>ginstitucion;-><>gYear;->[Alumnos:2]nivel_numero:29;->[Alumnos:2]numero:1)
				AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[Alumnos:2]nivel_numero:29;False:C215)
				AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]Curso:7;->[Alumnos:2]curso:20;True:C214)
				$l_resultado:=AL_TransferEvaluations 
		End case 
		If ($l_resultado=1)
			MESSAGES OFF:C175
			LOG_RegisterEvt ("Alumnos: "+[Alumnos:2]apellidos_y_nombres:40+" transferido desde "+$t_cursoDeOrigen+" a "+$t_cursoDeDestino;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
		End if 
		
	: ($l_nivelDeDestino=Nivel_Egresados)
		AL_ClearCurrentInfo 
		[Alumnos:2]AgnoEgreso:91:=<>gYear
		[Alumnos:2]curso:20:="EGR"+String:C10(<>gYear)
		[Alumnos:2]nivel_numero:29:=Nivel_Egresados
		[Alumnos:2]Nivel_Nombre:34:="Egresados"
		[Alumnos:2]Sección:26:="Egresados"
		[Alumnos:2]Status:50:="Egresado"
		[Alumnos:2]no_de_lista:53:=0
		SAVE RECORD:C53([Alumnos:2])
		AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[Alumnos:2]nivel_numero:29;False:C215)
		AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]Curso:7;->[Alumnos:2]curso:20;True:C214)
		LOG_RegisterEvt ("Alumnos: "+[Alumnos:2]apellidos_y_nombres:40+" transferido desde "+$t_cursoDeOrigen+" a grupo Egresados";Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
		
	: ($l_nivelDeDestino=Nivel_Retirados)
		AL_ClearCurrentInfo 
		[Alumnos:2]Fecha_de_retiro:42:=Current date:C33(*)
		[Alumnos:2]NoNIvel_alRetirarse:84:=[Alumnos:2]nivel_numero:29
		[Alumnos:2]curso:20:="RET"
		[Alumnos:2]nivel_numero:29:=Nivel_Retirados
		[Alumnos:2]Nivel_Nombre:34:="Retirados"
		[Alumnos:2]Sección:26:="Retirados"
		[Alumnos:2]Status:50:="Retirado"
		[Alumnos:2]no_de_lista:53:=0
		SAVE RECORD:C53([Alumnos:2])
		AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[Alumnos:2]nivel_numero:29;False:C215)
		AL_EscribeSintesisAnual ($t_llaveRegistro;->[Alumnos_SintesisAnual:210]Curso:7;->[Alumnos:2]curso:20;True:C214)
		LOG_RegisterEvt ("Alumnos: "+[Alumnos:2]apellidos_y_nombres:40+" transferido desde "+$t_cursoDeOrigen+" a grupo Retirados";Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
		
	: ($l_nivelDeDestino=Nivel_AdmisionDirecta)
		AL_ClearCurrentInfo 
		[Alumnos:2]curso:20:="Adm"+String:C10(<>gYear)
		[Alumnos:2]nivel_numero:29:=Nivel_AdmisionDirecta
		[Alumnos:2]Nivel_Nombre:34:="Admisión"
		[Alumnos:2]Sección:26:="Admisión"
		[Alumnos:2]no_de_lista:53:=0
		SAVE RECORD:C53([Alumnos:2])
		AL_CreaRegistroSalud ([Alumnos:2]numero:1)
		LOG_RegisterEvt ("Alumnos: "+[Alumnos:2]apellidos_y_nombres:40+" transferido desde "+$t_cursoDeOrigen+" a grupo Admisión";Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
End case 

KRL_UnloadReadOnly (->[Alumnos:2])
KRL_UnloadReadOnly (->[Cursos:3])  //20140529 ASM  Se quedaba tomado el registro de cursos en C/S
KRL_UnloadReadOnlyOnServer (->[Cursos:3])

$0:=$l_resultado


