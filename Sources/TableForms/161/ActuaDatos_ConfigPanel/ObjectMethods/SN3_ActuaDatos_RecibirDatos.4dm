vb_Gral_CFG_Mod:=True:C214

If (SN3_ActuaDatos_RecibirDatos=0)
	SN3_DataRecInterval:=0
	OBJECT SET ENABLED:C1123(*;"SN3_DataRecInterval";False:C215)
	OBJECT SET ENABLED:C1123(*;"btn_inv_min";False:C215)
Else 
	SN3_DataRecInterval:=al_minutos{1}
	OBJECT SET ENABLED:C1123(*;"SN3_DataRecInterval";True:C214)
	OBJECT SET ENABLED:C1123(*;"btn_inv_min";True:C214)
End if 

$msg:=ST_Boolean2Str (SN3_DataRecInterval=1;"Activada";"Desactivada")+", la recepción de datos automática."
LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")
