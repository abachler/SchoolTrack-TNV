//%attributes = {}
  // CIM_AnalizaIndex()
  // Por: Alberto Bachler K.: 16-04-15, 12:26:56
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

  // CIM_Indices.Botón()
  // Por: Alberto Bachler K.: 05-12-14, 11:08:38
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_indexCompuestos)
C_LONGINT:C283($i;$l_elementos;$l_elementosEncontrados;$l_progressID;$l_tipoCampo;$l_tipoIdTabla;$l_tipoIndex)
C_POINTER:C301($y_Campo;$y_IdCampo;$y_IdTabla;$y_listbox;$y_nombreIndex;$y_Tabla;$y_tipoCampo;$y_TipoIndex;$y_tipoIndexNum;$y_tipoNoAmbiguo)
C_POINTER:C301($y_uuidIndex)
C_TEXT:C284($t_indexId;$t_uuidIndex)

ARRAY LONGINT:C221($al_ElementosBTree;0)
ARRAY LONGINT:C221($al_ElementosCluster;0)
ARRAY LONGINT:C221($al_ElementosEncontrados;0)
ARRAY LONGINT:C221($al_IdCampo;0)
ARRAY LONGINT:C221($al_IdTabla;0)
ARRAY LONGINT:C221($al_tipoIndexes;0)
ARRAY TEXT:C222($at_campo;0)
ARRAY TEXT:C222($at_nombreIndex;0)
ARRAY TEXT:C222($at_TablaCampo;0)
ARRAY TEXT:C222($at_uuidIndexes;0)



$y_listbox:=OBJECT Get pointer:C1124(Object named:K67:5;"listboxIndexes")
$y_IdTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"ID_Tabla")
$y_IdCampo:=OBJECT Get pointer:C1124(Object named:K67:5;"Id_campo")
$y_Tabla:=OBJECT Get pointer:C1124(Object named:K67:5;"tabla")
$y_Campo:=OBJECT Get pointer:C1124(Object named:K67:5;"campo")
$y_TipoIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoIndex")
$y_nombreIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreIndex")
$y_tipoCampo:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoCampo")
$y_tipoIndexNum:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoIndex_L")
$y_uuidIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"ID_indice")
AT_Initialize ($y_IdTabla;$y_IdCampo;$y_Tabla;$y_Campo;$y_TipoIndex;$y_nombreIndex;$y_tipoCampo;$y_tipoIndexNum;$y_uuidIndex)

$l_tipoIdTabla:=Type:C295($y_IdTabla->)

Begin SQL
	SELECT UIC.TABLE_ID, UIC.COLUMN_ID, UI.TABLE_NAME, UIC.COLUMN_NAME, UI.INDEX_NAME, UI.INDEX_TYPE, UI.INDEX_ID
	FROM _USER_INDEXES AS UI, _USER_IND_COLUMNS AS UIC
	WHERE UI.INDEX_ID = UIC.INDEX_ID
	ORDER BY UIC.TABLE_ID, UIC.COLUMN_ID
	INTO :$al_IdTabla, :$al_IdCampo, :$at_TablaCampo, :$at_campo, :$at_nombreIndex, :$al_tipoIndexes, :$at_uuidIndexes;
End SQL

For ($i_campos;Size of array:C274($al_IdTabla);1;-1)
	Case of 
		: (Not:C34(Is table number valid:C999($al_IdTabla{$i_campos})))
			AT_Delete ($i_Campos;1;->$al_IdTabla;->$al_IdCampo;->$at_TablaCampo;->$at_campo;->$at_nombreIndex;->$al_tipoIndexes;->$at_uuidIndexes)
		: (Not:C34(Is field number valid:C1000($al_IdTabla{$i_campos};$al_IdCampo{$i_campos})))
			AT_Delete ($i_Campos;1;->$al_IdTabla;->$al_IdCampo;->$at_TablaCampo;->$at_campo;->$at_nombreIndex;->$al_tipoIndexes;->$at_uuidIndexes)
	End case 
End for 

COPY ARRAY:C226($al_IdTabla;$y_IdTabla->)
COPY ARRAY:C226($al_IdCampo;$y_IdCampo->)
COPY ARRAY:C226($at_TablaCampo;$y_Tabla->)
COPY ARRAY:C226($at_campo;$y_Campo->)
COPY ARRAY:C226($al_tipoIndexes;$y_tipoIndexNum->)
COPY ARRAY:C226($at_nombreIndex;$y_nombreIndex->)
COPY ARRAY:C226($at_uuidIndexes;$y_uuidIndex->)



ARRAY TEXT:C222($y_TipoIndex->;0)
ARRAY TEXT:C222($y_TipoIndex->;Size of array:C274($y_IdTabla->))

ARRAY TEXT:C222($y_tipoCampo->;0)
ARRAY TEXT:C222($y_tipoCampo->;Size of array:C274($y_IdTabla->))


$l_progressID:=Progress New 
For ($i;1;Size of array:C274($y_Tabla->))
	$l_tipoIndex:=$y_tipoIndexNum->{$i}
	GET FIELD PROPERTIES:C258($y_IdTabla->{$i};$y_IdCampo->{$i};$l_tipoCampo)
	
	$y_Tabla->{$i}:="["+$y_Tabla->{$i}+"]"+$y_Campo->{$i}
	
	Case of 
		: ($l_tipoCampo=Is subtable:K8:11)
			$y_tipoCampo->{$i}:="Subtable"
			
		: ($l_tipoCampo=Is boolean:K8:9)
			$y_tipoCampo->{$i}:="Boolean"
			
		: ($l_tipoCampo=Is alpha field:K8:1)
			$y_tipoCampo->{$i}:="Alpha"
			
		: ($l_tipoCampo=Is text:K8:3)
			$y_tipoCampo->{$i}:="Text"
			
		: ($l_tipoCampo=Is real:K8:4)
			$y_tipoCampo->{$i}:="Real"
			
		: ($l_tipoCampo=Is integer:K8:5)
			$y_tipoCampo->{$i}:="Integer"
			
		: ($l_tipoCampo=Is longint:K8:6)
			$y_tipoCampo->{$i}:="Longint"
			
		: ($l_tipoCampo=Is date:K8:7)
			$y_tipoCampo->{$i}:="Date"
			
		: ($l_tipoCampo=Is time:K8:8)
			$y_tipoCampo->{$i}:="Time"
			
		: ($l_tipoCampo=Is picture:K8:10)
			$y_tipoCampo->{$i}:="Picture"
	End case 
	
	Case of 
		: ($l_tipoIndex=2)
			
		: ($l_tipoIndex=3)
			
		: ($l_tipoIndex=7)
			$y_TipoIndex->{$i}:="Automatic"
	End case 
	Progress SET TITLE ($l_progressId;"Obteniendo información de indexacion...";$i/Size of array:C274($y_IdTabla->);$y_Tabla->{$i};True:C214)
End for 

  // desambiguacion index compuesto o B Tree (tipo 1)
For ($i;1;Size of array:C274($y_Tabla->))
	$l_tipoIndex:=$y_tipoIndexNum->{$i}
	$t_uuidIndex:=$y_uuidIndex->{$i}
	If ($l_tipoIndex=1)
		$at_uuidIndexes{0}:=$t_uuidIndex
		$al_tipoIndexes{0}:=1
		$l_elementos:=AT_MultiArraySearch (False:C215;->$al_ElementosEncontrados;->$at_uuidIndexes;->$al_tipoIndexes)
		If ($l_elementos>1)
			  //si hay mas de un index con el mismo ID y el mismo tipo 1 se trata de un index compuesto
			$y_TipoIndex->{$i}:="Composite"
			For ($i_indexCompuestos;1;$l_elementos)
				$y_TipoIndex->{$al_ElementosEncontrados{$i_indexCompuestos}}:="Composite"
			End for 
		Else 
			$y_TipoIndex->{$i}:="B Tree"
		End if 
	End if 
	Progress SET TITLE ($l_progressId;"Resolviendo indexes compuestos...";$i/Size of array:C274($y_IdTabla->);$y_Tabla->{$i};True:C214)
End for 

  // desambiguacion index cluster o keywords (tipo 1)
For ($i;1;Size of array:C274($y_Tabla->))
	$l_tipoIndex:=$y_tipoIndexNum->{$i}
	$t_uuidIndex:=$y_uuidIndex->{$i}
	GET FIELD PROPERTIES:C258($y_IdTabla->{$i};$y_IdCampo->{$i};$l_tipoCampo)
	
	Case of 
		: (($l_tipoIndex=3) & ($l_tipoCampo=Is picture:K8:10))
			$y_TipoIndex->{$i}:="Keywords"
			$y_tipoIndexNum->{$i}:=-1
			
		: ((Position:C15("IDX_c_";$y_nombreIndex->{$i})>0) & ($l_tipoIndex=3))
			$y_TipoIndex->{$i}:="Composite"
			$y_tipoIndexNum->{$i}:=3
			
		: ((Position:C15("IDX_bt_";$y_nombreIndex->{$i})>0) & ($l_tipoIndex=1))
			$y_TipoIndex->{$i}:="B Tree"
			$y_tipoIndexNum->{$i}:=1
			
		: (Position:C15("IDX_cl_";$y_nombreIndex->{$i})>0)
			$y_TipoIndex->{$i}:="Cluster"
			$y_tipoIndexNum->{$i}:=3
			
		: ((Position:C15("IDX_k_";$y_nombreIndex->{$i})>0) & ($l_tipoIndex=3))
			$y_TipoIndex->{$i}:="Keywords"
			$y_tipoIndexNum->{$i}:=-1
			
		: ($y_tipoIndexNum->{$i}=7)
			$y_TipoIndex->{$i}:="Automatic"
			  //si el campo es de tipo alpha o texto busco si hay un segundo indice para el mismo campo de tipo cluster
			If (($l_tipoCampo=Is text:K8:3) | ($l_tipoCampo=Is alpha field:K8:1))
				$y_tipoIndexNum->{0}:=3
				$y_IdTabla->{0}:=$y_IdTabla->{$i}
				$y_idCampo->{0}:=$y_IdCampo->{$i}
				$y_TipoIndex->{0}:=""
				$l_elementosEncontrados:=AT_MultiArraySearch (False:C215;->$al_ElementosEncontrados;$y_IdTabla;$y_idCampo;$y_tipoIndexNum)
				If ($l_elementosEncontrados=1)
					$y_TipoIndex->{$al_ElementosEncontrados{1}}:="Keywords"
					$y_tipoIndexNum->{$al_ElementosEncontrados{1}}:=-1
				End if 
			End if 
			
		: (($y_tipoIndexNum->{$i}=3) & ($y_TipoIndex->{$i}=""))
			  //si el campo es de tipo alpha o texto busco si hay un segundo indice para el mismo campo de tipo cluster
			If (($l_tipoCampo=Is text:K8:3) | ($l_tipoCampo=Is alpha field:K8:1))
				$y_tipoIndexNum->{0}:=3
				$y_IdTabla->{0}:=$y_IdTabla->{$i}
				$y_idCampo->{0}:=$y_IdCampo->{$i}
				$y_TipoIndex->{0}:=""
				$l_elementosEncontrados:=AT_MultiArraySearch (False:C215;->$al_ElementosEncontrados;$y_IdTabla;$y_idCampo;$y_tipoIndexNum)
				If ($l_elementosEncontrados>1)
					$y_TipoIndex->{$al_ElementosEncontrados{1}}:="Keywords"
					$y_tipoIndexNum->{$al_ElementosEncontrados{1}}:=-1
					If ($y_nombreIndex->{$al_ElementosEncontrados{1}}="") | ((Position:C15("{kw}";$y_nombreIndex->{$al_ElementosEncontrados{1}})=0) | (Position:C15("{keywords}";$y_nombreIndex->{$al_ElementosEncontrados{1}})=0))
						$y_nombreIndex->{$al_ElementosEncontrados{1}}:=$y_Tabla->{$al_ElementosEncontrados{1}}+".{kw}"
					End if 
					$y_tipoIndexNum->{$al_ElementosEncontrados{2}}:=3
					$y_TipoIndex->{$al_ElementosEncontrados{2}}:="Cluster"
					If ($y_nombreIndex->{$al_ElementosEncontrados{2}}="")
						$y_nombreIndex->{$al_ElementosEncontrados{2}}:=$y_Tabla->{$al_ElementosEncontrados{2}}
					End if 
				End if 
			Else 
				$y_TipoIndex->{$i}:="Cluster"
			End if 
			
			
		: (($y_tipoIndexNum->{$i}=1) & ($y_TipoIndex->{$i}#"Composite"))
			  //si el campo es de tipo alpha o texto busco si hay un segundo indice para el mismo campo de tipo cluster
			If (($l_tipoCampo=Is text:K8:3) | ($l_tipoCampo=Is alpha field:K8:1))
				$y_tipoIndexNum->{0}:=3
				$y_IdTabla->{0}:=$y_IdTabla->{$i}
				$y_idCampo->{0}:=$y_IdCampo->{$i}
				$y_TipoIndex->{0}:=""
				$l_elementosEncontrados:=AT_MultiArraySearch (False:C215;->$al_ElementosEncontrados;$y_IdTabla;$y_idCampo;$y_tipoIndexNum)
				If ($l_elementosEncontrados=1)
					$y_TipoIndex->{$al_ElementosEncontrados{1}}:="Keywords"
					$y_tipoIndexNum->{$al_ElementosEncontrados{1}}:=-1
				End if 
			End if 
			
	End case 
	Progress SET TITLE ($l_progressId;"Resolviendo indexes de palabras claves...";$i/Size of array:C274($y_IdTabla->);$y_Tabla->{$i};True:C214)
End for 
Progress QUIT ($l_progressId)
