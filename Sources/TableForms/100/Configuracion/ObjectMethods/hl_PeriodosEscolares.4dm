C_TEXT:C284($nombrePeriodo;$text)
C_LONGINT:C283($ref;$selected)
Case of 
	: (Form event:C388=On Clicked:K2:4)
		CFG_STR_PeriodosEscolares_NEW ("GuardaDatosPeriodo")
		$selected:=Selected list items:C379(hl_PeriodosEscolares)
		If ($selected>0)
			GET LIST ITEM:C378(hl_PeriodosEscolares;$selected;$recNum;$nombrePeriodo)
			vl_RecNumPeriodos:=$recNum
			CFG_STR_PeriodosEscolares_NEW ("LeeDatosPeriodo")
		Else 
			OBJECT SET VISIBLE:C603(*;"Periodos@";False:C215)
		End if 
	: ((Form event:C388=On After Edit:K2:43) | (Form event:C388=On Data Change:K2:15))
		GET LIST ITEM:C378(Self:C308->;*;$ref;$text)
		vt_PeriodoNombre:=$text
		
End case 