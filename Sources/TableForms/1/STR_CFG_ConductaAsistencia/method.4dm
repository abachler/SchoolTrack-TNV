Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283($Error)
		ARRAY TEXT:C222(at_logCambios;0)  //MONO 205385
		XS_SetConfigInterface 
		
		j_tabla1:=Num:C11(PREF_fGet (0;"ConfiguracionTablaPrimaria";"1"))
		j_tabla2:=Choose:C955(j_tabla1=1;0;1)
		
		STR_LeePreferenciasConducta2 
		
		xALP_CFG_STR_CatAn 
		xALP_CFG_STR_MotsAn 
		xALP_CFG_STR_Castigos 
		xALP_CFG_STR_Suspensiones 
		xALP_CFG_STR_TablaFaltas   //rch
		
		AL_SetLine (xALP_categoria;0)
		AL_SetLine (xALP_motivos;0)
		AL_SetLine (xALP_castigos;0)
		AL_SetLine (xALP_suspensiones;0)
		$line:=AL_GetLine (xALP_categoria)
		IT_SetButtonState ($line>0;->bDeleteCategoria)
		$line:=AL_GetLine (xALP_motivos)
		IT_SetButtonState ($line>0;->bDeleteMotivo)
		$line:=AL_GetLine (xALP_Suspensiones)
		IT_SetButtonState ($line>0;->bDeleteSuspension)
		$line:=AL_GetLine (xALP_Castigos)
		IT_SetButtonState ($line>0;->bDeleteCastigo)
		
		
		ARRAY INTEGER:C220($aInt2;2)
		For ($i;1;Size of array:C274(ai_TipoAnotacion))
			Case of 
				: (ai_TipoAnotacion{$i}=-1)
					GET PICTURE FROM LIBRARY:C565(31930;$icon)
					AL_SetCellColor (xALP_categoria;3;$i;0;0;$aInt2;"Red")
					AL_SetCellStyle (xALP_categoria;3;$i;0;0;$aInt2;1)
				: (ai_TipoAnotacion{$i}=0)
					GET PICTURE FROM LIBRARY:C565(31931;$icon)
					AL_SetCellColor (xALP_categoria;3;$i;0;0;$aInt2;"Blue")
					AL_SetCellStyle (xALP_categoria;3;$i;0;0;$aInt2;1)
				: (ai_TipoAnotacion{$i}=1)
					GET PICTURE FROM LIBRARY:C565(31932;$icon)
					AL_SetCellColor (xALP_categoria;3;$i;0;0;$aInt2;"Green")
					AL_SetCellStyle (xALP_categoria;3;$i;0;0;$aInt2;1)
			End case 
			ap_TipoAnotacion{$i}:=$icon
		End for 
		AL_UpdateArrays (xALP_categoria;-2)
		
		cb_MultipleLates:=Num:C11(PREF_fGet (0;"AllowMultipleLates";"0"))
		<>gAllowMultipleLates:=cb_MultipleLates
		  //
		C_BLOB:C604(xPreferenciasAtrasos)  //rch desde aca
		C_TEXT:C284(vt_Intervalos)
		_O_C_INTEGER:C282(vi_Minutos_Inasistencia_hora)
		_O_C_INTEGER:C282(vi_Minutos_Inasistencia_Dia)
		cb_TGenInasDia:=Num:C11(PREF_fGet (0;"RegistrarInasistenciasPorAtrasos";"0"))
		$modo:=Num:C11(PREF_fGet (0;"RegistrarMinutosEnAtrasos";"0"))
		<>b_RegistrarMinutosEnAtrasos:=$modo
		If ($modo=1)
			cb_RegistrarMinutosEnAtrasos:=1
			OBJECT SET ENTERABLE:C238(vt_Intervalos;True:C214)
		Else 
			If ($modo=2)
				cb_RegistrarFraccionesEnAtrasos:=1
				OBJECT SET ENTERABLE:C238(vt_Intervalos;False:C215)
			End if 
		End if 
		If ((cb_RegistrarMinutosEnAtrasos=1) | (cb_RegistrarFraccionesEnAtrasos=1))
			_O_ENABLE BUTTON:C192(*;"oTabla@")
			AL_SetEnterable (xALP_TablaFaltasMin;2;1)
			AL_SetEnterable (xALP_TablaFaltasMin;3;1)
		Else 
			cb_NoRegistrar:=1
			OBJECT SET ENTERABLE:C238(vt_Intervalos;False:C215)
			_O_DISABLE BUTTON:C193(*;"oTabla@")
			AL_SetEnterable (xALP_TablaFaltasMin;2;0)
			AL_SetEnterable (xALP_TablaFaltasMin;3;0)
			AL_SetEnterable (xALP_TablaFaltasMin;4;0)
		End if 
		If (conversionDia=1)  //preferencia conversióndía
			DConv1:=1
		Else 
			If (conversionDia=2)
				DConv2:=1
			Else 
				If (conversionDia=3)
					DConv3:=1
				Else 
					If (conversionDia=4)
						DConv4:=1
						AL_SetEnterable (xALP_TablaFaltasMin;4;1)
					Else 
						DConv1:=1
					End if 
				End if 
			End if 
		End if 
		  //tabla atrasos dia fija
		If (j_tabla2=1)
			ATSTRAL_FALTATIPO{1}:="1/6"
			ATSTRAL_FALTATIPO{2}:="1/5"
			ATSTRAL_FALTATIPO{3}:="1/4"
			ATSTRAL_FALTATIPO{4}:="1/2"
			ATSTRAL_FALTATIPO{5}:="3/4"
			ATSTRAL_FALTATIPO{6}:="1"
		Else 
			ATSTRAL_FALTATIPO{1}:="1/4"
			ATSTRAL_FALTATIPO{2}:="1/2"
			ATSTRAL_FALTATIPO{3}:="3/4"
			ATSTRAL_FALTATIPO{4}:="1"
			
		End if 
		AL_UpdateArrays (xALP_TablaFaltasMin;-2)  //rch hasta aca
		ST_JustificacionAtrasos ("inicializa")
	: (Form event:C388=On Clicked:K2:4)
		  //work around ALP 7.8
		$lastObject:=Focus object:C278
		RESOLVE POINTER:C394(Focus object:C278;$varName;$tableNum;$fieldnum)
		If ($varName="xALP_@")
			AL_ExitCell ($lastObject->)
		End if 
		  //----------(
		$line:=AL_GetLine (xALP_categoria)
		IT_SetButtonState ($line>0;->bDeleteCategoria)
		$line:=AL_GetLine (xALP_motivos)
		IT_SetButtonState ($line>0;->bDeleteMotivo)
		
		$line:=AL_GetLine (xALP_Suspensiones)
		IT_SetButtonState ($line>0;->bDeleteSuspension)
		$line:=AL_GetLine (xALP_Castigos)
		IT_SetButtonState ($line>0;->bDeleteCastigo)
		
	: (Form event:C388=On Close Box:K2:21)
		  //work around ALP 7.8
		$lastObject:=Focus object:C278
		RESOLVE POINTER:C394(Focus object:C278;$varName;$tableNum;$fieldnum)
		If ($varName="xALP_@")
			AL_ExitCell ($lastObject->)
		End if 
		  //----------
		CFG_STR_SaveConfiguration ("Conducta")
		vbCFG_CloseWindow:=True:C214
		CANCEL:C270
End case 
