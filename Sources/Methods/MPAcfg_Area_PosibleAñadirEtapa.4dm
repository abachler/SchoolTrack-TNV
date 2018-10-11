//%attributes = {}
  // MPAcfg_Area_PosibleAñadirEtapa ({varPointer_DesdeNivel;varPointer_HastaNivel -> esPosibleAñadir
  // Determina si es posible añadir o modificar una etapa en área de aprendizajes actual
  // esPosibleAñadir: Booleano, True si es posible, False si todos los niveles activos están ya asignados a etapas
  // los punteros sobre variables varPointer_DesdeNivel y varPointer_HastaNivel devuelven el rango de niveles en que es posible añadir etapas
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 17/07/12, 13:14:28
  // ---------------------------------------------
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_POINTER:C301($2)

C_BOOLEAN:C305($b_posibleAñadirEtapa)
_O_C_INTEGER:C282($i_etapas)
C_LONGINT:C283($l_limiteInferior;$l_limiteSuperior)
C_POINTER:C301($y_limiteInferior;$y_limiteSuperior)

If (False:C215)
	C_BOOLEAN:C305(MPAcfg_Area_PosibleAñadirEtapa ;$0)
	C_POINTER:C301(MPAcfg_Area_PosibleAñadirEtapa ;$1)
	C_POINTER:C301(MPAcfg_Area_PosibleAñadirEtapa ;$2)
End if 

  // CÓDIGO
$b_posibleAñadirEtapa:=False:C215
For ($i_etapas;Size of array:C274(atMPA_EtapasArea);2;-1)
	Case of 
		: ((alMPA_NivelHasta{$i_etapas}<<>al_NumeroNivelesActivos{Size of array:C274(<>al_NumeroNivelesActivos)}) & ($i_etapas=Size of array:C274(atMPA_EtapasArea)))
			$b_posibleAñadirEtapa:=True:C214
			$i_etapas:=0
		: ((alMPA_NivelDesde{$i_etapas}-alMPA_NivelHasta{$i_etapas-1}>2) & (alMPA_NivelHasta{$i_etapas-1}<0))
			$b_posibleAñadirEtapa:=True:C214
			$i_etapas:=0
		: ((alMPA_NivelDesde{$i_etapas}-alMPA_NivelHasta{$i_etapas-1}>1) & (alMPA_NivelHasta{$i_etapas-1}>0))
			$b_posibleAñadirEtapa:=True:C214
			$i_etapas:=0
	End case 
End for 

If (Not:C34($b_posibleAñadirEtapa))
	If (Find in array:C230(<>al_NumeroNivelesActivos;alMPA_NivelHasta{Size of array:C274(alMPA_NivelHasta)})<Size of array:C274(<>al_NumeroNivelesActivos))
		$b_posibleAñadirEtapa:=True:C214
	End if 
End if 

If (Not:C34($b_posibleAñadirEtapa))
	If (Find in array:C230(<>al_NumeroNivelesActivos;alMPA_NivelDesde{1})>1)
		$b_posibleAñadirEtapa:=True:C214
	End if 
End if 

If (Count parameters:C259=2)
	$y_limiteInferior:=$1
	$y_limiteSuperior:=$2
	If ($b_posibleAñadirEtapa)
		For ($i_etapas;Size of array:C274(atMPA_EtapasArea);2;-1)
			Case of 
				: ((alMPA_NivelHasta{$i_etapas}<<>al_NumeroNivelesActivos{Size of array:C274(<>al_NumeroNivelesActivos)}) & ($i_etapas=Size of array:C274(atMPA_EtapasArea)))
					If (alMPA_NivelHasta{$i_etapas}=-1)
						$l_limiteInferior:=0
					Else 
						$l_limiteInferior:=alMPA_NivelHasta{$i_etapas}+1
					End if 
					$l_limiteSuperior:=<>al_NumeroNivelesActivos{Size of array:C274(<>al_NumeroNivelesActivos)}
				: (alMPA_NivelDesde{$i_etapas}-alMPA_NivelHasta{$i_etapas-1}>1)
					If (alMPA_NivelHasta{$i_etapas-1}=-1)
						$l_limiteInferior:=1
					Else 
						$l_limiteInferior:=alMPA_NivelHasta{$i_etapas-1}+1
					End if 
					$l_limiteSuperior:=alMPA_NivelDesde{$i_etapas}-1
					If ($l_limiteSuperior=0)
						$l_limiteSuperior:=-1
					End if 
			End case 
		End for 
		
		If (($l_limiteInferior=0) | ($l_limiteSuperior=0))
			If (Find in array:C230(<>al_NumeroNivelesActivos;alMPA_NivelHasta{Size of array:C274(alMPA_NivelHasta)})<Size of array:C274(<>al_NumeroNivelesActivos))
				If (alMPA_NivelHasta{Size of array:C274(alMPA_NivelHasta)}=-1)
					$l_limiteInferior:=1
				Else 
					$l_limiteInferior:=alMPA_NivelHasta{Size of array:C274(alMPA_NivelHasta)}+1
				End if 
				$l_limiteSuperior:=<>al_NumeroNivelesActivos{Size of array:C274(<>al_NumeroNivelesActivos)}
			End if 
		End if 
		
		If (($l_limiteInferior=0) | ($l_limiteSuperior=0))
			If (Find in array:C230(<>al_NumeroNivelesActivos;alMPA_NivelDesde{1})>1)
				$l_limiteInferior:=<>al_NumeroNivelesActivos{1}
				$l_limiteSuperior:=alMPA_NivelDesde{1}-1
			End if 
		End if 
	End if 
	$y_limiteInferior->:=$l_limiteInferior
	$y_limiteSuperior->:=$l_limiteSuperior
End if 

$0:=$b_posibleAñadirEtapa

