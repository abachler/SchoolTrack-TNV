C_LONGINT:C283($col;$line)
LISTBOX GET CELL POSITION:C971(lb_Efemerides;$col;$line)
If ($line>0)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
	QUERY:C277([xxSTR_MetaReligionValues:164];[xxSTR_MetaReligionValues:164]ID_Efemeride:1=aIDs{$line})
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($recs=0)
		READ WRITE:C146([xxSTR_MetaReligionDef:165])
		QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]ID:1=aIDs{$line})
		DELETE RECORD:C58([xxSTR_MetaReligionDef:165])
		KRL_UnloadReadOnly (->[xxSTR_MetaReligionDef:165])
		AT_Delete ($line;1;->aRelMetaDef;->aIDs;->aIndexMeta)
		For ($i;1;Size of array:C274(aIndexMeta))
			aIndexMeta{$i}:=$i
		End for 
	Else 
		$r:=CD_Dlog (0;__ ("Hay ")+String:C10($recs)+__ (" registros que tienen almacenada una fecha para esta efeméride. Si la elimina dichas fechas se perderán. ¿Desea proseguir?");__ ("");__ ("Si");__ ("No"))
		If ($r=1)
			READ WRITE:C146([xxSTR_MetaReligionValues:164])
			QUERY:C277([xxSTR_MetaReligionValues:164];[xxSTR_MetaReligionValues:164]ID_Efemeride:1=aIDs{$line})
			DELETE SELECTION:C66([xxSTR_MetaReligionValues:164])
			KRL_UnloadReadOnly (->[xxSTR_MetaReligionValues:164])
			READ WRITE:C146([xxSTR_MetaReligionDef:165])
			QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]ID:1=aIDs{$line})
			DELETE RECORD:C58([xxSTR_MetaReligionDef:165])
			KRL_UnloadReadOnly (->[xxSTR_MetaReligionDef:165])
			AT_Delete ($line;1;->aRelMetaDef;->aIDs;->aIndexMeta)
			For ($i;1;Size of array:C274(aIndexMeta))
				aIndexMeta{$i}:=$i
			End for 
		End if 
	End if 
End if 
LISTBOX SELECT ROW:C912(lb_Efemerides;0;lk remove from selection:K53:3)
OBJECT SET ENABLED:C1123(Self:C308->;False:C215)

  //AL_ExitCell (xALP_Efemerides)
  //$line:=AL_GetLine (xALP_Efemerides)
  //If ($line>0)
  //SET QUERY DESTINATION(Into variable;$recs)
  //QUERY([xxSTR_MetaReligionValues];[xxSTR_MetaReligionValues]ID_Efemeride=aIDs{$line})
  //SET QUERY DESTINATION(Into current selection)
  //If ($recs=0)
  //READ WRITE([xxSTR_MetaReligionDef])
  //QUERY([xxSTR_MetaReligionDef];[xxSTR_MetaReligionDef]ID=aIDs{$line})
  //DELETE RECORD([xxSTR_MetaReligionDef])
  //KRL_UnloadReadOnly (->[xxSTR_MetaReligionDef])
  //AL_UpdateArrays (xALP_Efemerides;0)
  //AT_Delete ($line;1;->aRelMetaDef;->aIDs;->aIndexMeta)
  //For ($i;1;Size of array(aIndexMeta))
  //aIndexMeta{$i}:=$i
  //End for 
  //AL_UpdateArrays (xALP_Efemerides;-2)
  //Else 
  //$r:=CD_Dlog (0;__ ("Hay ")+String($recs)+__ (" registros que tienen almacenada una fecha para esta efeméride. Si la elimina dichas fechas se perderán. ¿Desea proseguir?");__ ("");__ ("Si");__ ("No"))
  //If ($r=1)
  //READ WRITE([xxSTR_MetaReligionValues])
  //QUERY([xxSTR_MetaReligionValues];[xxSTR_MetaReligionValues]ID_Efemeride=aIDs{$line})
  //DELETE SELECTION([xxSTR_MetaReligionValues])
  //KRL_UnloadReadOnly (->[xxSTR_MetaReligionValues])
  //READ WRITE([xxSTR_MetaReligionDef])
  //QUERY([xxSTR_MetaReligionDef];[xxSTR_MetaReligionDef]ID=aIDs{$line})
  //DELETE RECORD([xxSTR_MetaReligionDef])
  //KRL_UnloadReadOnly (->[xxSTR_MetaReligionDef])
  //AL_UpdateArrays (xALP_Efemerides;0)
  //AT_Delete ($line;1;->aRelMetaDef;->aIDs;->aIndexMeta)
  //For ($i;1;Size of array(aIndexMeta))
  //aIndexMeta{$i}:=$i
  //End for 
  //AL_UpdateArrays (xALP_Efemerides;-2)
  //End if 
  //End if 
  //End if 
  //AL_SetLine (xALP_Efemerides;0)
  //DISABLE BUTTON(Self->)