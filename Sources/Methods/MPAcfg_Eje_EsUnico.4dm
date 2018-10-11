//%attributes = {}
  // MPAcfg_Eje_EsUnico <-ejeEsUnico: Boolean
  // Determina si un eje con el mismo nombre existe en la misma área 
  // y en las mismas etapas
  //
  // <-ejeEsUnico
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 19/06/12, 15:57:12
  // ---------------------------------------------
C_BOOLEAN:C305($0)
C_BOOLEAN:C305($0)

_O_C_INTEGER:C282($i_ejesDuplicados)
C_LONGINT:C283($i;$l_BitNiveles;$l_Duplicados;$l_IdArea;$l_IdEje)
C_TEXT:C284($t_Enunciado)

ARRAY LONGINT:C221($al_BitNiveles;0)

If (False:C215)
	C_BOOLEAN:C305(MPAcfg_Eje_EsUnico ;$0)
End if 

  // CÓDIGO

$l_IdEje:=[MPA_DefinicionEjes:185]ID:1
$l_IdArea:=[MPA_DefinicionEjes:185]ID_Area:2
$t_Enunciado:=[MPA_DefinicionEjes:185]Nombre:3
$l_BitNiveles:=[MPA_DefinicionEjes:185]BitsNiveles:20
$0:=True:C214

PUSH RECORD:C176([MPA_DefinicionEjes:185])

QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID:1#$l_IdEje;*)
QUERY:C277([MPA_DefinicionEjes:185]; & [MPA_DefinicionEjes:185]ID_Area:2=$l_IdArea;*)
QUERY:C277([MPA_DefinicionEjes:185]; & ;[MPA_DefinicionEjes:185]Nombre:3=$t_Enunciado)

$l_Duplicados:=0
SELECTION TO ARRAY:C260([MPA_DefinicionEjes:185]BitsNiveles:20;$al_BitNiveles)
For ($i_ejesDuplicados;1;Size of array:C274($al_BitNiveles))
	For ($i;1;24)
		If (($l_BitNiveles ?? $i) & ($al_BitNiveles{$i_ejesDuplicados} ?? $i))
			$l_Duplicados:=$l_Duplicados+1
		End if 
	End for 
End for 

POP RECORD:C177([MPA_DefinicionEjes:185])
ONE RECORD SELECT:C189([MPA_DefinicionEjes:185])


If ($l_Duplicados>0)
	$0:=False:C215
End if 


