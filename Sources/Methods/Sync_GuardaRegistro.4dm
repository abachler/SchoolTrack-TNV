//%attributes = {"executedOnServer":true}
  // Sync_GuardaRegistro()
  // Por: Alberto Bachler K.: 14-04-15, 13:17:56
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_estadoProceso;$l_numeroProceso)
C_TEXT:C284(<>t_nombreBDCondor)


[sync_Modificaciones:284]keyDiccionario:20:=String:C10([sync_Modificaciones:284]st_tabla:6)+"."+String:C10([sync_Modificaciones:284]st_campo:7)

If ([sync_Modificaciones:284]nuevoValor:12#Old:C35([sync_Modificaciones:284]nuevoValor:12))
	[sync_Modificaciones:284]dts:16:=String:C10(Current date:C33;ISO date GMT:K1:10;Current time:C178)
End if 

READ ONLY:C145([sync_diccionario:285])
RELATE ONE:C42([sync_Modificaciones:284]keyDiccionario:20)
If ((Is table number valid:C999([sync_diccionario:285]st_tabla:8)) & ((Is field number valid:C1000([sync_diccionario:285]st_tabla:8;[sync_diccionario:285]st_campo:9)) | ([sync_diccionario:285]st_campo:9=0)) & ([sync_diccionario:285]condor_tabla:2#"") & ([sync_diccionario:285]condor_columna:3#""))
	[sync_Modificaciones:284]condor_tabla:8:=[sync_diccionario:285]condor_tabla:2
	[sync_Modificaciones:284]condor_columna:9:=[sync_diccionario:285]condor_columna:3
	[sync_Modificaciones:284]condor_tiposql:19:=[sync_diccionario:285]condor_tipoSQL:4
	[sync_Modificaciones:284]condor_tablaatributo:3:=[sync_diccionario:285]condor_tablaAtributo:5
	[sync_Modificaciones:284]condor_tipoatributo:4:=[sync_diccionario:285]condor_tipoAtributo:6
	[sync_Modificaciones:284]condor_valorAtributo:5:=[sync_diccionario:285]condor_nombreAtributo:7
	If ([sync_Modificaciones:284]st_campo:7=0)
		[sync_Modificaciones:284]st_tipo4d:10:=0
	Else 
		[sync_Modificaciones:284]st_tipo4d:10:=Type:C295(Field:C253([sync_Modificaciones:284]st_tabla:6;[sync_Modificaciones:284]st_campo:7)->)
	End if 
	[sync_Modificaciones:284]modificadocondor:14:=False:C215
	  //MONO 162358
	[sync_Modificaciones:284]st_pkey:17:=String:C10([sync_Modificaciones:284]st_tabla:6)+"."+String:C10([sync_Modificaciones:284]st_campo:7)+"."+[sync_Modificaciones:284]uuid_registro:11
	[sync_Modificaciones:284]condor_pkey:18:=[sync_Modificaciones:284]condor_tabla:8+"."+[sync_Modificaciones:284]condor_columna:9+"."+[sync_Modificaciones:284]uuid_registro:11
	[sync_Modificaciones:284]condor_nombrebd:2:=<>t_nombreBDCondor
	
	If ([sync_Modificaciones:284]uuid_colegio:21#<>gUUID)  //20170311 RCH Hay regitros no válidos
		If (Util_isValidUUID (<>gUUID))
			[sync_Modificaciones:284]uuid_colegio:21:=<>gUUID
		End if 
	End if 
	
	SAVE RECORD:C53([sync_Modificaciones:284])
	
	If (([sync_Modificaciones:284]modificadost:15 | [sync_Modificaciones:284]modificadocondor:14) & (<>b_sincronizar))
		$l_numeroProceso:=Process number:C372("Condor Sync")
		$l_estadoProceso:=Process state:C330($l_numeroProceso)
		If ($l_estadoProceso<Executing:K13:4)
			$l_numeroProceso:=New process:C317("SyncPG_SincronizaDatos";Pila_1024K;"Condor Sync";*)
		Else 
			RESUME PROCESS:C320($l_numeroProceso)
		End if 
	End if 
End if 

