//%attributes = {}
  //ACTac_MontosXCategoria

ARRAY TEXT:C222($at_Meses;0)
ARRAY TEXT:C222(atACT_NombreCategoria;0)
ARRAY REAL:C219(arACT_MontoCategoria;0)
ARRAY TEXT:C222(atACT_MesesCategorias;0)
ARRAY TEXT:C222(atACT_MesesCategoriasNum;0)
ARRAY LONGINT:C221($aIDCategoria;0)
ARRAY LONGINT:C221($aPosCategoria;0)
C_REAL:C285(vrACT_MontoTotalCategorias;vrACT_MontoTotalNoCategorias;vrACT_MontoTotalCat)
C_BOOLEAN:C305(vbACT_CargosNoEnCat;vbACT_ValoresAbsolutos)
C_POINTER:C301($ptr1;$1)

READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([xxACT_ItemsCategorias:98])

vrACT_MontoTotalCategorias:=0
vrACT_MontoTotalNoCategorias:=0
vrACT_MontoTotalCat:=0
COPY ARRAY:C226(<>atXS_MonthNames;$at_Meses)

$ptr1:=$1
If (Count parameters:C259>=2)
	vbACT_CargosNoEnCat:=$2
Else 
	vbACT_CargosNoEnCat:=False:C215
End if 
If (Count parameters:C259>=3)
	vbACT_ValoresAbsolutos:=$3
Else 
	vbACT_ValoresAbsolutos:=False:C215
End if 

ACTcc_LoadCargosIntoArrays 
ALL RECORDS:C47([xxACT_ItemsCategorias:98])
SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]ID:2;$aIDCategoria;[xxACT_ItemsCategorias:98]Posicion:3;$aPosCategoria;[xxACT_ItemsCategorias:98]Nombre:1;atACT_NombreCategoria)
AT_RedimArrays (Size of array:C274($aIDCategoria);->arACT_MontoCategoria;->atACT_MesesCategoriasNum)
For ($i;Size of array:C274(alACT_CRefs);1;-1)
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=alACT_CRefs{$i})
	If ([xxACT_Items:179]ID_Categoria:8#0)
		$cat:=Find in array:C230($aIDCategoria;[xxACT_Items:179]ID_Categoria:8)
		arACT_MontoCategoria{$cat}:=arACT_MontoCategoria{$cat}+$ptr1->{$i}
		atACT_MesesCategoriasNum{$cat}:=atACT_MesesCategoriasNum{$cat}+String:C10(alACT_MesCargo{$i})+";"
		AT_Delete ($i;1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoPagado;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta)
	End if 
End for 
arACT_MontoCategoria{0}:=0
ARRAY LONGINT:C221($DA_Return;0)
AT_SearchArray (->arACT_MontoCategoria;"=";->$DA_Return)
For ($i;Size of array:C274($DA_Return);1;-1)
	AT_Delete ($DA_Return{$i};1;->$aPosCategoria;->atACT_NombreCategoria;->arACT_MontoCategoria;->atACT_MesesCategoriasNum)
End for 

SORT ARRAY:C229($aPosCategoria;atACT_NombreCategoria;arACT_MontoCategoria;atACT_MesesCategoriasNum;>)

For ($i;1;Size of array:C274(atACT_MesesCategoriasNum))
	AT_Insert (0;1;->atACT_MesesCategorias)
	ARRAY LONGINT:C221($al_numMeses;0)
	AT_Text2Array (->$al_numMeses;atACT_MesesCategoriasNum{$i};";")
	AT_DistinctsArrayValues (->$al_numMeses)
	atACT_MesesCategoriasNum{$i}:=""
	For ($j;1;Size of array:C274($al_numMeses))
		atACT_MesesCategorias{$i}:=ST_Boolean2Str (atACT_MesesCategorias{$i}="";$at_Meses{$al_numMeses{$j}};";"+atACT_MesesCategorias{$i}+$at_Meses{$al_numMeses{$j}})
		atACT_MesesCategoriasNum{$i}:=ST_Boolean2Str (atACT_MesesCategoriasNum{$i}="";String:C10($al_numMeses{$j});";"+atACT_MesesCategoriasNum{$i}+String:C10($al_numMeses{$j}))
	End for 
End for 

vrACT_MontoTotalCategorias:=Abs:C99(AT_GetSumArray (->arACT_MontoCategoria))
vrACT_MontoTotalNoCategorias:=Abs:C99(AT_GetSumArray ($ptr1))
vrACT_MontoTotalCat:=vrACT_MontoTotalCategorias+vrACT_MontoTotalNoCategorias

If (vbACT_CargosNoEnCat)
	For ($i;1;Size of array:C274(alACT_CRefs))
		APPEND TO ARRAY:C911(atACT_NombreCategoria;atACT_CGlosa{$i})
		APPEND TO ARRAY:C911(arACT_MontoCategoria;$ptr1->{$i})
		APPEND TO ARRAY:C911(atACT_MesesCategorias;atACT_MesCargo{$i})
		APPEND TO ARRAY:C911(atACT_MesesCategoriasNum;String:C10(alACT_MesCargo{$i}))
	End for 
End if 

If (vbACT_ValoresAbsolutos)
	For ($i;1;Size of array:C274(arACT_MontoCategoria))
		arACT_MontoCategoria{$i}:=Abs:C99(arACT_MontoCategoria{$i})
	End for 
End if 