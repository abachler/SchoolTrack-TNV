//%attributes = {}
  // CFG_STR_Niveles()
  // Por: Alberto Bachler: 09/03/13, 18:14:14
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_elemento;$l_indice;$l_numeroNivel)

ARRAY LONGINT:C221($al_NoNiveles;0)


If (<>aNivel=0)
	READ ONLY:C145([xxSTR_Niveles:6])
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNivelRegular:4=True:C214)
	ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
	$l_elemento:=Find in array:C230(<>aNivNo;[xxSTR_Niveles:6]NoNivel:5)
	If ($l_elemento>0)
		<>aNivel:=$l_elemento
	Else 
		<>aNivel:=1
	End if 
	sNivel:=<>aNivel{<>aNivel}
End if 
$l_numeroNivel:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]Nivel:1;->sNivel;->[xxSTR_Niveles:6]NoNivel:5)
KRL_FindAndLoadRecordByIndex (->[xxSTR_Niveles:6]NoNivel:5;->$l_numeroNivel;True:C214)

  //20141114 ASM ticket 138554 .
If (OK=0)
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNivelRegular:4=True:C214)
	ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
	SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_NoNiveles)
	For ($l_indice;1;Size of array:C274($al_NoNiveles))
		KRL_FindAndLoadRecordByIndex (->[xxSTR_Niveles:6]NoNivel:5;->$al_NoNiveles{$l_indice};True:C214)
		If (OK=1)
			$l_indice:=Size of array:C274($al_NoNiveles)+1
			$l_elemento:=Find in array:C230(<>aNivNo;[xxSTR_Niveles:6]NoNivel:5)
			If ($l_elemento>0)
				<>aNivel:=$l_elemento
			Else 
				<>aNivel:=1
			End if 
			sNivel:=<>aNivel{<>aNivel}
		End if 
	End for 
	
End if 

STR_ResponsableNiveles ("init")

If (OK=1)
	CFG_OpenConfigPanel (->[xxSTR_Niveles:6];"Configuration";1;"Niveles Académicos: "+<>aNivel{<>aNivel})
	KRL_ExecuteEverywhere ("STR_LeeConfiguracion")
Else 
	CD_Dlog (0;__ ("Otro usuario está trabajando en la configuración de niveles.\r\rPor favor intente nuevamente más tarde."))
End if 