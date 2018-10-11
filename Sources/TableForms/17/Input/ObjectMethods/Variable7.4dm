If ([xShell_UserGroups:17]Propietary:3=0)
	$ignore:=CD_Dlog (0;__ ("Por favor designe al propietario de este grupo."))
	REJECT:C38
Else 
	  //125103 JVP se agrega informcion para validar crear linea en el registro de actividades para los procesos y modulos
	ARRAY TEXT:C222($at_alias;0)
	ARRAY TEXT:C222($at_metodos;0)
	ARRAY TEXT:C222($at_modulos;0)
	ARRAY REAL:C219($ar_permisos;0)
	ARRAY TEXT:C222($ar_permisoDatos;0)
	ARRAY REAL:C219($ar_Posicion;0)
	
	  // //<>aUserPriv es para validar el acceso a datos para el log
	  // 0 acceso restringido
	  // 1 explorar informacion
	  // 2 puede escribir datos
	  // 3 puede modificar datos
	  // 4 puede borrar datos
	APPEND TO ARRAY:C911($ar_permisoDatos;"acceso restringido")
	APPEND TO ARRAY:C911($ar_Posicion;0)
	APPEND TO ARRAY:C911($ar_permisoDatos;"explorar informacion")
	APPEND TO ARRAY:C911($ar_Posicion;Num:C11("0"+<>tXS_RS_DecimalSeparator+"1"))
	APPEND TO ARRAY:C911($ar_permisoDatos;"Crear registros")
	APPEND TO ARRAY:C911($ar_Posicion;Num:C11("0"+<>tXS_RS_DecimalSeparator+"2"))
	APPEND TO ARRAY:C911($ar_permisoDatos;"Modificacion de datos")
	APPEND TO ARRAY:C911($ar_Posicion;Num:C11("0"+<>tXS_RS_DecimalSeparator+"3"))
	APPEND TO ARRAY:C911($ar_permisoDatos;"Eliminar datos")
	APPEND TO ARRAY:C911($ar_Posicion;Num:C11("0"+<>tXS_RS_DecimalSeparator+"4"))
	
	
	  //125103 JVP se agrega informcion para validar crear linea en el registro de actividades
	BLOB_Blob2Vars (->[xShell_UserGroups:17]xCommands:5;0;->$at_alias;->$at_metodos)
	BLOB_Blob2Vars (->[xShell_UserGroups:17]Modules:11;0;->$at_modulos)
	BLOB_Blob2Vars (->[xShell_UserGroups:17]xTableAcces:4;0;->$ar_permisos)
	BLOB_Variables2Blob (->[xShell_UserGroups:17]xTableAcces:4;0;-><>aUserPriv)
	BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
	
	  //[xShell_UserGroups]Propietary:=<>alUSR_UserIds{<>atUSR_UserNames}
	
	  //20150226 RCH
	If (([xShell_UserGroups:17]IDGroup:1=-15001) & (Size of array:C274(<>atUSR_AuthModules)=0))
		APPEND TO ARRAY:C911(<>atUSR_AuthModules;"SchoolTrack")
		CD_Dlog (0;__ ("El grupo Administración debe tener acceso a un módulo.")+"\r\r"+__ ("Fue autorizado el módulo SchoolTrack."))
	End if 
	
	BLOB_Variables2Blob (->[xShell_UserGroups:17]Modules:11;0;-><>atUSR_AuthModules)
	
	
	  // // accesos modificados 125103 JVP
	$t_textoLog:=""
	$r_dec_priv:=0
	$r_pos_priv:=0
	$r_dec_datos:=0
	$r_pos_datos:=0
	
	For ($i;1;Size of array:C274(<>aUserPriv))
		If ($ar_permisos{$i}#<>aUserPriv{$i})
			  //<>aTxtPriv{$i}
			$r_dec_priv:=Dec:C9(<>aUserPriv{$i})
			$r_pos_priv:=Find in array:C230($ar_Posicion;$r_dec_priv)
			$r_dec_datos:=Dec:C9($ar_permisos{$i})
			$r_pos_datos:=Find in array:C230($ar_Posicion;$r_dec_datos)
			If ($ar_permisos{$i}><>aUserPriv{$i})
				  //se eliminaron accesos
				If ($r_pos_priv=1)
					$t_textoLog:=$t_textoLog+$ar_permisoDatos{$r_pos_priv}+" a "+<>aTxtPriv{$i}+"\r"
				Else 
					$t_textoLog:=$t_textoLog+"Se elimino el acceso a "
					For ($d;$r_pos_priv+1;$r_pos_datos)
						$t_textoLog:=$t_textoLog+Choose:C955($d<$r_pos_datos;$ar_permisoDatos{$d}+" - ";$ar_permisoDatos{$d})
					End for 
					$t_textoLog:=$t_textoLog+" en "+<>aTxtPriv{$i}+"\r"
				End if 
			Else 
				  //se agregaron accesos
				If ($r_pos_priv=1)
					$t_textoLog:=$t_textoLog+$ar_permisoDatos{$r_pos_datos}+" a "+<>aTxtPriv{$i}+"\r"
				Else 
					$t_textoLog:=$t_textoLog+"Se agrego el acceso a "
					
					For ($d;$r_pos_datos+1;$r_pos_priv)
						$t_textoLog:=$t_textoLog+Choose:C955($d<$r_pos_priv;$ar_permisoDatos{$d}+" - ";$ar_permisoDatos{$d})
					End for 
					$t_textoLog:=$t_textoLog+" en "+<>aTxtPriv{$i}+"\r"
				End if 
			End if 
		End if 
	End for 
	  //125103 JVP se envia el log  de accesos modificados
	If ($t_textoLog#"")
		LOG_RegisterEvt ($t_textoLog)
	End if 
	
	
	
	  // // registro de actividades JVP
	  //125103 JVP
	$t_textoLog:=""
	  //procesos autorizados
	For ($i;1;Size of array:C274(<>aAuthMethodsAlias))
		$l_posArray:=Find in array:C230($at_alias;<>aAuthMethodsAlias{$i})
		If ($l_posArray<0)
			If ($t_textoLog="")
				$t_textoLog:=$t_textoLog+"En el grupo "+[xShell_UserGroups:17]GroupName:2+" se agregó el siguiente permiso "+<>aAuthMethodsAlias{$i}+"\r"
			Else 
				$t_textoLog:=$t_textoLog+"Se agregó el siguiente permiso "+<>aAuthMethodsAlias{$i}+"\r"
			End if 
		End if 
	End for 
	For ($i;1;Size of array:C274($at_alias))
		$l_posArray:=Find in array:C230(<>aAuthMethodsAlias;$at_alias{$i})
		If ($l_posArray<0)
			If ($t_textoLog="")
				$t_textoLog:=$t_textoLog+"En el grupo "+[xShell_UserGroups:17]GroupName:2+" eliminó el siguiente permiso "+$at_alias{$i}+"\r"
			Else 
				$t_textoLog:=$t_textoLog+"Se eliminó el siguiente permiso "+$at_alias{$i}+"\r"
			End if 
		End if 
	End for 
	
	  //125103 JVP se envia el log  de procesos autorizados
	If ($t_textoLog#"")
		LOG_RegisterEvt ($t_textoLog)
	End if 
	
	  //125103 JVP
	$t_textoLog:=""
	  //modulos autorizados
	For ($i;1;Size of array:C274(<>atUSR_AuthModules))
		$l_posArray:=Find in array:C230($at_modulos;<>atUSR_AuthModules{$i})
		If ($l_posArray<0)
			If ($t_textoLog="")
				$t_textoLog:=$t_textoLog+"En el grupo "+[xShell_UserGroups:17]GroupName:2+" se agregó el siguiente Módulo "+<>atUSR_AuthModules{$i}+"\r"
			Else 
				$t_textoLog:=$t_textoLog+"Se agregó el siguiente Módulo "+<>atUSR_AuthModules{$i}+"\r"
			End if 
		End if 
	End for 
	
	For ($i;1;Size of array:C274($at_modulos))
		$l_posArray:=Find in array:C230(<>atUSR_AuthModules;$at_modulos{$i})
		If ($l_posArray<0)
			If ($t_textoLog="")
				$t_textoLog:=$t_textoLog+"En el grupo "+[xShell_UserGroups:17]GroupName:2+" eliminó el siguiente Módulo "+$at_modulos{$i}+"\r"
			Else 
				$t_textoLog:=$t_textoLog+"Se eliminó el siguiente Módulo "+$at_modulos{$i}+"\r"
			End if 
		End if 
	End for 
	  //125103 JVP se envia el log  de modulos autorizados
	If ($t_textoLog#"")
		LOG_RegisterEvt ($t_textoLog)
	End if 
	
	
	  // //
	
	If (<>vbUSR_Use4DSecurity)
		$userID:=USR_GetUserID 
		Case of 
			: (($userID=1) & (Is new record:C668([xShell_UserGroups:17])))
				[xShell_UserGroups:17]IDGroup:1:=Set group properties:C614(-1;[xShell_UserGroups:17]GroupName:2;[xShell_UserGroups:17]Propietary:3)
				
			: (Is new record:C668([xShell_UserGroups:17]))
				[xShell_UserGroups:17]IDGroup:1:=Set group properties:C614(-2;[xShell_UserGroups:17]GroupName:2;[xShell_UserGroups:17]Propietary:3)
				
			Else 
				$id:=Set group properties:C614([xShell_UserGroups:17]IDGroup:1;[xShell_UserGroups:17]GroupName:2;[xShell_UserGroups:17]Propietary:3)
		End case 
	End if 
	
	  //08-09-15 JVP Ticket 125103 
	  //Se Crea registro en el LOG de la creacion de grupos
	If (Is new record:C668([xShell_UserGroups:17]))
		LOG_RegisterEvt ("Creación de grupo del sistema. Grupo: "+[xShell_UserGroups:17]GroupName:2+" Propietario: "+[xShell_UserGroups:17]PropietaryName:9)
	End if 
	
	
End if 