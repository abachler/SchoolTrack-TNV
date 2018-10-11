//%attributes = {}
  // BBLitm_OnLoad()
  // Por: Alberto Bachler: 17/09/13, 13:24:28
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283(vlSTR_PaginaFormItems)


If ((vlSTR_PaginaFormItems=0) | (Is new record:C668([BBL_Items:61])))
	vlSTR_PaginaFormItems:=1
End if 

  //, visualización de la indexación
bAll:=1
If (bAll=1)
	bT:=1
	bA:=1
	bE:=1
	bS:=1
	bC:=1
	bN:=1
	bR:=1
End if 


vs_idxModified:=""
BBLitm_xALSet_AllAreas 
OBJECT SET RGB COLORS:C628(*;"lb_Materias";0x0000;0x00FFFFFF;<>vl_ColorFilasAlternas)

If (<>gUsaMARC)
	SELECT LIST ITEMS BY REFERENCE:C630(hlTab_BBL_items;vlSTR_PaginaFormItems)
	OBJECT SET COLOR:C271(*;"MARC@";-6)
	OBJECT SET FONT STYLE:C166(*;"MARC@";Underline:K14:4)
	_O_ENABLE BUTTON:C192(*;"btnMARC@")
Else 
	DELETE FROM LIST:C624(hlTab_BBL_items;6)
	If (vlSTR_PaginaFormItems=6)
		vlSTR_PaginaFormItems:=1
		SELECT LIST ITEMS BY REFERENCE:C630(hlTab_BBL_items;1)
	End if 
	_O_DISABLE BUTTON:C193(*;"btnMARC@")
End if 