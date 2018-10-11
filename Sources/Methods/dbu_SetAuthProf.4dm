//%attributes = {}
  //dbu_SetAuthProf

QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;aText1)
AT_DistinctsArrayValues (->aText1)
SF_ClearSubtable (->[Profesores:4]Asignaturas:13)
SF_Array2SubTable (->[Profesores:4]Asignaturas:13;->aText1;->[Profesores]Asignaturas'Asignatura)
[Profesores:4]Apellidos_y_nombres:28:=Replace string:C233([Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4+" "+[Profesores:4]Nombres:2;"  ";" ")
[Profesores:4]Iniciales:29:=ST_Uppercase (Substring:C12([Profesores:4]Nombres:2;1;1)+Substring:C12([Profesores:4]Apellido_paterno:3;1;1)+Substring:C12([Profesores:4]Apellido_materno:4;1;1))
[Profesores:4]Nombre_comun:21:=CTRY_CL_GetShortName ([Profesores:4]Nombres:2;[Profesores:4]Apellido_paterno:3;[Profesores:4]Apellido_materno:4)