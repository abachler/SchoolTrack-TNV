//%attributes = {}
  // Método: MData_Edit_OnClickEvent
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 29/10/09, 11:37:57
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal


$areaRef:=$1
Case of 
	: ((alProEvt=AL Single click event) | (alProEvt=AL Single Control Click))
		$menuText:=""
		$column:=AL_GetColumn ($areaRef)
		$row:=AL_GetClickedRow ($areaRef)
		$save:=False:C215
		If ($column=2)
			Case of 
				: (atMD_ValueList{$row}#"")
					ARRAY TEXT:C222($aTextMenu;0)
					AT_Text2Array (->$aTextMenu;atMD_ValueList{$row};"\r")
					$menuText:=Replace string:C233(atMD_ValueList{$row};"\r";";")
					$el:=0
					If (atMD_TextValues{$row}#"")
						$el:=Find in array:C230($aTextMenu;atMD_TextValues{$row})
					End if 
					If ($el<0)
						$el:=0
					End if 
					
					
				: (alMD_FieldType{$row}=Is date:K8:7)
					$menuText:=""
					$date:=DT_PopCalendar 
					If ($date#!00-00-00!)
						atMD_TextValues{$row}:=String:C10($date;7)
						$save:=True:C214
					End if 
					
				: (alMD_FieldType{$row}=Is boolean:K8:9)
					$menuText:="Si;No"
					Case of 
						: (atMD_TextValues{$row}="Si")
							$el:=1
						: (atMD_TextValues{$row}="No")
							$el:=2
						: (atMD_TextValues{$row}="")
							$el:=0
					End case 
			End case 
			
			  //***** 20110504 RCH Se agrega opcion para eliminar datos ingresados...
			  //If ($menuText#"")
			  //$result:=Pop up menu($menuText;$el)
			  //If ($result>0)
			  //atMD_TextValues{$row}:=ST_GetWord ($menuText;$result;";")
			  //$save:=True
			  //End if 
			  //End if 
			If ($menuText#"")
				$menuText:=$menuText+";(-;"+__ ("Borrar")
				$result:=Pop up menu:C542($menuText;$el)
				If ($result>0)
					If ($result=ST_CountWords ($menuText;0;";"))
						atMD_TextValues{$row}:=""
					Else 
						atMD_TextValues{$row}:=ST_GetWord ($menuText;$result;";")
					End if 
					$save:=True:C214
				End if 
			End if 
			  //***** 20110504 RCH 
			
			If ($save)
				AL_UpdateArrays ($areaRef;-2)
				If (atMD_RecNum{$row}<0)
					CREATE RECORD:C68([MDATA_RegistrosDatosLocales:145])
				Else 
					KRL_GotoRecord (->[MDATA_RegistrosDatosLocales:145];atMD_RecNum{$row};True:C214)
				End if 
				[MDATA_RegistrosDatosLocales:145]Field_UUID:1:=atMD_FieldUUID{$row}
				[MDATA_RegistrosDatosLocales:145]Agno:4:=<>gYear
				[MDATA_RegistrosDatosLocales:145]TableNumber:2:=Table:C252(vyMD_FieldPointer)
				[MDATA_RegistrosDatosLocales:145]ID_registro:3:=vyMD_FieldPointer->
				[MDATA_RegistrosDatosLocales:145]Valor_Texto:10:=atMD_TextValues{$row}
				SAVE RECORD:C53([MDATA_RegistrosDatosLocales:145])
				KRL_UnloadReadOnly (->[MDATA_RegistrosDatosLocales:145])
			End if 
		End if 
End case 





