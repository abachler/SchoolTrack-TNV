//%attributes = {}
  //ADTsq_HermanosPostulando


If (IT_AltKeyIsDown )
	USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(->[ADT_Candidatos:49])))
Else 
	ALL RECORDS:C47([ADT_Candidatos:49])
End if 
ARRAY LONGINT:C221(aFamIDs;0)
ARRAY LONGINT:C221($aRNCandidatos;0)
ARRAY LONGINT:C221($RNConHermano;0)
LONGINT ARRAY FROM SELECTION:C647([ADT_Candidatos:49];$aRNCandidatos;"")
SELECTION TO ARRAY:C260([ADT_Candidatos:49]Familia_numero:30;aFamIDs)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando postulantes con hermanos en proceso de postulación..."))
For ($i;1;Size of array:C274($aRNCandidatos))
	aFamIDs{0}:=aFamIDs{$i}
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->aFamIDs;"=";->$DA_Return)
	If (Size of array:C274($DA_Return)>1)
		INSERT IN ARRAY:C227($RNConHermano;Size of array:C274($RNConHermano)+1;1)
		$RNConHermano{Size of array:C274($RNConHermano)}:=$aRNCandidatos{$i}
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRNCandidatos))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
CREATE SELECTION FROM ARRAY:C640([ADT_Candidatos:49];$RNConHermano;"")
UNLOAD RECORD:C212([ADT_Candidatos:49])
AT_Initialize (->aFamIDs)