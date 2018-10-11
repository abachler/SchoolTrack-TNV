//%attributes = {}
  //QF2_Choices
vtQRY_ValorLiteral:=""
If (atVS_QFAssociatedList{atVS_QFSourceFieldAlias}#"")
	vb_ClairvoyanceON:=True:C214
	$listPtr:=Get pointer:C304(atVS_QFAssociatedList{atVS_QFSourceFieldAlias})
	
	Case of 
		: (Size of array:C274($listPtr->)=0)
			OBJECT SET VISIBLE:C603(*;"texto";True:C214)
			OBJECT SET VISIBLE:C603(*;"combo";False:C215)
			OBJECT SET VISIBLE:C603(*;"boolean@";False:C215)
			OBJECT SET ENABLED:C1123(aDelims;True:C214)
		: (Size of array:C274($listPtr->)>0)
			OBJECT SET VISIBLE:C603(*;"texto";False:C215)
			OBJECT SET VISIBLE:C603(*;"combo";True:C214)
			OBJECT SET VISIBLE:C603(*;"boolean@";False:C215)
			OBJECT SET ENABLED:C1123(aDelims;True:C214)
			COPY ARRAY:C226($listPtr->;PopChoice)
			PopChoice{0}:=""
	End case 
Else 
	$fieldPointer:=Field:C253(alVS_QFSourceTableNumber{atVS_QFSourceFieldAlias};alVS_QFSourcefieldNumber{atVS_QFSourceFieldAlias})
	If (Type:C295($fieldPointer->)=Is boolean:K8:9)
		aDelims:=2
		OBJECT SET ENABLED:C1123(aDelims;False:C215)
		OBJECT SET VISIBLE:C603(*;"texto";False:C215)
		OBJECT SET VISIBLE:C603(*;"combo";False:C215)
		OBJECT SET VISIBLE:C603(*;"boolean@";True:C214)
		boolean1:=1
		boolean2:=0
		vtQRY_ValorLiteral:="1"
		$el:=Find in array:C230(ayBWR_FieldPointers;$fieldPointer)
		If ($el>0)
			$format:=atVS_BrowserFormat{$el}
		Else 
			$format:=__ ("Verdadero")+";"+__ ("Falso")
		End if 
		$text1:=ST_GetWord ($format;1;";")
		$text2:=ST_GetWord ($format;2;";")
		OBJECT SET TITLE:C194(*;"boolean1";$text1)
		OBJECT SET TITLE:C194(*;"boolean2";$text2)
	Else 
		OBJECT SET VISIBLE:C603(*;"texto";True:C214)
		OBJECT SET VISIBLE:C603(*;"combo";False:C215)
		OBJECT SET VISIBLE:C603(*;"boolean@";False:C215)
		OBJECT SET ENABLED:C1123(aDelims;True:C214)
	End if 
End if 