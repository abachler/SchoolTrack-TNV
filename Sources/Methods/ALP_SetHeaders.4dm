//%attributes = {}
  // ALP_SetHeaders()
  // Por: Alberto Bachler K.: 10-12-13, 10:01:30
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_area:=$1
$l_columna:=$2
$l_numeroColumnas:=$3
$t_textoEncabezado:=$4

If (Application version:C493>="1400")
	If (Position:C15(Char:C90(94);$t_textoEncabezado)>0)
		$l_refIcono:=Num:C11(ST_GetWord ($t_textoEncabezado;2;Char:C90(94)))-Use PicRef:K28:4
		$t_textoEncabezado:=ST_GetWord ($t_textoEncabezado;1;Char:C90(94))
	End if 
	EXECUTE FORMULA:C63("AL_SetColumnTextProperty (xALP_ASNotas;$l_columna;ALP_Column_HeaderText;$t_textoEncabezado)")
	EXECUTE FORMULA:C63("AL_SetCellLongProperty (xALP_ASNotas;0;$l_columna;ALP_Cell_RightIconID;$l_refIcono)")
Else 
	AL_SetHeaders ($l_area;$l_columna;$l_numeroColumnas;$t_textoEncabezado)
End if 
