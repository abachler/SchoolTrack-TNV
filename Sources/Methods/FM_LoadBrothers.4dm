//%attributes = {}
  //FM_LoadBrothers

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_CuentasCorrientes:175])
QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
ORDER BY:C49([Alumnos:2]nivel_numero:29;>)
SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aBthrName;[Alumnos:2]curso:20;aBthrCurso;[Alumnos:2]numero:1;aBthrID;[Alumnos:2]nivel_numero:29;$aNivel)
ARRAY LONGINT:C221(aBrotherNumber;Size of array:C274(aBthrID))
For ($i;1;Size of array:C274(aBthrID))
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=aBthrID{$i})
	aBrotherNumber{$i}:=[ACT_CuentasCorrientes:175]Numero_Hijo:10
End for 
