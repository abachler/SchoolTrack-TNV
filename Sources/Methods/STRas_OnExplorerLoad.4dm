//%attributes = {}
  // STRas_OnExplorerLoad()
  //
  //
  // creado por: Alberto Bachler Klein: 14-03-16, 14:52:45
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_ajustesConsolidables;$b_ajustesNoPromediables)
C_LONGINT:C283($i;$i_asignaturas;$l_nivelJerarquico;$l_posicion)
C_POINTER:C301($y_AbrevAsignatura;$y_arreglo;$y_Consolidantes;$y_NombreAsignatura;$y_Promediable)

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_promedioAnual;0)

For ($i;1;Size of array:C274(ayBWR_FieldPointers))
	Case of 
		: ((Table:C252(ayBWR_FieldPointers{$i})=Table:C252(->[Asignaturas:18])) & (Field:C253(ayBWR_FieldPointers{$i})=Field:C253(->[Asignaturas:18]Incide_en_promedio:27)))
			$b_ajustesNoPromediables:=True:C214
			$y_Promediable:=ayBWR_ArrayPointers{$i}
			
		: ((Table:C252(ayBWR_FieldPointers{$i})=Table:C252(->[Asignaturas:18])) & (Field:C253(ayBWR_FieldPointers{$i})=Field:C253(->[Asignaturas:18]Consolidacion_Madre_nombre:8)))
			$b_ajustesConsolidables:=True:C214
			$y_Consolidantes:=ayBWR_ArrayPointers{$i}
			
		: ((Table:C252(ayBWR_FieldPointers{$i})=Table:C252(->[Asignaturas:18])) & (Field:C253(ayBWR_FieldPointers{$i})=Field:C253(->[Asignaturas:18]denominacion_interna:16)))
			$b_ajustesConsolidables:=True:C214
			$y_NombreAsignatura:=ayBWR_ArrayPointers{$i}
			
		: ((Table:C252(ayBWR_FieldPointers{$i})=Table:C252(->[Asignaturas:18])) & (Field:C253(ayBWR_FieldPointers{$i})=Field:C253(->[Asignaturas:18]Abreviación:26)))
			$b_ajustesConsolidables:=True:C214
			$y_AbrevAsignatura:=ayBWR_ArrayPointers{$i}
			
		: ((Table:C252(ayBWR_FieldPointers{$i})=Table:C252(->[Asignaturas_SintesisAnual:202])) & (Field:C253(ayBWR_FieldPointers{$i})=Field:C253(->[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19)) & (<>vtXS_CountryCode="ar"))
			  //para Argentina
			  // si el promedio FINAL interno está vacío se utiliza asigna el promedio ANUAL interno ya que el FINAL sólo se calcula cuando se cumplen ciertas condiciones
			$y_arreglo:=ayBWR_ArrayPointers{$i}
			CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];alBWR_recordNumber)
			SELECTION TO ARRAY:C260([Asignaturas:18];$al_RecNums;[Asignaturas_SintesisAnual:202]PromedioAnual_Literal:14;$at_promedioAnual)
			For ($i_asignaturas;1;Size of array:C274(alBWR_recordNumber))
				If ($y_arreglo->{$i_asignaturas}="")
					$l_posicion:=Find in array:C230($al_RecNums;alBWR_recordNumber{$i_asignaturas})
					If ($l_posicion>0)
						$y_arreglo->{$i_asignaturas}:=$at_promedioAnual{$l_posicion}
					End if 
				End if 
			End for 
			
	End case 
End for 

If ($b_ajustesConsolidables)
	$b_ajustesConsolidables:=False:C215
	For ($i;1;Size of array:C274(ayBWR_FieldPointers))
		If ((Table:C252(ayBWR_FieldPointers{$i})=Table:C252(->[Asignaturas:18])) & (Field:C253(ayBWR_FieldPointers{$i})=Field:C253(->[Asignaturas:18]ordenGeneral:105)))
			$b_ajustesConsolidables:=True:C214
		End if 
	End for 
End if 

For ($i;1;Size of array:C274(alBWR_recordNumber))
	If ($b_ajustesConsolidables)
		$l_nivelJerarquico:=ST_CountWords (ayBWR_ArrayPointers{1}->{$i};0;".")
		If (($y_Consolidantes->{$i}#"") & ($l_nivelJerarquico>1))
			$y_AbrevAsignatura->{$i}:=(" "*$l_nivelJerarquico)+ST_ClearSpaces ($y_AbrevAsignatura->{$i})
			$y_NombreAsignatura->{$i}:=Substring:C12(("  "*$l_nivelJerarquico)+ST_ClearSpaces ($y_NombreAsignatura->{$i});1;80)
			AL_SetRowColor (xALP_Browser;$i;"";12)
			AL_SetRowStyle (xALP_Browser;$i;2)
		Else 
			If ($b_ajustesNoPromediables)
				If (Not:C34($y_Promediable->{$i}))
					AL_SetRowColor (xALP_Browser;$i;"";15*16+13)
					AL_SetRowStyle (xALP_Browser;$i;2)
				Else 
					AL_SetRowColor (xALP_Browser;$i;"";16)
					AL_SetRowStyle (xALP_Browser;$i;0)
				End if 
			Else 
				AL_SetRowColor (xALP_Browser;$i;"";16)
				AL_SetRowStyle (xALP_Browser;$i;0)
			End if 
		End if 
	End if 
	If ($b_ajustesNoPromediables)
		If (Not:C34($y_Promediable->{$i}))
			If ($y_Consolidantes->{$i}="")
				AL_SetRowColor (xALP_Browser;$i;"";15*16+13)
				AL_SetRowStyle (xALP_Browser;$i;0)
			End if 
		Else 
			AL_SetRowColor (xALP_Browser;$i;"";16)
			AL_SetRowStyle (xALP_Browser;$i;0)
		End if 
	End if 
End for 

