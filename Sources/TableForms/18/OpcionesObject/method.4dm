If (Form event:C388=On Load:K2:1)
	  //Mono Ticket 172577 Evaluacion Especial
	(OBJECT Get pointer:C1124(Object named:K67:5;"usaEvaluacionEspecial"))->:=Num:C11(OB Get:C1224([Asignaturas:18]Opciones:57;"usaEvaluacionesEspeciales"))
	(OBJECT Get pointer:C1124(Object named:K67:5;"Input_impHorarioCode"))->:=OB Get:C1224([Asignaturas:18]Opciones:57;"impHorarioCode")
	(OBJECT Get pointer:C1124(Object named:K67:5;"NoMostrarEnSTWA"))->:=Num:C11(OB Get:C1224([Asignaturas:18]Opciones:57;"NoMostrarEnSTWA"))
	If (Not:C34(OB Is defined:C1231([Asignaturas:18]Opciones:57;"mostrarPTC")))
		OB SET:C1220([Asignaturas:18]Opciones:57;"mostrarPTC";False:C215)
	End if 
	(OBJECT Get pointer:C1124(Object named:K67:5;"mostrarPTC"))->:=Num:C11(OB Get:C1224([Asignaturas:18]Opciones:57;"mostrarPTC"))
End if 