//%attributes = {}
  // MÉTODO: EV2_TareasRecalculosPromedios
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 04/01/12, 10:26:14
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Crea las tareas de recalculo de promedios generales de Asignaturas, Alumnos y Cursos
  // Este método es llamado después de un recalculo general de promedio (EV2dbu_recalculo y MPAdbu_Recalculos)
  //
  // PARÁMETROS
  // EV2_TareasRecalculosPromedios(blob)
  // $1: Blob: El blob contiene tres arreglos (el orden debe ser imperativamente el siguiente
  //  - arreglo 1: ASIGNATURAS: IDs de asignaturas para las que hay que recalcular promedios
  //  - arreglo 2: ALUMNOS: IDs de asignaturas para las que hay que recalcular promedios
  //  - arreglo 3: CURSOS: IDs de asignaturas para las que hay que recalcular promedios
  // ----------------------------------------------------
C_BLOB:C604($x_ArreglosRecalculos;$1)
ARRAY LONGINT:C221($al_AsignaturaRecalculo;0)
ARRAY LONGINT:C221($al_AlumnosRecalculo;0)
ARRAY TEXT:C222($at_CursosRecalculo;0)


  // CODIGO PRINCIPAL
$x_ArreglosRecalculos:=$1
BLOB_Blob2Vars (->$x_ArreglosRecalculos;0;->$al_AsignaturaRecalculo;->$al_AlumnosRecalculo;->$at_CursosRecalculo)

For ($i;1;Size of array:C274($al_AsignaturaRecalculo))
	BM_CreateRequest ("EV2_ResultadosAsignatura";String:C10($al_AsignaturaRecalculo{$i});String:C10($al_AsignaturaRecalculo{$i}))
End for 

For ($i;1;Size of array:C274($al_AlumnosRecalculo))
	BM_CreateRequest ("CalculaPromediosGenerales";String:C10($al_AlumnosRecalculo{$i});String:C10($al_AlumnosRecalculo{$i}))
End for 

For ($i;1;Size of array:C274($at_CursosRecalculo))
	BM_CreateRequest ("Recalcular Promedios Curso";$at_CursosRecalculo{$i};$at_CursosRecalculo{$i})
End for 

