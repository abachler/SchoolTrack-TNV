//%attributes = {}
  //ADTcfg_LoadItemsACT

ARRAY TEXT:C222(atACT_Glosa;0)
ARRAY TEXT:C222(atACT_Moneda;0)
ARRAY REAL:C219(arACT_Monto;0)
ARRAY BOOLEAN:C223(abACT_IVA;0)
ARRAY PICTURE:C279(apACT_IVA;0)
ARRAY LONGINT:C221(alACT_ID;0)
_O_ARRAY STRING:C218(80;asACT_CtaCta;0)
_O_ARRAY STRING:C218(80;asACT_CodAuxCta;0)
_O_ARRAY STRING:C218(80;asACT_CentroCta;0)
_O_ARRAY STRING:C218(80;asACT_CtaCCta;0)
_O_ARRAY STRING:C218(80;asACT_CodAuxCCta;0)
_O_ARRAY STRING:C218(80;asACT_CentroCCta;0)
READ ONLY:C145([xxACT_Items:179])
QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1>0)
SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_Glosa;[xxACT_Items:179]Moneda:10;atACT_Moneda;[xxACT_Items:179]Monto:7;arACT_Monto;[xxACT_Items:179]Afecto_IVA:12;abACT_IVA;[xxACT_Items:179]ID:1;alACT_ID)
SELECTION TO ARRAY:C260([xxACT_Items:179]No_de_Cuenta_Contable:15;asACT_CtaCta;[xxACT_Items:179]CodAuxCta:27;asACT_CodAuxCta;[xxACT_Items:179]Centro_de_Costos:21;asACT_CentroCta;[xxACT_Items:179]No_CCta_contable:22;asACT_CtaCCta;[xxACT_Items:179]CodAuxCCta:28;asACT_CodAuxCCta;[xxACT_Items:179]CCentro_de_costos:23;asACT_CentroCCta)
ARRAY PICTURE:C279(apACT_IVA;Size of array:C274(abACT_IVA))
For ($i;1;Size of array:C274(abACT_IVA))
	If (abACT_IVA{$i})
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_IVA{$i})
	Else 
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_IVA{$i})
	End if 
End for 
SORT ARRAY:C229(atACT_Glosa;atACT_Moneda;arACT_Monto;abACT_IVA;apACT_IVA;alACT_ID;asACT_CtaCta;asACT_CodAuxCta;asACT_CentroCta;asACT_CtaCCta;asACT_CodAuxCCta;asACT_CentroCCta;>)