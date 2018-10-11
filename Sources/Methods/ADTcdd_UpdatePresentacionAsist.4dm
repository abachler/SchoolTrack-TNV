//%attributes = {}
  //ADTcdd_UpdatePresentacionAsist

For ($i;1;Size of array:C274(adPST_PresentDate))
	$secs:=SYS_DateTime2Secs (adPST_PresentDate{$i};alPST_PresentTime{$i})
	QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]secs_Presentación:23=$secs)
	CREATE SET:C116([ADT_Candidatos:49];"Presentacion")
	ARRAY LONGINT:C221(aFams;0)
	AT_DistinctsFieldValues (->[ADT_Candidatos:49]Familia_numero:30;->aFams)
	$acum:=0
	For ($j;1;Size of array:C274(aFams))
		USE SET:C118("Presentacion")
		SET QUERY LIMIT:C395(1)
		QUERY SELECTION:C341([ADT_Candidatos:49];[ADT_Candidatos:49]Familia_numero:30=aFams{$j})
		SET QUERY LIMIT:C395(0)
		$acum:=$acum+[ADT_Candidatos:49]Asistentes_presentación:22
	End for 
	aiPST_Asistentes{$i}:=$acum
	UNLOAD RECORD:C212([ADT_Candidatos:49])
End for 
CLEAR SET:C117("Presentacion")
PST_SaveParameters 