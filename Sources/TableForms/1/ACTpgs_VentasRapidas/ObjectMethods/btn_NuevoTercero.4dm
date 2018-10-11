READ WRITE:C146([ACT_Terceros:138])
C_LONGINT:C283(vlBWR_CurrentModuleRef;$vl_terId)
vlBWR_CurrentModuleRef:=4
yBWR_currentTable:=->[ACT_Terceros:138]
$vl_terId:=1
vyBWR_CustomArrayPointer:=->$vl_terId
vyBWR_CustonFieldRefPointer:=->[ACT_Terceros:138]Id:1
vlBWR_BrowsingMethod:=BWR Array Browsing
vbXS_inBrowser:=False:C215
vb_RecordInInputForm:=True:C214  //20131204 RCH para evitar error con arealist del browser.
ARRAY TEXT:C222(atMNU_ModuleReferencesMenus;0)
hlTab_ACT_Terceros:=AT_Array2ReferencedList (-><>atACT_PaginaTerceros;-><>alACT_PaginaTerceros;0;False:C215;True:C214)
C_TEXT:C284(vtMNU_DevelopperMenu)

MNU_LoadModuleMenus 
BWR_DeclareArrays 
BWR_LoadFormReportsArrays (->[ACT_Terceros:138])

  //FORM SET INPUT([ACT_Terceros];"Input")
  //FORM GET PROPERTIES([ACT_Terceros];"Input";$width;$height)
  //WDW_Open ($width;$height;2;4;<>aNombFile{Table(yBWR_currentTable)};"wdwCloseDlog")
WDW_OpenFormWindow (->[ACT_Terceros:138];"Input";0;4)
FORM SET INPUT:C55([ACT_Terceros:138];"Input")
ADD RECORD:C56([ACT_Terceros:138];*)
CLOSE WINDOW:C154

If (viBWR_RecordWasSaved>0)
	LOAD RECORD:C52([ACT_Terceros:138])
	RNTercero:=Record number:C243([ACT_Terceros:138])
	ACTpgs_OpcionesVR ("CargaRegistro")
Else 
	ACTpgs_OpcionesVR ("CambiaTipoRegistro")
End if 
READ ONLY:C145([ACT_Terceros:138])