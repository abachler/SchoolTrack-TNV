//%attributes = {}
  // Método: xALCB_EX_MetaDatosLocales
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 26/10/09, 10:45:06
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$row;$col)

  // Código principal



If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_MetaDatos;$Col;$Row)
	If (AL_GetCellMod (xALP_MetaDatos)=1)
		$stop:=False:C215
		Case of 
			: ((alMD_FieldType{$row}=Is text:K8:3) & ((aiMD_FieldLength{$row}<Length:C16(atMD_TextValues{$row}))))
				CD_Dlog (0;__ ("El largo del texto no puede ser superior a ")+String:C10(aiMD_FieldLength{$row}))
				atMD_TextValues{$row}:=Substring:C12(atMD_TextValues{$row};1;Length:C16(atMD_TextValues{$row}))
				$stop:=True:C214
			: ((alMD_FieldType{$row}=Is real:K8:4) | (alMD_FieldType{$row}=Is longint:K8:6) | (alMD_FieldType{$row}=Is integer:K8:5))
				Case of 
					: ((Num:C11(atMD_TextValues{$row})<arMD_MinimumValue{$row}) & (arMD_MinimumValue{$row}>0))
						CD_Dlog (0;__ ("El valor numérico no puede ser inferior a ")+String:C10(arMD_MinimumValue{$row}))
						atMD_TextValues{$row}:=atMD_TextValues{0}
						$stop:=True:C214
					: ((Num:C11(atMD_TextValues{$row})>arMD_MaximumValue{$row}) & (arMD_MaximumValue{$row}>0))
						CD_Dlog (0;__ ("El valor numérico no puede ser superior a ")+String:C10(arMD_MaximumValue{$row}))
						atMD_TextValues{$row}:=atMD_TextValues{0}
						$stop:=True:C214
				End case 
				
		End case 
		
		If (Not:C34($Stop))
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
		Else 
			AL_GotoCell (xALP_MetaDatos;$Col;$Row)
		End if 
	End if 
End if 





