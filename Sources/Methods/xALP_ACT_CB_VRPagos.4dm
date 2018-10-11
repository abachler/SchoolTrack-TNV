//%attributes = {}
  // Método: xALP_ACT_CB_VRPagos
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-03-10, 10:42:34
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
  //xALP_ACT_CB_VRPagos

C_BOOLEAN:C305($0;$vb_calcular)
C_LONGINT:C283($1;$2;$3)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (ALP_AreaVR;$col;$line)
	AL_UpdateArrays (ALP_AreaVR;0)
	Case of 
		: ($col=1)
			$vlACTpgs_SelectedItemId:=alACT_PgsVRIDItem{$line}
			Case of 
				: (arACT_PgsVRCantidad{$line}<=0)
					BEEP:C151
					arACT_PgsVRCantidad{$line}:=1
				: ((KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->$vlACTpgs_SelectedItemId;->[xxACT_Items:179]Imputacion_Unica:24)) & (arACT_PgsVRCantidad{$line}>1))
					BEEP:C151
					arACT_PgsVRCantidad{$line}:=1
					CD_Dlog (0;__ ("Este ítem es de imputación única no puede ser cobrado más de una vez. Si necesita emitirlo más de una vez, cambie la configuración de ítem de imputación única."))
			End case 
			$vb_calcular:=True:C214
			
		: ($col=3)
			$vlACTpgs_SelectedItemId:=alACT_PgsVRIDItem{$line}
			If (arACT_PgsVRMonto{$line}<=0)
				$vb_go:=ACTpgs_OpcionesVR ("BuscaItem";->$vlACTpgs_SelectedItemId)
				If ($vb_go)
					arACT_PgsVRMonto{$line}:=[xxACT_Items:179]Monto:7
				End if 
			End if 
			$vl_decimales:=0
			$vb_go:=ACTpgs_OpcionesVR ("BuscaItem";->$vlACTpgs_SelectedItemId)
			If ($vb_go)
				$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[xxACT_Items:179]Moneda:10))
				arACT_PgsVRMonto{$line}:=Round:C94(arACT_PgsVRMonto{$line};$vl_decimales)
			End if 
			$vb_calcular:=True:C214
			
	End case 
	If ($vb_calcular)
		ACTpgs_OpcionesVR ("Calcula";->$line)
	End if 
	AL_UpdateArrays (ALP_AreaVR;-2)
End if 