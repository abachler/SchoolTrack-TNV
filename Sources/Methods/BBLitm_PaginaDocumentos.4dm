//%attributes = {}
  // BBLitm_PaginaDocumentos()
  // Por: Alberto Bachler: 17/09/13, 13:25:59
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i;$i_registros)
C_LONGINT:C283($l_columna;$l_Columnas;$l_desplazamientoH;$l_desplazamientoV;$l_fila)
C_POINTER:C301($y_Imagen;$y_nil)
C_TEXT:C284($t_nombreObjeto)


ARRAY TEXT:C222(at_UUID_Documento;12)


$y_Imagen:=OBJECT Get pointer:C1124(Object named:K67:5;"vp_ImagenItemBBL1")
$y_Imagen->:=PICT_GetNoPictureImage 
at_UUID_Documento{1}:=""
$l_Columnas:=4
$l_fila:=0
$l_columna:=1
For ($i;2;12)
	Case of 
		: ($l_columna<$l_columnas)  // estamos en la misma fila, solo desplazamiento horizontal
			$l_desplazamientoH:=190*$l_columna
			$l_desplazamientoV:=137*$l_fila
			$l_columna:=$l_columna+1
		: ($l_columna=$l_columnas)  // estamos en la misma fila, solo desplazamiento horizontal
			$l_columna:=1
			$l_fila:=$l_fila+1
			$l_desplazamientoV:=137*$l_fila
			$l_desplazamientoH:=0
	End case 
	$t_nombreObjeto:="vp_ImagenItemBBL"+String:C10($i)
	OBJECT DUPLICATE:C1111(*;"vp_ImagenItemBBL1";$t_nombreObjeto;$y_nil;"";$l_desplazamientoH;$l_desplazamientoV)
	$y_Imagen:=OBJECT Get pointer:C1124(Object named:K67:5;$t_nombreObjeto)
	$y_Imagen->:=PICT_GetNoPictureImage 
	at_UUID_Documento{$i}:=""
End for 

DOCL_DocumentosAsociados (->[BBL_Items:61];String:C10([BBL_Items:61]Numero:1))
REDUCE SELECTION:C351([DocumentLibrary:234];12)
ARRAY TEXT:C222(at_UUID_Documento;12)
For ($i_registros;1;Records in selection:C76([DocumentLibrary:234]))
	at_UUID_Documento{$i_registros}:=[DocumentLibrary:234]Auto_UUID:2
	$t_nombreObjeto:="vp_ImagenItemBBL"+String:C10($i_registros)
	$y_Imagen:=OBJECT Get pointer:C1124(Object named:K67:5;$t_nombreObjeto)
	$y_Imagen->:=[DocumentLibrary:234]Thumbnail:4
	NEXT RECORD:C51([DocumentLibrary:234])
End for 

FORM GOTO PAGE:C247(7)

