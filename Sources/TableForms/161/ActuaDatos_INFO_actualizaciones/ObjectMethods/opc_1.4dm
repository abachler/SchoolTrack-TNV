SN3_ActuaDatos_INFO_Actua (1)

vb_Hoy:=0
vb_Mes:=0
vb_Año:=0
vb_Rango:=0

If (vlSN3_CurrentTab=2)
	OBJECT SET VISIBLE:C603(*;"Apo_Pend_txt";False:C215)
	OBJECT SET VISIBLE:C603(*;"Advice_op1";False:C215)
	OBJECT SET VISIBLE:C603(*;"Advice_op2";False:C215)
	OBJECT SET VISIBLE:C603(*;"Advice_op3";False:C215)
	
	OBJECT SET VISIBLE:C603(*;"Apo_cantidad_txt";False:C215)
	
	OBJECT SET VISIBLE:C603(*;"vt_fecha3";False:C215)
	OBJECT SET VISIBLE:C603(*;"Fecha3";False:C215)
	OBJECT SET VISIBLE:C603(*;"btn_comunicar";False:C215)
	
End if 