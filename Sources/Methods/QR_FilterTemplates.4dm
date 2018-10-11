//%attributes = {}
  // QR_FilterTemplates()
  //
  //
  // creado por: Alberto Bachler Klein: 08-04-16, 16:41:34
  // -----------------------------------------------------------

$t_filtro:=PREF_fGet (<>lUSR_CurrentUserID;"universoInformes";"todos")

Case of 
	: ($t_filtro="publicos")
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]Public:8=True:C214;*)
		QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]Propietary:9=<>lUSR_CurrentUserID)
	: ($t_filtro="todos")
		QUERY SELECTION BY FORMULA:C207([xShell_Reports:54];(Not:C34(Util_isValidUUID ([xShell_Reports:54]UUID_institucion:33))) | ([xShell_Reports:54]UUID_institucion:33=<>GUUID))
	: ($t_filtro="estandar")
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]IsStandard:38=True:C214;*)
		QUERY SELECTION:C341([xShell_Reports:54]; & [xShell_Reports:54]UUID_institucion:33="")
	: ($t_filtro="delColegio")
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]Propietary:9>0)
	: ($t_filtro="mios")
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]Propietary:9=<>lUSR_CurrentUserID)
	: ($t_filtro="estandarDelColegio")
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]UUID_institucion:33=<>gUUID;*)
		QUERY SELECTION:C341([xShell_Reports:54]; & [xShell_Reports:54]IsStandard:38=True:C214)
	: ($t_filtro="estandarOtrosColegios")
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]UUID_institucion:33#"";*)
		QUERY SELECTION:C341([xShell_Reports:54]; & ;[xShell_Reports:54]IsStandard:38=True:C214)
		QUERY SELECTION BY FORMULA:C207([xShell_Reports:54];(Util_isValidUUID ([xShell_Reports:54]UUID_institucion:33) | ([xShell_Reports:54]UUID_institucion:33#<>GUUID)))
End case 


