

$r:=CD_Dlog (0;Replace string:C233(__ ("¿Desea realmente eliminar la referencia a ^0?");__ ("^0");at_CrossRefWord{at_CrossRefWord});__ ("");__ ("Sí");__ ("No"))
If ($r=1)
	$recId:=Record number:C243([BBL_Thesaurus:68])
	$i:=at_CrossRefWord
	$xRefEnd:=sKeyword
	$typeOrigine:=Find in array:C230(at_popCrossRefType;at_CrossRefType{at_CrossRefWord})
	$keyword:=at_CrossRefWord{at_CrossRefWord}
	
	Case of 
		: ($typeOrigine=2)  //termino generico
			$xReftype:=1  //termino especifico
			
		: ($typeOrigine=1)  //termino especifico
			$xReftype:=2  //termino generico
			
		: ($typeOrigine=3)  //termino asociado
			$xReftype:=3  //termino asociado
			
		: ($typeOrigine=5)  //utilizar
			$xReftype:=4  //utilizado para
			
		: ($typeOrigine=4)  //utilizado para
			$xReftype:=5  //utilizar
	End case 
	
	
	$xRefEnd:="["+String:C10($xRefType;"00")+"]"+$xRefEnd
	QUERY:C277([BBL_Thesaurus:68];[BBL_Thesaurus:68]Materia:13=$keyword)
	_O_QUERY SUBRECORDS:C108([BBL_Thesaurus:68]CrossRefs:3;[BBL_Thesaurus]CrossRefs'References=$xRefEnd)
	_O_DELETE SUBRECORD:C96([BBL_Thesaurus:68]CrossRefs:3)
	AL_UpdateArrays (xALP_CrossRefs;0)
	AT_Delete ($i;1;->at_CrossRefWord;->at_CrossRefType)
	AL_UpdateArrays (xALP_CrossRefs;Size of array:C274(at_CrossRefWord))
	at_crossRefWord:=0
	AL_SetLine (xALP_CrossRefs;0)
	GOTO RECORD:C242([BBL_Thesaurus:68];$RecID)
End if 
