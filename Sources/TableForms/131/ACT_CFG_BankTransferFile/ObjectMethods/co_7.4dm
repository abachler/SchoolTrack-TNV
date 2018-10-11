AL_UpdateArrays (xALP_CFG_TranfBancaria;0)
ARRAY TEXT:C222(at_ACTNombreCampoAL;0)
ARRAY BOOLEAN:C223(ab_EnPATAL;0)
ARRAY BOOLEAN:C223(ab_EnPACAL;0)
ARRAY BOOLEAN:C223(ab_EnCUPONERAAL;0)
ARRAY BOOLEAN:C223(ab_EnCONTABILIDADAL;0)
ARRAY LONGINT:C221(al_PosicionAL;0)
at_ACTNombreCampo{0}:="[DP]"
ARRAY LONGINT:C221($DA_Return;0)
AT_SearchArray (->at_ACTNombreCampo;"@";->$DA_Return)
For ($i;1;Size of array:C274($DA_Return))
	AT_Insert (0;1;->at_ACTNombreCampoAL;->ab_EnPATAL;->ab_EnPACAL;->ab_EnCUPONERAAL;->ab_EnCONTABILIDADAL;->al_PosicionAL)
	at_ACTNombreCampoAL{Size of array:C274(at_ACTNombreCampoAL)}:=Substring:C12(at_ACTNombreCampo{$DA_Return{$i}};5)
	ab_EnPATAL{Size of array:C274(ab_EnPATAL)}:=ab_EnPAT{$DA_Return{$i}}
	ab_EnPACAL{Size of array:C274(ab_EnPACAL)}:=ab_EnPAC{$DA_Return{$i}}
	ab_EnCUPONERAAL{Size of array:C274(ab_EnCUPONERAAL)}:=ab_EnCUPONERA{$DA_Return{$i}}
	ab_EnCONTABILIDADAL{Size of array:C274(ab_EnCONTABILIDADAL)}:=ab_EnCONTABILIDAD{$DA_Return{$i}}
	al_PosicionAL{Size of array:C274(al_PosicionAL)}:=$DA_Return{$i}
End for 
SORT ARRAY:C229(at_ACTNombreCampoAL;ab_EnPATAL;ab_EnPACAL;ab_EnCUPONERAAL;ab_EnCONTABILIDADAL;al_PosicionAL;>)
AL_UpdateArrays (xALP_CFG_TranfBancaria;-2)