//%attributes = {}
  // MPAcfg_Comp_EsUnica <-competenciaEsUnica: Boolean
  // Determina si el nombre de la comptencia actual es único en el mismo contenedor (dimension, eje, area)
  // y en las mismas etapas
  //
  // <-- competenciaEsUnica
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 19/06/12, 15:17:10
  // ---------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_isNewRecord)
_O_C_INTEGER:C282($i_CompetenciasDuplicadas)
C_LONGINT:C283($i;$l_BitNiveles;$l_Duplicados;$l_IdCompetencia;$l_IdDimension;$l_IdEje)
C_TEXT:C284($t_Enunciado)

ARRAY LONGINT:C221($al_BitNiveles;0)

If (False:C215)
	C_BOOLEAN:C305(MPAcfg_Comp_EsUnica ;$0)
End if 




  // CÓDIGO
$0:=True:C214

$l_IdCompetencia:=[MPA_DefinicionCompetencias:187]ID:1
$l_IdArea:=[MPA_DefinicionCompetencias:187]ID_Area:11
$l_IdEje:=[MPA_DefinicionCompetencias:187]ID_Eje:2
$l_IdDimension:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
$t_Enunciado:=[MPA_DefinicionCompetencias:187]Competencia:6
$l_BitNiveles:=[MPA_DefinicionCompetencias:187]BitNiveles:28
$b_isNewRecord:=Is new record:C668([MPA_DefinicionCompetencias:187])

PUSH RECORD:C176([MPA_DefinicionCompetencias:187])

Case of 
	: ([MPA_DefinicionCompetencias:187]ID_Dimension:23#0)
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1#$l_IdCompetencia;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]ID_Area:11=$l_IdArea;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]ID_Dimension:23=$l_IdDimension;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]Competencia:6=$t_Enunciado)
		
		
	: (([MPA_DefinicionCompetencias:187]ID_Eje:2#0) & ([MPA_DefinicionCompetencias:187]ID_Dimension:23=0))
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1#$l_IdCompetencia;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]ID_Area:11=$l_IdArea;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]ID_Eje:2=$l_IdEje;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]ID_Dimension:23=0;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]Competencia:6=$t_Enunciado)
		
		
	: (([MPA_DefinicionCompetencias:187]ID_Eje:2=0) & ([MPA_DefinicionCompetencias:187]ID_Dimension:23=0))
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1#$l_IdCompetencia;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]ID_Area:11=$l_IdArea;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]ID_Eje:2=0;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]ID_Dimension:23=0;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]Competencia:6=$t_Enunciado)
End case 

$l_Duplicados:=0
SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187]BitNiveles:28;$al_BitNiveles)
For ($i_CompetenciasDuplicadas;1;Size of array:C274($al_BitNiveles))
	For ($i;1;24)
		If (($l_BitNiveles ?? $i) & ($al_BitNiveles{$i_CompetenciasDuplicadas} ?? $i))
			$l_Duplicados:=1
			$i:=24
			$i_CompetenciasDuplicadas:=Size of array:C274($al_BitNiveles)
		End if 
	End for 
End for 

POP RECORD:C177([MPA_DefinicionCompetencias:187])
ONE RECORD SELECT:C189([MPA_DefinicionCompetencias:187])

If ($l_duplicados>0)
	$0:=False:C215
End if 



