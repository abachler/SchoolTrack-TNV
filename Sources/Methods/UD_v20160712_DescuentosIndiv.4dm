//%attributes = {}
  //UD_v20160712_DescuentosIndiv

If (ACT_AccountTrackInicializado )
	$l_ok:=ACTdcto_LeeDctosXCuenta 
	
	If ($l_ok=1)
		ARRAY LONGINT:C221($alACT_idsCtas;0)
		ARRAY REAL:C219($arACT_pcts;0)
		C_LONGINT:C283($i;$r_idDcto)
		
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Descuento:23#0)
		
		If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
			$r_idDcto:=-1
			
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$alACT_idsCtas;[ACT_CuentasCorrientes:175]Descuento:23;$arACT_pcts)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Creando registros de descuentos...")
			For ($i;1;Size of array:C274($alACT_idsCtas))
				ACTdic_CreaRegistro ($alACT_idsCtas{$i};$r_idDcto;False:C215;1;"";$arACT_pcts{$i})
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alACT_idsCtas))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			LOG_RegisterEvt ("Descuento individual creado para cuentas id: "+AT_Arrays2Text ("; ";": ";->$alACT_idsCtas;->$arACT_pcts)+".")
		End if 
	Else 
		LOG_RegisterEvt ("No fue posible crear el descuento individual.")
	End if 
End if 