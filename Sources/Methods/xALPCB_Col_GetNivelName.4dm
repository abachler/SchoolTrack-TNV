//%attributes = {}
  //xALPCB_Col_GetNivelName

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3;$5;$6;$i;$numeroNivel)
C_TEXT:C284($nivel)
C_POINTER:C301($4)
ARRAY LONGINT:C221($aNivelNo;0)
SELECTION RANGE TO ARRAY:C368($5;$5+$6-1;[Asignaturas_Historico:84]Nivel:4;$aNivelNo)
For ($i;1;Size of array:C274($aNivelNo))
	$numeroNivel:=$aNivelNo{$i}
	$nivel:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$numeroNivel;->[xxSTR_Niveles:6]Nivel:1)
	$4->{$i}:=$nivel
End for 
