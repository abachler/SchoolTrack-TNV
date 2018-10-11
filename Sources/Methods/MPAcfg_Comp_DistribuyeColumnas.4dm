//%attributes = {}
  // MPAcfg_Comp_DistribuyeColumnas()
  //
  //
  //
  // ---------------------------------------------




  // Usuario (OS): Alberto Bachler
  // Fecha: 14/07/12, 13:11:52
  // ---------------------------------------------
C_LONGINT:C283($i;$l_abajoCompetencias;$l_ancho_ultimaColumna;$l_anchoAreaCompetencias;$l_anchoColumna;$l_anchoColumnas;$l_anchoTotal;$l_arribaCompetencias;$l_derechaCompetencias;$l_izquierdaCompetencias)
C_LONGINT:C283($l_numeroColumnas)


  // CÓDIGO
OBJECT GET COORDINATES:C663(xALP_Competencias;$l_izquierdaCompetencias;$l_arribaCompetencias;$l_derechaCompetencias;$l_abajoCompetencias)
$l_anchoAreaCompetencias:=$l_derechaCompetencias-$l_izquierdaCompetencias
$l_numeroColumnas:=Size of array:C274(atMPA_EtapasArea)
$l_anchoColumnas:=Int:C8($l_anchoAreaCompetencias/$l_numeroColumnas)
If ($l_anchoColumnas<160)
	$l_anchoColumnas:=160
	For ($i;1;$l_numeroColumnas)
		AL_SetWidths (xALP_Competencias;$i;1;$l_anchoColumnas)
	End for 
Else 
	$l_anchoTotal:=$l_numeroColumnas*$l_anchoColumnas
	$l_ancho_ultimaColumna:=$l_anchoColumnas+($l_anchoAreaCompetencias-$l_anchoTotal)
	For ($i;1;$l_numeroColumnas-1)
		AL_SetWidths (xALP_Competencias;$i;1;$l_anchoColumnas)
	End for 
	$l_anchoTotal:=$l_numeroColumnas*$l_anchoColumnas
	$l_ancho_ultimaColumna:=$l_anchoColumnas+($l_anchoAreaCompetencias-$l_anchoTotal)
	AL_SetWidths (xALP_Competencias;$i;1;$l_ancho_ultimaColumna)
End if 

$l_anchoTotal:=0
For ($i;1;$l_numeroColumnas)
	$l_anchoTotal:=$l_anchoTotal+$l_anchoColumnas
End for 

If ($l_anchoTotal>$l_anchoAreaCompetencias)
	AL_SetScroll (xALP_Competencias;-2;-2)
Else 
	AL_SetScroll (xALP_Competencias;-2;-3)
End if 

AL_UpdateArrays (xALP_Competencias;-2)