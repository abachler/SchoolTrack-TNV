//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 30-09-17, 16:08:21
  // ----------------------------------------------------
  // Método: STR_ResponsableNiveles
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($col;$i;$l_director;$l_id;$l_idProfesor;$l_itemSeleccionado;$line)
C_POINTER:C301($ptr;$y_arregloAsignaturas)
C_TEXT:C284($t_accion)
C_OBJECT:C1216($ob_responsable)
C_BOOLEAN:C305($b_esEncargado;$0)

ARRAY LONGINT:C221($al_IdProfesores;0)
ARRAY TEXT:C222($at_cargosNiveles;0)
ARRAY TEXT:C222($at_profesores;0)


$t_accion:=$1
$b_esEncargado:=False:C215

Case of 
	: (Count parameters:C259=2)
		$l_idProfesor:=$2
	: (Count parameters:C259=3)
		$l_idProfesor:=$2
		$y_arregloAsignaturas:=$3
End case 

Case of 
	: ($t_accion="init")
		ARRAY TEXT:C222(at_funcionarioNombre;0)
		ARRAY TEXT:C222(at_cargoFuncionario;0)
		ARRAY LONGINT:C221(al_IdFuncionario;0)
		
		
		$ob_responsable:=[xxSTR_Niveles:6]OB_responsable:28
		OB_GET ($ob_responsable;->at_funcionarioNombre;"nombre")
		OB_GET ($ob_responsable;->at_cargoFuncionario;"cargo")
		OB_GET ($ob_responsable;->al_IdFuncionario;"id")
		
		
	: ($t_accion="InsertaElementoArray")
		AT_Insert (0;1;->at_funcionarioNombre;->at_cargoFuncionario;->al_IdFuncionario)
		at_funcionarioNombre{Size of array:C274(at_funcionarioNombre)}:=__ ("Doble click para agregar...")
		at_cargoFuncionario{Size of array:C274(at_cargoFuncionario)}:=__ ("Doble click para agregar...")
		
	: ($t_accion="agregaFuncionario")
		
		LISTBOX GET CELL POSITION:C971(lb_responsables;$col;$line;$ptr)
		If ($line>0)
			READ ONLY:C145([Profesores:4])
			  //ALL RECORDS([Profesores])MONO ticket 207269
			QUERY:C277([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
			SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;$at_profesores;[Profesores:4]Numero:1;$al_IdProfesores)
			SORT ARRAY:C229($at_profesores;$al_IdProfesores;>)
			
			$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_profesores)
			If ($l_itemSeleccionado>0)
				$l_id:=$al_IdProfesores{$l_itemSeleccionado}
				KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->$l_id;False:C215)
				at_funcionarioNombre{$line}:=ST_ClearSpaces ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4)
				al_IdFuncionario{$line}:=[Profesores:4]Numero:1
				at_cargoFuncionario{$line}:="Director(a)"
			End if 
		End if 
		
	: ($t_accion="agregaCargo")
		
		LISTBOX GET CELL POSITION:C971(lb_responsables;$col;$line;$ptr)
		If ($line>0)
			COPY ARRAY:C226(<>cargosNiveles;$at_cargosNiveles)
			
			$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_cargosNiveles)
			If ($l_itemSeleccionado>0)
				at_cargoFuncionario{$line}:=$at_cargosNiveles{$l_itemSeleccionado}
			End if 
		End if 
		
	: ($t_accion="eliminaFuncionario")
		LISTBOX GET CELL POSITION:C971(lb_responsables;$col;$line;$ptr)
		If (($line>0) & (Size of array:C274(at_funcionarioNombre)>0))
			DELETE FROM ARRAY:C228(at_funcionarioNombre;$line)
			DELETE FROM ARRAY:C228(at_cargoFuncionario;$line)
			DELETE FROM ARRAY:C228(al_IdFuncionario;$line)
		End if 
		
	: ($t_accion="guardaResponsable")
		
		For ($i;Size of array:C274(al_IdFuncionario);1;-1)
			If (al_IdFuncionario{$i}<=0)
				DELETE FROM ARRAY:C228(at_funcionarioNombre;$i)
				DELETE FROM ARRAY:C228(at_cargoFuncionario;$i)
				DELETE FROM ARRAY:C228(al_IdFuncionario;$i)
			End if 
		End for 
		
		$ob_responsable:=OB_Create 
		OB_SET ($ob_responsable;->at_funcionarioNombre;"nombre")
		OB_SET ($ob_responsable;->at_cargoFuncionario;"cargo")
		OB_SET ($ob_responsable;->al_IdFuncionario;"id")
		[xxSTR_Niveles:6]OB_responsable:28:=$ob_responsable
		$l_director:=Find in array:C230(at_cargoFuncionario;"directo@")
		
		If ($l_director#-1)
			[xxSTR_Niveles:6]ID_DirectorNivel:52:=al_IdFuncionario{$l_director}
			[xxSTR_Niveles:6]Director:13:=at_funcionarioNombre{$l_director}
		Else 
			[xxSTR_Niveles:6]ID_DirectorNivel:52:=0
			[xxSTR_Niveles:6]Director:13:=""
		End if 
		
	: ($t_accion="cargaAsignaturas")
		
		QUERY BY ATTRIBUTE:C1331([xxSTR_Niveles:6];[xxSTR_Niveles:6]OB_responsable:28;"id[]";=;$l_idProfesor)
		KRL_RelateSelection (->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]NoNivel:5;"")
		SELECTION TO ARRAY:C260([Asignaturas:18];$y_arregloAsignaturas->)
		
	: ($t_accion="verificaUsuario")
		
		QUERY BY ATTRIBUTE:C1331([xxSTR_Niveles:6];[xxSTR_Niveles:6]OB_responsable:28;"id[]";=;$l_idProfesor)
		If (Records in selection:C76([xxSTR_Niveles:6])>0)
			$b_esEncargado:=True:C214
		Else 
			$b_esEncargado:=False:C215
		End if 
End case 

$0:=$b_esEncargado

