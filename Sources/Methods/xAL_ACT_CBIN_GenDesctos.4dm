//%attributes = {}
  //xAL_ACT_CBIN_GenDesctos

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)
ARRAY INTEGER:C220(aInt;2;0)

AL_GetCurrCell (xALP_Desctos;$col;$row)

Case of 
	: (($col>3) & ($row=1))
		AL_SetHdrStyle (xALP_Desctos;$col;"Tahoma";9;5)
		$size:=Size of array:C274(atACT_NombreAlumnos)
		ARRAY INTEGER:C220(aInt;2;0)
		ARRAY INTEGER:C220(aInt;2;$size)
		For ($i;1;$size)
			aInt{1}{$i}:=1
			aInt{2}{$i}:=(3*$i)-1
		End for 
		AL_SetCellStyle (xALP_Desctos;0;0;0;0;aInt;5)
	: ($col>3)
		AL_SetHdrStyle (xALP_Desctos;$col;"Tahoma";9;5)
		AL_SetCellStyle (xALP_Desctos;1;$row-1;0;0;aInt;5)
	: ($col=2)
		AL_SetCellStyle (xALP_Desctos;1;$row;0;0;aInt;5)
		For ($header;4;Size of array:C274(atACT_Glosas)+3)
			AL_SetHdrStyle (xALP_Desctos;$header;"Tahoma";9;5)
		End for 
End case 
AL_SetCellStyle (xALP_Desctos;$col;$row;0;0;aInt;3)
AL_UpdateArrays (xALP_Desctos;-1)
REDRAW WINDOW:C456