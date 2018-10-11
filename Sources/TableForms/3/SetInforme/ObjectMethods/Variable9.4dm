$vr_suma:=0
  //For ($i;1;Size of array(atCU_DispersionTo))
  //$vr_suma:=$vr_suma+Num(atCU_DispersionTo{$i})
  //End for 
For ($i;1;Size of array:C274(arCU_DispersionTo))
	$vr_suma:=$vr_suma+arCU_DispersionTo{$i}
End for 
  //ABC198877 //03302018// cuando es un estilo de evlauaciòn por simbolos no se puede sumar la dispersiion po lo que detemrino usar el REal.
If ($vr_suma>0)
	
	BLOB_Variables2Blob (->xBlob;0;->vlEVS_DefaultStyleID;->vi_SelectedStyle;->vi_StyleType;->aiCU_DispersionRango;->arCU_DispersionFrom;->arCU_DispersionTo;->iPosAnot;->iNegAnot;->iDet;->iSusp;->bNoPbl;->rAvgMinAsignaturaPercent;->rAvgSupPercent;->rAvgInfPercent;->rAvgMinPercent;->r0_Todas;->r1_EnPromedioInterno;->r2_EnPromedioOficial;->r3_Madres;->vl_sinprofesor)
	PREF_SetBlob (0;"DispersionNotasEnInformeJefatura";xBlob)
	ACCEPT:C269
Else 
	CD_Dlog (0;__ ("Ingrese rangos para dispersión."))
End if 