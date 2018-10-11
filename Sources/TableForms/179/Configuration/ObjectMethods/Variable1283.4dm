C_BOOLEAN:C305($b_continuar)
C_TEXT:C284($t_yaAvisado)

If (Size of array:C274(alACT_IdItem)>2)
	$t_yaAvisado:="0"
	$t_yaAvisado:=PREF_fGet (USR_GetUserID ;"ACT_MensajeNuevoItem";$t_yaAvisado)
	If (($t_yaAvisado="0") | (Shift down:C543))
		$l_resp:=CD_Dlog (0;__ ("Recuerde que puede crear nuevos ítems de cargo a partir de alguno ya existente. Para esto, seleccione un ítem de la lista, haga clic derecho sobre el ítem y seleccione la opción ")+ST_Qte (__ ("Nuevo periodo"))+"."+"\r\r"+"¿Desea continuar con la creación del ítem vacío?"+"\r\r"+"Seleccione "+__ ("Si")+__ (" si desea continuar con la creación del ítem sin datos previos. Seleccione ")+__ ("No")+__ (" para cancelar y utilizar la opción ")+__ ("Nuevo periodo")+".";"";__ ("Si");__ ("No"))
		If ($l_resp=1)
			$b_continuar:=True:C214
		End if 
		$t_yaAvisado:="1"
		PREF_Set (USR_GetUserID ;"ACT_MensajeNuevoItem";$t_yaAvisado)
	Else 
		$b_continuar:=True:C214
	End if 
Else 
	$b_continuar:=True:C214
End if 

If ($b_continuar)
	AL_ExitCell (xALP_DesctosHijos)
	AL_ExitCell (xALP_DesctosFamilia)
	If (vi_lastLine>0)
		
		  //20140423 RCH Si hay un ítem marcado, guardo por posibles cambio en, por ejemplo, los descuentos...
		ACTcfg_SaveItemdeCargo 
		
		If ([xxACT_Items:179]Glosa:2#"")
			BLOB_Variables2Blob (->[xxACT_Items:179]Descuentos_hijos:14;0;->vr_Hijo2;->vr_Hijo3;->vr_Hijo4;->vr_Hijo5;->vr_Hijo6;->vr_Hijo7;->vr_Hijo8;->vr_Hijo9;->vr_Hijo10;->vr_Hijo11;->vr_Hijo12;->vr_Hijo13;->vr_Hijo14;->vr_Hijo15;->vr_Hijo16;->vr_Hijo17)
			BLOB_Variables2Blob (->[xxACT_Items:179]Descuentos_Ingreso:16;0;->vr_Tramo1;->vr_Tramo2;->vr_Tramo3;->vr_Tramo4;->vr_Tramo5;->vr_Tramo6;->vr_Tramo7;->vr_Tramo8;->vr_Tramo9;->vr_Tramo10;->vr_Tramo11;->vr_Tramo12;->vr_Tramo13;->vr_Tramo14;->vr_Tramo15;->vr_Tramo16)
			BLOB_Variables2Blob (->[xxACT_Items:179]Descuento_Familia:32;0;->vr_Familia2;->vr_Familia3;->vr_Familia4;->vr_Familia5;->vr_Familia6;->vr_Familia7;->vr_Familia8;->vr_Familia9;->vr_Familia10;->vr_Familia11;->vr_Familia12;->vr_Familia13;->vr_Familia14;->vr_Familia15;->vr_Familia16;->vr_Familia17)
			If ([xxACT_Items:179]ID:1=0)
				[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1)
			End if 
			SAVE RECORD:C53([xxACT_Items:179])
			alACT_IdItem{vi_lastLine}:=[xxACT_Items:179]ID:1
			atACT_GlosaItem{vi_lastLine}:=[xxACT_Items:179]Glosa:2
			UNLOAD RECORD:C212([xxACT_Items:179])
		End if 
	End if 
	
	ACTitems_CreaItemConf 
	ACTcfg_SaveItemdeCargo 
	ACTitems_CargaItemConf 
End if 