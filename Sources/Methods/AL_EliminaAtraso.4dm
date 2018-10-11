//%attributes = {}
  // AL_EliminaAtraso()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 06/01/13, 10:15:27
  // ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_recNumAtraso;$l_registroEliminado;$l_respuestaUsuario)

If (False:C215)
	C_LONGINT:C283(AL_EliminaAtraso ;$0)
	C_LONGINT:C283(AL_EliminaAtraso ;$1)
End if 

  // CODIGO
$l_recNumAtraso:=$1
KRL_GotoRecord (->[Alumnos_Atrasos:55];$l_recNumAtraso;True:C214)
If (OK=1)
	$l_respuestaUsuario:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar el registro de Atraso seleccionado?");__ ("");__ ("No");__ ("Eliminar"))
	If ($l_respuestaUsuario=2)
		
		$l_noHora:=[Alumnos_Atrasos:55]NumeroHora:11
		$b_esIntersesion:=[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4
		$d_fecha:=[Alumnos_Atrasos:55]Fecha:2
		
		LOG_RegisterEvt ("Eliminación de Atraso ("+String:C10([Alumnos_Atrasos:55]Fecha:2;Internal date short special:K1:4)+") para "+[Alumnos:2]apellidos_y_nombres:40)
		DELETE RECORD:C58([Alumnos_Atrasos:55])
		$l_registroEliminado:=1
		
		  // ASM Ticket 208501 Registro de atraso de inicio de jornada cuando se crear atraso en la primera hora.
		
		If (($l_noHora=1) & ($b_esIntersesion) & (Num:C11(PREF_fGet (0;"CrearAtrasoInicioJornada";"0"))=1))
			QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
			QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]NumeroHora:11=$l_noHora;*)
			QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]CreadoPorConfiguracion:16=True:C214;*)
			QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$d_fecha)
			DELETE RECORD:C58([Alumnos_Atrasos:55])
			LOG_RegisterEvt ("Asistencia y Atrasos: Eliminación de atraso de inicio de jornada creado automáticamente por configuración.. \rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10([Alumnos_Atrasos:55]Fecha:2))
		End if 
		
	End if 
	READ ONLY:C145([Alumnos_Atrasos:55])
Else 
	CD_Dlog (0;__ ("No es posible eliminar el registro de Atraso en este momento.\r\rImposible de acceder en escritura al registro."))
End if 

$0:=$l_registroEliminado

