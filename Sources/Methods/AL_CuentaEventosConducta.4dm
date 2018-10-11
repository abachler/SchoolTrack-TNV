//%attributes = {}
  //Metodo: AL_CuentaEventosConducta
  //Por abachler
  //Creada el 03/06/2008, 09:58:59
  // ----------------------------------------------------
  // Descripción
  // Cuenta todos los eventos conductuales para el alumno cuyo ID es pasado en $1
  //
  // ----------------------------------------------------
  // Parámetros
  // $1: ID alumno; &L
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
$id_Alumno:=$1
$nivel:=0

$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$id_Alumno)

If (Count parameters:C259=2)
	$nivel:=$2
End if 

If ($nivel=0)
	$nivel:=[Alumnos:2]nivel_numero:29
End if 


  //CUERPO
If ($recNum>=0)
	PERIODOS_LoadData ($nivel)
	
	  //movido aquí para contabilizar las faltas por atrasos antes de calcular el % de asistencia
	$success:=AL_TotalizaAtrasos ($id_Alumno;$nivel)
	If (Not:C34($success))
		$0:=BM_CreateRequest ("Cuenta atrasos";String:C10($id_Alumno);String:C10($id_Alumno))
	End if 
	
	$success:=AL_TotalizaInasistencias ($id_Alumno;$nivel)
	If (Not:C34($success))
		$0:=BM_CreateRequest ("Cuenta Inasistencias";String:C10($id_Alumno);String:C10($id_Alumno))
	End if 
	
	$success:=AL_TotalizaCastigos ($id_Alumno;$nivel)
	If (Not:C34($success))
		$0:=BM_CreateRequest ("Cuenta castigos";String:C10($id_Alumno);String:C10($id_Alumno))
	End if 
	
	$success:=AL_TotalizaAnotaciones ($id_Alumno;$nivel)
	If (Not:C34($success))
		$ignore:=BM_CreateRequest ("Cuenta anotaciones";String:C10($id_Alumno);String:C10($id_Alumno))
	End if 
	
	$success:=AL_TotalizaSuspensiones ($id_Alumno;$nivel)
	If (Not:C34($success))
		$ignore:=BM_CreateRequest ("Cuenta suspensiones";String:C10($id_Alumno);String:C10($id_Alumno))
	End if 
	
End if 
  //LIMPIEZA


