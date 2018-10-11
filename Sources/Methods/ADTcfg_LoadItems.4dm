//%attributes = {}
  //ADTcfg_LoadItems

ARRAY TEXT:C222(atADT_Glosa;0)
ARRAY TEXT:C222(atADT_Moneda;0)
ARRAY REAL:C219(arADT_Monto;0)
ARRAY PICTURE:C279(apADT_IVA;0)
ARRAY BOOLEAN:C223(abADT_IVA;0)
ARRAY LONGINT:C221(alADT_ID;0)
_O_ARRAY STRING:C218(80;asADT_CtaCta;0)
_O_ARRAY STRING:C218(80;asADT_CodAuxCta;0)
_O_ARRAY STRING:C218(80;asADT_CentroCta;0)
_O_ARRAY STRING:C218(80;asADT_CtaCCta;0)
_O_ARRAY STRING:C218(80;asADT_CodAuxCCta;0)
_O_ARRAY STRING:C218(80;asADT_CentroCCta;0)
READ ONLY:C145([xxACT_Items:179])
QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1<0)
SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atADT_Glosa;[xxACT_Items:179]Moneda:10;atADT_Moneda;[xxACT_Items:179]Monto:7;arADT_Monto;[xxACT_Items:179]Afecto_IVA:12;abADT_IVA;[xxACT_Items:179]ID:1;alADT_ID)
SELECTION TO ARRAY:C260([xxACT_Items:179]No_de_Cuenta_Contable:15;asADT_CtaCta;[xxACT_Items:179]CodAuxCta:27;asADT_CodAuxCta;[xxACT_Items:179]Centro_de_Costos:21;asADT_CentroCta;[xxACT_Items:179]No_CCta_contable:22;asADT_CtaCCta;[xxACT_Items:179]CodAuxCCta:28;asADT_CodAuxCCta;[xxACT_Items:179]CCentro_de_costos:23;asADT_CentroCCta)
ARRAY PICTURE:C279(apADT_IVA;Size of array:C274(atADT_Glosa))
For ($i;1;Size of array:C274(atADT_Glosa))
	If (abADT_IVA{$i})
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apADT_IVA{$i})
	Else 
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apADT_IVA{$i})
	End if 
End for 
SORT ARRAY:C229(atADT_Glosa;atADT_Moneda;arADT_Monto;apADT_IVA;abADT_IVA;alADT_ID;asADT_CtaCta;asADT_CodAuxCta;asADT_CentroCta;asADT_CtaCCta;asADT_CodAuxCCta;asADT_CentroCCta;>)