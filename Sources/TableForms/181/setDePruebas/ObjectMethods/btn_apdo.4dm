  //READ ONLY([Personas])
  //ALL RECORDS([Personas])

READ ONLY:C145([ACT_Terceros:138])
ALL RECORDS:C47([ACT_Terceros:138])

ARRAY TEXT:C222(atACT_NombreApdo;0)
ARRAY LONGINT:C221(alACT_IDApdo;0)

SELECTION TO ARRAY:C260([ACT_Terceros:138]Nombre_Completo:9;atACT_NombreApdo;[ACT_Terceros:138]Id:1;alACT_IDApdo)

SORT ARRAY:C229(atACT_NombreApdo;alACT_IDApdo;>)

ARRAY POINTER:C280(<>aChoicePtrs;0)
ARRAY POINTER:C280(<>aChoicePtrs;2)
C_POINTER:C301($ptr)
<>aChoicePtrs{1}:=->atACT_NombreApdo
<>aChoicePtrs{2}:=->alACT_IDApdo
TBL_ShowChoiceList (1;"Seleccione un apoderado...";0)
If (ok=1)
	vtACT_apoderadoNombre:=atACT_NombreApdo{choiceIdx}
	  //vlACT_apoderadoID:=alACT_IDApdo{choiceIdx}
	vlACT_terceroID:=alACT_IDApdo{choiceIdx}
End if 