dummyBoolean:=True:C214
C_PICTURE:C286(dummyPict)
GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";dummyPict)
AT_Populate (->apACT_PrintItem2;->dummyPict)
AT_Populate (->abACT_PrintItem2;->dummyBoolean)
AL_UpdateArrays (xALP_camposop;-1)
$anyoneSelected:=Find in array:C230(abACT_PrintItem2;True:C214)
IT_SetButtonState (($anyoneSelected#-1);->bGo)