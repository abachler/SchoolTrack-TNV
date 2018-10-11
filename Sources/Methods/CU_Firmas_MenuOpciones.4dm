//%attributes = {}
  // CU_Firmas_MenuOpciones()
  // Por: Alberto Bachler K.: 25-02-14, 08:08:30
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
ARRAY LONGINT:C221($al_filasSeleccionadas;0)

$t_nombreListbox:="firmas.listbox"
$y_listBox:=OBJECT Get pointer:C1124(Object named:K67:5;$t_nombreListbox)
$y_firmantesAsignatura:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.asignaturas.arreglo")
$y_firmantesCodigoAsignatura:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.CodigoAsignatura.arreglo")
$y_firmantesUUID:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.uuid.arreglo")
$y_firmantesNombres:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.firmante.arreglo")
$y_firmantesRut:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.rut.arreglo")
$y_firmantesAutorizacion:=OBJECT Get pointer:C1124(Object named:K67:5;"firmas.Autorizacion.arreglo")
$y_mostrarNombresApellidos:=OBJECT Get pointer:C1124(Object named:K67:5;"mostrarNombresApellidos")

READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Profesores:4])

LISTBOX GET CELL POSITION:C971(*;$t_nombreListbox;$l_columna;$l_fila)
$l_fila:=LB_GetSelectedRows ($y_listBox;->$al_filasSeleccionadas)

$b_hayProfesoresSeleccionados:=False:C215
For ($i_filas;1;Size of array:C274($al_filasSeleccionadas))
	If ($y_firmantesUUID->{$i_filas}#"")
		$b_hayProfesoresSeleccionados:=True:C214
	End if 
End for 

READ ONLY:C145([Profesores:4])
QUERY:C277([Profesores:4];[Profesores]Asignaturas'Asignatura=$y_firmantesAsignatura->{$y_firmantesAsignatura->};*)
QUERY:C277([Profesores:4]; & ;[Profesores:4]Inactivo:62=False:C215)
ORDER BY:C49([Profesores:4];[Profesores:4]Apellidos_y_nombres:28;>)
SELECTION TO ARRAY:C260([Profesores:4]Auto_UUID:41;$at_uuidProfesor;[Profesores:4]Apellidos_y_nombres:28;$at_nombresProfesores;[Profesores:4]Nombres:2;$at_nombre;[Profesores:4]Apellido_paterno:3;$at_primerApellido;[Profesores:4]Apellido_materno:4;$at_segundoApellido)
$t_refMenuProfesores:=Create menu:C408
For ($i_items;1;Size of array:C274($at_nombresProfesores))
	APPEND MENU ITEM:C411($t_refMenuProfesores;$at_nombresProfesores{$i_items})
	SET MENU ITEM PARAMETER:C1004($t_refMenuProfesores;-1;$at_uuidProfesor{$i_items})
End for 


$t_refMenuOpciones:=Create menu:C408
Case of 
	: (Shift down:C543 & (Size of array:C274($al_filasSeleccionadas)=1))
		$b_agregarProfesor:=True:C214
		APPEND MENU ITEM:C411($t_refMenuOpciones;__ ("Añadir profesor firmante");$t_refMenuProfesores)
		
	: (Size of array:C274($al_filasSeleccionadas)=1)
		APPEND MENU ITEM:C411($t_refMenuOpciones;__ ("Asignar profesor firmante");$t_refMenuProfesores)
		
	Else 
		APPEND MENU ITEM:C411($t_refMenuOpciones;"("+__ ("Asignar profesor firmante");$t_refMenuProfesores)
End case 



APPEND MENU ITEM:C411($t_refMenuOpciones;"(-")
APPEND MENU ITEM:C411($t_refMenuOpciones;Choose:C955(Size of array:C274($al_filasSeleccionadas)>0;"("+__ ("Utilizar profesores asignados en las asignaturas");__ ("Utilizar profesores asignados en las asignaturas")))
SET MENU ITEM PARAMETER:C1004($t_refMenuOpciones;-1;"profesorAsignado")
APPEND MENU ITEM:C411($t_refMenuOpciones;Choose:C955($b_hayProfesoresSeleccionados | (Size of array:C274($al_filasSeleccionadas)=0);__ ("Actualizar autorizaciones desde las asignaturas");"("+__ ("Actualizar autorizaciones desde las asignaturas")))
SET MENU ITEM PARAMETER:C1004($t_refMenuOpciones;-1;"actualizarHabilitaciones")
APPEND MENU ITEM:C411($t_refMenuOpciones;"(-")

If (Size of array:C274($al_filasSeleccionadas)#0)
	APPEND MENU ITEM:C411($t_refMenuOpciones;"("+Choose:C955($y_mostrarNombresApellidos->=1;"!"+Char:C90(18)+__ ("Nombres y Apellidos");__ ("Nombres y Apellidos")))
	SET MENU ITEM PARAMETER:C1004($t_refMenuOpciones;-1;"nombresApellidos")
	APPEND MENU ITEM:C411($t_refMenuOpciones;"("+Choose:C955($y_mostrarNombresApellidos->=0;"!"+Char:C90(18)+__ ("Apellidos y Nombres");__ ("Apellidos y Nombres")))
	SET MENU ITEM PARAMETER:C1004($t_refMenuOpciones;-1;"apellidosNombres")
Else 
	APPEND MENU ITEM:C411($t_refMenuOpciones;Choose:C955($y_mostrarNombresApellidos->=1;"!"+Char:C90(18)+__ ("Nombres y Apellidos");__ ("Nombres y Apellidos")))
	SET MENU ITEM PARAMETER:C1004($t_refMenuOpciones;-1;"nombresApellidos")
	APPEND MENU ITEM:C411($t_refMenuOpciones;Choose:C955($y_mostrarNombresApellidos->=0;"!"+Char:C90(18)+__ ("Apellidos y Nombres");__ ("Apellidos y Nombres")))
	SET MENU ITEM PARAMETER:C1004($t_refMenuOpciones;-1;"apellidosNombres")
End if 

APPEND MENU ITEM:C411($t_refMenuOpciones;"(-")

APPEND MENU ITEM:C411($t_refMenuOpciones;Choose:C955($b_hayProfesoresSeleccionados;__ ("Sacar Profesor asignado");"("+__ ("Sacar Profesor asignado")))
SET MENU ITEM PARAMETER:C1004($t_refMenuOpciones;-1;"borrarProfesor")


$t_ParametroItemSeleccionado:=Dynamic pop up menu:C1006($t_refMenuOpciones;"")
If ($t_ParametroItemSeleccionado#"")
	
	If (Size of array:C274($al_filasSeleccionadas)=0)
		ARRAY LONGINT:C221($al_filasSeleccionadas;Size of array:C274($y_firmantesNombres->))
		For ($i_filas;1;Size of array:C274($al_filasSeleccionadas))
			$al_filasSeleccionadas{$i_filas}:=$i_filas
		End for 
	End if 
	
	Case of 
		: ($t_ParametroItemSeleccionado="profesorAsignado")
			CU_Firmas_ProfesoresAsignatura ($y_firmantesAsignatura;$y_firmantesCodigoAsignatura;$y_firmantesUUID;$y_firmantesNombres;$y_firmantesRut;$y_firmantesAutorizacion)
			
		: ($t_ParametroItemSeleccionado="actualizarHabilitaciones")
			For ($i_filas;1;Size of array:C274($al_filasSeleccionadas))
				$l_fila:=$al_filasSeleccionadas{$i_filas}
				$t_uuidProfesor:=$y_firmantesUUID->{$l_fila}
				$l_idProfesor:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_uuidProfesor;->[Profesores:4]Numero:1)
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=[Cursos:3]Nivel_Numero:7;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Asignatura:3=$y_firmantesAsignatura->{$l_fila};*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]profesor_firmante_numero:33=$l_idProfesor;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Incluida_en_Actas:44=True:C214;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Habilitacion_del_profesor:37#"")
				$y_firmantesAutorizacion->{$i_filas}:=Choose:C955([Asignaturas:18]Habilitacion_del_profesor:37#"";[Asignaturas:18]Habilitacion_del_profesor:37;"T")
			End for 
			
		: ($t_ParametroItemSeleccionado="nombresApellidos")
			$y_mostrarNombresApellidos->:=1
			For ($i_filas;1;Size of array:C274($al_filasSeleccionadas))
				$l_fila:=$al_filasSeleccionadas{$i_filas}
				$t_uuidProfesor:=$y_firmantesUUID->{$l_fila}
				$l_idProfesor:=KRL_FindAndLoadRecordByIndex (->[Profesores:4]Auto_UUID:41;->$t_uuidProfesor)
				$y_firmantesNombres->{$i_filas}:=ST_ClearSpaces ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4)
			End for 
			
			
		: ($t_ParametroItemSeleccionado="apellidosNombres")
			$y_mostrarNombresApellidos->:=0
			For ($i_filas;1;Size of array:C274($al_filasSeleccionadas))
				$l_fila:=$al_filasSeleccionadas{$i_filas}
				$t_uuidProfesor:=$y_firmantesUUID->{$l_fila}
				$l_idProfesor:=KRL_FindAndLoadRecordByIndex (->[Profesores:4]Auto_UUID:41;->$t_uuidProfesor)
				$y_firmantesNombres->{$i_filas}:=[Profesores:4]Apellidos_y_nombres:28
			End for 
			
		: ($t_ParametroItemSeleccionado="borrarProfesor")
			For ($i_filas;Size of array:C274($al_filasSeleccionadas);1;-1)
				$l_fila:=$al_filasSeleccionadas{$i_filas}
				$t_asignatura:=$y_firmantesAsignatura->{$l_fila}
				$l_numeroProfesoresAsignatura:=AT_CountValueOccurrences ($y_firmantesAsignatura;->$t_asignatura)
				If ($l_numeroProfesoresAsignatura>1)
					AT_Delete ($l_fila;1;$y_firmantesAsignatura;$y_firmantesCodigoAsignatura;$y_firmantesUUID;$y_firmantesNombres;$y_firmantesRut;$y_firmantesAutorizacion)
				Else 
					$y_firmantesNombres->{$l_fila}:=""
					$y_firmantesUUID->{$l_fila}:=""
					$y_firmantesRUT->{$l_fila}:=""
					$y_firmantesAutorizacion->{$l_fila}:=""
				End if 
			End for 
			
		: ($t_ParametroItemSeleccionado#"")  // asignación del profesor seleccionado
			$t_uuid:=$t_ParametroItemSeleccionado
			KRL_FindAndLoadRecordByIndex (->[Profesores:4]Auto_UUID:41;->$t_uuid;False:C215)
			If ($y_mostrarNombresApellidos->=1)
				$t_nombreProfesor:=ST_ClearSpaces ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4)
			Else 
				$t_nombreProfesor:=[Profesores:4]Apellidos_y_nombres:28
			End if 
			$t_habilitacion:="T"
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=$y_firmantesAsignatura->{$y_firmantesAsignatura->};*)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=[Cursos:3]Nivel_Numero:7)
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1;*)
			QUERY SELECTION:C341([Asignaturas:18]; | ;[Asignaturas:18]profesor_firmante_numero:33=[Profesores:4]Numero:1)
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Habilitacion_del_profesor:37#"")
			If (Records in selection:C76([Asignaturas:18])>0)
				$t_habilitacion:=[Asignaturas:18]Habilitacion_del_profesor:37
			End if 
			If ($b_agregarProfesor | (Shift down:C543))
				AT_Insert ($y_firmantesAsignatura->+1;1;$y_firmantesAsignatura;$y_firmantesCodigoAsignatura;$y_firmantesUUID;$y_firmantesNombres;$y_firmantesRut;$y_firmantesAutorizacion)
				$y_firmantesAsignatura->{$y_firmantesAsignatura->+1}:=$y_firmantesAsignatura->{$y_firmantesAsignatura->}
				$y_firmantesCodigoAsignatura->{$y_firmantesAsignatura->+1}:=$y_firmantesCodigoAsignatura->{$y_firmantesCodigoAsignatura->}
			End if 
			$y_firmantesNombres->{$y_firmantesNombres->}:=$t_nombreProfesor
			$y_firmantesUUID->{$y_firmantesUUID->}:=[Profesores:4]Auto_UUID:41
			$y_firmantesRUT->{$y_firmantesUUID->}:=[Profesores:4]RUT:27
			$y_firmantesAutorizacion->{$y_firmantesAutorizacion->}:=$t_habilitacion
	End case 
	LISTBOX SELECT ROW:C912(*;$t_nombreListbox;0;lk remove from selection:K53:3)
	CU_Firmas_GuardaFirmantes ($y_firmantesAsignatura;$y_firmantesCodigoAsignatura;$y_firmantesUUID;$y_firmantesNombres;$y_firmantesRut;$y_firmantesAutorizacion;$y_mostrarNombresApellidos)
	CU_Firmas_LeeFirmantes ($y_firmantesAsignatura;$y_firmantesCodigoAsignatura;$y_firmantesUUID;$y_firmantesNombres;$y_firmantesRut;$y_firmantesAutorizacion;$y_mostrarNombresApellidos)
	CU_Firmas_ActivarPagina 
End if 

