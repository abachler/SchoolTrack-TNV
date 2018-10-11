

If ([BBL_Thesaurus:68]Materia:13#"")
	For ($i;Size of array:C274(at_CrossRefWord);1;-1)
		$t_termino:=at_CrossRefWord{$i}
		$l_indexTipoRefCruzada:=Find in array:C230(at_popCrossRefType;at_CrossRefType{$i})
		Case of 
			: (at_CrossRefWord{$i}="")
				AT_Delete ($i;1;->at_CrossRefWord;->at_CrossRefType)
			: (at_CrossRefWord{$i}="")
				AT_Delete ($i;1;->at_CrossRefWord;->at_CrossRefType)
			Else 
				$t_TipoRefCruzada:=at_popCrossRefType{$l_indexTipoRefCruzada}
				at_CrossRefWord{$i}:="["+String:C10($l_indexTipoRefCruzada;"00")+"]"+at_CrossRefWord{$i}
		End case 
	End for 
	If (Find in array:C230(at_CrossRefWord;"[04]@")>0)
		[BBL_Thesaurus:68]NoUsar:10:=True:C214
	Else 
		[BBL_Thesaurus:68]NoUsar:10:=False:C215
	End if 
	
	SF_ClearSubtable (->[BBL_Thesaurus:68]CrossRefs:3)
	SF_Array2SubTable (->[BBL_Thesaurus:68]CrossRefs:3;->at_CrossRefWord;->[BBL_Thesaurus]CrossRefs'References)
	SAVE RECORD:C53([BBL_Thesaurus:68])
	$l_recNum:=Record number:C243([BBL_Thesaurus:68])
	
	$xRefEnd:=[BBL_Thesaurus:68]Materia:13
	$semanticField:=[BBL_Thesaurus:68]Campo semántico:1
	For ($i;1;Size of array:C274(at_CrossRefWord))
		$typeOrigine:=Num:C11(Substring:C12(at_CrossRefWord{$i};2;2))
		$keyword:=Substring:C12(at_CrossRefWord{$i};5)
		Case of 
			: ($typeOrigine=1)  //termino generico
				$xReftype:=2  //termino especifico
			: ($typeOrigine=2)  //termino especifico
				$xReftype:=1  //termino generico
			: ($typeOrigine=3)  //termino asociado
				$xReftype:=3  //termino asociado
			: ($typeOrigine=4)  //utilizar
				$xReftype:=5  //utilizado para
			: ($typeOrigine=5)  //utilizado para
				$xReftype:=4  //utilizar
			Else 
				$xRefType:=0
		End case 
		If ($xReftype>0)
			$xWord:="["+String:C10($xRefType;"00")+"]"+$xRefEnd
			QUERY:C277([BBL_Thesaurus:68];[BBL_Thesaurus:68]Materia:13=$keyword)
			If (Records in selection:C76([BBL_Thesaurus:68])=0)
				CREATE RECORD:C68([BBL_Thesaurus:68])
				[BBL_Thesaurus:68]Materia:13:=$keyword
				[BBL_Thesaurus:68]Campo semántico:1:=$semanticField
			End if 
			If ($xRefType=4)
				[BBL_Thesaurus:68]NoUsar:10:=True:C214
			End if 
			_O_QUERY SUBRECORDS:C108([BBL_Thesaurus:68]CrossRefs:3;[BBL_Thesaurus]CrossRefs'References=$xWord)
			If (_O_Records in subselection:C7([BBL_Thesaurus:68]CrossRefs:3)=0)
				_O_CREATE SUBRECORD:C72([BBL_Thesaurus:68]CrossRefs:3)
				[BBL_Thesaurus]CrossRefs'References:=$xWord
			End if 
			SAVE RECORD:C53([BBL_Thesaurus:68])
		End if 
	End for 
	ACCEPT:C269
	GOTO RECORD:C242([BBL_Thesaurus:68];$l_recNum)
Else 
	$r:=CD_Dlog (0;__ ("Complete por favor el campos Materia antes de guardar."))
End if 
