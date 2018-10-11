//%attributes = {}
  //MPA_CargaDatosColorCeldas
  //para cargar los datos
C_LONGINT:C283($i;$indexNivel;$l_colum;$l_ID;$l_linea;$l_nivelDesde;$l_nivelHasta;$l_pos)
C_POINTER:C301($y_fielComp;$y_listBox;$y_variableColumna)
C_TEXT:C284($t_accion)

$t_accion:=$1
$y_listBox:=$2
$l_nivelDesde:=$3
$l_nivelHasta:=$4

LISTBOX GET CELL POSITION:C971($y_listBox->;$l_colum;$l_linea;$y_variableColumna)

Case of 
	: ($t_accion="area")
		lb_asignaturasArea{$l_linea}:=True:C214
		$l_ID:=al_IDAreaAprendizajes{$l_linea}
		
		QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=$l_ID)
		ORDER BY:C49([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>)
		SELECTION TO ARRAY:C260([MPA_DefinicionEjes:185]Nombre:3;at_ejesAprendizajes;[MPA_DefinicionEjes:185]ID:1;al_IDejesAprendizajes;[MPA_DefinicionEjes:185]color_rgb:26;al_colorEje;[MPA_DefinicionEjes:185];alRecNum)
		  //cargo las etapas
		ARRAY TEXT:C222(at_Etapa;0)
		ARRAY TEXT:C222(at_Etapa;Size of array:C274(alRecNum))
		For ($i;1;Size of array:C274(alRecNum))
			GOTO RECORD:C242([MPA_DefinicionEjes:185];alRecNum{$i})
			Case of 
				: ([MPA_DefinicionEjes:185]DesdeGrado:4=999)
					at_Etapa{$i}:="Por Nivel"
				: ([MPA_DefinicionEjes:185]DesdeGrado:4=-100)
					at_Etapa{$i}:="Todos"
				: ([MPA_DefinicionEjes:185]Asignado_a_Etapa:19=1)
					$indexNivel:=Find in array:C230(<>aNivNo;[MPA_DefinicionEjes:185]DesdeGrado:4)
					If ($indexNivel#-1)
						at_Etapa{$i}:=String:C10(<>aNivNo{$indexNivel})
					End if 
					
					If ([MPA_DefinicionEjes:185]DesdeGrado:4#[MPA_DefinicionEjes:185]HastaGrado:5)
						$indexNivel2:=Find in array:C230(<>aNivNo;[MPA_DefinicionEjes:185]HastaGrado:5)
						If ($indexNivel2#-1)
							at_Etapa{$i}:=at_Etapa{$i}+"-"+String:C10(<>aNivNo{$indexNivel2})
						End if 
					End if 
					
				Else 
					
			End case 
		End for 
		
		QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=$l_ID)
		ORDER BY:C49([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>)
		SELECTION TO ARRAY:C260([MPA_DefinicionDimensiones:188]Dimensión:4;at_dimAprendizajes;[MPA_DefinicionDimensiones:188]ID:1;al_IDdimAprendizajes;[MPA_DefinicionDimensiones:188]color_rgb:26;al_colorDim;[MPA_DefinicionDimensiones:188];alRecNum)
		  //cargo las etapas
		ARRAY TEXT:C222(at_EtapaDim;0)
		ARRAY TEXT:C222(at_EtapaDim;Size of array:C274(alRecNum))
		For ($i;1;Size of array:C274(alRecNum))
			GOTO RECORD:C242([MPA_DefinicionDimensiones:188];alRecNum{$i})
			Case of 
				: ([MPA_DefinicionDimensiones:188]DesdeGrado:6=999)
					at_EtapaDim{$i}:="Por Nivel"
				: ([MPA_DefinicionDimensiones:188]DesdeGrado:6=-100)
					at_EtapaDim{$i}:="Todos"
				: ([MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5=1)
					$indexNivel:=Find in array:C230(<>aNivNo;[MPA_DefinicionDimensiones:188]DesdeGrado:6)
					If ($indexNivel#-1)
						at_EtapaDim{$i}:=String:C10(<>aNivNo{$indexNivel})
					End if 
					
					If ([MPA_DefinicionDimensiones:188]DesdeGrado:6#[MPA_DefinicionDimensiones:188]HastaGrado:7)
						$indexNivel2:=Find in array:C230(<>aNivNo;[MPA_DefinicionDimensiones:188]HastaGrado:7)
						If ($indexNivel2#-1)
							at_EtapaDim{$i}:=at_EtapaDim{$i}+"-"+String:C10(<>aNivNo{$indexNivel2})
						End if 
					End if 
					
				Else 
					
			End case 
		End for 
		
		
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=$l_ID)
		ORDER BY:C49([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>)
		SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187]Competencia:6;at_logrosAprendizajes;[MPA_DefinicionCompetencias:187]ID:1;al_IDlogrosAprendizajes;[MPA_DefinicionCompetencias:187]color_rgb:33;al_colorLogros;[MPA_DefinicionCompetencias:187];alRecNum)
		
	: ($t_accion="Eje")
		$l_ID:=al_IDejesAprendizajes{$l_linea}
		QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=$l_ID)
		ORDER BY:C49([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>)
		SELECTION TO ARRAY:C260([MPA_DefinicionDimensiones:188]Dimensión:4;at_dimAprendizajes;[MPA_DefinicionDimensiones:188]ID:1;al_IDdimAprendizajes;[MPA_DefinicionDimensiones:188]color_rgb:26;al_colorDim;[MPA_DefinicionDimensiones:188];alRecNum)
		  //cargo las etapas
		ARRAY TEXT:C222(at_EtapaDim;0)
		ARRAY TEXT:C222(at_EtapaDim;Size of array:C274(alRecNum))
		For ($i;1;Size of array:C274(alRecNum))
			GOTO RECORD:C242([MPA_DefinicionDimensiones:188];alRecNum{$i})
			Case of 
				: ([MPA_DefinicionDimensiones:188]DesdeGrado:6=999)
					at_EtapaDim{$i}:="Por Nivel"
				: ([MPA_DefinicionDimensiones:188]DesdeGrado:6=-100)
					at_EtapaDim{$i}:="Todos"
				: ([MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5=1)
					$indexNivel:=Find in array:C230(<>aNivNo;[MPA_DefinicionDimensiones:188]DesdeGrado:6)
					If ($indexNivel#-1)
						at_EtapaDim{$i}:=String:C10(<>aNivNo{$indexNivel})
					End if 
					
					If ([MPA_DefinicionDimensiones:188]DesdeGrado:6#[MPA_DefinicionDimensiones:188]HastaGrado:7)
						$indexNivel2:=Find in array:C230(<>aNivNo;[MPA_DefinicionDimensiones:188]HastaGrado:7)
						If ($indexNivel2#-1)
							at_EtapaDim{$i}:=at_EtapaDim{$i}+"-"+String:C10(<>aNivNo{$indexNivel2})
						End if 
					End if 
				Else 
					
			End case 
		End for 
		
		CREATE SELECTION FROM ARRAY:C640([MPA_DefinicionDimensiones:188];alRecNum;"")
		If (Records in selection:C76([MPA_DefinicionDimensiones:188])>0)
			KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID_Dimension:23;->[MPA_DefinicionDimensiones:188]ID:1;"")
			QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=$l_ID)
		Else 
			QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=$l_ID)
		End if 
		
		CREATE SET:C116([MPA_DefinicionCompetencias:187];"logros")
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]DesdeGrado:5=-100)
		CREATE SET:C116([MPA_DefinicionCompetencias:187];"TodasEtapas")
		DIFFERENCE:C122("logros";"TodasEtapas";"logros")
		
		CREATE EMPTY SET:C140([MPA_DefinicionCompetencias:187];"porNivel")
		For ($i;$l_nivelDesde;$l_nivelHasta)
			$indexNivel:=Find in array:C230(<>aNivNo;$i)
			USE SET:C118("logros")
			  //QUERY SELECTION([MPA_DefinicionCompetencias];[MPA_DefinicionCompetencias]DesdeGrado=999)
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $indexNivel)
			CREATE SET:C116([MPA_DefinicionCompetencias:187];"temp")
			UNION:C120("temp";"porNivel";"porNivel")
		End for 
		
		USE SET:C118("logros")
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]DesdeGrado:5>=$l_nivelDesde;*)
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]HastaGrado:13<=$l_nivelHasta)
		CREATE SET:C116([MPA_DefinicionCompetencias:187];"logrosNiveles")
		UNION:C120("TodasEtapas";"logrosNiveles";"logros")
		UNION:C120("porNivel";"logros";"logros")
		USE SET:C118("logros")
		SET_ClearSets ("TodasEtapas";"logrosNiveles";"logros";"porNivel")
		ORDER BY:C49([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>)
		SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187]Competencia:6;at_logrosAprendizajes;[MPA_DefinicionCompetencias:187]ID:1;al_IDlogrosAprendizajes;[MPA_DefinicionCompetencias:187]color_rgb:33;al_colorLogros)
		
	: ($t_accion="Dimension")
		  //LISTBOX GET CELL POSITION(lb_ejesaprendizajes;$l_colum;$l_linea;$y_variableColumna)//mono ticket 155729
		If ($l_linea>0)
			$l_ID:=al_IDdimAprendizajes{$l_linea}
			$y_fielComp:=->[MPA_DefinicionCompetencias:187]ID_Dimension:23
		Else 
			LISTBOX GET CELL POSITION:C971(lb_ejesaprendizajes;$l_colum;$l_linea;$y_variableColumna)
			$l_ID:=al_IDejesAprendizajes{$l_linea}
			$y_fielComp:=->[MPA_DefinicionCompetencias:187]ID_Eje:2
			If ($l_linea<=0)
				LISTBOX GET CELL POSITION:C971(lb_asignaturasArea;$l_colum;$l_linea;$y_variableColumna)
				$l_ID:=al_IDAreaAprendizajes{$l_linea}
				$y_fielComp:=->[MPA_DefinicionCompetencias:187]ID_Area:11
			End if 
		End if 
		
		
		QUERY:C277([MPA_DefinicionCompetencias:187];$y_fielComp->=$l_ID)
		CREATE SET:C116([MPA_DefinicionCompetencias:187];"logros")
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]DesdeGrado:5=-100)
		CREATE SET:C116([MPA_DefinicionCompetencias:187];"TodasEtapas")
		DIFFERENCE:C122("logros";"TodasEtapas";"logros")
		
		USE SET:C118("logros")
		CREATE EMPTY SET:C140([MPA_DefinicionCompetencias:187];"porNivel")
		For ($i;$l_nivelDesde;$l_nivelHasta)
			$indexNivel:=Find in array:C230(<>aNivNo;$i)
			USE SET:C118("logros")
			  //QUERY SELECTION([MPA_DefinicionCompetencias];[MPA_DefinicionCompetencias]DesdeGrado=999)
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $indexNivel)
			CREATE SET:C116([MPA_DefinicionCompetencias:187];"temp")
			UNION:C120("temp";"porNivel";"porNivel")
		End for 
		
		USE SET:C118("logros")
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]DesdeGrado:5>=$l_nivelDesde;*)
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]HastaGrado:13<=$l_nivelHasta)
		CREATE SET:C116([MPA_DefinicionCompetencias:187];"logrosNiveles")
		UNION:C120("TodasEtapas";"logrosNiveles";"logros")
		UNION:C120("porNivel";"logros";"logros")
		USE SET:C118("logros")
		SET_ClearSets ("TodasEtapas";"logrosNiveles";"logros";"porNivel")
		ORDER BY:C49([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>)
		SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187]Competencia:6;at_logrosAprendizajes;[MPA_DefinicionCompetencias:187]ID:1;al_IDlogrosAprendizajes;[MPA_DefinicionCompetencias:187]color_rgb:33;al_colorLogros)
End case 

For ($i;1;Size of array:C274(al_colorLogros))
	If (al_colorLogros{$i}=0)
		al_colorLogros{$i}:=-255
	End if 
End for 
For ($i;1;Size of array:C274(al_colorDim))
	If (al_colorDim{$i}=0)
		al_colorDim{$i}:=-255
	End if 
End for 
For ($i;1;Size of array:C274(al_colorEje))
	If (al_colorEje{$i}=0)
		al_colorEje{$i}:=-255
	End if 
End for 

