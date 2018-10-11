Case of 
	: (Form event:C388=On Load:K2:1)
		
		XS_SetInterface 
		ARRAY PICTURE:C279(apACT_AvisosCargoSel;0)
		ARRAY BOOLEAN:C223(abACT_AvisosCargoSel;0)
		
		For ($i;1;Size of array:C274(alACT_AvisosRecNumCargo))
			APPEND TO ARRAY:C911(abACT_AvisosCargoSel;True:C214)
		End for 
		ACTat_LLenaArregloPict (->abACT_AvisosCargoSel;->apACT_AvisosCargoSel)
		
		
		AL_RemoveArrays (xALP_ACT_Condonacion;1;14)
		AT_Inc (0)
		$error:=ALP_DefaultColSettings (xALP_ACT_Condonacion;AT_Inc ;"apACT_AvisosCargoSel";"";20;"1")
		$error:=ALP_DefaultColSettings (xALP_ACT_Condonacion;AT_Inc ;"alACT_AvisosGlosaCargo";__ ("Glosa Cargo");300;"";0;2;0)
		$error:=ALP_DefaultColSettings (xALP_ACT_Condonacion;AT_Inc ;"alACT_AvisosSaldo";__ ("Monto\rAdeudado");90;"|Despliegue_ACT";3;2;0)
		$error:=ALP_DefaultColSettings (xALP_ACT_Condonacion;AT_Inc ;"alACT_AvisosMontoCondonacion";__ ("Monto a\rCondonar");90;"|Despliegue_ACT";3;2;1)
		  //
		  //$error:=ALP_DefaultColSettings (xALP_ACT_Condonacion;AT_Inc ;"alACT_AvisosRefItem";"Saldo";60;"";0;2;0)
		$error:=ALP_DefaultColSettings (xALP_ACT_Condonacion;AT_Inc ;"alACT_AvisosRecNumCargo";"";0;"0";0;2;0)
		$error:=ALP_DefaultColSettings (xALP_ACT_Condonacion;AT_Inc ;"abACT_AvisosCargoSel";"";0;"0";0;2;0)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_ACT_Condonacion;9;1;6;2;8)
		AL_SetColOpts (xALP_ACT_Condonacion;1;1;1;2;0)
		AL_SetRowOpts (xALP_ACT_Condonacion;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_ACT_Condonacion;0;1;1)
		AL_SetMainCalls (xALP_ACT_Condonacion;"";"")
		AL_SetCallbacks (xALP_ACT_Condonacion;"";"xALP_ACT_CB_Condonacion")
		AL_SetScroll (xALP_ACT_Condonacion;0;-3)
		AL_SetEntryOpts (xALP_ACT_Condonacion;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_ACT_Condonacion;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xALP_ACT_Condonacion;1;"";"";"")
		AL_SetDrgSrc (xALP_ACT_Condonacion;2;"";"";"")
		AL_SetDrgSrc (xALP_ACT_Condonacion;3;"";"";"")
		AL_SetDrgDst (xALP_ACT_Condonacion;1;"";"";"")
		AL_SetDrgDst (xALP_ACT_Condonacion;1;"";"";"")
		AL_SetDrgDst (xALP_ACT_Condonacion;1;"";"";"")
		
		AL_SetLine (xALP_ACT_Condonacion;0)
End case 

