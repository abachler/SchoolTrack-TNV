  // [Cursos].Input.firmas.lista()
  // Por: Alberto Bachler K.: 23-02-14, 11:44:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_agregarProfesor)
C_LONGINT:C283($i_filas;$i_items;$l_columna;$l_fila;$l_idProfesor;$l_numeroProfesoresAsignatura)
C_POINTER:C301($y_firmantesAsignatura;$y_firmantesAutorizacion;$y_firmantesCodigoAsignatura;$y_firmantesNombres;$y_firmantesRut;$y_firmantesUUID;$y_mostrarNombresApellidos)
C_TEXT:C284($t_asignatura;$t_habilitacion;$t_nombreListbox;$t_nombreProfesor;$t_ParametroItemSeleccionado;$t_refMenuOpciones;$t_refMenuProfesores;$t_uuid;$t_uuidProfesor)

ARRAY TEXT:C222($at_nombre;0)
ARRAY TEXT:C222($at_nombresProfesores;0)
ARRAY TEXT:C222($at_primerApellido;0)
ARRAY TEXT:C222($at_segundoApellido;0)
ARRAY TEXT:C222($at_uuidProfesor;0)


$t_nombreListbox:=OBJECT Get name:C1087(Object current:K67:2)
$y_firmantesAsignatura:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.asignaturas.arreglo")
$y_firmantesCodigoAsignatura:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.CodigoAsignatura.arreglo")
$y_firmantesUUID:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.uuid.arreglo")
$y_firmantesNombres:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.firmante.arreglo")
$y_firmantesRut:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.rut.arreglo")
$y_firmantesAutorizacion:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.Autorizacion.arreglo")
$y_mostrarNombresApellidos:=OBJECT Get pointer:C1124(Object named:K67:5;"mostrarNombresApellidos")

READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Profesores:4])

Case of 
	: (Form event:C388=On Alternative Click:K2:36)
		
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			CU_Firmas_MenuOpciones 
		End if 
		
		
		
	: (Form event:C388=On Double Clicked:K2:5)
		
	: (Form event:C388=On Header Click:K2:40)
		
	: (Form event:C388=On Begin Drag Over:K2:44)
		
	: (Form event:C388=On Drag Over:K2:13)
		
	: (Form event:C388=On Drop:K2:12)
		
	: (Form event:C388=On After Sort:K2:28)
		
	: (Form event:C388=On Selection Change:K2:29)
		
	: (Form event:C388=On Data Change:K2:15)
		CU_Firmas_GuardaFirmantes ($y_firmantesAsignatura;$y_firmantesCodigoAsignatura;$y_firmantesUUID;$y_firmantesNombres;$y_firmantesRut;$y_firmantesAutorizacion;$y_mostrarNombresApellidos)
End case 

