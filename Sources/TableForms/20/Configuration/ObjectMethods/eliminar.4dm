CREATE SET:C116([xxSTR_Materias:20];"Seleccion")
USE SET:C118("MateriasSeleccionadas")
SET QUERY DESTINATION:C396(Into variable:K19:4;$f)
QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=[xxSTR_Materias:20]Materia:2)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($f#0)
	$r:=CD_Dlog (0;__ ("Existen asignaturas definidas con este nombre.\rNo es posible eliminar el subsector."))
	<>aAsign:=0
	IT_SetButtonState (False:C215;->b_Eliminar)
	USE SET:C118("Seleccion")
Else 
	READ WRITE:C146([xxSTR_Materias:20])
	LOAD RECORD:C52([xxSTR_Materias:20])
	DELETE RECORD:C58([xxSTR_Materias:20])
	READ ONLY:C145([xxSTR_Materias:20])
	ALL RECORDS:C47([xxSTR_Materias:20])
	<>aAsign:=0
	IT_SetButtonState (False:C215;->b_Eliminar)
	$l_ordenPorPosicion:=(OBJECT Get pointer:C1124(Object named:K67:5;"encabezadoOrden"))->
	$l_ordenPorSector:=(OBJECT Get pointer:C1124(Object named:K67:5;"encabezadoSector"))->
	$l_ordenPorSubSector:=(OBJECT Get pointer:C1124(Object named:K67:5;"encabezadoSubsector"))->
	Case of 
		: ($l_ordenPorPosicion#0)
			If ($l_ordenPorPosicion=1)
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]NoSector:11;>)
			Else 
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]NoSector:11;<)
			End if 
		: ($l_ordenPorSector#0)
			If ($l_ordenPorSector=1)
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Area:12;>)
			Else 
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Area:12;<)
			End if 
		: ($l_ordenPorSubSector#0)
			If ($l_ordenPorSubSector=1)
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2;>)
			Else 
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2;<)
			End if 
	End case 
	OBJECT SET SCROLL POSITION:C906(*;"lb_Materias")
	CLEAR SET:C117("Seleccion")
End if 