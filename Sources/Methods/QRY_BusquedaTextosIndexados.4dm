//%attributes = {}
  // QRY_BusquedaTextosIndexados()
  // Por: Alberto Bachler K.: 10-12-14, 18:32:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_numeroTerminos;$l_opcionBusqueda)
C_POINTER:C301($y_campo;$y_tabla)
C_TEXT:C284($t_expresion)

ARRAY TEXT:C222($at_terminos;0)

$t_expresion:=$1
$y_campo:=$2

$y_tabla:=Table:C252(Table:C252($y_campo))
$l_opcionBusqueda:=Contiene todas las palabras
Case of 
	: (Count parameters:C259=4)
		$l_OpcionBusqueda:=$3
		$y_tabla:=$4
	: (Count parameters:C259=3)
		$l_OpcionBusqueda:=$3
End case 


  // creo un registro asignando el texto a buscar a un campo con index de palabras claves
$t_expresion:=Replace string:C233($t_expresion;"@";"")
QUERY:C277([xShell_KeywordQueries:120];[xShell_KeywordQueries:120]Keywords:1=$t_expresion)
If (Records in selection:C76([xShell_KeywordQueries:120])=0)
	CREATE RECORD:C68([xShell_KeywordQueries:120])
	[xShell_KeywordQueries:120]Keywords:1:=$t_expresion
	SAVE RECORD:C53([xShell_KeywordQueries:120])
End if 
  // obtengo un arreglo con las palabras que 4D indexó utilizando el algoritmo ICU (http://userguide.icu-project.org/boundaryanalysis)
DISTINCT VALUES:C339([xShell_KeywordQueries:120]Keywords:1;$at_terminos)

  //  construyo y ejecuto la búsqueda de cada una de las palabras en el texto
$l_numeroTerminos:=Size of array:C274($at_terminos)
If ($l_numeroTerminos>0)
	  //DESCRIBE QUERY EXECUTION(True)
	Case of 
		: ($l_OpcionBusqueda=Contiene todas las palabras)
			QUERY:C277($y_tabla->;$y_campo->%$at_terminos{1};*)
			For ($i;2;$l_numeroTerminos)
				QUERY:C277($y_tabla->; & ;$y_campo->%$at_terminos{$i};*)
			End for 
			QUERY:C277($y_tabla->)
			
		: ($l_OpcionBusqueda=Contiene alguna de las palabras)
			QUERY:C277($y_tabla->;$y_campo->%$at_terminos{1};*)
			For ($i;2;$l_numeroTerminos)
				QUERY:C277($y_tabla->; | ;$y_campo->%$at_terminos{$i};*)
			End for 
			QUERY:C277($y_tabla->)
	End case 
	  //$t_QueryPlan:=Get last query path(Description in Text Format)
	  //DESCRIBE QUERY EXECUTION(False)
End if 




