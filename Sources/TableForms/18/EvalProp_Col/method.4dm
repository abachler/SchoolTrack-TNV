Case of 
	: (Form event:C388=On Load:K2:1)
		WDW_SlideDrawer (->[Asignaturas:18];"EvalProp_Col")
		C_TEXT:C284(vs_nombreActual)
		vdAS_ColPropDueDate:=adAS_EvalPropDueDate{vi_Parcial}
		vrAS_ColPropPonderacion:=arAS_EvalPropPonderacion{vi_Parcial}
		vtAS_ColPropDescription:=atAS_EvalPropDescription{vi_Parcial}
		vsAS_ColPropPrintName:=atAS_EvalPropPrintName{vi_Parcial}
		  // MOD Ticket N° 211815 Patricio Aliaga 20180711
		vs_nombreActual:=atAS_EvalPropPrintName{vi_Parcial}
		viAS_ColPropPrintDetail:=Num:C11(abAS_EvalPropPrintDetail{vi_Parcial})
		
		  //MONO 206278
		C_BOOLEAN:C305($b_blockPropEva)
		ARRAY TEXT:C222($at_nombresObjeto;0)
		ARRAY POINTER:C280($ay_camposAsociado;0)
		ARRAY LONGINT:C221($al_numPagina;0)
		OB_GET ([Asignaturas:18]Opciones:57;->$b_blockPropEva;"BloqueoPropDeEval")
		$b_editPropEva:=(((USR_checkRights ("M";->[Asignaturas:18])) | (USR_GetMethodAcces ("Propiedades de evaluación";0)) | ((<>lUSR_RelatedTableUserID=vlSTR_IDProfesor) & (<>viSTR_AutorizarPropEval=1))) & (Not:C34($b_blockPropEva)))
		FORM GET OBJECTS:C898($at_nombresObjetos;$ay_camposAsociados;$al_numPagina)
		For ($z;1;Size of array:C274($at_nombresObjetos))
			If (($al_numPagina{$z}=1) & ($at_nombresObjetos{$z}#"btn_cancel"))
				OBJECT SET ENABLED:C1123(*;$at_nombresObjetos{$z};$b_editPropEva)
			End if 
		End for 
		
		If (vlAS_CalcMethod=1)
			OBJECT SET VISIBLE:C603(*;"Ponderación";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"Coeficiente";False:C215)
		End if 
		
		XS_SetInterface 
		
		  // MOD Ticket N° 211814 Patricio Aliaga 20180710
		  //If (<>vb_BloquearModifSituacionFinal)
		If ((<>vb_BloquearModifSituacionFinal) | (<>viSTR_AutorizarPropEval=0))
			_O_DISABLE BUTTON:C193(bAccept)
		End if 
End case 
