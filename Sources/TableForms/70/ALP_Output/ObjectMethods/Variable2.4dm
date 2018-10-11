WDW_Open (311;118;0;-14000;__ ("Indices"))
FORM SET INPUT:C55([BBL_Index:70];"input")
ADD RECORD:C56([BBL_Index:70];*)
CLOSE WINDOW:C154
If (ok=1)
	ADD TO SET:C119([BBL_Index:70];"indices")
	USE SET:C118("indices")
End if 
AL_UpdateFields (xALP_indices;Records in selection:C76([BBL_Index:70]))