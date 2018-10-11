//%attributes = {}
  //ACTcfg_LoadDataMatrices

If (Count parameters:C259=1)
	$matrixID:=$1
Else 
	$matrixID:=0
End if 

  //lectura de la lista de los items de cargo/descuento
ARRAY TEXT:C222(atACT_GlosaItem;0)
ARRAY LONGINT:C221(alACT_IdItem;0)
vi_lastLine:=0
READ ONLY:C145([xxACT_Items:179])
QUERY:C277([xxACT_Items:179];[xxACT_Items:179]VentaRapida:3=False:C215;*)
QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1>0)
CREATE SET:C116([xxACT_Items:179];"items2show")
ACTcfg_LoadCargosEspeciales (2)
ADD TO SET:C119([xxACT_Items:179];"items2show")
KRL_UnloadReadOnly (->[xxACT_Items:179])
USE SET:C118("items2show")
SET_ClearSets ("items2show")
SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;alACT_IdItem;[xxACT_Items:179]Glosa:2;atACT_GlosaItem;[xxACT_Items:179]Monto:7;arACT_AmountItem;[xxACT_Items:179]EsDescuento:6;abACT_IsDiscountItem;[xxACT_Items:179]EsRelativo:5;abACT_isPercentItem;[xxACT_Items:179]Moneda:10;atACT_MonedaItemDef;[xxACT_Items:179]Afecto_IVA:12;abACT_AfectoIVA)
ARRAY PICTURE:C279(apACT_AfectoIVA;Size of array:C274(abACT_AfectoIVA))
For ($i;1;Size of array:C274(abACT_AfectoIVA))
	If (abACT_AfectoIVA{$i})
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_AfectoIVA{$i})
	Else 
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_AfectoIVA{$i})
	End if 
End for 
SORT ARRAY:C229(atACT_GlosaItem;alACT_IdItem;arACT_AmountItem;abACT_IsDiscountItem;abACT_isPercentItem;atACT_MonedaItemDef;abACT_AfectoIVA;apACT_AfectoIVA;>)
UNLOAD RECORD:C212([xxACT_Items:179])

  //Lectura de la lista de matrices
  //ARRAY TEXT(atACT_NombreMatriz;0)
  //ARRAY TEXT(atACT_MonedaMatriz;0)
  //ARRAY LONGINT(alACT_IdMatriz;0)
  //vi_lastLine:=0
  //READ WRITE([ACT_Matrices])
  //ALL RECORDS([ACT_Matrices])
  //SELECTION TO ARRAY([ACT_Matrices]ID;alACT_IdMatriz;[ACT_Matrices]Nombre_matriz;atACT_NombreMatriz;[ACT_Matrices]Moneda;atACT_MonedaMatriz)
  //SORT ARRAY(atACT_NombreMatriz;alACT_IdMatriz;atACT_MonedaMatriz;>)
ACTcfg_LoadMatrix 
vi_lastLine:=0
If (Records in selection:C76([ACT_Matrices:177])>0)
	vi_lastLine:=1
	QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=alACT_IdMatriz{vi_lastLine})
	ACTcfg_loadMatrixItems ([ACT_Matrices:177]ID:1)
	UNLOAD RECORD:C212([ACT_Matrices:177])
End if 