//%attributes = {}
  //ACTcc_RecalculaCargos

ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
ARRAY DATE:C224(adACT_fechasEm;0)
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=0)
SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$aRecNumDocs)
LOAD RECORD:C52([ACT_Documentos_de_Cargo:174])
SELECTION TO ARRAY:C260([ACT_Cargos:173];$aRecNumsCargos)
ACTinit_LoadPrefs 
For ($i_Cargos;1;Size of array:C274($aRecNumsCargos))
	READ WRITE:C146([ACT_Cargos:173])
	ACTcc_CalculaMontoItem ($aRecNumsCargos{$i_Cargos})
	UNLOAD RECORD:C212([ACT_Cargos:173])
	READ ONLY:C145([ACT_Cargos:173])
End for 
ACTcc_CalculaDocumentoCargo ($recnumDocumentoCargo)