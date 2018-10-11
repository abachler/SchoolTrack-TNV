//%attributes = {}
  // UD_v20140313_BBL_UsSistema()
  // Por: Alberto Bachler K.: 13-03-14, 20:16:08
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID:1<0)
ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];$al_RecNums;"")
For ($i;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([BBL_Lectores:72])
	GOTO RECORD:C242([BBL_Lectores:72];$al_RecNums{$i})
	[BBL_Lectores:72]BarCode_SinFormato:38:=""
	BBLpat_GeneraCodigoBarra 
	SAVE RECORD:C53([BBL_Lectores:72])
End for 
KRL_UnloadReadOnly (->[BBL_Lectores:72])




