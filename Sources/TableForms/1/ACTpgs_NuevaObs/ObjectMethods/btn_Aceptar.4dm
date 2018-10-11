C_LONGINT:C283($resp)
C_TEXT:C284($vt_msg)
C_BOOLEAN:C305($vb_ok)
ARRAY LONGINT:C221($al_selected;0)

$err:=AL_GetSelect (xALP_ACTpgs_Alumnos;$al_selected)

If (((btn_Cuenta=1) & (Size of array:C274($al_selected)>0)) | (btn_Apoderado=1))
	If (vdFechaObs#!00-00-00!)
		If (vt_Obs#"")
			If (btn_Apoderado=1)
				$vt_msg:="¿Está seguro de querer ingresar una observación para el apoderado "+[Personas:7]Apellidos_y_nombres:30+"?"
			Else 
				$vt_msg:="¿Está seguro de querer ingresar observación(es) para "+String:C10(Size of array:C274($al_selected))+" cuenta(s) "+"?"
			End if 
			$resp:=CD_Dlog (0;$vt_msg;"";"Si";"No")
			If ($resp=1)
				Case of 
					: (btn_Apoderado=1)
						ACTpp_CreateObs ([Personas:7]No:1;vt_Obs;vdFechaObs)
					: (btn_Cuenta=1)
						For ($i;1;Size of array:C274($al_selected))
							$vl_idAl:=alACT_IdsAlumnos{$i}
							$vl_idCta:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->$vl_idAl;->[ACT_CuentasCorrientes:175]ID:1)
							ACTcc_CreateObs ($vl_idCta;vt_Obs;vdFechaObs;Table:C252(->[ACT_CuentasCorrientes:175]))
						End for 
				End case 
				$vb_ok:=True:C214
				LOG_RegisterEvt ("Creación de observaciones desde la ventana de pagos.")
			End if 
		Else 
			CD_Dlog (0;"Ingrese un motivo.")
		End if 
	Else 
		CD_Dlog (0;"Ingrese una fecha válida.")
	End if 
Else 
	CD_Dlog (0;"Seleccione alguna cuenta.")
End if 
If ($vb_ok)
	CANCEL:C270
End if 