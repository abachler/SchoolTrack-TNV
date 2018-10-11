//%attributes = {}
  //ADTsq_HermanosEnColegio


If (IT_AltKeyIsDown )
	USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(->[ADT_Candidatos:49])))
Else 
	ALL RECORDS:C47([ADT_Candidatos:49])
End if 
ARRAY LONGINT:C221($aFamIDs;0)
ARRAY LONGINT:C221($aRNCandidatos;0)
ARRAY LONGINT:C221($RNConHermano;0)
LONGINT ARRAY FROM SELECTION:C647([ADT_Candidatos:49];$aRNCandidatos;"")
SELECTION TO ARRAY:C260([ADT_Candidatos:49]Familia_numero:30;$aFamIDs)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando postulantes con hermanos en colegio..."))
For ($i;1;Size of array:C274($aRNCandidatos))
	QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=$aFamIDs{$i};*)
	QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29>=<>al_NumeroNivelRegular{1};*)
	QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29<=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)})
	If (Records in selection:C76([Alumnos:2])>0)
		INSERT IN ARRAY:C227($RNConHermano;Size of array:C274($RNConHermano)+1;1)
		$RNConHermano{Size of array:C274($RNConHermano)}:=$aRNCandidatos{$i}
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRNCandidatos))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
CREATE SELECTION FROM ARRAY:C640([ADT_Candidatos:49];$RNConHermano;"")
UNLOAD RECORD:C212([ADT_Candidatos:49])
UNLOAD RECORD:C212([Alumnos:2])