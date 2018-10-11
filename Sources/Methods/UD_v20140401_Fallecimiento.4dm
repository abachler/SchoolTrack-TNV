//%attributes = {}
  // UD_v20140401_ListaEstadoCivil()
  // Por: Alberto Bachler K.: 01-04-14, 08:09:27
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_idTermometro;$l_posicionElemento)

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_Elementos;0)
ARRAY TEXT:C222($at_ElementosEstandar;0)

READ WRITE:C146([xShell_List:39])
QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Estado Civil")
BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->$at_Elementos)
$l_posicionElemento:=Find in array:C230($at_Elementos;"Fallecid@")
If ($l_posicionElemento>0)
	If ($at_Elementos{$l_posicionElemento}#"Fallecido(a)")
		$at_Elementos{$l_posicionElemento}:="Fallecido(a)"
	End if 
Else 
	APPEND TO ARRAY:C911($at_Elementos;"Fallecido(a)")
End if 
AT_Text2Array (->$at_ElementosEstandar;[xShell_List:39]DefaultValues:10;"\r")
$l_posicionElemento:=Find in array:C230($at_ElementosEstandar;"Fallecid@")
If ($l_posicionElemento>0)
	If ($at_ElementosEstandar{$l_posicionElemento}#"Fallecido(a)")
		$at_ElementosEstandar{$l_posicionElemento}:="Fallecido(a)"
	End if 
Else 
	APPEND TO ARRAY:C911($at_ElementosEstandar;"Fallecido(a)")
End if 
[xShell_List:39]DefaultValues:10:=AT_array2text (->$at_ElementosEstandar;"\r")
BLOB_Variables2Blob (->[xShell_List:39]Contents:9;0;->$at_Elementos)
SAVE RECORD:C53([xShell_List:39])
KRL_UnloadReadOnly (->[xShell_List:39])


QUERY:C277([Profesores:4];[Profesores:4]Fallecido:70;=True:C214;*)
QUERY:C277([Profesores:4]; | ;[Profesores:4]Estado_civil:18;=;"Fallecid@")
LONGINT ARRAY FROM SELECTION:C647([Profesores:4];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Normalizando estado civil en Profesores...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([Profesores:4])
	GOTO RECORD:C242([Profesores:4];$al_RecNums{$i_registros})
	[Profesores:4]Fallecido:70:=True:C214
	[Profesores:4]Estado_civil:18:="Fallecido(a)"
	SAVE RECORD:C53([Profesores:4])
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[Profesores:4])

QUERY:C277([Personas:7];[Personas:7]Fallecido:88;=True:C214;*)
QUERY:C277([Personas:7]; | ;[Personas:7]Estado_civil:10;=;"Fallecid@")
LONGINT ARRAY FROM SELECTION:C647([Personas:7];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Normalizando estado civil en Relaciones familiares...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([Personas:7])
	GOTO RECORD:C242([Personas:7];$al_RecNums{$i_registros})
	[Personas:7]Fallecido:88:=True:C214
	[Personas:7]Estado_civil:10:="Fallecido(a)"
	SAVE RECORD:C53([Personas:7])
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[Personas:7])

