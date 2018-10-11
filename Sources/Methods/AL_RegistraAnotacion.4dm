//%attributes = {}
  // AL_RegistraAnotacion()
  // Por: Alberto Bachler K.: 29-04-14, 09:12:58
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($err;$i;$l_opcionUsuario)
C_TEXT:C284($t_mensaje;$t_metodoRegistro)

If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("El registro de información conductual está bloqueado para el ciclo escolar actual a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
Else 
	If (USR_checkRights ("A";->[Alumnos_Conducta:8]))
		$t_metodoRegistro:=PREF_fGet (<>lUSR_CurrentUserID;"Anotaciones")
		If (($t_metodoRegistro="") | (IT_AltKeyIsDown ))
			$t_mensaje:="Puede ingresar las anotaciones de dos maneras: "+"\r"
			$t_mensaje:=$t_mensaje+"   - seleccionando a los alumnos en la lista"+"\r"
			$t_mensaje:=$t_mensaje+"   - ingresando los números de lista de curso"+"\r"
			$t_mensaje:=$t_mensaje+"¿ Que método desea utilizar ?"+"\r\r"
			$t_mensaje:=$t_mensaje+"(si más tarde desea cambiar esta opción presione la tecla Alt"+" cuando haga clic en el botón de registro de atrasos)"
			$l_opcionUsuario:=CD_Dlog (0;$t_mensaje;__ ("");__ ("Nº de Lista");__ ("Selección");__ ("Cancelar"))
			Case of 
				: ($l_opcionUsuario=1)
					PREF_Set (<>lUSR_CurrentUserID;"Anotaciones";"Numeros")
					$t_metodoRegistro:="Numeros"
				: ($l_opcionUsuario=2)
					PREF_Set (<>lUSR_CurrentUserID;"Anotaciones";"Selección")
					$t_metodoRegistro:="Selección"
				: ($l_opcionUsuario=3)
					$t_metodoRegistro:=""
			End case 
		End if 
		
		If (vLocation="Browser")
			$err:=AL_GetSelect (xALP_Browser;abrSelect)
		End if 
		
		Case of 
			: (($t_metodoRegistro="Numeros") & (vLocation="Browser"))
				ARRAY TEXT:C222(atSTRal_NombreAlumno;0)
				ARRAY DATE:C224(adSTRal_FechaAnotacion;0)
				ARRAY TEXT:C222(atSTRal_NombreProfesorAnot;0)
				ARRAY TEXT:C222(atSTRal_MotivoAnotacion;0)
				ARRAY LONGINT:C221(alSTRal_NoProfesorAnot;0)
				ARRAY TEXT:C222(atSTRal_NotasAnotacion;0)
				ARRAY TEXT:C222(atSTRal_CategoriaAnotacion;0)
				ARRAY INTEGER:C220(alSTRal_PuntosAnotacion;0)
				ARRAY LONGINT:C221(alSTRal_NumeroAlumno;0)
				ARRAY TEXT:C222(atSTRal_TipoAnotacion;0)
				ARRAY TEXT:C222(atSTRal_AsignaturaAnot;0)
				
				WDW_OpenFormWindow (->[Alumnos_Conducta:8];"AnotExpress";-1;Movable form dialog box:K39:8)
				DIALOG:C40([Alumnos_Conducta:8];"AnotExpress")
				AT_Initialize (->atSTRal_NombreAlumno;->adSTRal_FechaAnotacion;->atSTRal_NombreProfesorAnot;->atSTRal_MotivoAnotacion;->alSTRal_NoProfesorAnot;->atSTRal_NotasAnotacion;->atSTRal_CategoriaAnotacion;->alSTRal_PuntosAnotacion;->alSTRal_NumeroAlumno;->atSTRal_TipoAnotacion;->atSTRal_AsignaturaAnot)
				
			: (($t_metodoRegistro="Selección") | (vLocation="Input"))
				READ ONLY:C145([Alumnos:2])
				If (Size of array:C274(abrSelect)>0)
					If (vLocation="Browser")
						KRL_GotoRecord (->[Alumnos:2];alBWR_recordNumber{aBrSelect{1}})
						If (OK=0)
							CD_Dlog (0;__ ("No fue posible acceder al registro del alumno #")+String:C10(alBWR_recordNumber{aBrSelect{$i}})+__ (".\r\rPor favor seleccione en la lista los alumnos que desea anotar."))
							OK:=0
						End if 
					End if 
				End if 
				PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
				WDW_OpenDialogInDrawer (->[Alumnos_Anotaciones:11];"MultiInput")
				
		End case 
	Else 
		USR_ALERT_UserHasNoRights (4)
	End if 
End if 