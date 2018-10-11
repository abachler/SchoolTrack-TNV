//%attributes = {}
C_LONGINT:C283($i)

ARRAY TEXT:C222(<>at_caracteresInvalidos;0)

For ($i;0;8)
	APPEND TO ARRAY:C911(<>at_caracteresInvalidos;Char:C90($i))
End for 
APPEND TO ARRAY:C911(<>at_caracteresInvalidos;Char:C90(11))
APPEND TO ARRAY:C911(<>at_caracteresInvalidos;Char:C90(12))
For ($i;14;31)
	APPEND TO ARRAY:C911(<>at_caracteresInvalidos;Char:C90($i))
End for 
APPEND TO ARRAY:C911(<>at_caracteresInvalidos;Char:C90(127))