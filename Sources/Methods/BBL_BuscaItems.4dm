//%attributes = {}
  //BBL_BuscaItems
C_TEXT:C284($1;$2;$3;$4;$5)
C_LONGINT:C283($0)
ARRAY LONGINT:C221(al_NumeroItem;0)
C_BOOLEAN:C305($b_continuar)
C_TEXT:C284($t_agnoEdicion;$t_autor;$t_clasificacion;$t_Editor;$t_titulo)

READ ONLY:C145([BBL_Items:61])

$b_continuar:=True:C214

Case of 
	: (Count parameters:C259=5)
		$t_titulo:=$1
		$t_autor:=$2
		$t_Editor:=$3
		$t_clasificacion:=$4
		$t_agnoEdicion:=$5
	: (Count parameters:C259=4)
		$t_titulo:=$1
		$t_autor:=$2
		$t_Editor:=$3
		$t_clasificacion:=$4
	: (Count parameters:C259=3)
		$t_titulo:=$1
		$t_autor:=$2
		$t_Editor:=$3
	: (Count parameters:C259=2)
		$t_titulo:=$1
		$t_autor:=$2
		$t_Editor:=""
	: (Count parameters:C259=1)
		$t_titulo:=$1
		$t_autor:=""
		$t_Editor:=""
	Else 
		$b_continuar:=False:C215
End case 

If ($b_continuar)
	
	CREATE RECORD:C68([BBL_Items:61])
	[BBL_Items:61]Titulos:5:=$t_titulo
	[BBL_Items:61]Autores:7:=$t_autor
	[BBL_Items:61]Editores:9:=$t_Editor
	BBLitm_NormalizaAutores 
	BBLitm_NormalizaTitulos 
	BBLitm_NormalizaEditores 
	$t_titulo:=[BBL_Items:61]Primer_título:4
	$t_autor:=[BBL_Items:61]Primer_autor:6
	$t_Editor:=[BBL_Items:61]Editores:9
	UNLOAD RECORD:C212([BBL_Items:61])
	
	QUERY:C277([BBL_Items:61];[BBL_Items:61]Primer_título:4=$t_titulo;*)
	If (Count parameters:C259>=2)
		QUERY:C277([BBL_Items:61]; & ;[BBL_Items:61]Primer_autor:6=$t_autor;*)
	End if 
	If (Count parameters:C259>=3)
		QUERY:C277([BBL_Items:61]; & ;[BBL_Items:61]Primer_editor:8=$t_Editor;*)
	End if 
	If (Count parameters:C259>=4)
		QUERY:C277([BBL_Items:61];[BBL_Items:61]Clasificacion:2=$t_clasificacion;*)
	End if 
	If (Count parameters:C259=5)
		QUERY:C277([BBL_Items:61]; & ;[BBL_Items:61]Fecha_de_edicion:10=$t_agnoEdicion;*)
	End if 
	
	QUERY:C277([BBL_Items:61])
	SELECTION TO ARRAY:C260([BBL_Items:61]Numero:1;al_NumeroItem)
	QUERY WITH ARRAY:C644([BBL_Items:61]Numero:1;al_NumeroItem)
	$0:=1
Else 
	$0:=-1
End if 

