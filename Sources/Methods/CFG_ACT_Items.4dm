//%attributes = {}
  //CFG_ACT_Items

If (Test semaphore:C652("ProcesoACT"))
	CD_Dlog (0;__ ("Se están ejecutando procesos que no permiten la modificación de la configuración de AccountTrack. Inténtelo de nuevo más tarde."))
Else 
	If (Semaphore:C143("ConfigACT"))
		CD_Dlog (0;__ ("La configuración de AccountTrack está siendo modificada por otro usuario.\rInténtelo más tarde.");__ ("");__ ("Aceptar"))
	Else 
		ACTcfg_ConfigArraysDeclarations 
		ACTcfg_ModBlob:=False:C215
		If (Records in table:C83([xxACT_Items:179])=0)
			CD_Dlog (0;__ ("No existen definiciones de items de cargo.\rSe creará uno ahora."))
			CREATE RECORD:C68([xxACT_Items:179])
			[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1)
			[xxACT_Items:179]Glosa:2:=__ ("Nuevo Item")
			[xxACT_Items:179]Moneda:10:=<>vsACT_MonedaColegio
			[xxACT_Items:179]VentaRapida:3:=False:C215
			For ($i;1;12)
				[xxACT_Items:179]Meses_de_cargo:9:=[xxACT_Items:179]Meses_de_cargo:9 ?- $i
			End for 
			[xxACT_Items:179]VentaRapida:3:=False:C215
			SAVE RECORD:C53([xxACT_Items:179])
		End if 
		ALL RECORDS:C47([xxACT_Items:179])
		FIRST RECORD:C50([xxACT_Items:179])
		CFG_OpenConfigPanel (->[xxACT_Items:179];"Configuration";1)
		ACTcfg_SaveConfig (2)
		
		  //20121018 RCH Limpio areglos por log de item
		AT_Initialize (->arACT_DesctoPorHijo;->arACT_DesctoTramo;->arACT_DesctoPorFamilia)
		AT_RedimArrays (16;->arACT_DesctoPorHijo;->arACT_DesctoTramo;->arACT_DesctoPorFamilia)
		
		UNLOAD RECORD:C212([xxACT_Items:179])
		CLEAR SEMAPHORE:C144("ConfigACT")
	End if 
End if 