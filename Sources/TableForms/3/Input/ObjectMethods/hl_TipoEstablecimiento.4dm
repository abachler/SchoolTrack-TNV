C_LONGINT:C283($ref)
C_TEXT:C284($text)
Case of 
	: (Form event:C388=On Data Change:K2:15)
		GET LIST ITEM:C378(hl_tipoEstablecimiento;Selected list items:C379(hl_tipoEstablecimiento);$ref;$text)
		Case of 
			: ($ref=0)
				
			: ($ref=1)
				[Cursos:3]cl_CodigoTipoEnseñanza:21:=$ref
				[Cursos:3]cl_TipoEnseñanza:25:=$text
			Else 
				[Cursos:3]cl_CodigoTipoEnseñanza:21:=$ref
				[Cursos:3]cl_TipoEnseñanza:25:=$text
		End case 
		
		CU_SetInputFormObjects 
		
End case 
