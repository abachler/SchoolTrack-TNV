  // [xxSTR_EstilosEvaluacion].Configuration.escalaNotas_desde()
  //
  //
  // creado por: Alberto Bachler Klein: 11-07-16, 12:04:15
  // -----------------------------------------------------------
C_LONGINT:C283($l_evaluaciones)
C_TEXT:C284($t_mensaje)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		$l_evaluaciones:=(OBJECT Get pointer:C1124(Object named:K67:5;"usoEvaluaciones"))->
		$t_mensaje:=__ ("Valor mínimo aceptado en la escala de notas.")
		If ($l_evaluaciones>0)
			$t_mensaje:=$t_mensaje+"\r"+__ ("No puede ser modificado ya que hay evaluaciones registradas con este estilo de evaluacion.")
		End if 
		OBJECT SET HELP TIP:C1181(*;OBJECT Get name:C1087(Object current:K67:2);$t_mensaje)
		
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: (Self:C308-><0)
				CD_Dlog (0;__ ("El mínimo no puede ser inferior a 0"))
				Self:C308->:=0
				GOTO OBJECT:C206(Self:C308->)
			: ((Self:C308->>rGradesTo) & (rGradesTo>0))
				CD_Dlog (0;__ ("El mínimo no puede ser superior al máximo."))
				Self:C308->:=rGradesTo
				GOTO OBJECT:C206(Self:C308->)
			Else 
				If (iEvaluationMode=Notas)
					If (rGradesFrom>rGradesMinimum)
						rGradesMinimum:=rGradesFrom
						rPctMinimum:=Round:C94(rGradesMinimum/rGradesTo*100;11)
						rAprobatorioPorcentaje:=Round:C94(rGradesMinimum/rGradesTo*100;1)
					End if 
					sSymbolMinimum:=EV2_Nota_a_Simbolo (rGradesMinimum)
					If (rGradesTo>0)
						rPercentFrom:=Round:C94(rGradesFrom/rGradesTo*100;2)
						rPercentTo:=100
					End if 
					EVS_SetModified 
				End if 
				
		End case 
End case 