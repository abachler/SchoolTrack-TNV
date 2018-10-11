//%attributes = {}
SN3_InitPubVariables 
For ($i;1;Size of array:C274(<>al_NumeroNivelesSchoolNet))
	SN3_SavePubConfig (<>al_NumeroNivelesSchoolNet{$i};False:C215)
End for 