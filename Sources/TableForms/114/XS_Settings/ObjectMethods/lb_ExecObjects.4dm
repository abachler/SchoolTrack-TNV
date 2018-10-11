C_LONGINT:C283($styles;$PictureID;$style;$iconRef)
C_BOOLEAN:C305($enterable)
C_POINTER:C301($noTable)

XS_Settings ("EditExecObject")





  //  `GET LIST ITEM(Self->;*;$itemRef;$itemText)
  //  `vt_CurrentMethodName:=ST_GetWord ($itemText;2;";")
  //  `$el:=Find in array(alXS_ServicesItemId;$itemRef)
  //  `If ($el>0)
  //  `vl_CurrentIconRef:=alXS_ServicesIconsRefs{$el}
  //  `End if 
  //  `EDIT ITEM(Self->)
  //
  //: (Form event=On Clicked )
  //If (Contextual click)
  //GET LIST ITEM(hl_modules;*;$ModuleRef;$itemText)
  //
  //$listElements:=Size of array(alXS_ExecObjects_RecNum)
  //$selected:=alXS_ExecObjects_RecNum
  //If ($selected>0)
  //$objectNameRef:=atXS_ExecObjects_RefName{$selected}
  //Else 
  //$objectNameRef:=""
  //End if 
  //
  //
  //Case of 
  //: (vtXS_CurrentObjectClass="ConfigPanel")
  //If ($selected=0)
  //$choice:=Pop up menu("Agregar Panel de Configuración")
  //Else 
  //If ($listElements<=1)
  //$choice:=Pop up menu("Agregar Panel de Configuración;Agregar Panel de Configuración sólo para "+ST_GetWord (vtXS_Country;2;":")+";-;(Retirar "+$objectNameRef+";Retirar "+$objectNameRef+" solo para "+ST_GetWord (vtXS_Country;2;":")+";-;Seleccionar Icono...;Eliminar Icono")
  //Else 
  //$choice:=Pop up menu("Agregar Panel de Configuración;Agregar Panel de Configuración sólo para "+ST_GetWord (vtXS_Country;2;":")+";-;Retirar "+$objectNameRef+";Retirar "+$objectNameRef+" solo para "+ST_GetWord (vtXS_Country;2;":")+";-;Seleccionar Icono...;Eliminar Icono")
  //End if 
  //End if 
  //
  //: (vtXS_CurrentObjectClass="Wizard")
  //If ($selected=0)
  //$choice:=Pop up menu("Agregar Asistente")
  //Else 
  //If ($listElements<=1)
  //$choice:=Pop up menu("Agregar Asistente;Agregar Asistente sólo para "+ST_GetWord (vtXS_Country;2;":")+";-;(Retirar "+$objectNameRef+";Retirar "+$objectNameRef+" solo para "+ST_GetWord (vtXS_Country;2;":")+";-;Seleccionar Icono...;Eliminar Icono")
  //Else 
  //$choice:=Pop up menu("Agregar Asistente;Agregar Asistente sólo para "+ST_GetWord (vtXS_Country;2;":")+";-;Retirar "+$objectNameRef+";Retirar "+$objectNameRef+" solo para "+ST_GetWord (vtXS_Country;2;":")+";-;Seleccionar Icono...;Eliminar Icono")
  //End if 
  //End if 
  //
  //: (vtXS_CurrentObjectClass="ToolsMenuItem")
  //If ($selected=0)
  //$choice:=Pop up menu("Agregar Item Menú Herramientas")
  //Else 
  //If ($listElements<=1)
  //$choice:=Pop up menu("Agregar Herramienta;Agregar Herramienta sólo para "+ST_GetWord (vtXS_Country;2;":")+";-;(Retirar "+$objectNameRef+";Retirar "+$objectNameRef+" solo para "+ST_GetWord (vtXS_Country;2;":")+";-;Seleccionar Icono...;Eliminar Icono")
  //Else 
  //$choice:=Pop up menu("Agregar Herramienta;Agregar Herramienta sólo para "+ST_GetWord (vtXS_Country;2;":")+";-;Retirar "+$objectNameRef+";Retirar "+$objectNameRef+" solo para "+ST_GetWord (vtXS_Country;2;":")+";-;Seleccionar Icono...;Eliminar Icono")
  //End if 
  //End if 
  //End case 
  //
  //  `
  //  `Case of 
  //  `: ($choice=1)
  //  `$ref:=XS_InsertInAllServicesBlobs ($ModuleRef;$selected)
  //  `If ($ref#0)
  //  `SELECT LIST ITEMS BY REFERENCE(Self->;$ref)
  //  `GET LIST ITEM(Self->;*;$itemRef;$itemText)
  //  `vt_CurrentMethodName:=ST_GetWord ($itemText;2;";")
  //  `$el:=Find in array(alXS_WizardsItemId;$itemRef)
  //  `If ($el>0)
  //  `vl_CurrentIconRef:=alXS_WizardsIconsRefs{$el}
  //  `End if 
  //  `EDIT ITEM(Self->)
  //  `End if 
  //  `
  //  `: ($choice=2)
  //  `$listElements:=Count list items(Self->)
  //  `$ref:=HL_GetNextItemRefNumber (Self->)
  //  `If ($selected#0)
  //  `SELECT LIST ITEMS BY POSITION(Self->;$selected)
  //  `INSERT IN LIST(Self->;*;"Asistente "+String($listElements+1)+";Método";$ref)
  //  `Else 
  //  `APPEND TO LIST(Self->;"Asistente "+String($listElements+1)+";Método";$ref)
  //  `End if 
  //  `If ($ref#0)
  //  `SELECT LIST ITEMS BY REFERENCE(Self->;$ref)
  //  `EDIT ITEM(Self->)
  //  `End if 
  //  `
  //  `: ($choice=4)
  //  `XS_RemoveFromAllServicesBlobs ($ModuleRef;$selected)
  //  `: ($choice=5)
  //  `DELETE FROM LIST(Self->;$itemRef)
  //  `REDRAW LIST(Self->)
  //  `XS_Settings ("SaveServiceMenuItems")
  //  `XS_CopyPrefWizServiceItems (aChoiceObjects{aChoiceObjects};2)
  //  `
  //  `: ($choice=7)
  //  `$pictureVarPointer:=Bash_Get_Variable_By_Type (Is Picture )
  //  `READ PICTURE FILE("";$pictureVarPointer->)
  //  `If (ok=1)
  //  `PICT_ScalePicture ($pictureVarPointer;20;80)
  //  `$text:=$itemText
  //  `XS_SetIconInAllServicesBlobs ($ModuleRef;alXS_ServicesIconsRefs{$selected};$selected;$pictureVarPointer;$text)
  //  `End if 
  //  `Bash_Return_Variable ($pictureVarPointer)
  //  `
  //  `: ($choice=8)
  //  `XS_RemoveIconInAllServicesBlobs ($ModuleRef;$selected)
  //  `End case 
  //  `REDRAW LIST(Self->)
  //
  //Else 
  //  `GET LIST ITEM(Self->;*;$itemRef;$itemText)
  //  `vt_CurrentMethodName:=ST_GetWord ($itemText;2;";")
  //  `$el:=Find in array(alXS_ServicesItemId;$itemRef)
  //  `If ($el>0)
  //  `vl_CurrentIconRef:=alXS_ServicesIconsRefs{$el}
  //  `End if 
  //End if 
  //
  //: (Form event=On Data Change )
  //$selected:=Selected list items(Self->)
  //If ($selected#0)
  //GET LIST ITEM(hl_modules;Selected list items(hl_modules);$ModuleRef;$itemText)
  //GET LIST ITEM(Self->;Selected list items(Self->);$itemRef;$itemText)
  //$methodName:=""
  //If ((Position("(-";$itemText)=0) & (Position("-";$itemText)=0))
  //$methodName:=ST_GetWord ($itemText;2;";")
  //aMethodNames{0}:=$methodName
  //AT_SearchArray (->aMethodNames;">>")
  //If (Size of array(DA_Return)>1)
  //ARRAY TEXT(distinctMethods;0)
  //For ($i;1;Size of array(DA_Return))
  //APPEND TO ARRAY(distinctMethods;aMethodNames{DA_Return{$i}})
  //End for 
  //ARRAY POINTER(◊aChoicePtrs;0)
  //ARRAY POINTER(◊aChoicePtrs;1)
  //◊aChoicePtrs{1}:=->distinctMethods
  //TBL_ShowChoiceList (0;"Seleccione el método";1)
  //If (ok=1)
  //$methodName:=distinctMethods{choiceIdx}
  //Else 
  //$methodName:=""
  //End if 
  //ARRAY TEXT(distinctMethods;0)
  //Else 
  //If (Size of array(DA_Return)=0)
  //$methodName:=""
  //Else 
  //$methodName:=aMethodNames{DA_Return{1}}
  //End if 
  //End if 
  //
  //If ($methodName="")
  //$methodName:="Método"
  //CD_Dlog (0;"Método inexistente.\r\rIngrese un nombre de método válido.")
  //End if 
  //End if 
  //XS_Settings ("SaveServiceMenuItems")
  //XS_ChangeMethodInAllServicesBlo ($ModuleRef;$selected;$methodName)
  //End if 
  //
  //
  //: (Form event=On Losing Focus )
  //$selected:=Selected list items(Self->)
  //If ($selected#0)
  //GET LIST ITEM(hl_modules;Selected list items(hl_modules);$ModuleRef;$itemText)
  //GET LIST ITEM(Self->;Selected list items(Self->);$itemRef;$itemText)
  //$methodName:=""
  //If ((Position("(-";$itemText)=0) & (Position("-";$itemText)=0))
  //$methodName:=ST_GetWord ($itemText;2;";")
  //aMethodNames{0}:=$methodName
  //AT_SearchArray (->aMethodNames;">>")
  //If (Size of array(DA_Return)>1)
  //ARRAY TEXT(distinctMethods;0)
  //For ($i;1;Size of array(DA_Return))
  //APPEND TO ARRAY(distinctMethods;aMethodNames{DA_Return{$i}})
  //End for 
  //ARRAY POINTER(◊aChoicePtrs;0)
  //ARRAY POINTER(◊aChoicePtrs;1)
  //◊aChoicePtrs{1}:=->distinctMethods
  //TBL_ShowChoiceList (0;"Seleccione el método";1)
  //If (ok=1)
  //$methodName:=distinctMethods{choiceIdx}
  //Else 
  //$methodName:=""
  //End if 
  //ARRAY TEXT(distinctMethods;0)
  //Else 
  //If (Size of array(DA_Return)=0)
  //$methodName:=""
  //Else 
  //$methodName:=aMethodNames{DA_Return{1}}
  //End if 
  //End if 
  //
  //If ($methodName="")
  //$methodName:="Método"
  //CD_Dlog (0;"Método inexistente.\r\rIngrese un nombre de método válido.")
  //End if 
  //End if 
  //XS_Settings ("SaveServiceMenuItems")
  //XS_ChangeMethodInAllServicesBlo ($ModuleRef;$selected;$methodName)
  //End if 
  //: (Form event=On Drop )
  //$dropPos:=Drop position
  //$selected:=Selected list items(Self->)
  //GET LIST ITEM(hl_modules;Selected list items(hl_modules);$ModuleRef;$itemText)
  //XS_MoveInAllServicesBlobs ($ModuleRef;$selected;$dropPos)
  //End case 
  //
  //$iconRef:=alXS_ExecObjects_IconRef{alXS_ExecObjects_IconRef}
  //If ($iconRef>0)
  //  `GET PICTURE FROM LIBRARY($iconRef;vp_Icon)
  //vl_CurrentIconRef:=$iconRef
  //SET FORMAT(*;"bPreviewButton";"1;4;?"+String($iconRef)+";65;30")
  //  `SET FORMAT(*;"bPreviewButton";"1;4;?"+"vp_Icon"+";65;30")
  //SET VISIBLE(*;"bPreviewButton@";True)
  //GET OBJECT RECT(bPreviewButton;$left;$top;$right;$bottom)
  //IT_SetObjectRect (->bPreviewButton;$left;$top;$left+32;$top+32)
  //Else 
  //vl_CurrentIconRef:=0
  //SET VISIBLE(*;"bPreviewButton@";False)
  //End if 