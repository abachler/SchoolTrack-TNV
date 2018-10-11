dummyBoolean:=False:C215
C_PICTURE:C286(dummyPict)
GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";dummyPict)
AT_Populate (->apACT_PrintItem;->dummyPict)
AT_Populate (->abACT_PrintItem;->dummyBoolean)
AL_UpdateArrays (xALP_estados;-1)
$anyoneSelected:=Find in array:C230(abACT_PrintItem;True:C214)
IT_SetButtonState (($anyoneSelected#-1);->bGo)