//%attributes = {}
  //xAL_ACT_CB_CuentasEspeciales

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)

AL_GetCurrCell (xALP_Centros;$col;$row)
$0:=True:C214
If ($2=7)
	$0:=False:C215
Else 
	Case of 
		: (($col=1) | ($col=2))
			C_POINTER:C301($vy_pointer)
			Case of 
				: ($col=1)
					$vy_pointer:=-><>atACT_CentroGlosa
				Else 
					$vy_pointer:=-><>asACT_Centro
			End case 
			If ($vy_pointer->{0}#$vy_pointer->{$row})
				If (<>alACT_idCentro{$row}#0)
					C_LONGINT:C283($vl_records)
					C_BOOLEAN:C305($vb_update)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
					QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id_centro_asociado:7=<>alACT_idCentro{$row})
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($vl_records>0)
						$vl_resp:=CD_Dlog (0;__ ("Se actualizarán los centros de costo asociados a las cuentas especiales.")+"\r\r"+__ ("¿Desea continuar?");"";"Si";"No")
						If ($vl_resp=1)
							$vb_update:=True:C214
						Else 
							$vy_pointer->{$row}:=$vy_pointer->{0}
						End if 
					Else 
						$vl_resp:=1
					End if 
				Else 
					$vl_resp:=1
				End if 
				If ($vl_resp=1)
					READ WRITE:C146([ACT_Cuentas_Contables:286])
					QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id:1=<>alACT_idCentro{$row})
					[ACT_Cuentas_Contables:286]glosa:3:=<>atACT_CentroGlosa{$row}
					[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4:=<>asACT_Centro{$row}
					SAVE RECORD:C53([ACT_Cuentas_Contables:286])
					KRL_UnloadReadOnly (->[ACT_Cuentas_Contables:286])
					
					If ($vb_update)
						AL_UpdateArrays (xALP_CtasEspeciales;0)
						ACTcfg_OpcionesContabilidad ("CargaArreglosCuentasEspeciales")
						
						AL_UpdateArrays (xALP_CtasEspeciales;-2)
						
						ACTcfg_OpcionesContabilidad ("PintaCtasEspeciales")
						$line:=1  //en pruebas siempre es 1
						ACTcfg_OpcionesContabilidad ("SetEstadoBotonCtasEspeciales";->$line)
						
					End if 
					
				End if 
			End if 
	End case 
End if 