ARRAY BOOLEAN:C223(abACT_PrintItem;0)
ARRAY PICTURE:C279(apACT_PrintItem;0)
ARRAY TEXT:C222(at_anotaciones;0)

READ ONLY:C145([Alumnos_Anotaciones:11])

ALL RECORDS:C47([Alumnos_Anotaciones:11])
ORDER BY:C49([Alumnos_Anotaciones:11]Motivo:3;>)
DISTINCT VALUES:C339([Alumnos_Anotaciones:11]Motivo:3;at_anotaciones)

AT_RedimArrays (Size of array:C274(at_anotaciones);->abACT_PrintItem;->apACT_PrintItem)
SORT ARRAY:C229(at_anotaciones;apACT_PrintItem;abACT_PrintItem;>)

dummyBoolean:=True:C214
C_PICTURE:C286(dummyPict)
GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";dummyPict)

AT_Populate (->apACT_PrintItem;->dummyPict)
AT_Populate (->abACT_PrintItem;->dummyBoolean)

AL_UpdateArrays (xALP_ItemsInforme;-2)
AL_UpdateArrays (xALP_ItemsInforme;-1)