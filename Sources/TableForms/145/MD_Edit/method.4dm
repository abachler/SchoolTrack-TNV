  // Método: Método de Formulario: [MDATA_RegistrosDatosLocales]Edit
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 26/10/09, 11:29:23
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal


Case of 
	: (Form event:C388=On Load:K2:1)
		ALP_DefaultColSettings (xALP_MetaDatos;1;"atMD_FieldName";"";150)
		ALP_DefaultColSettings (xALP_MetaDatos;2;"atMD_TextValues";"";300)
		ALP_DefaultColSettings (xALP_MetaDatos;3;"atMD_FieldUUID")
		ALP_DefaultColSettings (xALP_MetaDatos;4;"alMD_FieldType")
		ALP_DefaultColSettings (xALP_MetaDatos;5;"aiMD_FieldLength")
		ALP_DefaultColSettings (xALP_MetaDatos;6;"atMD_ValueList")
		ALP_DefaultColSettings (xALP_MetaDatos;7;"arMD_MinimumValue")
		ALP_DefaultColSettings (xALP_MetaDatos;8;"arMD_MaximumValue")
		ALP_DefaultColSettings (xALP_MetaDatos;9;"atMD_Keys")
		ALP_DefaultColSettings (xALP_MetaDatos;10;"atMD_RecNum")
		
		ALP_SetDefaultAppareance (xALP_MetaDatos)
		AL_SetColOpts (xALP_MetaDatos;0;0;0;8)
		AL_SetMiscOpts (xALP_MetaDatos;1)
		AL_SetEntryOpts (xALP_MetaDatos;3;0;0;1;2;<>tXS_RS_DecimalSeparator)
		AL_SetEnterable (xALP_MetaDatos;2;1)
		AL_SetCallbacks (xALP_MetaDatos;"";"xALCB_EX_MetaDatosLocales")
		
		ARRAY INTEGER:C220($aInt2;2;0)
		For ($i;1;Size of array:C274(atMD_FieldUUID))
			Case of 
				: (atMD_ValueList{$i}#"")
					AL_SetCellEnter (xALP_MetaDatos;2;$i;2;$i;$aInt2;0)
					AL_SetCellIcon (xALP_MetaDatos;2;$i;Use PicRef:K28:4+12047;1;3;2)
					
				: (alMD_FieldType{$i}=Is text:K8:3)
					AL_SetCellEnter (xALP_MetaDatos;2;$i;2;$i;$aInt2;1)
					
				: (alMD_FieldType{$i}=Is date:K8:7)
					AL_SetCellEnter (xALP_MetaDatos;2;$i;2;$i;$aInt2;0)
					
				: (alMD_FieldType{$i}=Is boolean:K8:9)
					AL_SetCellEnter (xALP_MetaDatos;2;$i;2;$i;$aInt2;0)
					AL_SetCellIcon (xALP_MetaDatos;2;$i;Use PicRef:K28:4+12047;1;3;2)
					
				: ((alMD_FieldType{$i}=Is real:K8:4) | (alMD_FieldType{$i}=Is longint:K8:6) | (alMD_FieldType{$i}=Is integer:K8:5))
					AL_SetCellEnter (xALP_MetaDatos;2;$i;2;$i;$aInt2;1)
					
			End case 
		End for 
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

