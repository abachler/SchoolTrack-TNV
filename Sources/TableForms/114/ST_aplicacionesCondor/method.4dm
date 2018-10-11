

Case of 
	: (Form event:C388=On Load:K2:1)
		
		ARRAY TEXT:C222($at_nombres;0)
		ARRAY LONGINT:C221($al_Types;0)
		ARRAY TEXT:C222($at_modulosActivosUser;0)
		ARRAY PICTURE:C279($ap_modulosImagenActivo;0)
		ARRAY PICTURE:C279($ap_modulosImagenInactivo;0)
		
		C_OBJECT:C1216($jsonCondor;$o_parametros)
		C_BOOLEAN:C305($b_activo)
		$t_uuidColegio:=LICENCIA_ObtieneUUIDinstitucion 
		$l_userID:=USR_GetUserID 
		$l_idProfesor:=KRL_GetNumericFieldData (->[xShell_Users:47]No:1;->$l_userID;->[xShell_Users:47]NoEmployee:7)
		$l_tipoUsuario:=3
		$l_idAplicacion:=8
		$t_llavePrivada:="f6150b819489bfe46e7da82f43e8b637c087d7ff90b7e25754e192fdd0219750"
		
		OB SET:C1220($o_parametros;"accion";"consultaservicioscondor")
		OB SET:C1220($o_parametros;"usuarioID";$l_userID)
		OB SET:C1220($o_parametros;"profesorID";$l_idProfesor)
		OB SET:C1220($o_parametros;"uuid_colegio";$t_uuidColegio)
		OB SET:C1220($o_parametros;"llavePrivada";$t_llavePrivada)
		OB SET:C1220($o_parametros;"tipoUsuario";$l_tipoUsuario)
		OB SET:C1220($o_parametros;"idAplicacion";$l_idAplicacion)
		
		$t_resultado:=STWA2_ConsultaServicioCondor ($o_parametros)
		$o_resultado:=JSON Parse:C1218($t_resultado)
		
		ARRAY OBJECT:C1221($ao_modulos;0)
		OB GET ARRAY:C1229($o_resultado;"resultado";$ao_modulos)
		
		For ($i;1;Size of array:C274($ao_modulos))
			APPEND TO ARRAY:C911($at_modulosActivosUser;OB Get:C1224($ao_modulos{$i};"nombre_visible"))
		End for 
		
		
		LICENCIA_VerificaModCondorAct ("";->$jsonCondor)
		
		OB GET PROPERTY NAMES:C1232($jsonCondor;$at_nombres;$al_Types)
		
		AT_RedimArrays (Size of array:C274($at_nombres);->$ap_modulosImagenActivo;->$ap_modulosImagenInactivo)
		For ($i;1;Size of array:C274($at_nombres))
			Case of 
				: ($at_nombres{$i}="Actividades Escolares")
					GET PICTURE FROM LIBRARY:C565("actividades_escolares_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("actividades_escolares_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="Comedor")
					GET PICTURE FROM LIBRARY:C565("comedor_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("comedor_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="Comunicaciones")
					GET PICTURE FROM LIBRARY:C565("comunicaciones_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("comunicaciones_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="Dashboard")
					GET PICTURE FROM LIBRARY:C565("dashboard_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("dashboard_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="Dialect")
					GET PICTURE FROM LIBRARY:C565("dialect_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("dialect_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="Diamat")
					GET PICTURE FROM LIBRARY:C565("diamat_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("diamat_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="Extracurriculares")
					GET PICTURE FROM LIBRARY:C565("extracurriculares_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("extracurriculares_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="Gestion de Talentos")
					GET PICTURE FROM LIBRARY:C565("gestion_de_talentos_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("gestion_de_talentos_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="Inhabilidad")
					GET PICTURE FROM LIBRARY:C565("inhabilidad_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("inhabilidad_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="Orientacion y Seguimiento")
					GET PICTURE FROM LIBRARY:C565("orientacion_y_seguimiento_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("orientacion_y_seguimiento_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="Personas")
					GET PICTURE FROM LIBRARY:C565("personas_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("personas_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="PlanificaFacil")
					GET PICTURE FROM LIBRARY:C565("planificafacil_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("planificafacil_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="Postulaciones")
					GET PICTURE FROM LIBRARY:C565("postulaciones_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("postulaciones_inactivo";$ap_modulosImagenInactivo{$i})
					
				: ($at_nombres{$i}="Reinscripciones")
					GET PICTURE FROM LIBRARY:C565("reinscripciones_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("reinscripciones_inactivo";$ap_modulosImagenInactivo{$i})
					
				Else 
					GET PICTURE FROM LIBRARY:C565("sin_app_activo";$ap_modulosImagenActivo{$i})
					GET PICTURE FROM LIBRARY:C565("sin_app_inactivo";$ap_modulosImagenInactivo{$i})
			End case 
			
		End for 
		
		$l_cantidad:=0
		$l_izquierda:=10
		$l_superior:=20
		
		For ($i;1;Size of array:C274($at_nombres))
			$o_datos:=OB Get:C1224($jsonCondor;$at_nombres{$i})
			$b_activo:=OB Get:C1224($o_datos;"activo")
			
			If ($b_activo)
				OBJECT DUPLICATE:C1111(*;"boton-iconos";$at_nombres{$i})
				OBJECT SET COORDINATES:C1248(*;$at_nombres{$i};$l_izquierda+(35*$l_cantidad);$l_superior)
				OBJECT SET HELP TIP:C1181(*;$at_nombres{$i};$at_nombres{$i})
				
				$y_imagenIcono:=OBJECT Get pointer:C1124(Object named:K67:5;$at_nombres{$i})
				$l_pos:=Find in array:C230($at_modulosActivosUser;$at_nombres{$i})
				If ($l_pos=-1)
					$y_imagenIcono->:=$ap_modulosImagenInactivo{$i}
				Else 
					$y_imagenIcono->:=$ap_modulosImagenActivo{$i}
				End if 
				$t_ultimoBoton:=$at_nombres{$i}
				
				  //If (Dec($i/4)=0)
				If ($l_cantidad=3)
					$l_izquierda:=10
					$l_superior:=$l_superior+35
					$l_cantidad:=0
				Else 
					$l_cantidad:=$l_cantidad+1
				End if 
				
			End if 
		End for 
		
		OBJECT GET COORDINATES:C663(*;$t_ultimoBoton;$l_izquierdaBoton;$l_superiorBoton;$l_derechoBoton;$l_inferiorBoton)
		GET WINDOW RECT:C443($l_izquierda;$l_superior;$l_derecha;$l_inferior;Current form window:C827)
		SET WINDOW RECT:C444($l_izquierda;$l_superior;$l_derecha;$l_superior+$l_inferiorBoton+10;Current form window:C827)
		
	: (Form event:C388=On Mouse Leave:K2:34)
		  //POST KEY(Character code(".");Command key mask)
		
End case 