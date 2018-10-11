//%attributes = {}
  //SRACT_showItemsList

  //método que muestra un listado de items y permite multi selección
  //deja los ids de los cargos seleccionados en el arreglo aQR_Longint2 y en aQR_Text2 los nombres de los items

C_DATE:C307($vd_fecha1;$vd_fecha2)
C_BOOLEAN:C305($vb_buscarEnSel)
$vd_fecha1:=$1
$vd_fecha2:=$2
If (Count parameters:C259=3)
	$vb_buscarEnSel:=$3
End if 
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([xxACT_Items:179])

C_LONGINT:C283($base;$i)
C_DATE:C307($vd_fechaIni;$vd_fechaFin)
ARRAY TEXT:C222(aText1;0)
ARRAY TEXT:C222(aQR_Text2;0)
ARRAY TEXT:C222(aQR_Text3;0)
  //ARRAY LONGINT($al_idsCargos;0)
ARRAY LONGINT:C221(aQR_Longint1;0)
ARRAY LONGINT:C221(aQR_Longint2;0)
ARRAY LONGINT:C221(aQR_Longint3;0)
If (Not:C34($vb_buscarEnSel))
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fecha1;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fecha2)
End if 
CREATE SET:C116([ACT_Cargos:173];"cargosTodos")
KRL_RelateSelection (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16;"")
SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;aQR_Longint1;[xxACT_Items:179]Glosa:2;aText1)
KRL_RelateSelection (->[ACT_Cargos:173]Ref_Item:16;->[xxACT_Items:179]ID:1;"")
CREATE SET:C116([ACT_Cargos:173];"cargosFromItems")
DIFFERENCE:C122("cargosTodos";"cargosFromItems";"cargosTodos")
USE SET:C118("cargosTodos")
SET_ClearSets ("cargosTodos";"cargosFromItems")
If (Records in selection:C76([ACT_Cargos:173])>0)
	SELECTION TO ARRAY:C260([ACT_Cargos:173]Ref_Item:16;aQR_Longint3;[ACT_Cargos:173]Glosa:12;aQR_Text3)
	SORT ARRAY:C229(aQR_Longint3;aQR_Text3;>)
	$base:=0
	For ($i;1;Size of array:C274(aQR_Longint3))
		If ($base#aQR_Longint3{$i})
			APPEND TO ARRAY:C911(aQR_Longint1;aQR_Longint3{$i})
			APPEND TO ARRAY:C911(aText1;aQR_Text3{$i})
			$base:=aQR_Longint3{$i}
		End if 
	End for 
End if 

If (Size of array:C274(aText1)>0)
	ARRAY POINTER:C280(<>aChoicePtrs;0)
	ARRAY POINTER:C280(<>aChoicePtrs;2)
	C_POINTER:C301($ptr)
	<>aChoicePtrs{1}:=->aText1
	<>aChoicePtrs{2}:=->aQR_Longint1
	TBL_ShowChoiceList (0;"Seleccione los ítems";0;$ptr;True:C214)
	If (Size of array:C274(aLinesSelected)>0)
		For ($i;1;Size of array:C274(aLinesSelected))
			APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{aLinesSelected{$i}})
			APPEND TO ARRAY:C911(aQR_Text2;aText1{aLinesSelected{$i}})
		End for 
	Else 
		CANCEL:C270
	End if 
	AT_Initialize (->aText1;->aQR_Text3;->aQR_Longint1;->aQR_Longint3)
Else 
	CD_Dlog (0;"No hay registros que cumplan con el criterio de búsqueda.")
End if 