//%attributes = {}
  // PICTLib_ClearLibrary()
  //
  //
  // creado por: Alberto Bachler Klein: 01-09-16, 11:52:55
  // -----------------------------------------------------------
C_LONGINT:C283($i)

ARRAY LONGINT:C221($al_idImagenes;0)
ARRAY TEXT:C222($at_nombreImagenes;0)

PICTURE LIBRARY LIST:C564($al_idImagenes;$at_nombreImagenes)
For ($i;1;Size of array:C274($al_idImagenes))
	REMOVE PICTURE FROM LIBRARY:C567($al_idImagenes{$i})
End for 