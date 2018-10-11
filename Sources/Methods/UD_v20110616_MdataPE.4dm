//%attributes = {}

If (<>gCountryCode="pe")
	
	C_LONGINT:C283($vl_tableNum;$vl_proc;$i)
	ARRAY TEXT:C222($at_nombreAntiguo;0)
	ARRAY TEXT:C222($at_nombreNuevo;0)
	
	READ ONLY:C145([xxSTR_MetadatosLocales:141])
	READ WRITE:C146([MDATA_RegistrosDatosLocales:145])
	
	APPEND TO ARRAY:C911($at_nombreAntiguo;"A: Analfabeta")
	APPEND TO ARRAY:C911($at_nombreAntiguo;"SE: Secundaria")
	
	APPEND TO ARRAY:C911($at_nombreNuevo;"SE: Sin Escolaridad")
	APPEND TO ARRAY:C911($at_nombreNuevo;"S: Secundaria")
	
	$vl_proc:=IT_UThermometer (1;0;"Verificando metadatos...")
	$vl_tableNum:=Table:C252(->[Alumnos:2])
	
	QUERY:C277([xxSTR_MetadatosLocales:141];[xxSTR_MetadatosLocales:141]Tabla:2=$vl_tableNum;*)
	QUERY:C277([xxSTR_MetadatosLocales:141]; & ;[xxSTR_MetadatosLocales:141]Etiqueta:3="Escolaridad de la Madre")
	
	If (Records in selection:C76([xxSTR_MetadatosLocales:141])=1)
		QUERY:C277([MDATA_RegistrosDatosLocales:145];[MDATA_RegistrosDatosLocales:145]Field_UUID:1=[xxSTR_MetadatosLocales:141]UUID:10)
		CREATE SET:C116([MDATA_RegistrosDatosLocales:145];"setMDATA")
		
		For ($i;1;Size of array:C274($at_nombreAntiguo))
			USE SET:C118("setMDATA")
			QUERY SELECTION:C341([MDATA_RegistrosDatosLocales:145];[MDATA_RegistrosDatosLocales:145]Valor_Texto:10=$at_nombreAntiguo{$i})
			APPLY TO SELECTION:C70([MDATA_RegistrosDatosLocales:145];[MDATA_RegistrosDatosLocales:145]Valor_Texto:10:=$at_nombreNuevo{$i})
		End for 
		
		SET_ClearSets ("setMDATA")
	End if 
	
	IT_UThermometer (-2;$vl_proc)
	KRL_UnloadReadOnly (->[MDATA_RegistrosDatosLocales:145])
	
End if 