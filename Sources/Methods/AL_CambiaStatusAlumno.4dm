//%attributes = {}
  // AL_CambiaStatusAlumno()
  // Por: Alberto Bachler: 27/02/13, 10:35:04
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_itemSeleccionado;$l_itemSeleccionado;$l_año)
C_TEXT:C284($t_itemsMenu;$t_estatusNuevo)
C_POINTER:C301($y_status)
ARRAY TEXT:C222($at_status;0)

$y_status:=OBJECT Get pointer:C1124(Object named:K67:5;"InputStatusAlumno")

If (USR_GetMethodAcces (Current method name:C684))
	  //MONO Ticket 174967 Status Alumnos
	For ($i;1;Size of array:C274(<>at_StatusAlumnoAlias))
		If (<>ab_StatusAlumnoVisible{$i})
			APPEND TO ARRAY:C911($at_status;<>at_StatusAlumnoAlias{$i})
		End if 
	End for 
	
	  //MONO 20180711 - Deshabilitación de status antes de pasar el array al string utilizado por "Pop up menu"
	If ([Alumnos:2]nivel_numero:29=Nivel_Egresados)
		For ($i;1;Size of array:C274($at_status))
			$at_status{$i}:="("+$at_status{$i}
		End for 
		
	Else 
		  //20150227 ASM  para no seleccionar dos el mismo estado. ya que producía un problema al retirar a los alumnos con o sin mantener en la lista (calculaba mal el numero de alumnos en el curso)
		$fia:=Find in array:C230(<>at_StatusAlumno;[Alumnos:2]Status:50)
		If ($fia>0)
			$t_estatusActual:=<>at_StatusAlumnoAlias{$fia}
			$fia:=Find in array:C230($at_status;$t_estatusActual)
			If ($fia>0)
				$at_status{$fia}:="("+$at_status{$fia}
			End if 
		End if 
		
		  //un alumno que no viene de admisión directa no puede egresarse manualmente debido a que esto para los alumnos "regulares" debe hacer un proceso de cierre
		If ([Alumnos:2]nivel_numero:29#Nivel_AdmisionDirecta)
			$fia:=Find in array:C230(<>at_StatusAlumno;"Egresado")
			If ($fia>0)
				$t_egresado:=<>at_StatusAlumnoAlias{$fia}
				$fia:=Find in array:C230($at_status;$t_egresado)
				If ($fia>0)
					$at_status{$fia}:="("+$at_status{$fia}
				End if 
			End if 
		End if 
	End if 
	
	$t_itemsMenu:=AT_array2text (->$at_status)
	
	$l_itemSeleccionado:=Find in array:C230($at_status;$t_estatusActual)
	If ($l_itemSeleccionado=-1)
		$l_itemSeleccionado:=0
	End if 
	
	If ($l_itemSeleccionado=-1)
		$l_itemSeleccionado:=0
	End if 
	  //$l_itemSeleccionado:=Pop up menu($t_itemsMenu;$l_itemSeleccionado)
	  //$t_estatusNuevo:=$at_status{$l_itemSeleccionado}
	
	$l_itemSeleccionado:=Pop up menu:C542($t_itemsMenu;$l_itemSeleccionado)
	If ($l_itemSeleccionado>0)
		
		$fia:=Find in array:C230(<>at_StatusAlumnoAlias;$at_status{$l_itemSeleccionado})
		$t_estatusNuevo:=<>at_StatusAlumno{$fia}
		$y_status->:=$at_status{$l_itemSeleccionado}
		
		Case of 
				  //: (($t_estatusNuevo="Promovido anticipadamente") & ($t_estatusActual="Retirado@"))
			: ($t_estatusNuevo="Promovido anticipadamente")
				If ($t_estatusActual="Retirado@")
					ModernUI_Notificacion ("Promoción anticipada de un alumno";"Un alumno retirado no puede ser promovido anticipadamente.")
				Else 
					$l_recNumAlumno:=Record number:C243([Alumnos:2])
					$d_fechaPromoción:=!00-00-00!
					$t_fechaPromocionLiteral:=CD_Request (__ ("¿A contar de que fecha?");__ ("Aceptar");__ ("Cancelar");__ ("");String:C10(Current date:C33(*);7))
					While ((DT_StrDateIsOK ($t_fechaPromocionLiteral;False:C215)=dt_GetNullDateString ) & (OK=1))
						CD_Dlog (0;__ ("Fecha Incorrecta."))
						$t_fechaPromocionLiteral:=CD_Request (__ ("¿A contar de que fecha?");__ ("Aceptar");__ ("Cancelar");__ ("");String:C10(Current date:C33(*);7))
					End while 
					If (ok=1)
						$d_fechaPromoción:=Date:C102($t_fechaPromocionLiteral)
						$d_fechaPromoción:=DT_GetDateFromDayMonthYear (Day of:C23($d_fechaPromoción);Month of:C24($d_fechaPromoción);Year of:C25($d_fechaPromoción))
					End if 
					If ($d_fechaPromoción#!00-00-00!)
						[Alumnos:2]Fecha_de_retiro:42:=$d_fechaPromoción
						[Alumnos:2]Status:50:=$t_estatusNuevo
						[Alumnos:2]Tutor_numero:36:=0
						If (AL_EliminaInfoPostRetiro )
							SAVE RECORD:C53([Alumnos:2])
							KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;True:C214)
							[Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61:=False:C215
							SAVE RECORD:C53([Alumnos_SintesisAnual:210])
							KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
							AL_CalculaSituacionFinal ([Alumnos:2]numero:1)
							KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
							LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$t_estatusActual+" a "+$t_estatusNuevo)
						End if 
					End if 
				End if 
				
			: (($t_estatusActual="Retirado@") & ($t_estatusNuevo="Retirado@"))
				  //   edición de las propiedades de retiro o si se cambia de"retirado"a"retirado temporalmente"o viceversa
				[Alumnos:2]Status:50:=$t_estatusNuevo
				WDW_OpenFormWindow (->[Alumnos:2];"Retiros";-1;Modal form dialog box:K39:7)
				DIALOG:C40([Alumnos:2];"Retiros")
				CLOSE WINDOW:C154
				
			: ($t_estatusActual=$t_estatusNuevo)
				  // el usuario selecciono el mismo estado. no hacemos nada
				
			: (($t_estatusActual#"Retirado@") & ($t_estatusNuevo#"Retirado@") & ([Alumnos:2]nivel_numero:29=Nivel_Retirados))
				  // la reactivación de un alumno no puede ser efectuada aquí, se debe utilizar la herramienta de reorganización de cursos
				$t_titulo:=[Alumnos:2]apellidos_y_nombres:40+__ (" está en el grupo de alumnos retirados.")
				$t_mensaje:=__ ("Para activarlo debe utilizar la herramienta de reorganización de cursos.")
				ModernUI_Notificacion ($t_titulo;$t_mensaje)
				
			: ((($t_estatusActual="Activo") | ($t_estatusActual="En Tramite") | ($t_estatusActual="Oyente")) & (($t_estatusNuevo="Activo") | ($t_estatusNuevo="En Tramite") | ($t_estatusNuevo="Oyente")))
				  // el cambio de estado no implica ninguna modificación en los datos actules. Se realiza inmediatamente
				[Alumnos:2]Status:50:=$t_estatusNuevo
				SAVE RECORD:C53([Alumnos:2])
				LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$t_estatusActual+" a "+$t_estatusNuevo)
				
			: ($t_estatusNuevo="Egresado")
				$l_año:=Num:C11(CD_Request (__ ("Por favor ingrese el año de egreso...");"OK";__ ("Cancelar");"";String:C10(<>gYear-1)))
				If (($l_año>1492) & ($l_año<<>gYear))
					[Alumnos:2]nivel_numero:29:=Nivel_Egresados
					[Alumnos:2]Nivel_Nombre:34:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Nivel:1)
					[Alumnos:2]curso:20:="EGR-"+String:C10($l_año)
					[Alumnos:2]Sección:26:="Egresados"
					[Alumnos:2]Tutor_numero:36:=0
					[Alumnos:2]Status:50:="Egresado"
					[Alumnos:2]Apoderado_académico_Número:27:=0
					SAVE RECORD:C53([Alumnos:2])  //20180626 RCH: A solicitud de JHB.
					LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$t_estatusActual+" a "+$t_estatusNuevo)
				Else 
					CD_Dlog (0;__ ("El año de egreso no puede ser inferior a 1492 ni igual o superior al año actual."))
				End if 
				
			: (($t_estatusActual="Promovido anticipadamente") & ($t_estatusNuevo="Activo"))  //Mono ticket  134524
				
				$l_recNumAlumno:=Record number:C243([Alumnos:2])
				[Alumnos:2]Fecha_de_retiro:42:=!00-00-00!
				[Alumnos:2]Status:50:=$t_estatusNuevo
				SAVE RECORD:C53([Alumnos:2])
				AL_CalculaSituacionFinal ([Alumnos:2]numero:1)
				KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
				LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$t_estatusActual+" a "+$t_estatusNuevo)
				
				
			: ($l_itemSeleccionado>0)
				[Alumnos:2]Status:50:=$t_estatusNuevo
				  //WDW_OpenFormWindow (->[Alumnos];"Retiros";-1;Movable form dialog box)
				WDW_OpenFormWindow (->[Alumnos:2];"Retiros";-1;Modal form dialog box:K39:7)
				DIALOG:C40([Alumnos:2];"Retiros")
				CLOSE WINDOW:C154
		End case 
	End if 
End if 

OBJECT SET VISIBLE:C603(*;"fechaRetiro@";(([Alumnos:2]Fecha_de_retiro:42#!00-00-00!) | ([Alumnos:2]Status:50="Retirado@")))
