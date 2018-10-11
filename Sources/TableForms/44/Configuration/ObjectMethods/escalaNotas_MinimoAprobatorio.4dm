  // [xxSTR_EstilosEvaluacion].Configuration.escalaNotas_MinimoAprobatorio()
  //
  //
  // creado por: Alberto Bachler Klein: 11-07-16, 12:03:48
  // -----------------------------------------------------------
C_LONGINT:C283($l_evaluaciones)
C_TEXT:C284($t_mensaje)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		$l_evaluaciones:=(OBJECT Get pointer:C1124(Object named:K67:5;"usoEvaluaciones"))->
		$t_mensaje:=__ ("Valor requerido para aprobar una materia en la escala de notas.")
		If ($l_evaluaciones>0)
			$t_mensaje:=$t_mensaje+"\r"+__ ("No puede ser modificado ya que hay evaluaciones registradas con este estilo de evaluacion.")
		End if 
		OBJECT SET HELP TIP:C1181(*;OBJECT Get name:C1087(Object current:K67:2);$t_mensaje)
		
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: ((Self:C308->=0) & (iEvaluationMode=Notas))
				vi_SinReprobacion:=1
				
			: ((Self:C308-><rGradesFrom) & (Self:C308->>0))
				CD_Dlog (0;__ ("El mínimo requerido no puede ser inferior al mínimo de la escala."))
				Self:C308->:=0
				GOTO OBJECT:C206(Self:C308->)
				
			: (Self:C308->>rGradesTo)
				CD_Dlog (0;__ ("El mínimo requerido no puede ser superior al máximo de la escala."))
				Self:C308->:=0
				GOTO OBJECT:C206(Self:C308->)
				
				
			Else 
				Self:C308->:=Round:C94(Self:C308->;iGradesDec)
				If (iEvaluationMode=Notas)
					rPctMinimum:=Round:C94(rGradesMinimum/rGradesTo*100;11)
					rAprobatorioPorcentaje:=Round:C94(rGradesMinimum/rGradesTo*100;1)
					sSymbolMinimum:=EV2_Real_a_Simbolo (rPctMinimum)
				End if 
				EVS_SetModified 
		End case 
End case 