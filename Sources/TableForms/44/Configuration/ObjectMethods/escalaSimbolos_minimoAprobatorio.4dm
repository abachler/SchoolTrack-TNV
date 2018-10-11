  // [xxSTR_EstilosEvaluacion].Configuration.escalaSimbolos_minimoAprobatorio()
  //
  //
  // creado por: Alberto Bachler Klein: 11-07-16, 12:00:33
  // -----------------------------------------------------------
C_LONGINT:C283($l_posicion;$l_evaluaciones)
C_TEXT:C284($t_mensaje)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		$l_evaluaciones:=(OBJECT Get pointer:C1124(Object named:K67:5;"usoEvaluaciones"))->
		$t_mensaje:=__ ("Símbolo requerido para aprobar una materia.")
		If ($l_evaluaciones>0)
			$t_mensaje:=$t_mensaje+"\r"+__ ("No puede ser modificado ya que hay evaluaciones registradas con este estilo de evaluacion.")
		End if 
		OBJECT SET HELP TIP:C1181(*;OBJECT Get name:C1087(Object current:K67:2);$t_mensaje)
		
		
	: (Form event:C388=On Data Change:K2:15)
		
		$l_posicion:=Find in array:C230(aSymbol;Self:C308->)
		If ($l_posicion>0)
			
			If ((iEvaluationMode=Simbolos) | (rPointsMinimum=0) | (rGradesMinimum=0) | (rPctMinimum=0))
				rPctMinimum:=aSymbPctFrom{$l_posicion}
				rPointsMinimum:=Round:C94(rPointsTo*rPctMinimum/100;iPointsDec)
				rGradesMinimum:=Round:C94(rGradesTo*rPctMinimum/100;iGradesDec)
			End if 
			
			
			If (rPctMinimum=0)
				rPctMinimum:=aSymbPctFrom{$l_posicion}
			End if 
			If (rPointsMinimum=0)
				rPointsMinimum:=Round:C94(rPointsTo*rPctMinimum/100;iPointsDec)
			End if 
			If (rGradesMinimum=0)
				rGradesMinimum:=Round:C94(rGradesTo*rPctMinimum/100;iGradesDec)
			End if 
			EVS_SetModified 
			
		Else 
			CD_Dlog (0;__ ("El símbolo que ingresó no está definido.\rPor favor defínalo en la página Escalas."))
			Self:C308->:=""
		End if 
		
End case 