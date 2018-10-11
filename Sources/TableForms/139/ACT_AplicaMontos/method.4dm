Case of 
	: (Form event:C388=On Load:K2:1)
		C_REAL:C285(vr_montoFijo;vr_montoPct;$page;btn_todas;btn_seleccionadas;$line;cs_Fijo;cs_Pct)
		C_TEXT:C284(vt_lista;vt_seleccionado)
		ARRAY INTEGER:C220($ai_lines;0)
		vt_lista:=""
		vt_seleccionado:=""
		vr_montoFijo:=0
		vr_montoPct:=0
		cs_Fijo:=1
		cs_Pct:=1
		$page:=Selected list items:C379(hlTab_ACT_TercerosGen)
		Case of 
			: ($page=1)
				$line:=AL_GetSelect (xAL_ACT_Terc_Cargas;$ai_lines)
				vt_lista:="("+String:C10(Size of array:C274(alACT_TerIdCtaCte))+" registro(s))"
			: ($page=2)
				$line:=AL_GetSelect (xAL_ACT_Terc_Items;$ai_lines)
				vt_lista:="("+String:C10(Size of array:C274(alACT_TerIdItem))+" registro(s))"
		End case 
		
		If (Size of array:C274($ai_lines)>0)
			vt_seleccionado:="("+String:C10(Size of array:C274($ai_lines))+" registro(s))"
			btn_todas:=0
			btn_seleccionadas:=1
		Else 
			vt_seleccionado:="(0 registro(s))"
			btn_todas:=1
			btn_seleccionadas:=0
		End if 
		IT_SetButtonState (Num:C11(vt_seleccionado)>0;->btn_seleccionadas)
End case 