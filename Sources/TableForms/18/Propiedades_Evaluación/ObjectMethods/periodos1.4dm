AL_ExitCell (xALP_CsdList2)

$result:=Pop up menu:C542(vtSTR_PeriodosPopupMenu;0)

If ($result>0)
	vlSTR_PeriodoSeleccionado:=aiSTR_Periodos_Numero{$result}
	atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;vlSTR_PeriodoSeleccionado)
	vt_periodo:=atSTR_Periodos_Nombre{atSTR_Periodos_Nombre}
	C_BOOLEAN:C305(vb_menu2)
	vb_menu2:=False:C215
End if 



AL_ExitCell (xALP_CsdList2)
  //AS_PropEval_Escritura ("Blob_ConfigNotas/"+String(lConsID)+"/P"+String(vL_LastPeriod))
AL_RemoveArrays (xALP_CsdList2;1;8)
GOTO RECORD:C242([Asignaturas:18];vl_RecNumAsignatura)
AS_PropEval_Escritura (vL_LastPeriod)  //MONO CAMBIO AS_PropEval_Escritura

  //MONO CAMBIO AS_PropEval_Lectura
  //AS_PropEval_Lectura ("Blob_ConfigNotas/"+String(lConsID)+"/P"+String(vlSTR_PeriodoSeleccionado))
AS_PropEval_Lectura ("P"+String:C10(vlSTR_PeriodoSeleccionado))

AS_PropEval_MenuAsignaturas 
  //MONO: vuelvo a leer las propiedades ya que en el método AS_PropEval_MenuAsignaturas pueden ser leidas otras, ademas si estoy en el cambio de año completo a periodo termino con la config del año completo
  //AS_PropEval_Lectura ("Blob_ConfigNotas/"+String(lConsID)+"/P"+String(vlSTR_PeriodoSeleccionado))
AS_PropEval_Lectura ("P"+String:C10(vlSTR_PeriodoSeleccionado))
xALSet_AS_PropiedadesEvaluacion 

bc_PonderacionTruncada:=vi_PonderacionTruncada
Case of 
	: (vlAS_CalcMethod=0)
		w0iguales:=1
		w1coeficiente:=0
		w2porcentaje:=0
		AL_SetColOpts (xALP_CsdList2;0;0;0;3)
		AL_SetWidths (xALP_CsdList2;5;1;225)
		OBJECT SET VISIBLE:C603(*;"ponderacion@";False:C215)
	: (vlAS_CalcMethod=1)
		w0iguales:=0
		w1coeficiente:=1
		w2porcentaje:=0
		AL_SetWidths (xALP_CsdList2;5;2;145;80)
		AL_SetFormat (xALP_CsdList2;6;"##0";0;0;0;0)
		AL_SetHeaders (xALP_CsdList2;6;1;__ ("Coeficientes"))
		OBJECT SET VISIBLE:C603(*;"ponderacion@";False:C215)
	: (vlAS_CalcMethod=2)
		w0iguales:=0
		w2porcentaje:=1
		w1coeficiente:=0
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
OBJECT SET VISIBLE:C603(*;"cb_CalculoInmediato";False:C215)
  //cb_CalculoInmediato:=0

  //AL_UpdateArrays (xALP_CsdList2;Size of array(alAS_EvalPropSourceID))
vL_LastPeriod:=vlSTR_PeriodoSeleccionado
If (vlSTR_PeriodoSeleccionado#viSTR_PeriodoActual_Numero)
	  //vb_AvisaSiCambioPeriodo:=True
	OBJECT SET COLOR:C271(vt_periodo;-3)
Else 
	OBJECT SET COLOR:C271(vt_periodo;-5)
End if 