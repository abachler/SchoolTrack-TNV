  // CIM_Indices.NombreIndex()
  // Por: Alberto Bachler K.: 06-04-15, 15:03:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_filaEditada;$l_tipoIndexActual)
C_POINTER:C301($y_IdCampo;$y_IdTabla;$y_nombreIndex;$y_TipoIndex;$y_tipoIndexNum)
C_TEXT:C284($t_nombreIndexActual)

ARRAY LONGINT:C221($al_filas;0)
ARRAY POINTER:C280($ay_campos;0)

$y_nombreIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreIndex")
$y_TipoIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoIndex")
$y_tipoIndexNum:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoIndex_L")
$y_IdTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"ID_Tabla")
$y_IdCampo:=OBJECT Get pointer:C1124(Object named:K67:5;"Id_campo")

Case of 
	: (Form event:C388=On Data Change:K2:15)
		$l_filaEditada:=$y_nombreIndex->
		$l_tipoIndexActual:=$y_tipoIndexNum->{$l_filaEditada}
		$t_nombreIndexActual:=$y_nombreIndex->{0}
		Case of 
			: ($y_nombreIndex->{$l_filaEditada}="IDX_k_@")
				$y_TipoIndex->{$l_filaEditada}:="Keywords"
				$y_tipoIndexNum->{$l_filaEditada}:=-1
			: ($y_nombreIndex->{$l_filaEditada}="IDX_a_@")
				$y_TipoIndex->{$l_filaEditada}:="Automatic"
				$y_tipoIndexNum->{$l_filaEditada}:=7
			: ($y_nombreIndex->{$l_filaEditada}="IDX_cl_@")
				$y_TipoIndex->{$l_filaEditada}:="Cluster"
				$y_tipoIndexNum->{$l_filaEditada}:=3
			: ($y_nombreIndex->{$l_filaEditada}="IDX_c_@")
				$y_TipoIndex->{$l_filaEditada}:="Composite"
				$y_tipoIndexNum->{$l_filaEditada}:=3
			: ($y_nombreIndex->{$l_filaEditada}="IDX_bt_@")
				$y_TipoIndex->{$l_filaEditada}:="B Tree"
				$y_tipoIndexNum->{$l_filaEditada}:=1
		End case 
		If ($t_nombreIndexActual="")
			DELETE INDEX:C967(Field:C253($y_IdTabla->{$l_filaEditada};$y_IdCampo->{$l_filaEditada}))
		Else 
			DELETE INDEX:C967($t_nombreIndexActual)
		End if 
		APPEND TO ARRAY:C911($ay_campos;Field:C253($y_IdTabla->{$l_filaEditada};$y_IdCampo->{$l_filaEditada}))
		CREATE INDEX:C966(Table:C252($y_IdTabla->{$l_filaEditada})->;$ay_campos;$y_tipoIndexNum->{$l_filaEditada};$y_nombreIndex->{$l_filaEditada})
		
		If ($t_nombreIndexActual="")
			$y_IdTabla->{0}:=$y_IdTabla->{$l_filaEditada}
			$y_IdCampo->{0}:=$y_IdCampo->{$l_filaEditada}
			AT_MultiArraySearch (False:C215;->$al_filas;$y_IdTabla;$y_IdCampo)
			AT_Initialize (->$ay_campos)
			For ($i;1;Size of array:C274($al_filas))
				If ($al_filas{$i}#$l_filaEditada)
					APPEND TO ARRAY:C911($ay_campos;Field:C253($y_IdTabla->{$al_filas{$i}};$y_IdCampo->{$al_filas{$i}}))
					CREATE INDEX:C966(Table:C252($y_IdTabla->{$al_filas{$i}})->;$ay_campos;$y_tipoIndexNum->{$al_filas{$i}};$y_nombreIndex->{$al_filas{$i}})
				End if 
			End for 
		End if 
		
End case 