Case of 
	: (vi_PageNumber=1)
		C_BOOLEAN:C305($b_valida)
		$b_valida:=(ACTfear_OpcionesGenerales ("ValidaFechaEmision";->vdACT_FEmisionBol)="1")
		If ($b_valida)
			
			vi_PageNumber:=Num:C11(ACTbol_CargaDiasVencimiento ("ValidaVencimiento"))
			
		Else 
			vi_PageNumber:=1
		End if 
		vtACT_FEmisionBol:=String:C10(vdACT_FEmisionBol;7)
		
	: (vi_PageNumber=2)
		vi_PageNumber:=3
	: (vi_PageNumber=3)
		C_BOOLEAN:C305($vb_emitir)
		$vb_emitir:=ACTbol_ValidaEmisionDesdeAvisos ("Selection")
		If ($vb_emitir)
			If (f3=1)
				$resp:=CD_Dlog (0;__ ("Se emitirán Documentos Tributarios para todos los registros. ¿Desea Continuar?");__ ("");__ ("Si");__ ("No"))
				If ($resp=1)
					vi_PageNumber:=4
				Else 
					vi_PageNumber:=3
				End if 
			Else 
				vi_PageNumber:=4
			End if 
			IT_SetButtonState ((vi_Selected>0);->bNext)
			  //ENABLE BUTTON(bNext)
		Else 
			  //DISABLE BUTTON(bNext)
		End if 
		OBJECT SET ENABLED:C1123(bNext;$vb_emitir)
	: (vi_PageNumber=4)
		vi_PageNumber:=5
End case 
  //ENABLE BUTTON(bPrev)
OBJECT SET ENABLED:C1123(bPrev;True:C214)
FORM GOTO PAGE:C247(vi_PageNumber)
POST KEY:C465(Character code:C91("+");256)