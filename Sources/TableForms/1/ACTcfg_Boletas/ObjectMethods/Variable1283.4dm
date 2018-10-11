AL_ExitCell (xALP_CatsDT)
_O_DISABLE BUTTON:C193(bDelCat)
AL_UpdateArrays (xALP_CatsDT;0)
AT_Insert (1;1;->atACT_Categorias;->alACT_IDsCats;->abACT_ReqDatos;->apACT_ReqDatos;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento)
$nextID:=Num:C11(PREF_fGet (0;"ACT_CatsDTNextID";"1"))
alACT_IDsCats{1}:=$nextID
PREF_Set (0;"ACT_CatsDTNextID";String:C10($nextID+1))
abACT_ReqDatos{1}:=False:C215
GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ReqDatos{1})
If (Size of array:C274(abACT_PorDefecto)=1)
	GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_PorDefecto{1})
	abACT_PorDefecto{1}:=True:C214
End if 

  //20130210 RCH Requerimiento Aleman Pto Montt
If (<>gCountryCode="mx")
	GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_EmiteAfectoExento{1})
	abACT_EmiteAfectoExento{1}:=True:C214
Else 
	GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_EmiteAfectoExento{1})
	abACT_EmiteAfectoExento{1}:=False:C215
End if 

AL_UpdateArrays (xALP_CatsDT;-2)
AL_SetRowColor (xALP_CatsDT;1;"";4;"";0)
GOTO OBJECT:C206(xALP_CatsDT)
AL_GotoCell (xALP_CatsDT;2;1)
xALPSet_ACT_TiposdeDoc 