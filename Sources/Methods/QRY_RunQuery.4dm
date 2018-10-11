//%attributes = {}
  // QRY_RunQuery()
  // Por: Alberto Bachler: 21/02/13, 09:53:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)

C_BOOLEAN:C305($b_condicionProcesada;$b_esCampoPropio;$b_ProcesarCondicion)
C_LONGINT:C283($i;$l_ItemsConsulta;$l_itemsProcesados;$l_numeroCampo;$pID)
C_POINTER:C301($y_campo;$y_Tabla)
C_TEXT:C284($t_delimitador;$t_nombrecampo;$t_valorBuscado)
_O_C_STRING:C293(1;$t_conector;$t_conectorSiguiente)

ARRAY LONGINT:C221($al_IdAlumnos;0)
If (False:C215)
	C_LONGINT:C283(QRY_RunQuery ;$0)
	C_POINTER:C301(QRY_RunQuery ;$1)
End if 

$0:=0
$y_Tabla:=$1
$t_conectorSiguiente:=""
$t_conector:=""

MESSAGES ON:C181
CREATE EMPTY SET:C140($y_Tabla->;"SearchResult")
$b_condicionProcesada:=False:C215
$b_ProcesarCondicion:=False:C215
$l_ItemsConsulta:=Size of array:C274(atQRY_NombreInternoCampo)
If (bSrchSel=1)
	CREATE SET:C116($y_Tabla->;"Theselection")
End if 

If ($l_ItemsConsulta=0)
	BEEP:C151
Else 
	
	  //PROCESAMIENTO DEL PRIMER ITEM DE LA CONSULTA
	$t_nombrecampo:=Field name:C257(ayQRY_Campos{1})
	$b_esCampoPropio:=(atQRY_NombreInternoCampo{1}="@userfields'value")
	$l_numeroCampo:=Field:C253(ayQRY_Campos{1})
	Case of 
		: ([xShell_Queries:53]Name:2="Hijo de ex alumno")
			$pID:=IT_UThermometer (1;0;__ ("Buscando alumnos hijos de ex alumnos.."))
			
			  //ALL RECORDS([Alumnos])
			  //SELECTION TO ARRAY([Alumnos]Número;$al_IdAlumnos)
			  //For ($i;1;Size of array($al_IdAlumnos))
			  //QUERY([Alumnos];[Alumnos]Número=$al_IdAlumnos{$i})
			  //   //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hijo de ex alumno")
			  // 
			  //If (Records in subselection([Alumnos]Conexiones)>0)
			  //ADD TO SET([Alumnos];"SearchResult")
			  //End if 
			  //End for 
			
			  //MONO CONEXIONES
			QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Conexion:1="Hijo de ex alumno")
			KRL_RelateSelection (->[Alumnos:2]auto_uuid:72;->[Alumnos_Conexiones:212]Alumno_AutoUUID:7;"")
			  //ADD TO SET([Alumnos];"SearchResult")
			
			  // Modificado por: Alexis Bustamante (10-07-2017)
			  //TICKET 18761
			CREATE SET:C116([Alumnos:2];"SearchResult")
			
			KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
			
			$l_itemsProcesados:=$l_ItemsConsulta+1
			IT_UThermometer (-2;$pID)
			
		: (($b_esCampoPropio) & (Table:C252(ayQRY_Campos{1})=Table:C252($y_Tabla)))
			QRY_QueryUserFields (Table:C252(Table:C252(ayQRY_Campos{1}));1;"")
			If ($l_ItemsConsulta=1)
				CREATE SET:C116($y_Tabla->;"SearchResult")
				$l_itemsProcesados:=$l_ItemsConsulta+1
			Else 
				$l_itemsProcesados:=2
			End if 
			
			
		: (($l_numeroCampo>0) & (Table:C252(ayQRY_Campos{1})=Table:C252($y_Tabla)))
			$y_campo:=ayQRY_Campos{1}
			$t_delimitador:=QRY_GetOperator (atQRY_Operador_Literal{1})
			$t_valorBuscado:=QRY_PrePocesoValores ($y_campo;atQRY_ValorLiteral{1};atQRY_Operador_Literal{1})
			
			If ($l_ItemsConsulta=1)
				
				If (bSrchSel=1)
					
					If (Type:C295($y_campo->)=Is picture:K8:10)
						  /////
						  // Modificado por: Alexis Bustamante (10-07-2017)
						  ///TICKET 182553 
						If ($t_delimitador#"=")
							QUERY BY FORMULA:C48($y_Tabla->;Picture size:C356($y_campo->)>0)
						Else 
							QUERY BY FORMULA:C48($y_Tabla->;Picture size:C356($y_campo->)=0)
						End if 
					Else 
						QUERY SELECTION:C341($y_Tabla->;$y_campo->;$t_delimitador;$t_valorBuscado)
					End if 
					
				Else 
					If (Type:C295($y_campo->)=Is picture:K8:10)
						  //QUERY($y_Tabla->;$y_campo->;$t_delimitador;0)
						
						  // Modificado por: Alexis Bustamante (10-07-2017)
						  //TICKET182553 
						If ($t_delimitador#"=")
							QUERY BY FORMULA:C48($y_Tabla->;Picture size:C356($y_campo->)>0)
						Else 
							QUERY BY FORMULA:C48($y_Tabla->;Picture size:C356($y_campo->)=0)
						End if 
					Else 
						QUERY:C277($y_Tabla->;$y_campo->;$t_delimitador;$t_valorBuscado)
					End if 
				End if 
				CREATE SET:C116($y_Tabla->;"SearchResult")
				$l_itemsProcesados:=$l_ItemsConsulta+1
			Else 
				If (bSrchSel=1)
					QUERY SELECTION:C341($y_Tabla->;$y_campo->;$t_delimitador;$t_valorBuscado;*)
				Else 
					QUERY:C277($y_Tabla->;$y_campo->;$t_delimitador;$t_valorBuscado;*)
				End if 
				If ((atQRY_NombreInternoCampo{2}="@userfields'value") | (Table:C252(ayQRY_Campos{2})#Table:C252($y_Tabla)))
					If (bSrchSel=1)
						QUERY SELECTION:C341($y_Tabla->)
					Else 
						QUERY:C277($y_Tabla->)
					End if 
					CREATE SET:C116($y_Tabla->;"SearchResult")
				End if 
				$l_itemsProcesados:=2
			End if 
			
			
			
		: (Table:C252(ayQRY_Campos{1})#Table:C252($y_Tabla))
			$l_itemsProcesados:=QRY_RelatedQueries (Table:C252(Table:C252(ayQRY_Campos{1}));1;"")+1
			If ($l_ItemsConsulta=1)
				CREATE SET:C116($y_Tabla->;"SearchResult")
			End if 
	End case 
	
	
	
	
	
	
	
	
	  // PROCESAMIENTO DE LOS SIGUIENTES ITEMS DE LA CONSULTA
	If ($l_itemsProcesados<=$l_ItemsConsulta)
		For ($i;$l_itemsProcesados;$l_ItemsConsulta)
			$t_conector:=QRY_GetLogicalConnector (atQRY_Conector_Literal{$i})
			$b_esCampoPropio:=(atQRY_NombreInternoCampo{$i}="@userfields'value")
			$l_numeroCampo:=Field:C253(ayQRY_Campos{$i})
			
			
			Case of 
				: (($l_numeroCampo>0) & (Not:C34($b_esCampoPropio)) & (Table:C252(ayQRY_Campos{$i})=Table:C252($y_Tabla)))
					$y_campo:=ayQRY_Campos{$i}
					$t_delimitador:=QRY_GetOperator (atQRY_Operador_Literal{$i})
					$t_valorBuscado:=QRY_PrePocesoValores ($y_campo;atQRY_ValorLiteral{$i};atQRY_Operador_Literal{$i})
					If ((Not:C34((atQRY_NombreInternoCampo{$i-1}="@userfields'value"))) & (Table:C252(ayQRY_Campos{$i-1})=Table:C252($y_Tabla)))
						If (bSrchSel=1)
							Case of 
								: ($t_conector="&")
									QUERY SELECTION:C341($y_Tabla->; & ;$y_campo->;$t_delimitador;$t_valorBuscado;*)
								: ($t_conector="|")
									QUERY SELECTION:C341($y_Tabla->; | ;$y_campo->;$t_delimitador;$t_valorBuscado;*)
								: ($t_conector="#")
									QUERY SELECTION:C341($y_Tabla->;#;$y_campo->;$t_delimitador;$t_valorBuscado;*)
							End case 
						Else 
							Case of 
								: ($t_conector="&")
									QUERY:C277($y_Tabla->; & ;$y_campo->;$t_delimitador;$t_valorBuscado;*)
								: ($t_conector="|")
									QUERY:C277($y_Tabla->; | ;$y_campo->;$t_delimitador;$t_valorBuscado;*)
								: ($t_conector="#")
									QUERY:C277($y_Tabla->;#;$y_campo->;$t_delimitador;$t_valorBuscado;*)
							End case 
						End if 
					Else 
						If (bSrchSel=1)
							QUERY SELECTION:C341($y_Tabla->;$y_campo->;$t_delimitador;$t_valorBuscado;*)
						Else 
							QUERY:C277($y_Tabla->;$y_campo->;$t_delimitador;$t_valorBuscado;*)
						End if 
					End if 
					
					Case of 
						: ($i<$l_ItemsConsulta)
							  // si el siguiente item es una tablas relacionadas o un campos propios, ejecuto la consulta
							If ((atQRY_NombreInternoCampo{$i+1}="@userfields'value") | (Table:C252(ayQRY_Campos{$i+1})#Table:C252($y_Tabla)))
								If (bSrchSel=1)
									QUERY SELECTION:C341($y_Tabla->)
								Else 
									QUERY:C277($y_Tabla->)
								End if 
								CREATE SET:C116($y_tabla->;"SearchResult")
							End if 
							
						: ($i=$l_ItemsConsulta)
							  // si es el último item de la consulta, la ejecuto
							If (bSrchSel=1)
								QUERY SELECTION:C341($y_Tabla->)
							Else 
								QUERY:C277($y_Tabla->)
							End if 
							CREATE SET:C116($y_tabla->;"TempSearch")
							If ((atQRY_NombreInternoCampo{$i-1}="@userfields'value") | (Table:C252(ayQRY_Campos{$i-1})#Table:C252($y_Tabla)))
								$t_conector:=QRY_GetLogicalConnector (atQRY_Conector_Literal{$i})
								Case of 
									: (($t_conector="|") | ($t_conector=""))
										UNION:C120("TempSearch";"SearchResult";"SearchResult")
									: ($t_conector="&")
										INTERSECTION:C121("TempSearch";"SearchResult";"SearchResult")
									: ($t_conector="&")
										DIFFERENCE:C122("SearchResult";"TempSearch";"SearchResult")
								End case 
							Else 
								CREATE SET:C116($y_tabla->;"SearchResult")
							End if 
					End case 
					
					
					
					
					
					
				: (($b_esCampoPropio) & (Table:C252(ayQRY_Campos{$i})=Table:C252($y_Tabla)))
					QRY_QueryUserFields (Table:C252(Table:C252(ayQRY_Campos{$i}));$i;$t_conector)
					CREATE SET:C116($y_Tabla->;"TempSearch")
					$t_conector:=QRY_GetLogicalConnector (atQRY_Conector_Literal{$i})
					Case of 
						: (($t_conector="|") | ($t_conector=""))
							UNION:C120("TempSearch";"SearchResult";"SearchResult")
						: ($t_conector="&")
							INTERSECTION:C121("TempSearch";"SearchResult";"SearchResult")
						: ($t_conector="&")
							DIFFERENCE:C122("SearchResult";"TempSearch";"SearchResult")
					End case 
					
					
					
				: (Table:C252(ayQRY_Campos{$i})#Table:C252($y_Tabla))
					$t_conector:=QRY_GetLogicalConnector (atQRY_Conector_Literal{$l_itemsProcesados})
					$i:=QRY_RelatedQueries (Table:C252(Table:C252(ayQRY_Campos{$i}));$i;$t_conector)
			End case 
		End for 
		
	Else 
	End if 
	MESSAGES OFF:C175
	USE SET:C118("SearchResult")
	
	
	dhQF_RefineQuery 
	CREATE SET:C116($y_Tabla->;"SearchResult")
	If (bSrchSel=1)
		INTERSECTION:C121("Theselection";"SearchResult";"SearchResult")
		USE SET:C118("SearchResult")  //20131001 RCH Cuando se consultaba por una tabla relacionada y la interseccion no encontraba registros, se salia con la seleccion de registros ya que la seleccion no cambiaba... 125619
	End if 
	If (Records in set:C195("SearchResult")>0)
		USE SET:C118("SearchResult")
		$0:=Records in set:C195("SearchResult")
		CREATE SET:C116($y_Tabla->;"Selection"+Table name:C256($y_Tabla))
		USE SET:C118("Selection"+Table name:C256($y_Tabla))
	End if 
	$0:=Records in selection:C76($y_Tabla->)
	
	If (bCurrentYearOnly=1)
		For ($i;1;Size of array:C274(ayQRY_Campos))
			Case of 
				: (Table:C252($y_Tabla)=Table:C252(->[Alumnos_Atrasos:55]))
					QUERY SELECTION:C341($y_Tabla->;[Alumnos_Atrasos:55]Año:6=<>gYear)
					
				: (Table:C252($y_Tabla)=Table:C252(->[Alumnos_Anotaciones:11]))
					QUERY SELECTION:C341($y_Tabla->;[Alumnos_Anotaciones:11]Año:11=<>gYear)
					
				: (Table:C252($y_Tabla)=Table:C252(->[Alumnos_Inasistencias:10]))
					QUERY SELECTION:C341($y_Tabla->;[Alumnos_Inasistencias:10]Año:8=<>gYear)
					
				: (Table:C252($y_Tabla)=Table:C252(->[Alumnos_Castigos:9]))
					QUERY SELECTION:C341($y_Tabla->;[Alumnos_Castigos:9]Año:5=<>gYear)
					
				: (Table:C252($y_Tabla)=Table:C252(->[Alumnos_Licencias:73]))
					QUERY SELECTION:C341($y_Tabla->;[Alumnos_Licencias:73]Año:9=<>gYear)
					
				: (Table:C252($y_Tabla)=Table:C252(->[Alumnos_Suspensiones:12]))
					QUERY SELECTION:C341($y_Tabla->;[Alumnos_Suspensiones:12]Año:1=<>gYear)
					
				: (Table:C252($y_Tabla)=Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
					QUERY SELECTION:C341($y_Tabla->;[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
					
				: (Table:C252($y_Tabla)=Table:C252(->[Alumnos_EvaluacionAprendizajes:203]))
					QUERY SELECTION:C341($y_Tabla->;[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
					
				: (Table:C252($y_Tabla)=Table:C252(->[Alumnos_SintesisAnual:210]))
					QUERY SELECTION:C341($y_Tabla->;[Alumnos_SintesisAnual:210]Año:2=<>gYear)
					
				: (Table:C252($y_Tabla)=Table:C252(->[Asignaturas_SintesisAnual:202]))
					QUERY SELECTION:C341($y_Tabla->;[Asignaturas_SintesisAnual:202]Año:3=<>gYear)
					
				: (Table:C252($y_Tabla)=Table:C252(->[Cursos_SintesisAnual:63]))
					QUERY SELECTION:C341($y_Tabla->;[Cursos_SintesisAnual:63]Año:2=<>gYear)
			End case 
		End for 
		$0:=Records in selection:C76($y_Tabla->)
	End if 
	SET_ClearSets ("SearchResult";"TheSelection";"TempSearch")
	
End if 