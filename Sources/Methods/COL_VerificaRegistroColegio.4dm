//%attributes = {}
  // COL_VerificaRegistroColegio()
  // Por: Alberto Bachler K.: 22-07-14, 13:30:35
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283($l_versionBD_Build)
C_TEXT:C284($t_asunto;$t_copiaA;$t_cuerpo;$t_datos;$t_destinatario;$t_rutaBD;$t_versionBaseDeDatos)

ARRAY LONGINT:C221($al_recNumColegio;0)
ARRAY TEXT:C222($at_nombreColegio;0)
ARRAY TEXT:C222($at_RBD;0)

ALL RECORDS:C47([Colegio:31])
If (Records in selection:C76([Colegio:31])>1)
	QUERY:C277([Colegio:31];[Colegio:31]Rol Base Datos:9="";*)
	QUERY:C277([Colegio:31]; | ;[Colegio:31]Nombre_Colegio:1="";*)
	QUERY:C277([Colegio:31]; | ;[Colegio:31]Codigo_Pais:31="")
	KRL_DeleteSelection (->[Colegio:31])
End if 

ALL RECORDS:C47([Colegio:31])
Case of 
	: (Records in selection:C76([Colegio:31])=1)
		If ([Colegio:31]UUID:58="")
			If (([Colegio:31]Rol Base Datos:9#"") & ([Colegio:31]Codigo_Pais:31#""))
				If (<>gRolBD="")
					STR_ReadGlobals 
					XS_ReadCustomerData 
				End if 
				  //LICENCIA_ObtieneUUIDinstitucion 
			End if 
		End if 
		
	: (Records in selection:C76([Colegio:31])>1)
		$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("build";->$l_versionBD_Build)
		$t_rutaBD:=SYS_GetServerProperty (XS_DataFileFolder)+SYS_GetServerProperty (XS_DataFileName)
		
		$t_destinatario:="qa@colegium.com"
		$t_copiaA:="desarrollo@colegium.com"
		$t_asunto:="Duplicación de registro de tabla colegio "+[Colegio:31]Nombre_Colegio:1
		$t_cuerpo:="Durante la ejecución de las tareas de fin de día se detectaron registros duplicados en la tabla colegio."
		$t_cuerpo:=$t_cuerpo+"\r"+"Colegio: "+[Colegio:31]Nombre_Colegio:1
		$t_cuerpo:=$t_cuerpo+"\r"+"Cantidad de registros de Colegio: "+String:C10(Records in selection:C76([Colegio:31]))
		$t_cuerpo:=$t_cuerpo+"\r"+"Ruta base: "+$t_rutaBD
		$t_cuerpo:=$t_cuerpo+"\r"+"Usuario máquina: "+Current system user:C484
		$t_cuerpo:=$t_cuerpo+"\r"+"Versión: "+String:C10($l_versionBD_Build)
		
		SELECTION TO ARRAY:C260([Colegio:31];$al_recNumColegio;[Colegio:31]Nombre_Colegio:1;$at_nombreColegio;[Colegio:31]Rol Base Datos:9;$at_RBD)
		$t_datos:="Record number"+"\t"+"Nombre Colegio"+"\t"+"Rol Base de datos"+"\r\n"
		$t_datos:=$t_datos+AT_Arrays2Text ("\r\n";"\t";->$al_recNumColegio;->$at_nombreColegio;->$at_RBD)
		$t_cuerpo:=$t_cuerpo+"\r"+"Datos de la tabla:"+"\r"
		$t_cuerpo:=$t_cuerpo+$t_datos
		
		Mail_EnviaNotificacion ($t_asunto;$t_cuerpo;$t_destinatario)
End case 