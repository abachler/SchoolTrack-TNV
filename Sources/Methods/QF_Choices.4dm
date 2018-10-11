//%attributes = {}
  //QF_Choices

If (atVS_QFAssociatedList{atVS_QFSourceFieldAlias}#"")
	vb_ClairvoyanceON:=True:C214
	$listPtr:=Get pointer:C304(atVS_QFAssociatedList{atVS_QFSourceFieldAlias})
	
	Case of 
		: (Size of array:C274($listPtr->)=0)
			OBJECT SET ENTERABLE:C238(vtQRY_ValorLiteral;True:C214)
			OBJECT GET COORDINATES:C663(vtQRY_ValorLiteral;$left;$top;$right;$bottom)
			If (($right-$left)=176)
				OBJECT MOVE:C664(vtQRY_ValorLiteral;0;0;18;0)
			End if 
			OBJECT SET VISIBLE:C603(*;"pPopIndic";False:C215)
			OBJECT SET VISIBLE:C603(PopChoice;False:C215)
			ARRAY TEXT:C222(popChoice;0)
			
			
		: (Size of array:C274($listPtr->)>0)
			OBJECT SET ENTERABLE:C238(vtQRY_ValorLiteral;True:C214)
			OBJECT GET COORDINATES:C663(vtQRY_ValorLiteral;$left;$top;$right;$bottom)
			If (($right-$left)=194)
				OBJECT MOVE:C664(vtQRY_ValorLiteral;0;0;-18;0)
			End if 
			COPY ARRAY:C226($listPtr->;PopChoice)
			OBJECT SET VISIBLE:C603(PopChoice;True:C214)
			OBJECT SET VISIBLE:C603(*;"pPopIndic";True:C214)
			COPY ARRAY:C226($listPtr->;PopChoice)
			ARRAY TEXT:C222(popChoice;0)
			ARRAY TEXT:C222(popChoice;Size of array:C274($listPtr->))
			For ($i;1;Size of array:C274($listPtr->))
				popChoice{$i}:=$listPtr->{$i}
			End for 
	End case 
	
	
Else 
	vb_ClairvoyanceON:=False:C215
	OBJECT SET ENTERABLE:C238(vtQRY_ValorLiteral;True:C214)
	OBJECT GET COORDINATES:C663(vtQRY_ValorLiteral;$left;$top;$right;$bottom)
	If (($right-$left)=176)
		OBJECT MOVE:C664(vtQRY_ValorLiteral;0;0;18;0)
	End if 
	OBJECT SET VISIBLE:C603(*;"pPopIndic";False:C215)
	OBJECT SET VISIBLE:C603(PopChoice;False:C215)
End if 

