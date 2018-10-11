//%attributes = {}
  // TGR_SyncModificaciones()
  // Por: Alberto Bachler K.: 08-04-15, 16:47:52
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
  //
  //C_BOOLEAN(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
  //If ((Not(<>vb_ImportHistoricos_STX)) & (Not(<>vb_AvoidTriggerExecution)))
  //
  //If (Trigger event#On Deleting Record Event)
  //[sync_Modificaciones]keyDiccionario:=String([sync_Modificaciones]st_tabla)+"."+String([sync_Modificaciones]st_campo)
  //[sync_Modificaciones]dts:=String(Current date;ISO Date GMT;Current time)
  //
  //READ ONLY([sync_diccionario])
  //RELATE ONE([sync_Modificaciones]keyDiccionario)
  //If ((Is table number valid([sync_diccionario]st_tabla)) & (Is field number valid([sync_diccionario]st_tabla;[sync_diccionario]st_campo)) & ([sync_diccionario]condor_tabla#"") & ([sync_diccionario]condor_columna#""))
  //[sync_Modificaciones]condor_tabla:=[sync_diccionario]condor_tabla
  //[sync_Modificaciones]condor_columna:=[sync_diccionario]condor_columna
  //[sync_Modificaciones]condor_tiposql:=[sync_diccionario]condor_tipoSQL
  //[sync_Modificaciones]condor_tablaatributo:=[sync_diccionario]condor_tablaAtributo
  //[sync_Modificaciones]condor_tipoatributo:=[sync_diccionario]condor_tipoAtributo
  //[sync_Modificaciones]condor_valoratributo:=[sync_diccionario]condor_nombreAtributo
  //[sync_Modificaciones]st_tipo4D:=Type(Field([sync_Modificaciones]st_tabla;[sync_Modificaciones]st_campo)->)
  //[sync_Modificaciones]modificadocondor:=False
  //[sync_Modificaciones]st_pkey:=<>t_nombreBDCondor+"."+String([sync_Modificaciones]st_tabla)+"."+String([sync_Modificaciones]st_campo)+"."+[sync_Modificaciones]uuid_registro
  //[sync_Modificaciones]condor_pkey:=<>t_nombreBDCondor+"."+[sync_Modificaciones]condor_tabla+"."+[sync_Modificaciones]condor_columna+"."+[sync_Modificaciones]uuid_registro
  //
  //If ([sync_Modificaciones]modificadost | [sync_Modificaciones]modificadocondor)
  //$l_numeroProceso:=Process number("Condor Sync")
  //$l_estadoProceso:=Process state($l_numeroProceso)
  //If ($l_estadoProceso<Executing)
  //$l_numeroProceso:=New process("SyncPG_SincronizaDatos";Pila_1024K;"Condor Sync";*)
  //Else 
  //RESUME PROCESS($l_numeroProceso)
  //End if 
  //End if 
  //End if 
  //End if 
  //End if 