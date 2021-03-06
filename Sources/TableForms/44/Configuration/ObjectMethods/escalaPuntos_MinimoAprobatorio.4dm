  // [xxSTR_EstilosEvaluacion].Configuration.escalaPuntos_MinimoAprobatorio()
  //
  //
  // creado por: Alberto Bachler Klein: 11-07-16, 12:02:07
  // -----------------------------------------------------------
C_LONGINT:C283($l_evaluaciones)
C_TEXT:C284($t_mensaje)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		$l_evaluaciones:=(OBJECT Get pointer:C1124(Object named:K67:5;"usoEvaluaciones"))->
		$t_mensaje:=__ ("Valor requerido para aprobar una materia en la escala de puntos.")
		If ($l_evaluaciones>0)
			$t_mensaje:=$t_mensaje+"\r"+__ ("No puede ser modificado ya que hay evaluaciones registradas con este estilo de evaluacion.")
		End if 
		OBJECT SET HELP TIP:C1181(*;OBJECT Get name:C1087(Object current:K67:2);$t_mensaje)
		
		
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: ((rPointsMinimum=0) & (iEvaluationMode=Puntos))
				vi_SinReprobacion:=1
				
			: (rPointsMinimum<rPointsFrom)
				CD_Dlog (0;__ ("El mínimo requerido no puede ser inferior al mínimo de la escala."))
				rPointsMinimum:=0
				GOTO OBJECT:C206(rPointsMinimum)
				
			: (rPointsMinimum>rPointsTo)
				CD_Dlog (0;__ ("El mínimo requerido no puede ser superior al máximo de la escala."))
				rPointsMinimum:=0
				GOTO OBJECT:C206(rPointsMinimum)
				
			Else 
				rPointsMinimum:=Round:C94(rPointsMinimum;iPointsDec)
				If (iEvaluationMode=Puntos)
					rPctMinimum:=Round:C94(rPointsMinimum/rPointsTo*100;11)
					rAprobatorioPorcentaje:=Round:C94(rPointsMinimum/rPointsTo*100;1)
					sSymbolMinimum:=EV2_Puntos_a_Simbolo (rPointsMinimum)
					EVS_SetModified 
				End if 
		End case 
End case 