//%attributes = {}
  //XS_LoadFields

C_LONGINT:C283($table;$1)

ARRAY INTEGER:C220(alXS_Fields_FieldNo;0)
ARRAY TEXT:C222(atXS_Fields_FieldName;0)
ARRAY TEXT:C222(atXS_Fields_FieldAlias;0)
ARRAY BOOLEAN:C223(abXS_Fields_Indexed;0)
ARRAY BOOLEAN:C223(abXS_Fields_CampoOculto;0)
ARRAY REAL:C219(arXS_Fields_AutoformatMode;0)
ARRAY TEXT:C222(atXS_Fields_AssociatedListArray;0)
ARRAY BOOLEAN:C223(abXS_Fields_AutoSeqNumber;0)
ARRAY LONGINT:C221(alXS_Fields_RecNums;0)
ARRAY LONGINT:C221($fieldIDs;0)

If (Count parameters:C259=1)
	$table:=$1
Else 
	$table:=[xShell_Tables:51]NumeroDeTabla:5
End if 


READ WRITE:C146([xShell_Tables:51])
QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$table)
vtXS_TableAlias:=XSvs_nombreTablaLocal_Numero ($table;vtXS_CountryCode;vtXS_LangageCode)

READ WRITE:C146([xShell_Fields:52])
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$table)
ORDER BY:C49([xShell_Fields:52];[xShell_Fields:52]NombreCampo:3;>)
LONGINT ARRAY FROM SELECTION:C647([xShell_Fields:52];alXS_Fields_RecNums;"")
SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;alXS_Fields_FieldNo;[xShell_Fields:52]NombreCampo:3;atXS_Fields_FieldName;[xShell_Fields:52]EsCampoIndexado:6;abXS_Fields_Indexed;[xShell_Fields:52]EsCampoOcultoEnEditores:9;abXS_Fields_CampoOculto;[xShell_Fields:52]EsImportable:13;alXS_Fields_Importable;[xShell_Fields:52]FormatoNombres:15;arXS_Fields_AutoformatMode;[xShell_Fields:52]ListaDeValoresAsociados:11;atXS_Fields_AssociatedListArray;[xShell_Fields:52]AutomaticSequenceNumber:23;abXS_Fields_AutoSeqNumber)
SELECTION TO ARRAY:C260([xShell_Fields:52]ID:24;$fieldIDs)
ARRAY TEXT:C222(atXS_Fields_FieldAlias;Size of array:C274(alXS_Fields_FieldNo))

For ($i;1;Size of array:C274(alXS_Fields_FieldNo))
	atXS_Fields_FieldAlias{$i}:=XSvs_nombreCampoLocal_Numero ($table;$fieldIDs{$i};vtXS_CountryCode;vtXS_LangageCode)
End for 

SORT ARRAY:C229(atXS_Fields_FieldName;alXS_Fields_FieldNo;atXS_Fields_FieldAlias;abXS_Fields_Indexed;abXS_Fields_CampoOculto;alXS_Fields_Importable;arXS_Fields_AutoformatMode;atXS_Fields_AssociatedListArray;abXS_Fields_AutoSeqNumber;alXS_Fields_RecNums;>)