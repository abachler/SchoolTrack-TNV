//%attributes = {}
  //ACTbol_MassivePrinting

For ($i;1;Size of array:C274(aACT_Ptrs))
	If (abACT_PrintBol{$i})
		CREATE SELECTION FROM ARRAY:C640([ACT_Boletas:181];aACT_Ptrs{$i}->)
		CREATE SET:C116([ACT_Boletas:181];"Bols2Print")
		If (alACT_CatIDBol{$i}=-100)
			ACTbol_PrintBoletasVR ("Bols2Print";True:C214;alACT_DocIDBol{$i};True:C214;False:C215;alACT_DesdeBol{$i})
		Else 
			ACTbol_PrintBoletasVR ("Bols2Print";True:C214;alACT_DocIDBol{$i};False:C215;False:C215;alACT_DesdeBol{$i})
		End if 
		CLEAR SET:C117("Bols2Print")
	End if 
End for 