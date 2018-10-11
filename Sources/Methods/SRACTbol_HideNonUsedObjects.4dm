//%attributes = {}
  //SRACTbol_HideNonUsedObjects

  //REGISTO DE CAMBIOS
  //20080401 RCH.  Al agrupar ahora se muestra la variable que muestra el mes
vlSRP_AreaRef:=SR New Offscreen Area 
$err:=SR Set Area (vlSRP_AreaRef;xSR_ReportBlob)
  //$err:=SR Set Area (vlSRP_AreaRef;xs_ReportBlob)
If (Count parameters:C259=0)
	ARRAY LONGINT:C221($aObjectIDs;0)
	$err:=SR Get Object IDs (vlSRP_AreaRef;0;$aObjectIDs)
	For ($i;1;Size of array:C274($aObjectIDs))
		$t_nombreVariable:=SR_GetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Variable_Source)
		If (($t_nombreVariable="vrACT_SRbol_MontoCargo@") | ($t_nombreVariable="vrACT_SRbol_CantidadCargo@") | ($t_nombreVariable="vrACT_SRbol_UnitarioCargo@") | ($t_nombreVariable="vtACT_SRbol_MontoMoneda@") | ($t_nombreVariable="vrACT_SRbol_MontoEnUF@") | ($t_nombreVariable="vrACT_SRbol_MontoDcto@"))
			$varIndex:=Num:C11($t_nombreVariable)
			$varPtr:=Get pointer:C304("vbACT_HideMonto"+String:C10($varIndex))
			If ($varPtr->=True:C214)
				SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_TextColor;"#FFFFFF")
				SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_BackColor;"#FFFFFF")
			End if 
		Else 
			  //20130128 RCH Para ocultar los 0 de los montos de los pagos...
			If ($t_nombreVariable="vrACT_SRbolPGS_Monto@")
				$varIndex:=Num:C11($t_nombreVariable)
				$varPtr:=Get pointer:C304("vrACT_SRbolPGS_Monto"+String:C10($varIndex))
				If ($varPtr->=0)
					SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_TextColor;"#FFFFFF")
					SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_BackColor;"#FFFFFF")
				End if 
			End if 
		End if 
		  //If (($t_nombreVariable="vtACT_SRbol_CuentaCargo@") | ($t_nombreVariable="vtACT_SRbol_CuentaCurCargo@") | ($t_nombreVariable="vtACT_SRbol_CuentaNivCargo@") | ($t_nombreVariable="vtACT_SRbol_CuentaPCurCargo@") | ($t_nombreVariable="vtACT_SRbol_CuentaPNivCargo@") | ($t_nombreVariable="vtACl_MesCargo@") | ($t_nombreVariable="vlACT_SRbol_AñoCargo@"))
		If (($t_nombreVariable="vtACT_SRbol_CuentaCargo@") | ($t_nombreVariable="vtACT_SRbol_CuentaCurCargo@") | ($t_nombreVariable="vtACT_SRbol_CuentaNivCargo@") | ($t_nombreVariable="vtACT_SRbol_CuentaPCurCargo@") | ($t_nombreVariable="vtACT_SRbol_CuentaPNivCargo@") | ($t_nombreVariable="vlACT_SRbol_AñoCargo@") | ($t_nombreVariable="vtACT_SRbol_AñoCargo@") | ($t_nombreVariable="vtACT_SRbol_CuentaRUT@"))
			If (vb_HideColsCtas)
				SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_TextColor;"#FFFFFF")
				SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_BackColor;"#FFFFFF")
			End if 
		End if 
	End for 
Else 
	$bol:=$1
	ARRAY LONGINT:C221($aObjectIDs;0)
	Case of 
		: ($bol=1)
			$section:=SR Section SubHeader1
		: ($bol=2)
			$section:=SR Section SubHeader2
		: ($bol=3)
			$section:=SR Section SubHeader3
		: ($bol=4)
			$section:=SR Section SubHeader4
	End case 
	$err:=SR Get Section Object IDs (vlSRP_AreaRef;$section;$aObjectIDs)
	For ($i;1;Size of array:C274($aObjectIDs))
		SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_TextColor;"#FFFFFF")
		SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_BackColor;"#FFFFFF")
	End for 
End if 
$err:=SR Get Area (vlSRP_AreaRef;xSR_ReportBlob)
  //$err:=SR Get Area (vlSRP_AreaRef;xs_ReportBlob)
SR DELETE OFFSCREEN AREA (vlSRP_AreaRef)