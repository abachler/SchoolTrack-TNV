//%attributes = {}
  //ACTmnu_GeneraDesctos

If (USR_GetMethodAcces (Current method name:C684))
	If (Test semaphore:C652("ConfigACT"))
		CD_Dlog (0;__ ("No es posible realizar la generación de descuentos en este momento.\rOtro usuario está realizando modificaciones a la configuración de AccountTrack que podrían afectar este proceso.\r\rPor favor intente la generación de descuentos más tarde."))
	Else 
		$sem:=Semaphore:C143("ProcesoACT")
		ACTinit_LoadPrefs 
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcc_ComoDescta";-1;-Palette form window:K39:9;__ ("Parámetros para generación de descuentos"))
		DIALOG:C40([xxSTR_Constants:1];"ACTcc_ComoDescta")
		CLOSE WINDOW:C154
		If (OK=1)
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcc_GenDesctos";0;4;__ ("Generación de descuentos"))
			DIALOG:C40([xxSTR_Constants:1];"ACTcc_GenDesctos")
			CLOSE WINDOW:C154
			If (ok=1)
				ACTdesctos_AplicaDesctos 
			End if 
			If (Size of array:C274(apACT_Glosas)>0)
				For ($i;1;Size of array:C274(apACT_Glosas))
					Bash_Return_Variable (apACT_Glosas{$i})
				End for 
			End if 
			AT_Initialize (->alACT_CuentasAplicar;->atACT_Glosas;->alACT_GlosasIDs;->apACT_Glosas;->atACT_ArrNames;->atACT_NombreAlumnos;->alACT_IDCtas)
			AT_Initialize (->alACT_IDsCtasdeCargos;->alACT_RefsCargos;->atACT_Glosas4Extra;->aFooterL1;->aFooterL2;->aFooterL3;->arACT_DesctoXAlumno)
			AT_Initialize (->atACT_4TitleOnly;->arACT_Totales;->aDisColumns;->aDisRows;->DA_Return;->DA_Return2)
			ARRAY INTEGER:C220(aInteger2D;0;0)
			ARRAY LONGINT:C221(aCtasCargos;0;0)
		End if 
		FLUSH CACHE:C297
		CLEAR SEMAPHORE:C144("ProcesoACT")
	End if 
End if 