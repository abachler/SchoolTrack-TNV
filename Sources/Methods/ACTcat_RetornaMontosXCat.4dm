//%attributes = {}
  //ACTcat_RetornaMontosXCat

ARRAY LONGINT:C221($aIDCategoria;0)
ARRAY LONGINT:C221($aPosCategoria;0)
ARRAY TEXT:C222($atACT_NombreCategoria;0)

READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([xxACT_ItemsCategorias:98])
ALL RECORDS:C47([xxACT_ItemsCategorias:98])
ORDER BY:C49([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]Posicion:3;>)
SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]ID:2;$aIDCategoria;[xxACT_ItemsCategorias:98]Posicion:3;$aPosCategoria;[xxACT_ItemsCategorias:98]Nombre:1;$atACT_NombreCategoria)

ARRAY LONGINT:C221($al_IdCategoria;Size of array:C274($aIDCategoria))
ARRAY REAL:C219($ar_MontoCategoria;Size of array:C274($aIDCategoria))

For ($j;Size of array:C274($1->);1;-1)  //cargo los montos para cada categoria 
	GOTO RECORD:C242([ACT_Cargos:173];$1->{$j})
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
	$el:=Find in array:C230($aIDCategoria;[xxACT_Items:179]ID_Categoria:8)
	If ($el#-1)  //puede ser un dcto exento en caja o el cargo puede no estar en las categorias
		$in:=Find in array:C230($al_IdCategoria;$aIDCategoria{$el})
		If ($in=-1)
			$al_IdCategoria{$el}:=[xxACT_Items:179]ID_Categoria:8
			$ar_MontoCategoria{$el}:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";$2;$2;$3->))
		Else 
			$ar_MontoCategoria{$el}:=$ar_MontoCategoria{$el}+Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";$2;$2;$3->))
		End if 
	Else 
		AT_Delete ($j;1;$1)
	End if 
End for 

If (Count parameters:C259>=5)
	COPY ARRAY:C226($aIDCategoria;$4->)
	COPY ARRAY:C226($atACT_NombreCategoria;$5->)
	COPY ARRAY:C226($ar_MontoCategoria;$6->)
End if 