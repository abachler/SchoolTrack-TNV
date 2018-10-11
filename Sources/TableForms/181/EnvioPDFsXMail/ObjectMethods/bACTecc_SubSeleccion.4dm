
ARRAY LONGINT:C221($alACT_seleccionados;0)
lb_ACTdte_Apoderados{0}:=True:C214
AT_SearchArray (->lb_ACTdte_Apoderados;"=";->$alACT_seleccionados)
If (Size of array:C274($alACT_seleccionados)>0)
	
	ARRAY TEXT:C222($atACTdte_Nombre;0)
	ARRAY TEXT:C222($atACTdte_Tipo;0)
	ARRAY LONGINT:C221($alACTdte_Folio;0)
	ARRAY LONGINT:C221($alACTdte_ID;0)
	ARRAY LONGINT:C221($alACTdte_Colores;0)
	ARRAY BOOLEAN:C223($abACTdte_Enviar;0)
	
	COPY ARRAY:C226(atACTdte_Nombre;$atACTdte_Nombre)
	COPY ARRAY:C226(atACTdte_Tipo;$atACTdte_Tipo)
	COPY ARRAY:C226(alACTdte_Folio;$alACTdte_Folio)
	COPY ARRAY:C226(alACTdte_ID;$alACTdte_ID)
	COPY ARRAY:C226(alACTdte_Colores;$alACTdte_Colores)
	COPY ARRAY:C226(abACTdte_Enviar;$abACTdte_Enviar)
	
	AT_Initialize (->atACTdte_Nombre;->atACTdte_Tipo;->alACTdte_Folio;->alACTdte_ID;->alACTdte_Colores;->abACTdte_Enviar)
	
	For ($l_indice;1;Size of array:C274($alACT_seleccionados))
		APPEND TO ARRAY:C911(atACTdte_Nombre;$atACTdte_Nombre{$alACT_seleccionados{$l_indice}})
		APPEND TO ARRAY:C911(atACTdte_Tipo;$atACTdte_Tipo{$alACT_seleccionados{$l_indice}})
		APPEND TO ARRAY:C911(alACTdte_Folio;$alACTdte_Folio{$alACT_seleccionados{$l_indice}})
		APPEND TO ARRAY:C911(alACTdte_ID;$alACTdte_ID{$alACT_seleccionados{$l_indice}})
		APPEND TO ARRAY:C911(alACTdte_Colores;$alACTdte_Colores{$alACT_seleccionados{$l_indice}})
		APPEND TO ARRAY:C911(abACTdte_Enviar;$abACTdte_Enviar{$alACT_seleccionados{$l_indice}})
		
	End for 
End if 