  // [xxSTR_EstilosEvaluacion].Configuration.escalaPorcentaje_MinimoAprobatorio()
  //
  //
  // creado por: Alberto Bachler Klein: 11-07-16, 12:01:47
  // -----------------------------------------------------------
C_LONGINT:C283($l_evaluaciones)
C_TEXT:C284($t_mensaje)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		$l_evaluaciones:=(OBJECT Get pointer:C1124(Object named:K67:5;"usoEvaluaciones"))->
		$t_mensaje:=__ ("Valor requerido para aprobar una materia en escala de 1 a 100.")
		If ($l_evaluaciones>0)
			$t_mensaje:=$t_mensaje+"\r"+__ ("No puede ser modificado ya que hay evaluaciones registradas con este estilo de evaluacion.")
		End if 
		OBJECT SET HELP TIP:C1181(*;OBJECT Get name:C1087(Object current:K67:2);$t_mensaje)
		
		
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: ((rAprobatorioPorcentaje>=0) & (iEvaluationMode=Porcentaje))
				vi_SinReprobacion:=1
				
			: (rAprobatorioPorcentaje<1)
				CD_Dlog (0;__ ("El mínimo requerido no puede ser inferior al mínimo de la escala."))
				rAprobatorioPorcentaje:=0
				GOTO OBJECT:C206(rAprobatorioPorcentaje)
				
			: (rAprobatorioPorcentaje>100)
				CD_Dlog (0;__ ("El mínimo requerido no puede ser superior al máximo de la escala."))
				rAprobatorioPorcentaje:=0
				GOTO OBJECT:C206(rAprobatorioPorcentaje)
				
			Else 
				rAprobatorioPorcentaje:=Round:C94(rAprobatorioPorcentaje;1)
				Case of 
					: (iEvaluationMode=Porcentaje)
						rPctMinimum:=Round:C94(rAprobatorioPorcentaje/100;11)
						rGradesMinimum:=Round:C94(rGradesTo*rPctMinimum;iGradesDec)
						rPointsMinimum:=Round:C94(rPointsTo*rPctMinimum/100;iPointsDec)
						sSymbolMinimum:=EV2_Real_a_Simbolo (rPctMinimum)
				End case 
				EVS_SetModified 
		End case 
End case 