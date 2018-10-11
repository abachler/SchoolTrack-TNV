Case of 
	: (Form event:C388=On Clicked:K2:4)
		ARRAY TEXT:C222($at_modulosActivosUser;0)
		ARRAY TEXT:C222($at_modulosActivosURL;0)
		ARRAY LONGINT:C221($at_modulosActivosIdCLiente;0)
		
		C_OBJECT:C1216($o_parametros)
		
		$t_nombreModulo:=OBJECT Get name:C1087(Object current:K67:2)
		
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
			APPEND TO ARRAY:C911($at_modulosActivosURL;OB Get:C1224($ao_modulos{$i};"url"))
			APPEND TO ARRAY:C911($at_modulosActivosIdCLiente;OB Get:C1224($ao_modulos{$i};"idcliente"))
		End for 
		
		
		$l_pos:=Find in array:C230($at_modulosActivosUser;$t_nombreModulo)
		If ($l_pos#-1)
			CLEAR VARIABLE:C89($o_parametros)
			OB SET:C1220($o_parametros;"accion";"loginUsuarioSTWA")
			OB SET:C1220($o_parametros;"url";$at_modulosActivosURL{$l_pos})
			OB SET:C1220($o_parametros;"tipoUsuario";$l_tipoUsuario)
			OB SET:C1220($o_parametros;"idAplicacion";$l_idAplicacion)
			OB SET:C1220($o_parametros;"idColegio";$at_modulosActivosIdCLiente{$l_pos})
			OB SET:C1220($o_parametros;"profesorID";$l_idProfesor)
			
			$t_resultado:=STWA2_ConsultaServicioCondor ($o_parametros)
			$o_resultado:=JSON Parse:C1218($t_resultado)
			$t_URL:=OB Get:C1224($o_resultado;"url")
			OPEN URL:C673($t_URL)
		End if 
		POST KEY:C465(Character code:C91(".");Command key mask:K16:1)
End case 