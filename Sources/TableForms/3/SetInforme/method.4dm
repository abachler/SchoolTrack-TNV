$event:=Form event:C388
Case of 
	: ($event=On Load:K2:1)
		C_LONGINT:C283($el)
		xBlob:=PREF_fGetBlob (0;"DispersionNotasEnInformeJefatura";xBlob)
		If (BLOB size:C605(xBlob)>0)
			  // Modificado por: Alexis Bustamante (12/09/2016)
			  //r3_Madres
			BLOB_Blob2Vars (->xBlob;0;->vlEVS_DefaultStyleID;->vi_SelectedStyle;->vi_StyleType;->aiCU_DispersionRango;->arCU_DispersionFrom;->arCU_DispersionTo;->iPosAnot;->iNegAnot;->iDet;->iSusp;->bNoPbl;->rAvgMinAsignaturaPercent;->rAvgSupPercent;->rAvgInfPercent;->rAvgMinPercent;->r0_Todas;->r1_EnPromedioInterno;->r2_EnPromedioOficial;->r3_Madres;->vl_sinprofesor)
		End if 
		
		If (iNegAnot=0)
			iNegAnot:=1
		End if 
		If (iDet=0)
			iDet:=1
		End if 
		If (iSusp=0)
			iSusp:=1
		End if 
		
		If ((r0_Todas+r1_EnPromedioInterno+r2_EnPromedioOficial+r3_Madres)=0)
			r1_EnPromedioInterno:=1
		End if 
		vlEVS_CurrentEvStyleID:=0
		  // MOD Ticket N° 209201 Patricio Aliaga 20180705
		$el:=Find in array:C230(aEvStyleID;vi_SelectedStyle)
		  //aEvStyleName:=vi_SelectedStyle
		aEvStyleName:=$el
		aEvStyleType:=vi_StyleType
		
		EVS_ReadStyleData (aEvStyleID{aEvStyleName})
		sAvgSup:=NTA_PercentValue2StringValue (rAvgSupPercent;iEvaluationMode)
		sAvgInf:=NTA_PercentValue2StringValue (rAvgInfPercent;iEvaluationMode)
		sAvgMin:=NTA_PercentValue2StringValue (rAvgMinPercent;iEvaluationMode)
		sAvgMinAsignatura:=NTA_PercentValue2StringValue (rAvgMinAsignaturaPercent;iEvaluationMode)
		
		For ($i;1;8)
			atCU_DispersionFrom{$i}:=NTA_PercentValue2StringValue (arCU_DispersionFrom{$i};iEvaluationMode)
			atCU_DispersionTo{$i}:=NTA_PercentValue2StringValue (arCU_Dispersionto{$i};iEvaluationMode)
		End for 
		
		XS_SetInterface 
		wref:=WDW_GetWindowID 
		xALSet_CU_AreaInformeJefatura 
		C_BOOLEAN:C305(vb_graficos;vb_exportar)
		vb_graficos:=True:C214
		vb_exportar:=False:C215
		  //chk_fsinprofesor:=vl_sinprofesor
		
		
	: ($event=On Deactivate:K2:10)
		WDW_SetFrontmost (wref)
	: ($event=On Close Box:K2:21)
		CANCEL:C270
End case 
