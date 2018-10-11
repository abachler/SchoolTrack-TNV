//%attributes = {}
  // TMT_ColorCelda()
  // Por: Alberto Bachler: 11/06/13, 10:18:32
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_DATE:C307($3)
C_DATE:C307($4)

C_DATE:C307($d_fechaDesde;$d_fechaHasta)
C_LONGINT:C283($l_columna;$l_fila)

ARRAY LONGINT:C221($al_CeldasSeleccionadas_2D;0)
If (False:C215)
	C_LONGINT:C283(TMT_ColorCelda ;$1)
	C_LONGINT:C283(TMT_ColorCelda ;$2)
	C_DATE:C307(TMT_ColorCelda ;$3)
	C_DATE:C307(TMT_ColorCelda ;$4)
End if 

$l_columna:=$1
$l_fila:=$2
$d_fechaDesde:=$3
$d_fechaHasta:=$4

If ($d_fechaHasta<Current date:C33(*))
	AL_SetCellColor (xALP_Horario;$l_columna;$l_fila;$l_columna;$l_fila;$al_CeldasSeleccionadas_2D;"";15*16+9)
Else 
	AL_SetCellColor (xALP_Horario;$l_columna;$l_fila;$l_columna;$l_fila;$al_CeldasSeleccionadas_2D;"";16)
End if 

