//%attributes = {}
  // MÉTODO: AS_TareasPostEdicionNotas
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 26/12/11, 18:10:06
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_TareasPostEdicionNotas()
  // ----------------------------------------------------
C_BOOLEAN:C305($b_readWriteState)
C_LONGINT:C283($l_RecNumAsignaturaActual;$i)

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_Cursos;0)

If (Count parameters:C259=2)
	$userID:=$1
	$module:=$2
Else 
	$userID:=<>lUSR_CurrentUserID
	$module:=vsBWR_CurrentModule
End if 


  // CODIGO PRINCIPAL
If (modNotas)
	
	LOG_RegisterEvt ("Asignaturas - Modificación en calificaciones: "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Table:C252(->[Asignaturas:18]);[Asignaturas:18]Numero:1;$userID;$module)
	
	AS_CreaTareasRecalculos ([Asignaturas:18]Numero:1;->aIdAlumnos_a_Recalcular)
	modNotas:=False:C215
End if 

