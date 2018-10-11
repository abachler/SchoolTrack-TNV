//%attributes = {}
  // dhVS_SetSpecialTitles()
  // Por: Alberto Bachler: 08/03/13, 16:09:30
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_indiceElemento)

ARRAY LONGINT:C221($al_numeroCampos;0)
ARRAY TEXT:C222($at_nombreCampos;0)



LOC_LoadIdenNacionales 

  //cambio de los nombres de los campos
GET FIELD TITLES:C804([Alumnos:2];$at_nombreCampos;$al_numeroCampos)
$l_indiceElemento:=Find in array:C230($al_numeroCampos;Field:C253(->[Alumnos:2]RUT:5))
If ($l_indiceElemento>0)
	$at_nombreCampos{$l_indiceElemento}:=<>at_IDNacional_Names{1}
End if 
$l_indiceElemento:=Find in array:C230($al_numeroCampos;Field:C253(->[Alumnos:2]IDNacional_2:71))
If ($l_indiceElemento>0)
	$at_nombreCampos{$l_indiceElemento}:=<>at_IDNacional_Names{2}
End if 
$l_indiceElemento:=Find in array:C230($al_numeroCampos;Field:C253(->[Alumnos:2]IDNacional_3:70))
If ($l_indiceElemento>0)
	$at_nombreCampos{$l_indiceElemento}:=<>at_IDNacional_Names{3}
End if 
SET FIELD TITLES:C602([Alumnos:2];$at_nombreCampos;$al_numeroCampos)

GET FIELD TITLES:C804([Personas:7];$at_nombreCampos;$al_numeroCampos)
$l_indiceElemento:=Find in array:C230($al_numeroCampos;Field:C253(->[Personas:7]RUT:6))
If ($l_indiceElemento>0)
	$at_nombreCampos{$l_indiceElemento}:=<>at_IDNacional_Names{1}
End if 
$l_indiceElemento:=Find in array:C230($al_numeroCampos;Field:C253(->[Personas:7]IDNacional_2:37))
If ($l_indiceElemento>0)
	$at_nombreCampos{$l_indiceElemento}:=<>at_IDNacional_Names{2}
End if 
$l_indiceElemento:=Find in array:C230($al_numeroCampos;Field:C253(->[Personas:7]IDNacional_3:38))
If ($l_indiceElemento>0)
	$at_nombreCampos{$l_indiceElemento}:=<>at_IDNacional_Names{3}
End if 
SET FIELD TITLES:C602([Personas:7];$at_nombreCampos;$al_numeroCampos)

GET FIELD TITLES:C804([Profesores:4];$at_nombreCampos;$al_numeroCampos)
$l_indiceElemento:=Find in array:C230($al_numeroCampos;Field:C253(->[Profesores:4]RUT:27))
If ($l_indiceElemento>0)
	$at_nombreCampos{$l_indiceElemento}:=<>at_IDNacional_Names{1}
End if 
$l_indiceElemento:=Find in array:C230($al_numeroCampos;Field:C253(->[Profesores:4]IDNacional_2:42))
If ($l_indiceElemento>0)
	$at_nombreCampos{$l_indiceElemento}:=<>at_IDNacional_Names{2}
End if 
$l_indiceElemento:=Find in array:C230($al_numeroCampos;Field:C253(->[Profesores:4]IDNacional_3:43))
If ($l_indiceElemento>0)
	$at_nombreCampos{$l_indiceElemento}:=<>at_IDNacional_Names{3}
End if 
SET FIELD TITLES:C602([Profesores:4];$at_nombreCampos;$al_numeroCampos)

