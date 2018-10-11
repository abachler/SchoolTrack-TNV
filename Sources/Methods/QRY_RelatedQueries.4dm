//%attributes = {}
  // QRY_RelatedQueries()
  // Por: Alberto Bachler: 21/02/13, 09:18:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($b_consultaEjecutada;$b_esCampoPropio)
C_LONGINT:C283($i;$l_itemConsulta;$l_NumeroCampo;$l_numeroTabla;$l_posicionRelacion;$l_registrosEncontrados)
C_POINTER:C301($y_campo;$y_relacionMuchos;$y_relacionUno;$y_tabla;$y_tablaRelacionada)
C_TEXT:C284($t_conector2;$t_conectorBloque;$t_conectorCamposPropios;$t_delimitador;$t_nombreCampo;$t_valorBuscado)

If (False:C215)
	C_LONGINT:C283(QRY_RelatedQueries ;$0)
	C_POINTER:C301(QRY_RelatedQueries ;$1)
	C_LONGINT:C283(QRY_RelatedQueries ;$2)
	C_TEXT:C284(QRY_RelatedQueries ;$3)
End if 

$y_tabla:=$1
$l_itemConsulta:=$2
$t_conectorBloque:=$3
$0:=$l_itemConsulta

QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11=Table:C252(vyQRY_TablePointer))
SELECTION TO ARRAY:C260([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;$al_TablaRelacionada;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3;$al_campoRelacionado_Origen;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4;$al_campoRelacionado_Destino)

$l_numeroTabla:=Table:C252($y_tabla)
$l_posicionRelacion:=Find in array:C230($al_TablaRelacionada;$l_numeroTabla)
$y_relacionMuchos:=Field:C253($l_numeroTabla;$al_campoRelacionado_Destino{$l_posicionRelacion})
$y_relacionUno:=Field:C253(Table:C252(vyQRY_TablePointer);$al_campoRelacionado_Origen{$l_posicionRelacion})

If (Size of array:C274(ayQRY_Campos)>$l_itemConsulta)
	$t_nombreCampo:=Substring:C12(atQRY_NombreVirtualCampo{$l_itemConsulta};Position:C15("]";atQRY_NombreVirtualCampo{$l_itemConsulta})+1)
	$b_esCampoPropio:=(atQRY_NombreInternoCampo{$l_itemConsulta}="@userfields'value")
	$l_NumeroCampo:=Field:C253(ayQRY_Campos{$l_itemConsulta})
	If (Table:C252(ayQRY_Campos{$l_itemConsulta+1})#$l_numeroTabla)
		If (($l_NumeroCampo>0) & (Not:C34($b_esCampoPropio)))
			$y_campo:=ayQRY_Campos{$l_itemConsulta}
			$t_delimitador:=QRY_GetOperator (atQRY_Operador_Literal{$l_itemConsulta})
			$t_valorBuscado:=QRY_PrePocesoValores ($y_campo;atQRY_ValorLiteral{$l_itemConsulta};atQRY_Operador_Literal{$l_itemConsulta})
			QUERY:C277($y_tabla->;$y_campo->;$t_delimitador;$t_valorBuscado)
			$0:=$0
		Else 
			$t_conectorCamposPropios:=QRY_GetLogicalConnector (atQRY_Conector_Literal{$l_itemConsulta})
			QRY_QueryUserFields (Table:C252(Table:C252(ayQRY_Campos{$l_itemConsulta}));$l_itemConsulta;$t_conectorCamposPropios)
			$0:=$0+1
		End if 
	Else 
		For ($i;$l_itemConsulta;Size of array:C274(ayQRY_Campos))
			If (Table:C252(ayQRY_Campos{$i})=$l_numeroTabla)
				$t_nombreCampo:=Substring:C12(atQRY_NombreVirtualCampo{$i};Position:C15("]";atQRY_NombreVirtualCampo{$i})+1)
				$b_esCampoPropio:=(atQRY_NombreInternoCampo{$i}="@userfields'value")
				$l_NumeroCampo:=Field:C253(ayQRY_Campos{$i})
				If (($l_NumeroCampo>0) & (Not:C34($b_esCampoPropio)))
					$y_campo:=ayQRY_Campos{$i}
					$t_delimitador:=QRY_GetOperator (atQRY_Operador_Literal{$i})
					$t_valorBuscado:=QRY_PrePocesoValores ($y_campo;atQRY_ValorLiteral{$i};atQRY_Operador_Literal{$i})
					If ($i>$l_itemConsulta)
						$t_conector2:=QRY_GetLogicalConnector (atQRY_Conector_Literal{$i})
						Case of 
							: ($t_conector2="&")
								QUERY:C277($y_tabla->; & ;$y_campo->;$t_delimitador;$t_valorBuscado;*)
							: ($t_conector2="|")
								QUERY:C277($y_tabla->; | ;$y_campo->;$t_delimitador;$t_valorBuscado;*)
							: ($t_conector2="#")
								QUERY:C277($y_tabla->;#;$y_campo->;$t_delimitador;$t_valorBuscado;*)
							: ($t_conector2="")
								QUERY:C277($y_tabla->;$y_campo->;$t_delimitador;$t_valorBuscado;*)
						End case 
					Else 
						QUERY:C277($y_tabla->;$y_campo->;$t_delimitador;$t_valorBuscado;*)
					End if 
					$0:=$i
					$b_consultaEjecutada:=True:C214
				Else 
					If ($b_consultaEjecutada)
						QUERY:C277($y_tabla->)
						$b_consultaEjecutada:=False:C215
						$t_conectorBloque:=QRY_GetLogicalConnector (atQRY_Conector_Literal{$i})
						QRY_QueryUserFields (Table:C252(Table:C252(ayQRY_Campos{$i}));$i;$t_conectorBloque)
					End if 
				End if 
			Else 
				$0:=$i-1
				$i:=Size of array:C274(ayQRY_Campos)
			End if 
		End for 
		If ($b_consultaEjecutada)
			QUERY:C277($y_tabla->)
		End if 
	End if 
Else 
	$t_nombreCampo:=Substring:C12(atQRY_NombreVirtualCampo{$l_itemConsulta};Position:C15("]";atQRY_NombreVirtualCampo{$l_itemConsulta})+1)
	$b_esCampoPropio:=(atQRY_NombreInternoCampo{$l_itemConsulta}="@userfields'value")
	$l_NumeroCampo:=Field:C253(ayQRY_Campos{$l_itemConsulta})
	If (($l_NumeroCampo>0) & (Not:C34($b_esCampoPropio)))
		$y_campo:=ayQRY_Campos{$l_itemConsulta}
		$t_delimitador:=QRY_GetOperator (atQRY_Operador_Literal{$l_itemConsulta})
		$t_valorBuscado:=QRY_PrePocesoValores ($y_campo;atQRY_ValorLiteral{$l_itemConsulta};atQRY_Operador_Literal{$l_itemConsulta})
		QUERY:C277($y_tabla->;$y_campo->;$t_delimitador;$t_valorBuscado)
		$0:=$0+1
	Else 
		$t_conectorCamposPropios:=QRY_GetLogicalConnector (atQRY_Conector_Literal{$l_itemConsulta})
		QRY_QueryUserFields (Table:C252(Table:C252(ayQRY_Campos{$l_itemConsulta}));$l_itemConsulta;$t_conectorCamposPropios)
		$0:=$0+1
	End if 
End if 

$l_registrosEncontrados:=dhQRY_BusquedasPorAgnos ($y_relacionUno;$y_relacionMuchos)
If ($l_registrosEncontrados=-1)
	$y_tablaRelacionada:=Table:C252(Table:C252($y_relacionMuchos))
	Case of 
		: (Table:C252($y_tablaRelacionada)=Table:C252(->[Alumnos_Atrasos:55]))
			QUERY SELECTION:C341($y_tablaRelacionada->;[Alumnos_Atrasos:55]Año:6=<>gYear)
			
		: (Table:C252($y_tablaRelacionada)=Table:C252(->[Alumnos_Anotaciones:11]))
			QUERY SELECTION:C341($y_tablaRelacionada->;[Alumnos_Anotaciones:11]Año:11=<>gYear)
			
		: (Table:C252($y_tablaRelacionada)=Table:C252(->[Alumnos_Inasistencias:10]))
			QUERY SELECTION:C341($y_tablaRelacionada->;[Alumnos_Inasistencias:10]Año:8=<>gYear)
			
		: (Table:C252($y_tablaRelacionada)=Table:C252(->[Alumnos_Castigos:9]))
			QUERY SELECTION:C341($y_tablaRelacionada->;[Alumnos_Castigos:9]Año:5=<>gYear)
			
		: (Table:C252($y_tablaRelacionada)=Table:C252(->[Alumnos_Licencias:73]))
			QUERY SELECTION:C341($y_tablaRelacionada->;[Alumnos_Licencias:73]Año:9=<>gYear)
			
		: (Table:C252($y_tablaRelacionada)=Table:C252(->[Alumnos_Suspensiones:12]))
			QUERY SELECTION:C341($y_tablaRelacionada->;[Alumnos_Suspensiones:12]Año:1=<>gYear)
			
		: (Table:C252($y_tablaRelacionada)=Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
			QUERY SELECTION:C341($y_tablaRelacionada->;[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
			
		: (Table:C252($y_tablaRelacionada)=Table:C252(->[Alumnos_EvaluacionAprendizajes:203]))
			QUERY SELECTION:C341($y_tablaRelacionada->;[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
			
		: (Table:C252($y_tablaRelacionada)=Table:C252(->[Alumnos_SintesisAnual:210]))
			QUERY SELECTION:C341($y_tablaRelacionada->;[Alumnos_SintesisAnual:210]Año:2=<>gYear)
			
		: (Table:C252($y_tablaRelacionada)=Table:C252(->[Asignaturas_SintesisAnual:202]))
			QUERY SELECTION:C341($y_tablaRelacionada->;[Asignaturas_SintesisAnual:202]Año:3=<>gYear)
			
		: (Table:C252($y_tablaRelacionada)=Table:C252(->[Cursos_SintesisAnual:63]))
			QUERY SELECTION:C341($y_tablaRelacionada->;[Cursos_SintesisAnual:63]Año:2=<>gYear)
	End case 
	
	$l_registrosEncontrados:=KRL_RelateSelection ($y_relacionUno;$y_relacionMuchos)
End if 

CREATE SET:C116(vyQRY_TablePointer->;"RelatedSearch")
Case of 
	: ($t_conectorBloque="&")
		INTERSECTION:C121("SearchResult";"RelatedSearch";"SearchResult")
	: ($t_conectorBloque="|")
		UNION:C120("SearchResult";"RelatedSearch";"SearchResult")
	: ($t_conectorBloque="#")
		DIFFERENCE:C122("SearchResult";"RelatedSearch";"SearchResult")
	: ($t_conectorBloque="")
		CREATE SET:C116(vyQRY_TablePointer->;"SearchResult")
End case 

SET_ClearSets ("RelatedSearch")

