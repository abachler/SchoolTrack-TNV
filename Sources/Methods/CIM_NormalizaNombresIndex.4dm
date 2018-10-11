//%attributes = {}
  // CIM_NormalizaNombresIndex()
  // Por: Alberto Bachler K.: 16-04-15, 13:03:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_compuestos;$i_index)
C_LONGINT:C283($l_indexes;$l_indexesKeywords)
C_POINTER:C301($y_Campo;$y_IdCampo;$y_IdTabla;$y_listBox;$y_nombreIndex;$y_Tabla;$y_tipoCampo;$y_TipoIndex;$y_tipoIndexNum;$y_uuidIndex)
C_TEXT:C284($t_nombreIndex;$t_nombreIndexActual;$t_uuidIndex)

ARRAY LONGINT:C221($al_campo;0)
ARRAY LONGINT:C221($al_elementosEncontrados;0)
ARRAY LONGINT:C221($al_tabla;0)
ARRAY POINTER:C280($ay_campos;0)

$y_IdTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"ID_Tabla")
$y_IdCampo:=OBJECT Get pointer:C1124(Object named:K67:5;"Id_campo")
$y_Tabla:=OBJECT Get pointer:C1124(Object named:K67:5;"Tabla")
$y_Campo:=OBJECT Get pointer:C1124(Object named:K67:5;"campo")
$y_TipoIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoIndex")
$y_nombreIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreIndex")
$y_tipoCampo:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoCampo")
$y_tipoIndexNum:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoIndex_L")
$y_uuidIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"ID_indice")
$y_listBox:=OBJECT Get pointer:C1124(Object named:K67:5;"listboxIndexes")

For ($i_index;1;Size of array:C274($y_uuidIndex->))
	$t_uuidIndex:=$y_uuidIndex->{$i_index}
	$t_nombreIndex:=$y_nombreIndex->{$i_index}
	$t_nombreIndexActual:=$y_nombreIndex->{$i_index}
	
	If (($t_nombreIndexActual#"IDX_a_@") & ($t_nombreIndexActual#"IDX_bt_@") & ($t_nombreIndexActual#"IDX_cl_@") & ($t_nombreIndexActual#"IDX_c_@") & ($t_nombreIndexActual#"IDX_k_@"))
		Case of 
			: ($y_Tabla->{$i_index}="@Id_added_by_Converter")
				$t_nombreIndex:="IDX_cl_"+Table name:C256($y_IdTabla->{$i_index})+"_"+Field name:C257($y_IdTabla->{$i_index};$y_IdCampo->{$i_index})
				$y_tipoIndexNum->{$i_index}:=3
				$y_TipoIndex->{$i_index}:="Cluster"
				APPEND TO ARRAY:C911($ay_campos;Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
				DELETE INDEX:C967(Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
				CREATE INDEX:C966(Table:C252($y_IdTabla->{$i_index})->;$ay_campos;Cluster BTree index:K58:4;$t_nombreIndex)
				
			: ($y_TipoIndex->{$i_index}="Composite")
				$y_uuidIndex->{0}:=$y_uuidIndex->{$i_index}
				AT_MultiArraySearch (False:C215;->$al_elementosEncontrados;$y_uuidIndex)
				For ($i_compuestos;1;Size of array:C274($al_elementosEncontrados))
					APPEND TO ARRAY:C911($al_tabla;$y_IdTabla->{$al_elementosEncontrados{$i_compuestos}})
					APPEND TO ARRAY:C911($al_Campo;$y_IdCampo->{$al_elementosEncontrados{$i_compuestos}})
					APPEND TO ARRAY:C911($ay_campos;Field:C253($y_IdTabla->{$al_elementosEncontrados{$i_compuestos}};$y_IdCampo->{$al_elementosEncontrados{$i_compuestos}}))
				End for 
				$t_nombreIndex:=Table name:C256($al_tabla{1})+"_"+Field name:C257($al_tabla{1};$al_Campo{1})
				For ($i_compuestos;2;Size of array:C274($al_Campo))
					$t_nombreIndex:=$t_nombreIndex+"."+Field name:C257($al_tabla{$i_compuestos};$al_Campo{$i_compuestos})
				End for 
				$t_nombreIndex:="IDX_c_"+$t_nombreIndex
				If ($t_nombreIndex#$t_nombreIndexActual)
					If ($t_nombreIndexActual#"")
						DELETE INDEX:C967($t_nombreIndexActual)
						CREATE INDEX:C966(Table:C252($y_IdTabla->{$i_index})->;$ay_campos;Standard BTree index:K58:3;$t_nombreIndex)
						If (OK=1)
							For ($i_compuestos;1;Size of array:C274($al_elementosEncontrados))
								$y_nombreIndex->{$al_elementosEncontrados{$i_compuestos}}:=$t_nombreIndex
							End for 
						End if 
					End if 
				End if 
				
			: ($y_TipoIndex->{$i_index}="Automatic")
				$t_nombreIndex:="IDX_a_"+Table name:C256($y_IdTabla->{$i_index})+"_"+Field name:C257($y_IdTabla->{$i_index};$y_IdCampo->{$i_index})
				If ($t_nombreIndex#$t_nombreIndexActual)
					OK:=0
					If ($t_nombreIndexActual#"")
						APPEND TO ARRAY:C911($ay_campos;Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
						DELETE INDEX:C967(Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
						CREATE INDEX:C966(Table:C252($y_IdTabla->{$i_index})->;$ay_campos;Default index type:K58:2;$t_nombreIndex)
					Else 
						$y_IdTabla->{0}:=$y_IdTabla->{$i_index}
						$y_IdCampo->{0}:=$y_IdCampo->{$i_index}
						$y_TipoIndex->{0}:="Keywords"
						$l_indexesKeywords:=AT_MultiArraySearch (False:C215;->$al_elementosEncontrados;$y_IdTabla;$y_IdCampo;$y_TipoIndex)
						If ($l_indexesKeywords=0)
							APPEND TO ARRAY:C911($ay_campos;Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
							DELETE INDEX:C967(Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
							CREATE INDEX:C966(Table:C252($y_IdTabla->{$i_index})->;$ay_campos;Default index type:K58:2;$t_nombreIndex)
						End if 
					End if 
					If (OK=1)
						$y_nombreIndex->{$i_index}:=$t_nombreIndex
					Else 
						
					End if 
				End if 
				
			: ($y_TipoIndex->{$i_index}="B Tree")
				$t_nombreIndex:="IDX_bt_"+Table name:C256($y_IdTabla->{$i_index})+"_"+Field name:C257($y_IdTabla->{$i_index};$y_IdCampo->{$i_index})
				If ($t_nombreIndex#$t_nombreIndexActual)
					OK:=0
					If ($t_nombreIndexActual#"")
						APPEND TO ARRAY:C911($ay_campos;Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
						DELETE INDEX:C967(Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
						CREATE INDEX:C966(Table:C252($y_IdTabla->{$i_index})->;$ay_campos;Standard BTree index:K58:3;$t_nombreIndex)
					Else 
						$y_IdTabla->{0}:=$y_IdTabla->{$i_index}
						$y_IdCampo->{0}:=$y_IdCampo->{$i_index}
						$l_indexesKeywords:=AT_MultiArraySearch (False:C215;->$al_elementosEncontrados;$y_IdTabla;$y_IdCampo;$y_TipoIndex)
						If ($l_indexesKeywords=0)
							APPEND TO ARRAY:C911($ay_campos;Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
							DELETE INDEX:C967(Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
							CREATE INDEX:C966(Table:C252($y_IdTabla->{$i_index})->;$ay_campos;Standard BTree index:K58:3;$t_nombreIndex)
							If (OK=1)
								$y_nombreIndex->{$i_index}:=$t_nombreIndex
							Else 
								
							End if 
						End if 
					End if 
					If (OK=1)
						$y_nombreIndex->{$i_index}:=$t_nombreIndex
					End if 
				End if 
				
			: (($y_TipoIndex->{$i_index}="Keywords") | ($y_tipoIndexNum->{$i_index}=-1))
				$t_nombreIndex:="IDX_k_"+Table name:C256($y_IdTabla->{$i_index})+"_"+Field name:C257($y_IdTabla->{$i_index};$y_IdCampo->{$i_index})
				If ($t_nombreIndex#$t_nombreIndexActual)
					OK:=0
					If ($t_nombreIndexActual#"")
						APPEND TO ARRAY:C911($ay_campos;Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
						DELETE INDEX:C967(Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
						CREATE INDEX:C966(Table:C252($y_IdTabla->{$i_index})->;$ay_campos;Keywords index:K58:1;$t_nombreIndex)
					Else 
						$y_IdTabla->{0}:=$y_IdTabla->{$i_index}
						$y_IdCampo->{0}:=$y_IdCampo->{$i_index}
						$l_indexes:=AT_MultiArraySearch (False:C215;->$al_elementosEncontrados;$y_IdTabla;$y_IdCampo)
						If ($l_indexes=1)
							APPEND TO ARRAY:C911($ay_campos;Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
							DELETE INDEX:C967(Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
							CREATE INDEX:C966(Table:C252($y_IdTabla->{$i_index})->;$ay_campos;Keywords index:K58:1;$t_nombreIndex)
						End if 
					End if 
					If (OK=1)
						$y_nombreIndex->{$i_index}:=$t_nombreIndex
					Else 
						
					End if 
				End if 
				
			: ($y_TipoIndex->{$i_index}="Cluster")
				$t_nombreIndex:="IDX_cl_"+Table name:C256($y_IdTabla->{$i_index})+"_"+Field name:C257($y_IdTabla->{$i_index};$y_IdCampo->{$i_index})
				If ($t_nombreIndex#$t_nombreIndexActual)
					OK:=0
					If ($t_nombreIndexActual#"")
						APPEND TO ARRAY:C911($ay_campos;Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
						DELETE INDEX:C967(Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
						CREATE INDEX:C966(Table:C252($y_IdTabla->{$i_index})->;$ay_campos;Cluster BTree index:K58:4;$t_nombreIndex)
					Else 
						$y_IdTabla->{0}:=$y_IdTabla->{$i_index}
						$y_IdCampo->{0}:=$y_IdCampo->{$i_index}
						$l_indexes:=AT_MultiArraySearch (False:C215;->$al_elementosEncontrados;$y_IdTabla;$y_IdCampo)
						If ($l_indexes=1)
							APPEND TO ARRAY:C911($ay_campos;Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
							DELETE INDEX:C967(Field:C253($y_IdTabla->{$i_index};$y_IdCampo->{$i_index}))
							CREATE INDEX:C966(Table:C252($y_IdTabla->{$i_index})->;$ay_campos;Cluster BTree index:K58:4;$t_nombreIndex)
						End if 
					End if 
					If (OK=1)
						$y_nombreIndex->{$i_index}:=$t_nombreIndex
					End if 
				End if 
				
			: ($y_nombreIndex->{$i_index}="IDX_k_@")
				$y_TipoIndex->{$i_index}:="Keywords"
				$y_tipoIndexNum->{$i_index}:=-1
				$y_tipoIndexNum:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoIndex_L")
		End case 
	End if 
End for 

