GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$text)
If (vlSN3_CurrentTab#$ref)
	Case of 
		: (vlSN3_CurrentTab=1)
		: (vlSN3_CurrentTab=2)
	End case 
	Case of 
		: ($ref=1)
			FORM GOTO PAGE:C247(1)
		: ($ref=2)
			FORM GOTO PAGE:C247(2)
			$visible:=False:C215
			If (opc_2=1)  //Personas pendientes
				$visible:=True:C214
			End if 
			OBJECT SET VISIBLE:C603(*;"Apo_Pend_txt";$visible)
			OBJECT SET VISIBLE:C603(*;"Advice_op1";$visible)
			OBJECT SET VISIBLE:C603(*;"Advice_op2";$visible)
			OBJECT SET VISIBLE:C603(*;"Advice_op3";$visible)
			
			OBJECT SET VISIBLE:C603(*;"Apo_cantidad_txt";$visible)
			
			OBJECT SET VISIBLE:C603(*;"vt_fecha3";$visible)
			OBJECT SET VISIBLE:C603(*;"Fecha3";$visible)
			OBJECT SET VISIBLE:C603(*;"btn_comunicar";$visible)
			
			OBJECT SET ENABLED:C1123(*;"vt_fecha3";False:C215)
			OBJECT SET ENABLED:C1123(*;"Fecha3";False:C215)
			
	End case 
End if 
vlSN3_CurrentTab:=$ref