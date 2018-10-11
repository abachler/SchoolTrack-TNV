Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ACTcfg_OpcionesTextoMail ("LeeBlob")
		C_TEXT:C284(vtACT_varOriginal)
		vtACT_varOriginal:=vt_CuerpoMail
		
		C_LONGINT:C283(vlb_HeaderID)
		vlb_HeaderID:=0
		ARRAY TEXT:C222(atACTcfgMail_Codigos;0)
		ARRAY TEXT:C222(atACTcfgMail_Descripcion;0)
		
		APPEND TO ARRAY:C911(atACTcfgMail_Codigos;"&NA")
		APPEND TO ARRAY:C911(atACTcfgMail_Codigos;"&CR")
		APPEND TO ARRAY:C911(atACTcfgMail_Codigos;"&ID")
		APPEND TO ARRAY:C911(atACTcfgMail_Codigos;"&M")
		APPEND TO ARRAY:C911(atACTcfgMail_Codigos;"&A")
		APPEND TO ARRAY:C911(atACTcfgMail_Codigos;"&NC")
		
		APPEND TO ARRAY:C911(atACTcfgMail_Descripcion;"Nombre apoderado")
		APPEND TO ARRAY:C911(atACTcfgMail_Descripcion;"Salto de línea")
		APPEND TO ARRAY:C911(atACTcfgMail_Descripcion;"Número aviso")
		APPEND TO ARRAY:C911(atACTcfgMail_Descripcion;"Mes del aviso de cobranza")
		APPEND TO ARRAY:C911(atACTcfgMail_Descripcion;"Año del aviso de cobranza")
		APPEND TO ARRAY:C911(atACTcfgMail_Descripcion;"Nombre del colegio")
		
		LISTBOX DELETE COLUMN:C830(*;"lbVarsDisp";LISTBOX Get number of columns:C831(lbVarsDisp))
		vlb_HeaderID:=vlb_HeaderID+1
		LISTBOX INSERT COLUMN:C829(*;"lbVarsDisp";1;"Código";atACTcfgMail_Codigos;"HeaderCod";vlb_HeaderID)
		vlb_HeaderID:=vlb_HeaderID+1
		LISTBOX INSERT COLUMN:C829(*;"lbVarsDisp";2;"Descripción";atACTcfgMail_Descripcion;"HeaderDesc";vlb_HeaderID)
		OBJECT SET ENTERABLE:C238(*;"lbVarsDisp";False:C215)
		OBJECT SET FONT SIZE:C165(*;"lbVarsDisp";9)
		OBJECT SET RGB COLORS:C628(*;"lbVarsDisp";0x0000;0x00FFFFFF;(<>vl_AltBackground_Red << 16)+(<>vl_AltBackground_Green << 8)+<>vl_AltBackground_Blue)
		LISTBOX SET COLUMN WIDTH:C833(*;"HeaderCod";40)
		OBJECT SET ENTERABLE:C238(*;"lbVarsDisp";False:C215)
End case 
