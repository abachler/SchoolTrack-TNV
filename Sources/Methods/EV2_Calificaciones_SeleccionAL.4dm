//%attributes = {}
  // EV2_Calificaciones_SeleccionAL()
  // Por: Alberto Bachler: 15/11/13, 20:02:00
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($l_año)

ARRAY LONGINT:C221($al_IdAlumnos;0)
If (False:C215)
	C_LONGINT:C283(EV2_Calificaciones_SeleccionAL ;$1)
End if 

If (Count parameters:C259=1)
	$l_año:=$1
Else 
	$l_año:=<>gyear
End if 
If ($l_año=<>gyear)
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
Else 
	SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_IdAlumnos)
	AT_NegativeNumericArray (->$al_IdAlumnos)
	QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$al_IdAlumnos;True:C214)
End if 
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_institucion:2=<>gInstitucion;*)
QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]Año:3=$l_año)
