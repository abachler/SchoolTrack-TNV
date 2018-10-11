//%attributes = {}
C_LONGINT:C283($mode;$1)
C_TEXT:C284($0)

$mode:=$1
Case of 
	: ($mode=0)
		$xml_parent:="opcionesgenerales"
	: ($mode=1)
		$xml_parent:="opcionespornivel"
End case 

$xmlRef:=DOM Create XML Ref:C861($xml_parent)
DOM SET XML DECLARATION:C859($xmlRef;"UTF-8")

Case of 
	: ($mode=0)
		$correos:=DOM Create XML element:C865($xmlRef;"correos")
		$fia:=Find in array:C230(al_usr_id;SN3_ActuaDatosEncargadoID)
		$mail_encargado:=""
		If ($fia>0)
			$mail_encargado:=at_usr_mail{$fia}
		End if 
		DOM_SetElementValueAndAttr ($correos;"encargado";$mail_encargado;True:C214)
		
		$otros_correos:=DOM Create XML element:C865($correos;"otroscorreos")
		
		For ($i;1;Size of array:C274(SN3_NotificacionUsrID))
			$fia:=Find in array:C230(al_usr_id;SN3_NotificacionUsrID{$i})
			If ($fia>0)
				If (at_usr_mail{$fia}#"")
					DOM_SetElementValueAndAttr ($otros_correos;"correo";at_usr_mail{$fia};True:C214)
				End if 
			End if 
		End for 
		
		$opciones:=DOM Create XML element:C865($xmlRef;"opciones")
		DOM_SetElementValueAndAttr ($opciones;"requiereverificacion";String:C10(SN3_ActuaDatosReqVerif);True:C214)
		
		If (SN3_ActuaDatosNoMailApo=1)  //MONO: esto es por que la opción es al revés... :P
			SN3_ActuaDatosNoMailApo:=0
		Else 
			SN3_ActuaDatosNoMailApo:=1
		End if 
		
		DOM_SetElementValueAndAttr ($opciones;"enviarcorreopadres";String:C10(SN3_ActuaDatosNoMailApo);True:C214)
		
	: ($mode=1)
		
		$opciones:=DOM Create XML element:C865($xmlRef;"opciones")
		DOM_SetElementValueAndAttr ($opciones;"publica";String:C10(SN3_ActuaDatosPublica);True:C214)
		
		$campos:=DOM Create XML element:C865($xmlRef;"campos")
		
		$campos_rf_sen:=DOM Create XML element:C865($campos;"relacionfamiliarsensibles")
		
		For ($i;1;4)
			DOM_SetElementValueAndAttr ($campos_rf_sen;SN3_ListaTagsXMLRF{$i};String:C10(Num:C11(SN3_PublicaRF{$i}));True:C214)
		End for 
		
		$campos_rf:=DOM Create XML element:C865($campos;"relacionfamiliar")
		
		For ($i;5;Size of array:C274(SN3_ListaCamposRF))
			DOM_SetElementValueAndAttr ($campos_rf;SN3_ListaTagsXMLRF{$i};String:C10(Num:C11(SN3_PublicaRF{$i}));True:C214)
		End for 
		
		$campos_alu_sen:=DOM Create XML element:C865($campos;"alumnosensibles")
		
		For ($i;1;4)
			DOM_SetElementValueAndAttr ($campos_alu_sen;SN3_ListaTagsXMLAlumno{$i};String:C10(Num:C11(SN3_PublicaAlumno{$i}));True:C214)
		End for 
		
		$campos_alu:=DOM Create XML element:C865($campos;"alumno")
		$ultimo_gpo:=""
		For ($i;5;Size of array:C274(SN3_ListaTagsXMLAlumno))
			
			If (SN3_FieldGroupsAlumno{$i}="")
				DOM_SetElementValueAndAttr ($campos_alu;XML_GetValidXMLText (SN3_ListaTagsXMLAlumno{$i});String:C10(Num:C11(SN3_PublicaAlumno{$i}));True:C214)
			Else 
				
				If ($ultimo_gpo#SN3_FieldGroupsAlumno{$i})
					DOM_SetElementValueAndAttr ($campos_alu;Lowercase:C14(XML_GetValidXMLText (SN3_FieldGroupsAlumno{$i}));String:C10(Num:C11(SN3_PublicaAlumno{$i}));True:C214)
					$ultimo_gpo:=SN3_FieldGroupsAlumno{$i}
				End if 
				
			End if 
		End for 
		
		  //NO EDITABLE, los booleanos van  con not por que en xml van como no editable.
		
		$campos:=DOM Create XML element:C865($xmlRef;"noeditable")
		
		$campos_rf_sen:=DOM Create XML element:C865($campos;"relacionfamiliarsensibles")
		
		For ($i;1;4)
			DOM_SetElementValueAndAttr ($campos_rf_sen;SN3_ListaTagsXMLRF{$i};String:C10(Num:C11(Not:C34(SN3_EditaRF{$i})));True:C214)
		End for 
		
		$campos_rf:=DOM Create XML element:C865($campos;"relacionfamiliar")
		
		For ($i;5;Size of array:C274(SN3_ListaCamposRF))
			DOM_SetElementValueAndAttr ($campos_rf;SN3_ListaTagsXMLRF{$i};String:C10(Num:C11(Not:C34(SN3_EditaRF{$i})));True:C214)
		End for 
		
		$campos_alu_sen:=DOM Create XML element:C865($campos;"alumnosensibles")
		
		For ($i;1;4)
			DOM_SetElementValueAndAttr ($campos_alu_sen;SN3_ListaTagsXMLAlumno{$i};String:C10(Num:C11(Not:C34(SN3_EditaAlumno{$i})));True:C214)
		End for 
		
		$campos_alu:=DOM Create XML element:C865($campos;"alumno")
		$ultimo_gpo:=""
		For ($i;5;Size of array:C274(SN3_ListaTagsXMLAlumno))
			
			If (SN3_FieldGroupsAlumno{$i}="")
				DOM_SetElementValueAndAttr ($campos_alu;XML_GetValidXMLText (SN3_ListaTagsXMLAlumno{$i});String:C10(Num:C11(Not:C34(SN3_EditaAlumno{$i})));True:C214)
			Else 
				If ($ultimo_gpo#SN3_FieldGroupsAlumno{$i})
					DOM_SetElementValueAndAttr ($campos_alu;Lowercase:C14(XML_GetValidXMLText (SN3_FieldGroupsAlumno{$i}));String:C10(Num:C11(Not:C34(SN3_EditaAlumno{$i})));True:C214)
					$ultimo_gpo:=SN3_FieldGroupsAlumno{$i}
				End if 
				
			End if 
		End for 
		
End case 

DOM EXPORT TO VAR:C863($xmlRef;$0)
DOM CLOSE XML:C722($xmlRef)