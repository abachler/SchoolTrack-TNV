
If ([Colegio:31]Nombre_Colegio:1#"") & ([Colegio:31]Codigo_Pais:31#"") & ([Colegio:31]Rol Base Datos:9#"")
	C_TEXT:C284($t_rolAnterior)
	$t_uuidAnterior:=Old:C35([Colegio:31]UUID:58)
	$t_rolAnterior:=Old:C35([Colegio:31]Rol Base Datos:9)
	$t_codigoPaisAnterior:=Old:C35([Colegio:31]Codigo_Pais:31)
	SAVE RECORD:C53([Colegio:31])
	
	If (LICENCIA_esModuloAutorizado (AccountTrack))  //MONO TICKET 200243
		READ WRITE:C146([ACT_RazonesSociales:279])
		QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]id:1=-1)
		If (Records in selection:C76([ACT_RazonesSociales:279])=0)
			CREATE RECORD:C68([ACT_RazonesSociales:279])
		End if 
		[ACT_RazonesSociales:279]id:1:=-1
		[ACT_RazonesSociales:279]direccion:7:=[Colegio:31]Administracion_Direccion:41
		[ACT_RazonesSociales:279]comuna:8:=[Colegio:31]Administracion_Comuna:42
		[ACT_RazonesSociales:279]ciudad:10:=[Colegio:31]Administracion_Ciudad:43
		[ACT_RazonesSociales:279]codigo_postal:9:=[Colegio:31]Administracion_CPostal:44
		[ACT_RazonesSociales:279]telefono:11:=[Colegio:31]Administracion_Telefono:45
		[ACT_RazonesSociales:279]fax:12:=[Colegio:31]Administracion_Fax:46
		[ACT_RazonesSociales:279]eMail:13:=[Colegio:31]Administracion_EMail:47
		[ACT_RazonesSociales:279]representante_legal:4:=[Colegio:31]RepresentanteLegal_Nombre:39
		[ACT_RazonesSociales:279]representante_legal_rut:5:=[Colegio:31]RepresentanteLegal_RUN:40
		[ACT_RazonesSociales:279]razon_social:2:=[Colegio:31]RazonSocial:38
		[ACT_RazonesSociales:279]RUT:3:=[Colegio:31]RUT:2
		[ACT_RazonesSociales:279]logo:17:=[Colegio:31]Logo:37
		[ACT_RazonesSociales:279]giro:18:=[Colegio:31]Giro:48
		[ACT_RazonesSociales:279]contacto_nombre:14:=[Colegio:31]ContactoACT_Nombre:50
		[ACT_RazonesSociales:279]eMail:13:=[Colegio:31]ContactoACT_EMail:51
		[ACT_RazonesSociales:279]contacto_telefono:16:=[Colegio:31]ContactoACT_Telefono:52
		SAVE RECORD:C53([ACT_RazonesSociales:279])
		KRL_UnloadReadOnly (->[ACT_RazonesSociales:279])
	End if 
	
	KRL_ReloadAsReadOnly (->[Colegio:31])
	$l_recNumActual:=Record number:C243([Colegio:31])
	
	  //20160706 RCH Si hay cambio en RBD o CC se fuerza la ejecución que obtiene UUID.
	  //$t_uuidNuevo:=LICENCIA_ObtieneUUIDinstitucion
	If (($t_rolAnterior#[Colegio:31]Rol Base Datos:9) | ($t_codigoPaisAnterior#[Colegio:31]Codigo_Pais:31))
		$t_uuidNuevo:=LICENCIA_ObtieneUUIDinstitucion (True:C214)  //LICENCIA_ObtieneUUIDinstitucion se ejecuta en el server
	Else 
		$t_uuidNuevo:=$t_uuidAnterior
	End if 
	
	KRL_GotoRecord (->[Colegio:31];$l_recNumActual;True:C214)
	If (Not:C34(Util_isValidUUID ($t_uuidNuevo)))
		[Colegio:31]UUID:58:=$t_uuidAnterior
		[Colegio:31]Codigo_Pais:31:=$t_codigoPaisAnterior
		[Colegio:31]Rol Base Datos:9:=$t_rolAnterior
		SAVE RECORD:C53([Colegio:31])
		<>vtXS_UUID:=$t_uuidAnterior
		<>gUUID:=$t_uuidAnterior
		<>GROLBD:=$t_rolAnterior
		<>GCOUNTRYCODE:=$t_codigoPaisAnterior
		ModernUI_Notificacion (__ ("Información de la institución");"El identificador nacional no corresponde ninguna institucion registrada para el pais seleccionado.\rSe restablecera el identificador nacional y el pais anteriormente registrado.";"Aceptar")
	Else 
		SAVE RECORD:C53([Colegio:31])
		<>vtXS_UUID:=[Colegio:31]UUID:58
		<>gUUID:=[Colegio:31]UUID:58
		<>GROLBD:=[Colegio:31]Rol Base Datos:9
		<>GCOUNTRYCODE:=[Colegio:31]Codigo_Pais:31
		LICENCIA_Descarga 
		$l_resultado:=LICENCIA_Verifica 
		If ($l_resultado=1)
			If ($t_rolAnterior#[Colegio:31]Rol Base Datos:9)
				LOG_RegisterEvt (__ ("Se cambia Rol de base de datos ")+ST_Qte ($t_rolAnterior)+__ (" a ")+ST_Qte ([Colegio:31]Rol Base Datos:9))
			End if 
			CANCEL:C270
		Else 
			KRL_GotoRecord (->[Colegio:31];$l_recNumActual;True:C214)
			[Colegio:31]UUID:58:=$t_uuidAnterior
			[Colegio:31]Codigo_Pais:31:=$t_codigoPaisAnterior
			[Colegio:31]Rol Base Datos:9:=$t_rolAnterior
			SAVE RECORD:C53([Colegio:31])
			<>vtXS_UUID:=$t_uuidAnterior
			<>gUUID:=$t_uuidAnterior
			<>GROLBD:=$t_rolAnterior
			<>GCOUNTRYCODE:=$t_codigoPaisAnterior
			ModernUI_Notificacion (__ ("Licencia");"No hay licencia registrada para la institución y el servidor SchoolTrack.\rSe restableció el identificador nacional y el pais anteriormente registrado.";"Aceptar")
		End if 
	End if 
Else 
	Case of 
		: ([Colegio:31]Codigo_Pais:31="cl")
			ModernUI_Notificacion (__ ("Información de la institución");__ ("Debe indicar el nombre, el país y el Rol de Base de Datos del establecimiento"))
		: ([Colegio:31]Codigo_Pais:31="mx")
			ModernUI_Notificacion (__ ("Información de la institución");__ ("Debe indicar el nombre, el país y la Clave del Centro de Trabajo (CCT)"))
		Else 
			ModernUI_Notificacion (__ ("Información de la institución");__ ("Debe indicar el nombre, el país y el identificador único de la institución"))
	End case 
End if 