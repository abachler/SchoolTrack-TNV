
If (Self:C308->)
	  //$msg:="Si utiliza esta opción las eventuales notas existentes (en la modalidad de evalua"+"ción tradicional) en las asignaturas que utilizan esta matriz serán DEFINITIVAMEN"+"TE eliminadas y reemplazadas con las evaluaciones finales de los aprendizajes esp"+"erados"+"\r\r¿Está usted seguro de lo que estáhaciendo?"
	  //$msg:=$msg+"\r\r¿Está usted seguro de lo que estáhaciendo?"
	OK:=CD_Dlog (0;__ ("Si utiliza esta opción las eventuales notas existentes (en la modalidad de evaluación tradicional) en las asignaturas que utilizan esta matriz serán DEFINITIVAMENTE eliminadas y reemplazadas con las evaluaciones finales de los aprendizajes esperados.\r"+"\r¿Está usted seguro de lo que está haciendo?");__ ("");__ ("No");__ ("Si. Continuar"))
	
	If (OK=2)
		LOG_RegisterEvt ("El usuario estableció que en las asignaturas "+[xxSTR_Materias:20]Materia:2+" en "+[xxSTR_Niveles:6]Nivel:1+" a contar de ahora la evaluación tradicional será calcul"+"ada a partir de las evaluaciones de aprendizajes. Las evaluaciones existentes fue"+"ron eliminadas.")
		vb_CalculoResultadoFinal:=True:C214
	Else 
		Self:C308->:=False:C215
		vb_CalculoResultadoFinal:=True:C214
	End if 
End if 

