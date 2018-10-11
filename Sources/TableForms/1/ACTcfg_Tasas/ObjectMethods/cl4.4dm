$yearStr:=String:C10(alACT_IPCYears{alACT_IPCYears})
vbWA_GetContent:=True:C214

  //20171018 RCH
  //vt_URL:=Replace string(vtACT_URLUTMSII;"AAAA";$yearStr)
If (Num:C11($yearStr)>=2013)
	vt_URL:=Replace string:C233(vtACT_URLUTMSII_2017;"AAAA";$yearStr)
Else 
	vt_URL:=Replace string:C233(vtACT_URLUTMSII_PRE2017;"AAAA";$yearStr)
End if 

WDW_OpenFormWindow (->[xShell_Dialogs:114];"LiveWindow";-1;4;__ ("SII"))
DIALOG:C40([xShell_Dialogs:114];"LiveWindow")
CLOSE WINDOW:C154
If (vtWA_getContent#"")
	  //If (Position(Substring(vtACT_URLUTMSII;1;40);vtWA_currentURL)#0)
	If (Position:C15(Substring:C12(vt_URL;1;40);vtWA_currentURL)#0)  //20171018 RCH
		If (Position:C15("UTM";vtWA_title)>0)
			$yearStr:=String:C10(Num:C11(vtWA_currentURL))
			If (Num:C11($yearStr)>2000)
				$resp:=CD_Dlog (0;__ ("¿Desea actualizar los valores del IPC para el año ")+$yearStr+"?";"";__ ("Si");__ ("No"))
				If ($resp=1)
					vl_lastYear:=Num:C11($yearStr)
					$proc:=IT_UThermometer (1;0;__ ("Recalculando valores UF..."))
					ACTmyt_SincronizaSII (vtWA_getContent;$yearStr)
					IT_UThermometer (-2;$proc)
					LOG_RegisterEvt ("IPC actualizado desde botón SII.")
					CD_Dlog (0;__ ("Por favor verifique los valores del IPC para el año ")+$yearStr+".")
				End if 
			End if 
		End if 
	End if 
End if 