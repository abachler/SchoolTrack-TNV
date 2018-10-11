//%attributes = {}
  //VS_BuildIndex

QUERY:C277([xShell_Fields:52];[xShell_Fields:52]EsCampoIndexado:6=True:C214)
SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroTabla:1;$file;[xShell_Fields:52]NumeroCampo:2;$field)
For ($i;1;Size of array:C274($file))
	MESSAGE:C88("Building Index: "+String:C10($i)+"/"+String:C10(Size of array:C274($file)))
	SET INDEX:C344(Field:C253($file{$i};$field{$i})->;True:C214)
End for 