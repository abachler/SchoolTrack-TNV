//%attributes = {}
  //ACTac_AgruparXCategoria

  //ACTbol_AgruparXCategoria

ARRAY TEXT:C222(atACT_NombreCategoria;0)
ARRAY REAL:C219(arACT_MontoCategoria;0)
ARRAY LONGINT:C221(arACT_CIDCtaCteTemp;0)  //RCH
ARRAY LONGINT:C221(arACT_CIDCtaCteTemp2;0)  //RCH
ARRAY LONGINT:C221(arACT_CIDCtaCteTemp3;1)  //RCH
ARRAY TEXT:C222(atACT_CIDCtaCteTemp;0)  //RCH
ARRAY LONGINT:C221($aIDCategoria;0)
ARRAY LONGINT:C221($aPosCategoria;0)

$aviso:=$1

READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([xxACT_ItemsCategorias:98])
ALL RECORDS:C47([xxACT_ItemsCategorias:98])
SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]ID:2;$aIDCategoria;[xxACT_ItemsCategorias:98]Posicion:3;$aPosCategoria;[xxACT_ItemsCategorias:98]Nombre:1;atACT_NombreCategoria)
AT_RedimArrays (Size of array:C274($aIDCategoria);->arACT_MontoCategoria)
AT_RedimArrays (Size of array:C274($aIDCategoria);->atACT_CIDCtaCteTemp;->arACT_CIDCtaCteTemp2)  //RCH
For ($i;Size of array:C274(alACT_CRefs);1;-1)
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=alACT_CRefs{$i})
	If ([xxACT_Items:179]ID_Categoria:8#0)
		$cat:=Find in array:C230($aIDCategoria;[xxACT_Items:179]ID_Categoria:8)
		arACT_MontoCategoria{$cat}:=arACT_MontoCategoria{$cat}+arACT_CMontoNeto{$i}
		atACT_CIDCtaCteTemp{$cat}:=atACT_CIDCtaCteTemp{$cat}+String:C10(alACT_CIDCtaCte{$i})+";"  //RCH
		  //20130626 RCH NF CANTIDAD
		AT_Delete ($i;1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoPagado;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->atACT_MesCargo;->alACT_AñoCargo;->atACT_AñoCargo)
	End if 
End for 
For ($i;1;Size of array:C274($aIDCategoria))  //RCH
	AT_Initialize (->arACT_CIDCtaCteTemp3)  //RCH
	AT_Text2Array (->arACT_CIDCtaCteTemp3;Substring:C12(atACT_CIDCtaCteTemp{$i};1;Length:C16(atACT_CIDCtaCteTemp{$i})-1);";")  //RCH
	AT_DistinctsArrayValues (->arACT_CIDCtaCteTemp3)  //RCH
	arACT_CIDCtaCteTemp2{$i}:=Size of array:C274(arACT_CIDCtaCteTemp3)  //RCH
End for   //RCH
If (Size of array:C274(adACT_CFechaEmision)=0)
	vb_HideColsCtas:=True:C214
	vb_HideColAfecto:=True:C214
End if 
SORT ARRAY:C229($aPosCategoria;atACT_NombreCategoria;arACT_MontoCategoria;arACT_CIDCtaCteTemp2;>)
$arrPtr:=Get pointer:C304("arACT_MontoCategoria"+$aviso)
COPY ARRAY:C226(arACT_MontoCategoria;$arrPtr->)