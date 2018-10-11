//%attributes = {}
  // Método: AS_ActualizaNombreAsignatura
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 25/10/10, 20:44:52
  // ---------------------------------------------
  // Descripción:
  // Actualiza el nombre oficial de la asignatura en la tabla [Alumnos_Calificaciones]
  // usando el nuevo nombre oficial de la asignatura 
  // Parámetros:
  // AS_ActualizaNombreAsignatura(ID asignatura; Nuevo nombre)
  //   $1: Longint
  //   $2: Texto o cadena
  //----------------------------------------------
  // Declaraciones e inicializaciones

_O_C_INTEGER:C282($i_asignaturas)
C_LONGINT:C283($1;$l_ID_Asignatura)
C_TEXT:C284($2;$t_nuevoNombre)
ARRAY LONGINT:C221($al_RecNums;0)

  // Código principal
$l_ID_Asignatura:=$1
$t_nuevoNombre:=$2
EV2_RegistrosDeLaAsignatura ($l_ID_Asignatura)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$al_RecNums;"")
For ($i_asignaturas;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([Alumnos_Calificaciones:208])
	GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_RecNums{$i_asignaturas})
	[Alumnos_Calificaciones:208]NombreOficialAsignatura:7:=$t_nuevoNombre
	SAVE RECORD:C53([Alumnos_Calificaciones:208])
End for 
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])

