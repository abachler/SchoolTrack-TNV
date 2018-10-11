//%attributes = {}
  // MPAcfg_Area_AgregaEtapa()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 05/07/12, 12:57:51
  // ---------------------------------------------
C_BOOLEAN:C305($b_posibleAñadirEtapa)
_O_C_INTEGER:C282($i_etapas)
C_LONGINT:C283($i;$l_desdeNivel;$l_hastaNivel)


  // CÓDIGO

  //determino si es posible añadir una etapa al área
  // y en que niveles se añade
$b_posibleAñadirEtapa:=MPAcfg_Area_PosibleAñadirEtapa (->$l_desdeNivel;->$l_hastaNivel)

If ($b_posibleAñadirEtapa)
	If (($l_desdeNivel#0) | ($l_hastaNivel#0))
		$t_nombreEtapa:="Etapa "+String:C10(Size of array:C274(atMPA_EtapasArea)+1)
		APPEND TO ARRAY:C911(atMPA_EtapasArea;"Etapa "+String:C10(Size of array:C274(atMPA_EtapasArea)+1))
		APPEND TO ARRAY:C911(alMPA_NivelDesde;$l_desdeNivel)
		APPEND TO ARRAY:C911(alMPA_NivelHasta;$l_hastaNivel)
		APPEND TO ARRAY:C911(atMPA_NivelDesde;"["+String:C10($l_desdeNivel)+"] "+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_desdeNivel;->[xxSTR_Niveles:6]Nivel:1))
		APPEND TO ARRAY:C911(atMPA_NivelHasta;"["+String:C10($l_hastaNivel)+"] "+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_hastaNivel;->[xxSTR_Niveles:6]Nivel:1))
		
		LISTBOX SORT COLUMNS:C916(lb_Etapas;4;>)
		atMPA_EtapasArea:=Find in array:C230(atMPA_EtapasArea;$t_nombreEtapa)
		EDIT ITEM:C870(lb_Etapas;atMPA_EtapasArea)
		
	End if 
	
End if 