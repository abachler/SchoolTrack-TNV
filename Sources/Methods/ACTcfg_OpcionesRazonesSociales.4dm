//%attributes = {}
  //ACTcfg_OpcionesRazonesSociales

C_TEXT:C284($vt_accion;$vt_nombrePref;$vt_nombreRazon)
C_BLOB:C604($xBlob)
C_POINTER:C301($ptr1;$ptr2;$ptr3)
C_LONGINT:C283($vl_old;$vl_New;$vl_records;$vl_idItem;$vl_idConf;$vl_idRazon)
C_TEXT:C284($vt_key;$vt_keyOrg)
C_BOOLEAN:C305($0;$vb_return;$vb_readWrite)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
$vb_return:=True:C214

Case of 
	: ($vt_accion="LoadConfig")
		If (Not:C34(Is nil pointer:C315($ptr1)))
			$vb_readWrite:=$ptr1->
		End if 
		ACTcfg_OpcionesRazonesSociales ("InitVars")
		atACTcfg_Razones:=1
		ACTcfg_OpcionesRazonesSociales ("Carga";->$vb_readWrite)
		
	: ($vt_accion="LimpiaVars")
		<>vsACT_Direccion:=""
		<>vsACT_Comuna:=""
		<>vsACT_Ciudad:=""
		<>vsACT_CPostal:=""
		<>vsACT_Telefono:=""
		<>vsACT_Fax:=""
		<>vsACT_Email:=""
		<>vsACT_RepLegal:=""
		<>vsACT_RUTRepLegal:=""
		<>vsACT_RazonSocial:=""
		<>vsACT_RUT:=""
		<>vPict_Logo:=<>vPict_Logo*0
		<>vsACT_Giro:=""
		<>vsACT_NombreContacto:=""
		<>vsACT_EMailContacto:=""
		<>vsACT_TelefonoContacto:=""
		
		  //20171228 RCH
		<>vsACT_Numero:=""
		<>vsACT_NumeroInterior:=""
		<>vsACT_RegionEstado:=""
		
		
	: ($vt_accion="CargaPrincipal")
		ACTcfg_OpcionesRazonesSociales ("LimpiaVars")
		  //Preferencias Institución
		  //READ ONLY([Colegio])
		  //ALL RECORDS([Colegio])
		  //FIRST RECORD([Colegio])
		  //<>vsACT_Direccion:=[Colegio]Administracion_Direccion
		  //<>vsACT_Comuna:=[Colegio]Administracion_Comuna
		  //<>vsACT_Ciudad:=[Colegio]Administracion_Ciudad
		  //<>vsACT_CPostal:=[Colegio]Administracion_CPostal
		  //<>vsACT_Telefono:=[Colegio]Administracion_Telefono
		  //<>vsACT_Fax:=[Colegio]Administracion_Fax
		  //<>vsACT_Email:=[Colegio]Administracion_EMail
		  //<>vsACT_RepLegal:=[Colegio]RepresentanteLegal_Nombre
		  //<>vsACT_RUTRepLegal:=[Colegio]RepresentanteLegal_RUN
		  //<>vsACT_RazonSocial:=[Colegio]RazonSocial
		  //<>vsACT_RUT:=[Colegio]RUT
		  //<>vPict_Logo:=[Colegio]Logo
		  //<>vsACT_Giro:=[Colegio]Giro
		  //<>vsACT_NombreContacto:=[Colegio]ContactoACT_Nombre
		  //<>vsACT_EMailContacto:=[Colegio]ContactoACT_EMail
		  //<>vsACT_TelefonoContacto:=[Colegio]ContactoACT_Telefono
		$vl_idRazon:=-1
		ACTcfg_OpcionesRazonesSociales ("CargaByID";->$vl_idRazon)
		
	: ($vt_accion="InitVars")
		ARRAY TEXT:C222(atACTcfg_Razones;0)
		ARRAY LONGINT:C221(alACTcfg_Razones;0)
		C_REAL:C285(cs_MultiRazones;cs_MultiRazonesReportes)
		cs_MultiRazones:=0
		cs_MultiRazonesReportes:=0
		
	: ($vt_accion="Carga")
		If (Not:C34(Is nil pointer:C315($ptr1)))
			$vb_readWrite:=$ptr1->
		End if 
		ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
		  //$vl_idRazon:=alACTcfg_Razones{atACTcfg_Razones}
		  //
		  //If (atACTcfg_Razones=1)
		  //ACTcfg_OpcionesRazonesSociales ("CargaPrincipal")
		  //ACTcfg_OpcionesRazonesSociales ("LastSelected")
		  //Else 
		  //ACTcfg_OpcionesRazonesSociales ("GetNamePref";->$vt_nombrePref)
		  //$vt_nombrePref:=$vt_nombrePref+String(atACTcfg_Razones)
		  //$xBlob:=PREF_fGetBlob (0;$vt_nombrePref;$xBlob)
		  //ACTcfg_OpcionesRazonesSociales ("DesarmaBlob";->$xBlob)
		  //End if 
		If (Size of array:C274(atACTcfg_Razones)>0)
			$vl_idRazon:=alACTcfg_Razones{atACTcfg_Razones}
		Else 
			$vl_idRazon:=-1
		End if 
		ACTcfg_OpcionesRazonesSociales ("CargaByID";->$vl_idRazon;->$vb_readWrite)
		
	: ($vt_accion="BuscaRazonesSecundarias")
		  //ACTcfg_OpcionesRazonesSociales ("GetNamePref";->$vt_nombrePref)
		  //READ ONLY([xShell_Prefs])
		  //QUERY([xShell_Prefs];[xShell_Prefs]User=0;*)
		  //QUERY([xShell_Prefs]; & [xShell_Prefs]Reference=$vt_nombrePref+"@")
		  //ORDER BY([xShell_Prefs];[xShell_Prefs]Reference;>)
		READ ONLY:C145([ACT_RazonesSociales:279])
		ALL RECORDS:C47([ACT_RazonesSociales:279])
		ORDER BY:C49([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]razon_social:2;>)
		
	: ($vt_accion="LeePreferencias")
		ACTcfg_OpcionesRazonesSociales ("InitVars")
		ACTcfg_OpcionesRazonesSociales ("BuscaRazonesSecundarias")
		  //ARRAY LONGINT($al_recNums;0)
		  //LONGINT ARRAY FROM SELECTION([xShell_Prefs];$al_recNums;"")
		  //For ($i;1;Size of array($al_recNums))
		  //GOTO RECORD([xShell_Prefs];$al_recNums{$i})
		  //APPEND TO ARRAY(atACTcfg_Razones;[xShell_Prefs]Text)
		  //APPEND TO ARRAY(alACTcfg_Razones;[xShell_Prefs]_Longint)
		  //End for 
		$vl_valor:=atACTcfg_Razones
		SELECTION TO ARRAY:C260([ACT_RazonesSociales:279]razon_social:2;atACTcfg_Razones;[ACT_RazonesSociales:279]id:1;alACTcfg_Razones)
		atACTcfg_Razones:=$vl_valor
		  //READ ONLY([Colegio])
		  //ALL RECORDS([Colegio])
		  //FIRST RECORD([Colegio])
		  //AT_Insert (1;1;->atACTcfg_Razones;->alACTcfg_Razones)
		  //atACTcfg_Razones{1}:=[Colegio]RazonSocial
		  //alACTcfg_Razones{1}:=-1
		  //para que por defecto aparezca el -1...
		ARRAY LONGINT:C221($alACT_orden;0)
		APPEND TO ARRAY:C911($alACT_orden;-1)
		AT_OrderArraysByArray (MAXLONG:K35:2;->$alACT_orden;->alACTcfg_Razones;->atACTcfg_Razones)
		
		cs_MultiRazones:=Num:C11(PREF_fGet (0;"ACT_csMultiRazones";String:C10(cs_MultiRazones)))
		cs_MultiRazonesReportes:=Num:C11(PREF_fGet (0;"ACT_csMultiRazonesReportes";String:C10(cs_MultiRazonesReportes)))
		
	: ($vt_accion="DesarmaBlob")
		$xBlob:=$ptr1->
		ACTcfg_OpcionesRazonesSociales ("LimpiaVars")
		BLOB_Blob2Vars (->$xBlob;0;-><>vsACT_Direccion;-><>vsACT_Comuna;-><>vsACT_Ciudad;-><>vsACT_CPostal;-><>vsACT_Telefono;-><>vsACT_Fax;-><>vsACT_Email;-><>vsACT_RepLegal;-><>vsACT_RUTRepLegal;-><>vsACT_RazonSocial;-><>vsACT_RUT;-><>vPict_Logo;-><>vsACT_Giro;-><>vsACT_NombreContacto;-><>vsACT_EMailContacto;-><>vsACT_TelefonoContacto)
		
	: ($vt_accion="ArmaBlob")
		BLOB_Variables2Blob ($ptr1;0;-><>vsACT_Direccion;-><>vsACT_Comuna;-><>vsACT_Ciudad;-><>vsACT_CPostal;-><>vsACT_Telefono;-><>vsACT_Fax;-><>vsACT_Email;-><>vsACT_RepLegal;-><>vsACT_RUTRepLegal;-><>vsACT_RazonSocial;-><>vsACT_RUT;-><>vPict_Logo;-><>vsACT_Giro;-><>vsACT_NombreContacto;-><>vsACT_EMailContacto;-><>vsACT_TelefonoContacto)
		
	: ($vt_accion="Guarda")
		If (Not:C34(Is nil pointer:C315($ptr1)))
			$vb_readWrite:=$ptr1->
		End if 
		  //ACTcfg_OpcionesRazonesSociales ("Guarda")
		
		
		SAVE RECORD:C53([ACT_RazonesSociales:279])
		If ($vb_readWrite)
			KRL_ReloadInReadWriteMode (->[ACT_RazonesSociales:279])
		Else 
			KRL_ReloadAsReadOnly (->[ACT_RazonesSociales:279])
		End if 
		  //If (Nil($ptr1))
		  //$atACTcfg_Razones:=atACTcfg_Razones
		  //Else 
		  //$atACTcfg_Razones:=$ptr1->
		  //End if 
		
		  //If ($atACTcfg_Razones=1)
		  //si es la razon principal actualizo la tabla colegio
		If ([ACT_RazonesSociales:279]id:1=-1)
			C_BOOLEAN:C305($vb_done)
			$vb_done:=ACTcfg_OpcionesRazonesSociales ("ActualizaTablaColegio";->[ACT_RazonesSociales:279]id:1)
			If (Not:C34($vb_done))
				BM_CreateRequest ("ActualizaDatosColegio";String:C10([ACT_RazonesSociales:279]id:1))
			End if 
		End if 
		  //Institucion    
		  //READ WRITE([Colegio])
		  //ALL RECORDS([Colegio])
		  //FIRST RECORD([Colegio])
		  //[Colegio]Administracion_Direccion:=<>vsACT_Direccion
		  //[Colegio]Administracion_Comuna:=<>vsACT_Comuna
		  //[Colegio]Administracion_Ciudad:=<>vsACT_Ciudad
		  //[Colegio]Administracion_CPostal:=<>vsACT_CPostal
		  //[Colegio]Administracion_Telefono:=<>vsACT_Telefono
		  //[Colegio]Administracion_Fax:=<>vsACT_Fax
		  //[Colegio]Administracion_EMail:=<>vsACT_Email
		  //[Colegio]RepresentanteLegal_Nombre:=<>vsACT_RepLegal
		  //[Colegio]RepresentanteLegal_RUN:=<>vsACT_RUTRepLegal
		  //[Colegio]RazonSocial:=<>vsACT_RazonSocial
		  //[Colegio]RUT:=<>vsACT_RUT
		  //[Colegio]Logo:=<>vPict_Logo
		  //[Colegio]Giro:=<>vsACT_Giro
		  //[Colegio]ContactoACT_Nombre:=<>vsACT_NombreContacto
		  //[Colegio]ContactoACT_EMail:=<>vsACT_EMailContacto
		  //[Colegio]ContactoACT_Telefono:=<>vsACT_TelefonoContacto
		
		  //SAVE RECORD([Colegio])
		  //KRL_ReloadAsReadOnly (->[Colegio])
		
		
		  //Else 
		  //ACTcfg_OpcionesRazonesSociales ("GetNamePref";->$vt_nombrePref)
		  //If (Not(Nil($ptr1)))
		  //$vl_idConf:=$ptr1->
		  //Else 
		  //$vl_idConf:=$atACTcfg_Razones
		  //End if 
		  //If ($vl_idConf>0)
		  //$vt_nombrePref:=$vt_nombrePref+String($vl_idConf)
		  //PREF_Set (0;$vt_nombrePref;<>vsACT_RazonSocial)
		  //ACTcfg_OpcionesRazonesSociales ("ArmaBlob";->$xBlob)
		  //PREF_SetBlob (0;$vt_nombrePref;$xBlob)
		  //Else 
		  //TRACE
		  //End if 
		  //End if 
		
	: ($vt_accion="ActualizaTablaColegio")
		
		$vl_idRazon:=$ptr1->
		READ WRITE:C146([Colegio:31])
		ALL RECORDS:C47([Colegio:31])
		FIRST RECORD:C50([Colegio:31])
		
		If (Not:C34(Locked:C147([Colegio:31])))
			READ ONLY:C145([ACT_RazonesSociales:279])
			QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]id:1=$vl_idRazon)
			
			[Colegio:31]Administracion_Direccion:41:=[ACT_RazonesSociales:279]direccion:7
			[Colegio:31]Administracion_Comuna:42:=[ACT_RazonesSociales:279]comuna:8
			[Colegio:31]Administracion_Ciudad:43:=[ACT_RazonesSociales:279]ciudad:10
			[Colegio:31]Administracion_CPostal:44:=[ACT_RazonesSociales:279]codigo_postal:9
			[Colegio:31]Administracion_Telefono:45:=[ACT_RazonesSociales:279]telefono:11
			[Colegio:31]Administracion_Fax:46:=[ACT_RazonesSociales:279]fax:12
			[Colegio:31]Administracion_EMail:47:=[ACT_RazonesSociales:279]eMail:13
			[Colegio:31]RepresentanteLegal_Nombre:39:=[ACT_RazonesSociales:279]representante_legal:4
			[Colegio:31]RepresentanteLegal_RUN:40:=[ACT_RazonesSociales:279]representante_legal_rut:5
			[Colegio:31]RazonSocial:38:=[ACT_RazonesSociales:279]razon_social:2
			[Colegio:31]RUT:2:=[ACT_RazonesSociales:279]RUT:3
			[Colegio:31]Logo:37:=[ACT_RazonesSociales:279]logo:17
			[Colegio:31]Giro:48:=[ACT_RazonesSociales:279]giro:18
			[Colegio:31]ContactoACT_Nombre:50:=[ACT_RazonesSociales:279]contacto_nombre:14
			[Colegio:31]ContactoACT_EMail:51:=[ACT_RazonesSociales:279]eMail:13
			[Colegio:31]ContactoACT_Telefono:52:=[ACT_RazonesSociales:279]contacto_telefono:16
			
			[Colegio:31]Region:14:=[ACT_RazonesSociales:279]Región_estado:38  //20171228 RCH
			
			SAVE RECORD:C53([Colegio:31])
			$vb_return:=True:C214
		Else 
			$vb_return:=False:C215
		End if 
		KRL_UnloadReadOnly (->[Colegio:31])
		
	: ($vt_accion="ActualizaNomPrefs")
		  //actualización de números de referencia de preferencias
		  //ARRAY TEXT($at_references;0)
		  //READ WRITE([xShell_Prefs])
		  //QUERY([xShell_Prefs];[xShell_Prefs]User=0;*)
		  //QUERY([xShell_Prefs]; & [xShell_Prefs]Reference=$ptr1->+"@")
		  //CREATE SET([xShell_Prefs];"Prefs1")
		  //AT_DistinctsFieldValues (->[xShell_Prefs]Reference;->$at_references)
		  //For ($i;1;Size of array($at_references))
		  //USE SET("Prefs1")
		  //QUERY SELECTION([xShell_Prefs];[xShell_Prefs]Reference=$at_references{$i})
		  //$pos:=Find in array(atACTcfg_Razones;[xShell_Prefs]Text)
		  //[xShell_Prefs]Reference:=$ptr1->+String($pos)
		  //SAVE RECORD([xShell_Prefs])
		  //End for 
		  //KRL_UnloadReadOnly (->[xShell_Prefs])
		
	: ($vt_accion="Elimina")
		C_LONGINT:C283($vl_razonSocial;$pos;$resp)
		ARRAY TEXT:C222($at_references;0)
		
		$vl_razonSocial:=atACTcfg_Razones
		If (atACTcfg_Razones>1)
			If (alACTcfg_Razones{atACTcfg_Razones}>0)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
				SET QUERY LIMIT:C395(1)
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_RazonSocial:57=alACTcfg_Razones{atACTcfg_Razones})
				SET QUERY LIMIT:C395(0)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
			End if 
			If ($vl_records=0)
				$resp:=CD_Dlog (0;__ ("Se eliminarán todos los datos de la razón social ")+<>vsACT_RazonSocial+__ (".\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
				If ($resp=1)
					  //eliminación de registro de preferencia seleccionada por el usuario
					  //ACTcfg_OpcionesRazonesSociales ("GetNamePref";->$vt_nombrePref)
					  //READ WRITE([xShell_Prefs])
					  //QUERY([xShell_Prefs];[xShell_Prefs]User=0;*)
					  //QUERY([xShell_Prefs]; & [xShell_Prefs]Reference=$vt_nombrePref+String(atACTcfg_Razones))
					  //KRL_DeleteRecord (->[xShell_Prefs])
					  //KRL_UnloadReadOnly (->[xShell_Prefs])
					
					READ WRITE:C146([ACT_RazonesSociales:279])
					QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]id:1=alACTcfg_Razones{atACTcfg_Razones})
					DELETE RECORD:C58([ACT_RazonesSociales:279])
					KRL_UnloadReadOnly (->[ACT_RazonesSociales:279])
					
					$vb_readWrite:=True:C214
					atACTcfg_Razones:=$vl_razonSocial-1
					ACTcfg_OpcionesRazonesSociales ("Carga";->$vb_readWrite)
					ACTcfg_OpcionesRazonesSociales ("LastSelected")
					  //ACTcfg_OpcionesRazonesSociales ("ActualizaNomPrefs";->$vt_nombrePref)
				End if 
			Else 
				CD_Dlog (0;__ ("Existen cargos asociados a esta Razón Social. La eliminación no puede ser completada."))
			End if 
		Else 
			CD_Dlog (0;__ ("La Razón social por defecto no puede ser eliminada."))
		End if 
		
	: ($vt_accion="SeteaObjetos")
		If (cs_MultiRazones=1)
			OBJECT SET ENTERABLE:C238(*;"MultiRazones@";True:C214)
			_O_ENABLE BUTTON:C192(*;"MultiRazones@")
		Else 
			OBJECT SET ENTERABLE:C238(*;"MultiRazones@";False:C215)
			_O_DISABLE BUTTON:C193(*;"MultiRazones@")
			cs_MultiRazonesReportes:=0
		End if 
		If (atACTcfg_Razones>1)
			_O_DISABLE BUTTON:C193(bCtas)
		Else 
			_O_ENABLE BUTTON:C192(bCtas)
		End if 
		
	: ($vt_accion="GetNamePref")
		$ptr1->:="ACT_cfgRazonSocial"
		
	: ($vt_accion="GetNameVar")
		$ptr1->:=__ ("Razón Social ")
		
	: ($vt_accion="Inserta")
		ACTcfg_OpcionesRazonesSociales ("LimpiaVars")
		  //ACTcfg_OpcionesRazonesSociales ("GetNamePref";->$vt_nombrePref)
		  //ACTcfg_OpcionesRazonesSociales ("GetNameVar";->$vt_nombreRazon)
		  //AT_Insert (0;1;->atACTcfg_Razones)
		  //atACTcfg_Razones:=Size of array(atACTcfg_Razones)
		  //$vt_nombreRazon:=$vt_nombreRazon+String(Size of array(atACTcfg_Razones))
		  //$vt_nombrePref:=$vt_nombrePref+String(Size of array(atACTcfg_Razones))
		  //
		  //<>vsACT_RazonSocial:=$vt_nombreRazon
		  //atACTcfg_Razones{Size of array(atACTcfg_Razones)}:=<>vsACT_RazonSocial
		  //
		  //PREF_Set (0;$vt_nombrePref;<>vsACT_RazonSocial)
		
		  //READ WRITE([xShell_Prefs])
		  //QUERY([xShell_Prefs];[xShell_Prefs]User=0;*)
		  //QUERY([xShell_Prefs]; & [xShell_Prefs]Reference=$vt_nombrePref)
		  //[xShell_Prefs]_Longint:=SQ_SeqNumber (->[xShell_Prefs]_Longint)
		  //SAVE RECORD([xShell_Prefs])
		  //KRL_UnloadReadOnly (->[xShell_Prefs])
		
		ACTcfg_OpcionesRazonesSociales ("GetNameVar";->$vt_nombreRazon)
		CREATE RECORD:C68([ACT_RazonesSociales:279])
		$vl_contador:=1
		$vt_nombre:=$vt_nombreRazon+String:C10($vl_contador)
		While (Find in field:C653([ACT_RazonesSociales:279]razon_social:2;$vt_nombre)#-1)
			$vl_contador:=$vl_contador+1
			$vt_nombre:=$vt_nombreRazon+String:C10($vl_contador)
		End while 
		[ACT_RazonesSociales:279]razon_social:2:=$vt_nombre
		[ACT_RazonesSociales:279]id:1:=SQ_SeqNumber (->[ACT_RazonesSociales:279]id:1)
		SAVE RECORD:C53([ACT_RazonesSociales:279])
		APPEND TO ARRAY:C911(atACTcfg_Razones;[ACT_RazonesSociales:279]razon_social:2)
		APPEND TO ARRAY:C911(alACTcfg_Razones;[ACT_RazonesSociales:279]id:1)
		atACTcfg_Razones:=Size of array:C274(atACTcfg_Razones)
		  //ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
		  //ACTcfg_OpcionesRazonesSociales ("ArmaBlob";->$xBlob)
		  //PREF_SetBlob (0;$vt_nombrePref;$xBlob)
		
	: ($vt_accion="LastSelected")
		vi_lastSelected:=atACTcfg_Razones
		
	: ($vt_accion="SetObjetosVisiblesItems")
		If (cs_MultiRazones=1)
			OBJECT SET VISIBLE:C603(*;"RazonSocial@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"RazonSocial@";False:C215)
		End if 
		
	: ($vt_accion="ActualizaNombreRazon")
		$el:=Find in array:C230(alACTcfg_Razones;[xxACT_Items:179]ID_RazonSocial:36)
		If ($el#-1)
			[xxACT_Items:179]RazonSocialAsociada:35:=atACTcfg_Razones{$el}
		End if 
		
	: ($vt_accion="AplicaCambiosEnRazonSocial")
		$vt_accion:="AplicaCambiosOnServer"
		$vt_key:=$ptr1->
		$vt_key:=ST_Concatenate (";";->$vt_accion;->$vt_key)
		$proc:=Execute on server:C373(Current method name:C684;Pila_256K;"Actualizando nombre de razón social";$vt_key)
		
	: ($vt_accion="AplicaCambiosEnCargos")
		$vt_keyOrg:=$ptr1->
		ST_Deconcatenate (";";$vt_keyOrg;->$vt_key;->$vl_old;->$vl_New)
		MESSAGES OFF:C175
		APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]ID_RazonSocial:57:=$vl_New)
		$el:=Find in array:C230(alACTcfg_Razones;$vl_New)
		If ($el#-1)
			APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]RazonSocialAsociada:56:=atACTcfg_Razones{$el})
		Else 
			APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]RazonSocialAsociada:56:="")
		End if 
		If (Records in set:C195("LockedSet")>0)
			BM_CreateRequest ("ActualizaRazonSocial";$vt_keyOrg)
		End if 
		MESSAGES ON:C181
		
		
	: ($vt_accion="AplicaCambiosOnServer@")
		ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
		$vt_keyOrg:=$vt_accion
		ST_Deconcatenate (";";$vt_keyOrg;->$vt_key;->$vl_old;->$vl_New;->$vl_idItem)
		READ WRITE:C146([ACT_Cargos:173])
		If ($vl_idItem#0)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$vl_idItem)
		Else 
			If ($vl_old#0)
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_RazonSocial:57=$vl_old)
			End if 
		End if 
		If (Records in selection:C76([ACT_Cargos:173])>0)
			ACTcfg_OpcionesRazonesSociales ("AplicaCambiosEnCargos";->$vt_keyOrg)
		End if 
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		
	: ($vt_accion="AplicaCambiosEnRazonSocialItems")
		C_TEXT:C284($vt_key;$vt_accion)
		$vt_accion:="AplicaCambiosItemsOnServer"
		$vt_key:=$ptr1->
		$vt_key:=ST_Concatenate (";";->$vt_accion;->$vt_key)
		$proc:=Execute on server:C373(Current method name:C684;Pila_256K;"Actualizando nombre de razón social";$vt_key)
		
	: ($vt_accion="AplicaCambiosItemsOnServer@")
		ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
		$vt_keyOrg:=$vt_accion
		ST_Deconcatenate (";";$vt_keyOrg;->$vt_key;->$vl_old;->$vl_New)
		If ($vl_old#0)
			READ WRITE:C146([xxACT_Items:179])
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_RazonSocial:36=$vl_old)
			If (Records in selection:C76([xxACT_Items:179])>0)
				ACTcfg_OpcionesRazonesSociales ("AplicaCambiosEnItems";->$vt_keyOrg)
			End if 
			KRL_UnloadReadOnly (->[xxACT_Items:179])
		End if 
		
	: ($vt_accion="AplicaCambiosEnItems")
		$vt_keyOrg:=$ptr1->
		ST_Deconcatenate (";";$vt_keyOrg;->$vt_key;->$vl_old;->$vl_New)
		If ($vl_New#0)
			MESSAGES OFF:C175
			$el:=Find in array:C230(alACTcfg_Razones;$vl_New)
			If ($el#-1)
				APPLY TO SELECTION:C70([xxACT_Items:179];[xxACT_Items:179]RazonSocialAsociada:35:=atACTcfg_Razones{$el})
			Else 
				APPLY TO SELECTION:C70([xxACT_Items:179];[xxACT_Items:179]RazonSocialAsociada:35:="")
			End if 
			If (Records in set:C195("LockedSet")>0)
				BM_CreateRequest ("ActualizaRazonSocialItems";$vt_keyOrg)
			End if 
			MESSAGES ON:C181
		End if 
		
	: ($vt_accion="CargaRazonDesdeInforme")
		If (cs_MultiRazones=1)
			READ ONLY:C145([ACT_Cargos:173])
			ARRAY LONGINT:C221($al_IDSRazones;0)
			CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$ptr1->;"")
			ACTcfg_OpcionesRazonesSociales ("Selection2Array";->[ACT_Cargos:173]ID_RazonSocial:57;->$al_IDSRazones)
			If (Size of array:C274($al_IDSRazones)=1)
				$vl_idRazon:=$al_IDSRazones{1}
				If ($vl_idRazon>0)
					ACTcfg_OpcionesRazonesSociales ("CargaByID";->$vl_idRazon)
				Else 
					ACTcfg_OpcionesRazonesSociales ("LoadConfig")
				End if 
			End if 
			REDUCE SELECTION:C351([ACT_Cargos:173];0)
		End if 
		
	: ($vt_accion="CargaArregloDesdeTrans")
		KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
		ACTcfg_OpcionesRazonesSociales ("Selection2Array";->[ACT_Cargos:173]ID_RazonSocial:57;$ptr1)
		
		
	: ($vt_accion="CargaArreglo")
		If (cs_MultiRazones=1)
			KRL_RelateSelection ($ptr1;$ptr2;"")
			ACTcfg_OpcionesRazonesSociales ("CargaArregloDesdeTrans";->al_idRazonSocial)
		Else 
			APPEND TO ARRAY:C911(al_idRazonSocial;0)
		End if 
		
	: ($vt_accion="Selection2Array")
		AT_DistinctsFieldValues ($ptr1;$ptr2)
		$position:=Find in array:C230($ptr2->;0)
		If ($position#-1)
			$ptr2->{$position}:=-1
		End if 
		AT_DistinctsArrayValues ($ptr2)
		
	: ($vt_accion="CargaByID")
		$vl_idRazon:=$ptr1->
		If (Not:C34(Is nil pointer:C315($ptr2)))
			$vb_readWrite:=$ptr2->
		End if 
		If ($vb_readWrite)
			READ WRITE:C146([ACT_RazonesSociales:279])
		Else 
			READ ONLY:C145([ACT_RazonesSociales:279])
		End if 
		QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]id:1=$vl_idRazon)
		
		<>vsACT_Direccion:=[ACT_RazonesSociales:279]direccion:7
		<>vsACT_Comuna:=[ACT_RazonesSociales:279]comuna:8
		<>vsACT_Ciudad:=[ACT_RazonesSociales:279]ciudad:10
		<>vsACT_CPostal:=[ACT_RazonesSociales:279]codigo_postal:9
		<>vsACT_Telefono:=[ACT_RazonesSociales:279]telefono:11
		<>vsACT_Fax:=[ACT_RazonesSociales:279]fax:12
		<>vsACT_Email:=[ACT_RazonesSociales:279]eMail:13
		<>vsACT_RepLegal:=[ACT_RazonesSociales:279]representante_legal:4
		<>vsACT_RUTRepLegal:=[ACT_RazonesSociales:279]representante_legal_rut:5
		<>vsACT_RazonSocial:=[ACT_RazonesSociales:279]razon_social:2
		<>vsACT_RUT:=[ACT_RazonesSociales:279]RUT:3
		<>vPict_Logo:=[ACT_RazonesSociales:279]logo:17
		<>vsACT_Giro:=[ACT_RazonesSociales:279]giro:18
		<>vsACT_NombreContacto:=[ACT_RazonesSociales:279]contacto_nombre:14
		<>vsACT_EMailContacto:=[ACT_RazonesSociales:279]contacto_eMail:15
		<>vsACT_TelefonoContacto:=[ACT_RazonesSociales:279]contacto_telefono:16
		
		  //20171228 RCH
		<>vsACT_Numero:=[ACT_RazonesSociales:279]Numero_exterior:36
		<>vsACT_NumeroInterior:=[ACT_RazonesSociales:279]Numero_interior:37
		<>vsACT_RegionEstado:=[ACT_RazonesSociales:279]Región_estado:38
		
		
	: ($vt_accion="CargaArreglosDesdeNC")
		ARRAY LONGINT:C221($al_idRazonSocial;0)
		If (cs_MultiRazones=1)
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=$ptr1->)
			ACTcfg_OpcionesRazonesSociales ("CargaArregloDesdeTrans";->$al_idRazonSocial)
		Else 
			APPEND TO ARRAY:C911($al_idRazonSocial;0)
		End if 
		If (Size of array:C274($al_idRazonSocial)>0)
			$ptr2->:=$al_idRazonSocial{1}
		End if 
		
	: ($vt_accion="SeleccionaCargos")
		Case of 
			: (($ptr1->=0) | ($ptr1->=-1))
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_RazonSocial:57=-1;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]ID_RazonSocial:57=0)
				
			Else 
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_RazonSocial:57=$ptr1->)
		End case 
	: ($vt_accion="SetObjetosInformes")
		C_LONGINT:C283(cs_todasRazones)
		C_BOOLEAN:C305(vbACTrz_InformePreparado)
		ACTcfg_OpcionesRazonesSociales ("LoadConfig")
		If ((cs_MultiRazonesReportes=1) & (vbACTrz_InformePreparado))
			cs_todasRazones:=0
			OBJECT SET VISIBLE:C603(*;"MultiRazones@";True:C214)
		Else 
			cs_todasRazones:=1
			OBJECT SET VISIBLE:C603(*;"MultiRazones@";False:C215)
		End if 
		ACTcfg_OpcionesRazonesSociales ("SetObjetosInformesClick")
		
	: ($vt_accion="SetObjetosInformesClick")
		If (cs_todasRazones=0)
			_O_ENABLE BUTTON:C192(atACTcfg_Razones)
		Else 
			_O_DISABLE BUTTON:C193(atACTcfg_Razones)
		End if 
		
		
	: ($vt_accion="CreaPrincipal")
		READ ONLY:C145([Colegio:31])
		READ WRITE:C146([ACT_RazonesSociales:279])
		
		ALL RECORDS:C47([Colegio:31])
		FIRST RECORD:C50([Colegio:31])
		
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
		
		  //: ($vt_accion="actualizaActeco@")
		  //TRACE
		  //DELAY PROCESS(Current process;60)
		  //vbACTdte_pendiente:=True
		  //ST_Deconcatenate (";";$vt_accion;->$vt_accion;->$vl_idRazon)
		  //READ ONLY([ACT_RazonesSociales])
		  //QUERY([ACT_RazonesSociales];[ACT_RazonesSociales]id=$vl_idRazon)
		  //If ([ACT_RazonesSociales]codigo_actividad_economica#"")
		  //READ WRITE([xxACT_Items])
		  //If ([ACT_RazonesSociales]id=-1)
		  //QUERY([xxACT_Items];[xxACT_Items]ID_RazonSocial<=0)
		  //Else 
		  //QUERY([xxACT_Items];[xxACT_Items]ID_RazonSocial=[ACT_RazonesSociales]id)
		  //End if 
		  //  //QUERY SELECTION([xxACT_Items];[xxACT_Items]
		  //APPLY TO SELECTION([xxACT_Items];[xxACT_Items]
		  //KRL_UnloadReadOnly (->[xxACT_Items])
		  //End if 
End case 
SET BLOB SIZE:C606($xBlob;0)
$0:=$vb_return