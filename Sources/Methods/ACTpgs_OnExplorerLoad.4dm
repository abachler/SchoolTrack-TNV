//%attributes = {}
  // ACTpgs_OnExplorerLoad()
  //
  //
  // creado por: Alberto Bachler Klein: 14-03-16, 17:11:04
  // basado en codigo anterior de Roberto Catalan (?)
  //CAMBIOS
  //20170825 RCH Ticket 187923.
  // -----------------------------------------------------------
C_LONGINT:C283($i_columna;$i_columnas;$i_registro;$l_registros;$vl_idTercero)

ARRAY BOOLEAN:C223($abACT_Nulo;0)
ARRAY BOOLEAN:C223($abACT_VentaRapida;0)
ARRAY LONGINT:C221($alACT_idTercero;0)



$l_registros:=Size of array:C274(alBWR_recordNumber)
READ ONLY:C145([ACT_Pagos:172])


CREATE SELECTION FROM ARRAY:C640([ACT_Pagos:172];alBWR_recordNumber;"")
SELECTION TO ARRAY:C260([ACT_Pagos:172]Venta_Rapida:10;$abACT_VentaRapida;[ACT_Pagos:172]ID_Tercero:26;$alACT_idTercero;[ACT_Pagos:172]Nulo:14;$abACT_Nulo)

For ($i_columna;1;Size of array:C274(ayBWR_FieldPointers))
	Case of 
		: ((Table:C252(ayBWR_FieldPointers{$i_columna})=Table:C252(->[Personas:7])) & (Field:C253(ayBWR_FieldPointers{$i_columna})=Field:C253(->[Personas:7]Apellidos_y_nombres:30)))
			For ($i_registro;1;$l_registros)  //20170825 RCH
				If ($abACT_VentaRapida{$i_registro})
					ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=__ ("Venta Rápida")
				End if 
				$vl_idTercero:=$alACT_idTercero{$i_registro}
				If ($vl_idTercero#0)
					ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->$vl_idTercero;->[ACT_Terceros:138]Nombre_Completo:9)
				End if 
			End for 
	End case 
End for 

For ($i_registro;1;$l_registros)
	If ($abACT_Nulo{$i_registro})
		AL_SetRowColor (xALP_Browser;$i_registro;"";15*16+8)
		AL_SetRowStyle (xALP_Browser;$i_registro;2)
	Else 
		AL_SetRowColor (xALP_Browser;$i_registro;"";16)
		AL_SetRowStyle (xALP_Browser;$i_registro;0)
	End if 
End for 

