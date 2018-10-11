C_BOOLEAN:C305($b_editPropEva;$b_blockPropEva)
C_LONGINT:C283($l_event)
C_TEXT:C284(vt_lastSelectedSA)  // MONO Ticket 187315

$event:=Form event:C388
  //MONO: Condiciones para editar las propiedades de evaluación
  // debes tener permisos de modificación en asignaturas 
  // o tener autorizado el proceso "Propiedades de evaluación"
  // o tener la preferencia ("PermitirConfigPropEval") y ser profesor de la asignatura
  //"PermitirConfigPropEval" es configurada en archivo > configuración > otras preferencias > profesores > Permitir que profesores configuren propiedades de evaluacion de sus asignaturas
  // y lo que solicitaron en el ticket 175179 bloquear las propiedades de las asignaturas en check de la misma. 

Case of 
	: ($event=On Load:K2:1)
		XS_SetInterface 
		xALSet_AS_PropiedadesEvaluacion 
		OB_GET ([Asignaturas:18]Opciones:57;->$b_blockPropEva;"BloqueoPropDeEval")
		cb_bloqueoPropDeEval:=Choose:C955($b_blockPropEva;1;0)  //Bloquear las propiedades de evaluación de la asignatura de la ficha en que estamos
		
		$b_editPropEva:=(((USR_checkRights ("M";->[Asignaturas:18])) | (USR_GetMethodAcces ("Propiedades de evaluación";0)) | ((<>lUSR_RelatedTableUserID=vlSTR_IDProfesor) & (<>viSTR_AutorizarPropEval=1))) & (cb_bloqueoPropDeEval=0))
		
		  //Set por permisos de edición de las propiedades de Evaluación
		AS_BloqueoPropiedadesEvaluacion ($b_editPropEva)  // Ticket Nº 175179
		
		  //Configuraciones
		vlSTR_PeriodoSeleccionado:=aiSTR_Periodos_Numero{atSTR_Periodos_Nombre}
		vt_periodo:=atSTR_Periodos_Nombre{atSTR_Periodos_Nombre}
		
		For ($i;1;12)
			aiAS_EvalPropColumnIndex{$i}:=$i
			Case of 
				: (alAS_EvalPropSourceID{$i}<0)
					If ((atAS_EvalPropSourceName{$i}="") | (atAS_EvalPropSourceName{$i}="No Ingresable") | (atAS_EvalPropSourceName{$i}="Evaluación ingresable"))
						$referencia:=String:C10(lConsID)+"."+String:C10(vlSTR_PeriodoSeleccionado)+"."+String:C10($i)
						$sourceRecNum:=Find in field:C653([xxSTR_Subasignaturas:83]Referencia:11;$referencia)
						If ($sourceRecNum>=0)
							KRL_GotoRecord (->[xxSTR_Subasignaturas:83];$sourceRecNum)
							atAS_EvalPropSourceName{$i}:=[xxSTR_Subasignaturas:83]Name:2
						End if 
					End if 
				: (alAS_EvalPropSourceID{$i}>0)
					If ((atAS_EvalPropSourceName{$i}="") | (atAS_EvalPropSourceName{$i}="No ingresable") | (atAS_EvalPropSourceName{$i}="Evaluación ingresable"))
						$currentRecNum:=Record number:C243([Asignaturas:18])
						$sourceRecNum:=Find in field:C653([Asignaturas:18]Numero:1;alAS_EvalPropSourceID{$i})
						If ($sourceRecNum>=0)
							GOTO RECORD:C242([Asignaturas:18];$sourceRecNum)
							atAS_EvalPropSourceName{$i}:=[Asignaturas:18]denominacion_interna:16
							GOTO RECORD:C242([Asignaturas:18];$currentRecNum)
						End if 
					End if 
				: ((alAS_EvalPropSourceID{$i}=0) & (aiAS_EvalPropEnterable{$i}=1))
					atAS_EvalPropSourceName{$i}:="Evaluación ingresable"
				: (aiAS_EvalPropEnterable{$i}=0)
					atAS_EvalPropSourceName{$i}:="No ingresable"
			End case 
			
			If (Not:C34(abAS_EvalPropPrintDetail{$i}))
				atAS_EvalPropPrintName{$i}:=""
			End if 
		End for 
		
		vt_textMsg:=""
		vL_LastPeriod:=vlSTR_PeriodoSeleccionado
		vb_callBackEnabled:=True:C214
		  //bSumGrades:=iDec 
		r1:=Num:C11(vb_CsdVariable=False:C215)
		r2:=Num:C11(vb_CsdVariable=True:C214)
		If (r2=1)
			OBJECT SET VISIBLE:C603(*;"periodos";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"periodos";False:C215)
		End if 
		If (vlSTR_PeriodoSeleccionado#viSTR_PeriodoActual_Numero)
			vb_AvisaSiCambioPeriodo:=True:C214
			OBJECT SET COLOR:C271(vt_periodo;-3)
		Else 
			OBJECT SET COLOR:C271(vt_periodo;-5)
		End if 
		
		bc_PonderacionTruncada:=vi_PonderacionTruncada
		Case of 
			: (vlAS_CalcMethod=0)  //TODAS POR IGUAL
				w0iguales:=1
				w1coeficiente:=0
				w2porcentaje:=0
				AL_SetColOpts (xALP_CsdList2;0;0;0;3)
				AL_SetWidths (xALP_CsdList2;5;1;225)
				OBJECT SET VISIBLE:C603(*;"ponderacion@";False:C215)
			: (vlAS_CalcMethod=1)  //COEFICIENTE
				w0iguales:=0
				w1coeficiente:=1
				w2porcentaje:=0
				AL_SetColOpts (xALP_CsdList2;0;0;0;2)
				AL_SetWidths (xALP_CsdList2;5;2;145;80)
				AL_SetFormat (xALP_CsdList2;6;"##0";0;0;0;0)  //MONO CORRECION DE FORMATO PARA INGRESO DE COEFICIENTES
				AL_SetHeaders (xALP_CsdList2;6;1;__ ("Coeficientes"))
				OBJECT SET VISIBLE:C603(*;"ponderacion@";False:C215)
			: (vlAS_CalcMethod=2)  //PONDERACIONES
				w0iguales:=0
				w2porcentaje:=1
				w1coeficiente:=0
				AL_SetColOpts (xALP_CsdList2;0;0;0;2)
				AL_SetWidths (xALP_CsdList2;5;2;145;80)
				AL_SetFormat (xALP_CsdList2;6;"##0"+<>tXS_RS_DecimalSeparator+"00%";0;0;0;0)
				AL_SetHeaders (xALP_CsdList2;6;1;__ ("Ponderaciones"))
				OBJECT SET VISIBLE:C603(*;"ponderacion@";True:C214)
		End case 
		AL_UpdateArrays (xALP_CsdList2;-2)
		
		Case of 
			: (vi_metodo=0)
				m0:=1
				m1:=0
				m2:=0
				_O_ENABLE BUTTON:C192(*;"Opción Ponderación@")
				OBJECT SET VISIBLE:C603(*;"ponderación@";True:C214)
			: (vi_metodo=1)
				m0:=0
				m1:=1
				m2:=0
				_O_ENABLE BUTTON:C192(*;"Opción Ponderación@")
				OBJECT SET VISIBLE:C603(*;"ponderación@";True:C214)
			: (vi_metodo=2)
				m0:=0
				m1:=0
				m2:=1
				_O_DISABLE BUTTON:C193(*;"Opción Ponderación@")
				OBJECT SET VISIBLE:C603(*;"ponderación@";False:C215)
		End case 
		
		bConsolidaExamenFinal:=vi_ConsolidaExamenFinal
		bConsolidaNotasFinales:=vi_ConsolidaNotasFinales
		If (vb_CsdVariable)
			bConsolidaExamenFinal:=0
			bConsolidaNotasFinales:=0
			vi_ConsolidaNotasFinales:=0
			vi_ConsolidaExamenFinal:=0
			_O_DISABLE BUTTON:C193(*;"finales@")
		Else 
			If ($b_editPropEva)
				_O_ENABLE BUTTON:C192(*;"finales@")
			Else 
				_O_DISABLE BUTTON:C193(*;"finales@")
			End if 
		End if 
		
		$habilitaOpcionesCalculo:=False:C215
		For ($i;1;Size of array:C274(alAS_EvalPropSourceID))
			If (alAS_EvalPropSourceID{$i}#0)
				$habilitaOpcionesCalculo:=True:C214
				$i:=Size of array:C274(alAS_EvalPropSourceID)
			End if 
		End for 
		If ($habilitaOpcionesCalculo)
			_O_ENABLE BUTTON:C192(*;"Opciones consolidacion@")
			OBJECT SET FONT STYLE:C166(*;"Opciones consolidacion";1)
			OBJECT SET COLOR:C271(*;"Opciones consolidacion@";-15)
		Else 
			_O_DISABLE BUTTON:C193(*;"Opciones consolidacion@")
			OBJECT SET FONT STYLE:C166(*;"Opciones consolidacion";0)
			OBJECT SET COLOR:C271(*;"Opciones consolidacion@";-14)
		End if 
		
		If (<>vb_BloquearModifSituacionFinal)
			_O_DISABLE BUTTON:C193(bOK)
			OBJECT SET HELP TIP:C1181(bOK;__ ("Acciones que afectan la situación final bloqueadas."))
		End if 
		
		  //MONO Limite de ingreso parciales por fecha
		ARRAY TEXT:C222(at_parciales;0)
		For ($i;1;12)  //para las 12 parciales
			APPEND TO ARRAY:C911(at_parciales;"Parcial "+String:C10($i))
		End for 
		
		For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
			$ptr_col:=Get pointer:C304("ad_BloqueoParcial_p"+String:C10($i))
			ARRAY DATE:C224($ptr_col->;12)
			$ptr_enc:=Get pointer:C304("vl_enc"+String:C10($i))
			
			LISTBOX INSERT COLUMN:C829(*;"FechaBloqueoParciales";$i+1;"Periodo"+String:C10($i);$ptr_col->;"Periodo "+String:C10($i);$ptr_enc->)
			OBJECT SET TITLE:C194($ptr_enc->;"Periodo "+String:C10($i))
			LISTBOX SET COLUMN WIDTH:C833(*;"parciales";650/$i+1;650/$i+1;650/$i+1)
			LISTBOX SET PROPERTY:C1440(*;"FechaBloqueoParciales";lk sortable:K53:45;0)
			LISTBOX SET PROPERTY:C1440(*;"FechaBloqueoParciales";lk single click edit:K53:70;1)
		End for 
		
		LOG_RegistraCambiosPropDeEval ("DeclaraArreglos")  // Ticket Nº 175179
		LOG_RegistraCambiosPropDeEval ("CopiaArreglos")  // Ticket Nº 175179
		
		vt_lastSelectedSA:=""  // MONO Ticket 187315
		
	: (($event=On Data Change:K2:15) | ($event=On Clicked:K2:4))
		$habilitaOpcionesCalculo:=False:C215
		For ($i;1;Size of array:C274(alAS_EvalPropSourceID))
			If (alAS_EvalPropSourceID{$i}#0)
				$habilitaOpcionesCalculo:=True:C214
				$i:=Size of array:C274(alAS_EvalPropSourceID)
			End if 
		End for 
		If ($habilitaOpcionesCalculo)
			_O_ENABLE BUTTON:C192(*;"Opciones consolidacion@")
			OBJECT SET FONT STYLE:C166(*;"Opciones consolidacion";1)
			OBJECT SET COLOR:C271(*;"Opciones consolidacion@";-15)
		Else 
			_O_DISABLE BUTTON:C193(*;"Opciones consolidacion@")
			OBJECT SET FONT STYLE:C166(*;"Opciones consolidacion";0)
			OBJECT SET COLOR:C271(*;"Opciones consolidacion@";-14)
		End if 
		
		Case of 
			: (vi_metodo=0)
				m0:=1
				m1:=0
				m2:=0
				_O_ENABLE BUTTON:C192(*;"Opción Ponderación@")
				OBJECT SET VISIBLE:C603(*;"ponderación@";True:C214)
			: (vi_metodo=1)
				m0:=0
				m1:=1
				m2:=0
				_O_ENABLE BUTTON:C192(*;"Opción Ponderación@")
				OBJECT SET VISIBLE:C603(*;"ponderación@";True:C214)
			: (vi_metodo=2)
				m0:=0
				m1:=0
				m2:=1
				_O_DISABLE BUTTON:C193(*;"Opción Ponderación@")
				OBJECT SET VISIBLE:C603(*;"ponderación@";False:C215)
		End case 
		
		If (vb_CsdVariable)
			bConsolidaExamenFinal:=0
			bConsolidaNotasFinales:=0
			vi_ConsolidaNotasFinales:=0
			vi_ConsolidaExamenFinal:=0
		End if 
		  // Ticket Nº 175179
		LOG_RegistraCambiosPropDeEval ("GuardaLog";OBJECT Get name:C1087(Object with focus:K67:3);OBJECT Get pointer:C1124(Object with focus:K67:3);[Asignaturas:18]Numero:1;False:C215)
		
		  //ASM Ticket 216399
		Case of 
			: (vlAS_CalcMethod=0)
				AL_UpdateArrays (xALP_CsdList2;0)
				AL_SetColOpts (xALP_CsdList2;0;0;0;3)
				AL_SetWidths (xALP_CsdList2;5;1;225)
				OBJECT SET VISIBLE:C603(*;"ponderacion@";False:C215)
				AL_UpdateArrays (xALP_CsdList2;-2)
				
			: (vlAS_CalcMethod=1)
				AL_UpdateArrays (xALP_CsdList2;0)
				AL_SetColOpts (xALP_CsdList2;0;0;0;2)
				AL_SetWidths (xALP_CsdList2;5;2;145;80)
				AL_SetFormat (xALP_CsdList2;6;"##0";0;0;0;0)
				AL_SetHeaders (xALP_CsdList2;6;1;__ ("Coeficientes"))
				AL_UpdateArrays (xALP_CsdList2;-2)
				
			: (vlAS_CalcMethod=2)
				AL_UpdateArrays (xALP_CsdList2;0)
				AL_SetColOpts (xALP_CsdList2;0;0;0;2)
				AL_SetWidths (xALP_CsdList2;5;2;145;80)
				AL_SetFormat (xALP_CsdList2;6;"##0"+<>tXS_RS_DecimalSeparator+"00%";0;0;0;0)
				AL_SetHeaders (xALP_CsdList2;6;1;__ ("Ponderaciones"))
				AL_UpdateArrays (xALP_CsdList2;-2)
				
		End case 
		
	: ($event=On Unload:K2:2)
		  // Ticket Nº 175179
		  // LOG_RegistraCambiosPropDeEval ("LimpiaArreglos")//MONO TICKET 187619
		OBJECT SET VISIBLE:C603(*;"periodos";True:C214)
		
	: ($event=On Close Box:K2:21)
		  // Ticket Nº 175179
		  //LOG_RegistraCambiosPropDeEval ("LimpiaArreglos")//MONO TICKET 187619
		CANCEL:C270
End case 