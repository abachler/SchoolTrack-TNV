Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283($subList;$itemRef)
		C_TEXT:C284($itemText;vt_title)
		XS_SetConfigInterface 
		hl_ItemsEspeciales:=New list:C375
		hl_ItemsEspeciales:=LOC_LoadList ("ACT_ItemsEspeciales")
		vi_lastLine:=0
		vl_idItemIE:=0  //inicializa record number de items
		_O_ENABLE BUTTON:C192(*;"ItemsEspeciales@")
		vi_lastLine:=1
		ACTcfg_LoadCargosEspeciales (1)
		OBJECT SET VISIBLE:C603(*;"Mask@";False:C215)
		FORM GOTO PAGE:C247(1)
		SELECT LIST ITEMS BY POSITION:C381(hl_ItemsEspeciales;1)
		GET LIST ITEM:C378(hl_ItemsEspeciales;Selected list items:C379(hl_ItemsEspeciales);$itemRef;$itemText;$subList)
		vt_title:=$itemText
		ACTcfgcar_SetObjects ("SetPrivilegios")
	: (Form event:C388=On Clicked:K2:4)
		C_LONGINT:C283($subList;$itemRef)
		C_TEXT:C284($itemText)
		OBJECT SET ENTERABLE:C238(*;"ItemsEspeciales@";True:C214)
		_O_ENABLE BUTTON:C192(*;"ItemsEspeciales@")
		GET LIST ITEM:C378(hl_ItemsEspeciales;Selected list items:C379(hl_ItemsEspeciales);$itemRef;$itemText;$subList)
		
		If ($itemRef>0)
			ACTcfg_SaveItemCargosEsp 
		End if 
		
		If ($itemRef#vi_lastLine)
			  //20120126 AS. se estaba modificando el largo de los arreglos que se utilizan en la lista "xALP_Items". 
			  //ARRAY TEXT(atACT_GlosaItem;vi_lastLine)
			  //ARRAY LONGINT(alACT_idItem;vi_lastLine)
			  //ACTcfg_SaveItemCargosEsp 
			ACTcfg_pctsXFechaPago (1)
		End if 
		Case of 
			: ($itemRef>0)
				vi_lastLine:=$itemRef
				ACTcfg_LoadCargosEspeciales ($itemRef)
				OBJECT SET VISIBLE:C603(*;"Mask@";False:C215)
				vt_title:=$itemText
				FORM GOTO PAGE:C247($itemRef)
			Else 
				SELECT LIST ITEMS BY POSITION:C381(hl_ItemsEspeciales;vi_lastLine)
				FORM GOTO PAGE:C247(vi_lastLine)
		End case 
		REDRAW WINDOW:C456
		vtACT_CPCCS:=[xxACT_Items:179]No_de_Cuenta_Contable:15
		vtACT_CCCCS:=[xxACT_Items:179]Centro_de_Costos:21
		vtACT_CCPCCS:=[xxACT_Items:179]No_CCta_contable:22
		vtACT_CCCCCS:=[xxACT_Items:179]CCentro_de_costos:23
		ACTcfgcar_SetObjects ("SetPrivilegios")
		OBJECT SET ENTERABLE:C238(*;"obj_NoEdit@";False:C215)
End case 