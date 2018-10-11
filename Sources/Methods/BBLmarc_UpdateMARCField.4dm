//%attributes = {}
  //BBLmarc_UpdateMARCField

If (<>gUsaMARC)
	$fieldPtr:=$1
	
	If (Form event:C388=On Data Change:K2:15)
		Case of 
			: ((Type:C295($fieldPtr->)=Is alpha field:K8:1) | (Type:C295($fieldPtr->)=Is string var:K8:2) | (Type:C295($fieldPtr->)=Is text:K8:3))
				$condition:=($fieldPtr->#"")
				$dato:=$fieldPtr->
			: ((Type:C295($fieldPtr->)=Is longint:K8:6) | (Type:C295($fieldPtr->)=Is real:K8:4) | (Type:C295($fieldPtr->)=Is integer:K8:5))
				$condition:=True:C214
				$dato:=String:C10($fieldPtr->)
			: (Type:C295($fieldPtr->)=Is date:K8:7)
				$condition:=($fieldPtr->#!00-00-00!)
				$dato:=String:C10($fieldPtr->;Internal date short:K1:7)
		End case 
		
		$m:=Milliseconds:C459
		$tableNum:=Table:C252($fieldPtr)
		$fieldNum:=Field:C253($fieldPtr)
		
		READ ONLY:C145([xxBBL_MarcRecordStructure:75])
		QUERY:C277([xxBBL_MarcRecordStructure:75];[xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6=$tableNum;*)
		QUERY:C277([xxBBL_MarcRecordStructure:75];[xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7=$fieldNum;*)
		QUERY:C277([xxBBL_MarcRecordStructure:75]; & ;[xxBBL_MarcRecordStructure:75]Equivalencia_Principal:10=True:C214)
		
		READ WRITE:C146([BBL_ItemMarcFields:205])
		$key:=String:C10($tableNum)+"."+String:C10($fieldNum)+"."+String:C10([BBL_Items:61]Numero:1)+"."+[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8
		$recNum:=Find in field:C653([BBL_ItemMarcFields:205]LLaveItem:10;$key)
		If ($recNum<0)
			If ($condition)
				CREATE RECORD:C68([BBL_ItemMarcFields:205])
				[BBL_ItemMarcFields:205]Dato:6:=$dato
				[BBL_ItemMarcFields:205]ID_Item:1:=[BBL_Items:61]Numero:1
				[BBL_ItemMarcFields:205]FieldRef:2:=Num:C11([xxBBL_MarcRecordStructure:75]FieldNumber:1)
				[BBL_ItemMarcFields:205]SubFieldRef:3:=[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8
				[BBL_ItemMarcFields:205]TableNum:7:=$tableNum
				[BBL_ItemMarcFields:205]FieldNum:8:=$fieldNum
				SAVE RECORD:C53([BBL_ItemMarcFields:205])
				KRL_UnloadReadOnly (->[BBL_ItemMarcFields:205])
			End if 
		Else 
			KRL_GotoRecord (->[BBL_ItemMarcFields:205];$recNum;True:C214)
			If ($condition)
				[BBL_ItemMarcFields:205]Dato:6:=$dato
				SAVE RECORD:C53([BBL_ItemMarcFields:205])
				KRL_UnloadReadOnly (->[BBL_ItemMarcFields:205])
			Else 
				DELETE RECORD:C58([BBL_ItemMarcFields:205])
				KRL_UnloadReadOnly (->[BBL_ItemMarcFields:205])
			End if 
		End if 
	End if 
	
End if 