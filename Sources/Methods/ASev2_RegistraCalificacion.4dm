//%attributes = {}
  // MÉTODO: ASev2_RegistraCalificacion
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/03/12, 12:38:28
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AS_RegistraCalificacion()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_REAL:C285($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)
C_POINTER:C301($7)
C_BOOLEAN:C305($8)

C_BOOLEAN:C305($b_guardarRegistro)
C_LONGINT:C283($l_Fila;$l_recNumCalificaciones;$l_decimales_literal)
C_POINTER:C301($y_arreglo_Reales;$y_campoCalificaciones_literal;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_real;$y_campoCalificaciones_simbolo)
C_REAL:C285($r_valorNota;$r_valorPuntos;$r_valorReal)
C_TEXT:C284($t_valorLiteral;$t_valorSimbolo)
C_TEXT:C284($userName)
If (False:C215)
	C_LONGINT:C283(ASev2_RegistraCalificacion ;$1)
	C_REAL:C285(ASev2_RegistraCalificacion ;$2)
	C_POINTER:C301(ASev2_RegistraCalificacion ;$3)
	C_POINTER:C301(ASev2_RegistraCalificacion ;$4)
	C_POINTER:C301(ASev2_RegistraCalificacion ;$5)
	C_POINTER:C301(ASev2_RegistraCalificacion ;$6)
	C_POINTER:C301(ASev2_RegistraCalificacion ;$7)
	C_BOOLEAN:C305(ASev2_RegistraCalificacion ;$8)
	C_TEXT:C284(ASev2_RegistraCalificacion ;$9)
End if 

  // CODIGO PRINCIPAL
$l_recNumCalificaciones:=$1
$r_valorReal:=$2
$y_campoCalificaciones_literal:=$3
$y_campoCalificaciones_real:=$4
$y_campoCalificaciones_nota:=$5
$y_campoCalificaciones_puntos:=$6
$y_campoCalificaciones_simbolo:=$7

Case of 
	: (Count parameters:C259=8)
		$b_guardarRegistro:=$8
	: (Count parameters:C259=9)
		$b_guardarRegistro:=$8
		$userName:=$9
End case 


Case of 
	: (KRL_isSameField ($y_campoCalificaciones_literal;->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36))
		$l_decimalesNotas:=iGradesDecNO
		$l_decimalesPuntos:=iPointsDecNO
	: (KRL_isSameField ($y_campoCalificaciones_literal;->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30))
		$l_decimalesNotas:=iGradesDecNF
		$l_decimalesPuntos:=iPointsDecNF
	: (KRL_isSameField ($y_campoCalificaciones_literal;->[Alumnos_Calificaciones:208]Anual_Literal:15))
		$l_decimalesNotas:=iGradesDecPF
		$l_decimalesPuntos:=iPointsDecPF
		
	: (KRL_isSameField ($y_campoCalificaciones_literal;->[Alumnos_Calificaciones:208]P01_Final_Literal:116) | KRL_isSameField ($y_campoCalificaciones_literal;->[Alumnos_Calificaciones:208]P02_Final_Literal:191) | KRL_isSameField ($y_campoCalificaciones_literal;->[Alumnos_Calificaciones:208]P03_Final_Literal:266) | KRL_isSameField ($y_campoCalificaciones_literal;->[Alumnos_Calificaciones:208]P04_Final_Literal:341) | KRL_isSameField ($y_campoCalificaciones_literal;->[Alumnos_Calificaciones:208]P05_Final_Literal:416))
		$l_decimalesNotas:=iGradesDecPP
		$l_decimalesPuntos:=iPointsDecPP
	Else 
		$l_decimalesNotas:=iGradesDEC
		$l_decimalesPuntos:=iPointsDEC
End case 

Case of 
	: (iPrintMode=Notas)
		$l_decimales_literal:=$l_decimalesNotas
	: (iPrintMode=Puntos)
		$l_decimales_literal:=$l_decimalesPuntos
	: (iPrintMode=Porcentaje)
		$l_decimales_literal:=1
	: (iPrintMode=Simbolos)
		$l_decimales_literal:=0
End case 

$t_valorLiteral:=EV2_Real_a_Literal ($r_valorReal;iPrintMode;$l_decimales_literal)
$r_valorNota:=EV2_Real_a_Nota ($r_valorReal;0;$l_decimalesNotas)
$r_valorPuntos:=EV2_Real_a_Puntos ($r_valorReal;0;$l_decimalesPuntos)
$t_valorSimbolo:=EV2_Real_a_Simbolo ($r_valorReal)




KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNumCalificaciones;True:C214)
Case of 
	: (Table:C252($y_campoCalificaciones_literal)=Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
		KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
		Case of 
			: (Count parameters:C259=2)
				$y_campoCalificaciones_literal->:=$t_valorLiteral
			: (Count parameters:C259>=7)
				$y_campoCalificaciones_literal->:=$t_valorLiteral
				$y_campoCalificaciones_real->:=$r_valorReal
				$y_campoCalificaciones_nota->:=$r_valorNota
				$y_campoCalificaciones_puntos->:=$r_valorPuntos
				$y_campoCalificaciones_simbolo->:=$t_valorSimbolo
		End case 
		SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
		KRL_ReloadAsReadOnly (->[Alumnos_ComplementoEvaluacion:209])
		
	: (Table:C252($y_campoCalificaciones_literal)=Table:C252(->[Alumnos_Calificaciones:208]))
		
		$y_campoCalificaciones_literal->:=$t_valorLiteral
		$y_campoCalificaciones_real->:=$r_valorReal
		$y_campoCalificaciones_nota->:=$r_valorNota
		$y_campoCalificaciones_puntos->:=$r_valorPuntos
		$y_campoCalificaciones_simbolo->:=$t_valorSimbolo
		
		If ([Asignaturas:18]Resultado_no_calculado:47)
			[Alumnos_Calificaciones:208]P01_Final_RealNoAproximado:496:=[Alumnos_Calificaciones:208]P01_Final_Real:112
			[Alumnos_Calificaciones:208]P02_Final_RealNoAproximado:497:=[Alumnos_Calificaciones:208]P02_Final_Real:187
			[Alumnos_Calificaciones:208]P03_Final_RealNoAproximado:498:=[Alumnos_Calificaciones:208]P03_Final_Real:262
			[Alumnos_Calificaciones:208]P04_Final_RealNoAproximado:499:=[Alumnos_Calificaciones:208]P04_Final_Real:337
			[Alumnos_Calificaciones:208]P05_Final_RealNoAproximado:500:=[Alumnos_Calificaciones:208]P05_Final_Real:412
			[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=[Alumnos_Calificaciones:208]Anual_Real:11
			[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;iPrintActa;vlNTA_DecimalesNO)
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;0;vlNTA_DecimalesNO)
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=NTA_Grade2LongText ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36)
			EV2_AprobacionReprobacion 
		End if 
		EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;$y_campoCalificaciones_literal;"";$userName)
		If ($b_guardarRegistro)
			SAVE RECORD:C53([Alumnos_Calificaciones:208])
			KRL_ReloadAsReadOnly (->[Alumnos_Calificaciones:208])
		End if 
End case 

