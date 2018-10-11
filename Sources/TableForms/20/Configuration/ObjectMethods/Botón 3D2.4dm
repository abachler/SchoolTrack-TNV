READ WRITE:C146([xxSTR_Materias:20])
FORM SET INPUT:C55([xxSTR_Materias:20];"Input")
CREATE SET:C116([xxSTR_Materias:20];"temp")
WDW_OpenFormWindow (->[xxSTR_Materias:20];"Input";-1;5;__ ("Subsectores de aprendizaje"))
ADD RECORD:C56([xxSTR_Materias:20];*)
CLOSE WINDOW:C154
If (OK=1)
	CREATE EMPTY SET:C140([xxSTR_Materias:20];"MateriasSeleccionadas")
	ADD TO SET:C119([xxSTR_Materias:20];"MateriasSeleccionadas")
	ADD TO SET:C119([xxSTR_Materias:20];"temp")
	AT_Insert (Size of array:C274(<>aAsign)+1;1;-><>aAsign;-><>aAsignNo)
	<>aAsign{Size of array:C274(<>aAsign)}:=[xxSTR_Materias:20]Materia:2
	<>aAsignNo{Size of array:C274(<>aAsignNo)}:=[xxSTR_Materias:20]Orden interno:9
	_O_ENABLE BUTTON:C192(b_Eliminar)
End if 
UNLOAD RECORD:C212([xxSTR_Materias:20])
READ ONLY:C145([xxSTR_Materias:20])
USE SET:C118("temp")
CLEAR SET:C117("temp")
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