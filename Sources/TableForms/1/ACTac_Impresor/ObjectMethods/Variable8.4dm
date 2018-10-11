vi_PageNumber:=FORM Get current page:C276
Case of 
	: (vi_PageNumber=1)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		vi_step:=1
	: (vi_PageNumber=2)
		vi_step:=2
		_O_ENABLE BUTTON:C192(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: (vi_PageNumber=3)
		vi_step:=3
		_O_ENABLE BUTTON:C192(bPrev)
		$modSel:=Find in array:C230(abACT_ModeloSel;True:C214)
		IT_SetButtonState (($modSel#-1);->bNext)
	: (vi_PageNumber=4)
		vi_step:=4
		_O_ENABLE BUTTON:C192(bPrev)
		IT_SetButtonState ((viACT_avisos#0);->bNext)
	: (vi_PageNumber=5)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_DISABLE BUTTON:C193(bNext)
		vi_Step:=5
		Case of 
			: (f1=1)
				$universo:=String:C10(viACT_avisos1)+__ (" avisos de cobranza (avisos seleccionados en la lista)")
			: (f2=1)
				$universo:=String:C10(viACT_avisos2)+__ (" avisos de cobranza (todos los avisos en la lista)")
			: (f3=1)
				$universo:=String:C10(viACT_avisos3)+__ (" avisos de cobranza (todos los avisos en la base de datos)")
		End case 
		
		Case of 
			: (b1=1)
				$t:=__ ("La impresión de avisos de cobranza se hará para ^0.";$universo)+"\r\r"
			: (b2=1)
				$t:=__ ("El envío de avisos de cobranza se hará para ^0.";$universo)+"\r\r"
		End case 
		
		  //20160118 RCH Ticket 155327
		If (bPDF2Mail=1)
			Case of 
				: (r_opMail1_AC=1)
					$t:=$t+__ ("Los Avisos de Cobranza serán enviados sólo a los Apoderados de Cuentas.")
				: (r_opMail2_AA=1)
					$t:=$t+__ ("Los Avisos de Cobranza serán enviados sólo a los Apoderados de Académicos.")
				: (r_opMail3_Ambos=1)
					$t:=$t+__ ("Los Avisos de Cobranza serán enviados a ambos apoderados (Cuentas y Académicos).")
			End case 
		End if 
		
		vtACT_ResumenAsistente:=$t
End case 