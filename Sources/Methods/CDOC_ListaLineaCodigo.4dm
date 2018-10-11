//%attributes = {}
  // CDOC_ListaLineaCodigo()
  // Por: Alberto Bachler: 18/04/13, 12:24:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_BLOB:C604($x_Data)
C_LONGINT:C283($i;$l_alto;$l_ancho;$l_caracteres)
C_POINTER:C301($y_arregloCodigo;$y_arregloNumeroLineas)
C_TEXT:C284($t_codigo;$t_codigoMultiEstilo;$t_texto_remover)

If (False:C215)
	C_TEXT:C284(CDOC_ListaLineaCodigo ;$1)
	C_POINTER:C301(CDOC_ListaLineaCodigo ;$2)
	C_POINTER:C301(CDOC_ListaLineaCodigo ;$3)
End if 

$t_codigo:=$1
$y_arregloCodigo:=$2
$y_arregloNumeroLineas:=$3


$t_codigoMultiEstilo:=CDOC_CodigoMultiEstilo ($t_codigo)
  //
  //CODE HIGHLIGHT ($t_codigo;$t_codigoMultiEstilo;"4dus";"xhtml")
  //
  //$t_texto_remover:="<!-- Generator: GNU source-highlight 3.1.6"+Char(10)
  //$t_texto_remover:=$t_texto_remover+"by Lorenzo Bettini"+Char(10)
  //$t_texto_remover:=$t_texto_remover+"http://www.lorenzobettini.it"+Char(10)
  //$t_texto_remover:=$t_texto_remover+"http://www.gnu.org/software/src-highlite -->"+Char(10)
  //$t_texto_remover:=$t_texto_remover+"<pre><tt>"
  //$t_codigoMultiEstilo:=Replace string($t_codigoMultiEstilo;$t_texto_remover;"")
  //$t_codigoMultiEstilo:=Replace string($t_codigoMultiEstilo;"</tt></pre>";"")
  //$t_codigoMultiEstilo:=Replace string($t_codigoMultiEstilo;"span style=\"color: #808080\">//";"span style=\"color: #D81E05\">//")
  //$t_codigoMultiEstilo:=Replace string($t_codigoMultiEstilo;"span style=\"color: #808080\">[";"span style=\"font-weight:bold;color: #9A1900\">[")
  //$t_codigoMultiEstilo:=Replace string($t_codigoMultiEstilo;"span style=\"color: #9A1900\">[";"span style=\"font-weight:bold;color: #9A1900\">[")

AT_Text2Array ($y_arregloCodigo;$t_codigoMultiEstilo;Char:C90(10))
ARRAY LONGINT:C221($y_arregloNumeroLineas->;Size of array:C274($y_arregloCodigo->))
$l_ancho:=0
vt_testigo:=""
For ($i;1;Size of array:C274($y_arregloNumeroLineas->))
	$y_arregloNumeroLineas->{$i}:=$i
	$l_caracteres:=Length:C16(ST Get plain text:C1092($y_arregloCodigo->{$i}))
	If ($l_caracteres>$l_ancho)
		vt_testigo:=ST Get plain text:C1092($y_arregloCodigo->{$i})
		$l_ancho:=$l_caracteres
	End if 
End for 
OBJECT GET BEST SIZE:C717(vt_testigo;$l_ancho;$l_alto)
LISTBOX SET COLUMN WIDTH:C833($y_arregloCodigo->;$l_ancho)

