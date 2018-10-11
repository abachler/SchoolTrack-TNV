//%attributes = {}
  // MPAcfg_Dim_EsUnica <-dimensionEsUnica: Boolean
  // Determina si el nombre de la dimension actual es único en el mismo contenedor (eje, area)
  //
  // <-- dimensionEsUnica
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 19/06/12, 15:17:10
  // ---------------------------------------------
C_BOOLEAN:C305($0)

C_LONGINT:C283($i;$i_dimensionesDuplicadas;$l_BitNiveles;$l_Duplicados;$l_IdArea;$l_IdDimension;$l_IdEje)
C_TEXT:C284($t_Enunciado)

ARRAY LONGINT:C221($al_BitNiveles;0)

If (False:C215)
	C_BOOLEAN:C305(MPAcfg_Dim_EsUnica ;$0)
End if 




  // CÓDIGO
$0:=True:C214
$l_IdDimension:=[MPA_DefinicionDimensiones:188]ID:1
$l_IdArea:=[MPA_DefinicionDimensiones:188]ID_Area:2
$l_IdEje:=[MPA_DefinicionDimensiones:188]ID_Eje:3
$t_Enunciado:=[MPA_DefinicionDimensiones:188]Dimensión:4
$l_BitNiveles:=[MPA_DefinicionDimensiones:188]BitsNiveles:21

PUSH RECORD:C176([MPA_DefinicionDimensiones:188])


QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID:1#$l_Iddimension;*)
QUERY:C277([MPA_DefinicionDimensiones:188]; & ;[MPA_DefinicionDimensiones:188]ID_Area:2=$l_IdArea;*)
QUERY:C277([MPA_DefinicionDimensiones:188]; & ;[MPA_DefinicionDimensiones:188]ID_Eje:3=$l_IdEje;*)
QUERY:C277([MPA_DefinicionDimensiones:188]; & ;[MPA_DefinicionDimensiones:188]Dimensión:4=$t_Enunciado)


$l_Duplicados:=0
SELECTION TO ARRAY:C260([MPA_DefinicionDimensiones:188]BitsNiveles:21;$al_BitNiveles)
For ($i_dimensionesDuplicadas;1;Size of array:C274($al_BitNiveles))
	For ($i;1;24)
		If (($l_BitNiveles ?? $i) & ($al_BitNiveles{$i_dimensionesDuplicadas} ?? $i))
			$l_Duplicados:=$l_Duplicados+1
		End if 
	End for 
End for 

POP RECORD:C177([MPA_DefinicionDimensiones:188])
ONE RECORD SELECT:C189([MPA_DefinicionDimensiones:188])

If ($l_Duplicados>0)
	$0:=False:C215
End if 

