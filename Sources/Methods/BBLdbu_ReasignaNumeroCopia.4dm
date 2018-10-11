//%attributes = {}
  //BBLdbu_ReasignaNumeroCopia

ALL RECORDS:C47([BBL_Items:61])
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([BBL_Items:61];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([BBL_Items:61])
	GOTO RECORD:C242([BBL_Items:61];$aRecNums{$i})
	QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1)
	ORDER BY:C49([BBL_Registros:66];[BBL_Registros:66]Número_de_copia:2;>)
	ARRAY LONGINT:C221($aRecNumRegistroBBL;0)
	LONGINT ARRAY FROM SELECTION:C647([BBL_Registros:66];$aRecNumRegistroBBL;"")
	[BBL_Items:61]UltimoNumeroDeCopia:49:=0
	[BBL_Items:61]Copias:24:=Records in selection:C76([BBL_Registros:66])
	QUERY SELECTION:C341([BBL_Registros:66];[BBL_Registros:66]StatusID:34=Disponible)
	[BBL_Items:61]Copias_disponibles:43:=Records in selection:C76([BBL_Registros:66])
	SAVE RECORD:C53([BBL_Items:61])
	For ($iNumCopia;1;Size of array:C274($aRecNumRegistroBBL))
		READ WRITE:C146([BBL_Registros:66])
		GOTO RECORD:C242([BBL_Registros:66];$aRecNums{$i})
		[BBL_Registros:66]Número_de_copia:2:=$iNumCopia
		SAVE RECORD:C53([BBL_Registros:66])
	End for 
End for 
