//%attributes = {}
  //ACTbol_OnLoad

ACTbol_FormArraysDeclarations 
ACTinit_LoadPrefs 

xALSet_ACT_CargosBoleta 
xALSet_ACT_PagosBoleta 
xALSet_ACT_AlumnosBoleta 
xALSet_ACT_AreaDctosAsoc 

  //20140711 RCH Para ver el PDF generado
C_LONGINT:C283($l_registros)
If (<>gCountryCode="cl")  //20150813 RCH Se valida para ver el archivo solo en CL
	READ ONLY:C145([ACT_RazonesSociales:279])
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
	QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]emisor_electronico:30=True:C214)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
Else 
	$l_registros:=0
End if 

OBJECT SET FORMAT:C236(*;"Monto_Total2";"|Despliegue_ACT")

OBJECT SET VISIBLE:C603(btn_pdfBol;$l_registros>0)

OBJECT SET VISIBLE:C603(*;"categoria@";(cbEmitirXCategorias=1))

OBJECT SET VISIBLE:C603(*;"categoria@";(cbEmitirXMonedas=1))