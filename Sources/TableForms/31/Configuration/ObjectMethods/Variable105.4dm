C_LONGINT:C283($ref;$subList)
C_TEXT:C284($text)
GET LIST ITEM:C378(hl_tipoEstablecimiento;Selected list items:C379(hl_tipoEstablecimiento);$ref;$text;$sublist)
Case of 
	: ($ref=0)
		
	: ($ref=1)
		[Colegio:31]MINEDUC_CodigoEnsenanza:32:=""
		OBJECT SET VISIBLE:C603([Colegio:31]MINEDUC_CodigoEnsenanza:32;False:C215)
	Else 
		[Colegio:31]MINEDUC_CodigoEnsenanza:32:=String:C10($ref)
		OBJECT SET VISIBLE:C603([Colegio:31]MINEDUC_CodigoEnsenanza:32;True:C214)
End case 