//%attributes = {}
  //BBL_LeeReglasPorDefecto

  //carga regla para lectores
READ ONLY:C145([xxBBL_ReglasParaUsuarios:64])
QUERY:C277([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Default:12=True:C214)
<>sMT_DefaultUserRule:=[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1

  //carga regla para items
READ ONLY:C145([xxBBL_ReglasParaItems:69])
QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Default:10=True:C214)
<>sMT_DefaultItemRule:=[xxBBL_ReglasParaItems:69]Codigo_regla:1