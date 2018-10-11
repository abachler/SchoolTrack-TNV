//%attributes = {}
  // CU_Firmas_ActivarPagina()
  // Por: Alberto Bachler K.: 22-02-14, 19:44:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_filas)
C_POINTER:C301($y_firmantesAsignatura;$y_firmantesAutorizacion;$y_firmantesCodigoAsignatura;$y_firmantesNombres;$y_firmantesRut;$y_firmantesUUID;$y_mostrarNombresApellidos)

ARRAY POINTER:C280($ay_Jerarquia;0)
ARRAY TEXT:C222($at_asignaturas;0)
ARRAY TEXT:C222($at_ValoresUnicos;0)

$y_firmantesAsignatura:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.asignaturas.arreglo")
$y_firmantesCodigoAsignatura:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.CodigoAsignatura.arreglo")
$y_firmantesUUID:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.uuid.arreglo")
$y_firmantesNombres:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.firmante.arreglo")
$y_firmantesRut:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.rut.arreglo")
$y_firmantesAutorizacion:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.Autorizacion.arreglo")
$y_mostrarNombresApellidos:=OBJECT Get pointer:C1124(Object named:K67:5;"mostrarNombresApellidos")



READ ONLY:C145([xxSTR_Niveles:6])
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)

CU_Firmas_ActualizaLista ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)

If (BLOB size:C605([xxSTR_Niveles:6]Actas_y_Certificados:43)>0)
	$l_recNum:=Record number:C243([Cursos:3])
	ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
	KRL_GotoRecord (->[Cursos:3];$l_recNum;True:C214)
	
	  //CU_Firmas_ActualizaLista ([Cursos]Nivel_Numero;[Cursos]Curso)
	CU_Firmas_LeeFirmantes ($y_firmantesAsignatura;$y_firmantesCodigoAsignatura;$y_firmantesUUID;$y_firmantesNombres;$y_firmantesRut;$y_firmantesAutorizacion;$y_mostrarNombresApellidos)
	ARRAY LONGINT:C221($al_Orden;Size of array:C274($y_firmantesAsignatura->))
	For ($i_filas;1;Size of array:C274($y_firmantesAsignatura->))
		$al_Orden{$i_filas}:=Find in array:C230(atActas_Subsectores;$y_firmantesAsignatura->{$i_filas})
	End for 
	SORT ARRAY:C229($al_Orden;$y_firmantesAsignatura->;$y_firmantesCodigoAsignatura->;$y_firmantesUUID->;$y_firmantesNombres->;$y_firmantesRut->;$y_firmantesAutorizacion->;>)
	
	COPY ARRAY:C226($y_firmantesAsignatura->;$at_ValoresUnicos)
	AT_DistinctsArrayValues (->$at_ValoresUnicos)
	If (Size of array:C274($at_ValoresUnicos)#Size of array:C274($y_firmantesAsignatura->))
		APPEND TO ARRAY:C911($ay_Jerarquia;$y_firmantesAsignatura)
		LISTBOX SET HIERARCHY:C1098(*;"firmas.listbox";True:C214;$ay_Jerarquia)
	Else 
		LISTBOX SET HIERARCHY:C1098(*;"firmas.listbox";False:C215)
	End if 
	
	KRL_ReloadInReadWriteMode (->[Cursos:3])
	REDUCE SELECTION:C351([Profesores:4];0)
	RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
	FORM GOTO PAGE:C247(7)
	
	
Else 
	CD_Dlog (0;__ ("No es posible definir los profesores firmantes ahora.\rDefina previamente el modelo de actas en Preferencias -> Niveles."))
	CU_OnRecordLoad (1)
End if 