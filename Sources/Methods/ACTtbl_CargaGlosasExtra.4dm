//%attributes = {}
  //ACTtbl_CargaGlosasExtra

_O_ARRAY STRING:C218(80;atACT_GlosasExtraGlosa;0)
_O_ARRAY STRING:C218(80;atACT_GlosasExtraCta;0)
_O_ARRAY STRING:C218(80;atACT_GlosasExtraCentro;0)
_O_ARRAY STRING:C218(80;atACT_GlosasExtraCCta;0)
_O_ARRAY STRING:C218(80;atACT_GlosasExtraCCentro;0)
ARRAY BOOLEAN:C223(abACT_ImputacionUnica;0)
_O_ARRAY STRING:C218(80;<>atACT_CargosExtraordinarios;0)
_O_ARRAY STRING:C218(80;<>atACT_GlosasExtraCta;0)
_O_ARRAY STRING:C218(80;<>atACT_GlosasExtraCentro;0)
_O_ARRAY STRING:C218(80;<>atACT_GlosasExtraCCta;0)
_O_ARRAY STRING:C218(80;<>atACT_GlosasExtraCCentro;0)
ARRAY BOOLEAN:C223(<>abACT_ImputacionUnica;0)

ARRAY PICTURE:C279(apACT_ImputacUnicaPict;0)

READ ONLY:C145([xxACT_GlosasExtraordinarias:5])
ALL RECORDS:C47([xxACT_GlosasExtraordinarias:5])
SELECTION TO ARRAY:C260([xxACT_GlosasExtraordinarias:5]Glosa:1;atACT_GlosasExtraGlosa;[xxACT_GlosasExtraordinarias:5]No_de_Cuenta_Contable:2;atACT_GlosasExtraCta;[xxACT_GlosasExtraordinarias:5]Centro_de_Costos:3;atACT_GlosasExtraCentro;[xxACT_GlosasExtraordinarias:5]No_CCta_contable:4;atACT_GlosasExtraCCta;[xxACT_GlosasExtraordinarias:5]CCentro_de_costos:5;atACT_GlosasExtraCCentro;[xxACT_GlosasExtraordinarias:5]Imputacion_Unica:6;abACT_ImputacionUnica)
ARRAY PICTURE:C279(apACT_ImputacUnicaPict;Size of array:C274(abACT_ImputacionUnica))
For ($i;1;Size of array:C274(abACT_ImputacionUnica))
	If (abACT_ImputacionUnica{$i})
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ImputacUnicaPict{$i})
	Else 
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ImputacUnicaPict{$i})
	End if 
End for 
atACT_GlosasExtraGlosa{0}:=""
ARRAY LONGINT:C221($DA_Return;0)
AT_SearchArray (->atACT_GlosasExtraGlosa;"=";->$DA_Return)
For ($i;Size of array:C274($DA_Return);1;-1)
	AT_Delete ($DA_Return{$i};1;->atACT_GlosasExtraGlosa;->atACT_GlosasExtraCta;->atACT_GlosasExtraCentro;->atACT_GlosasExtraCCta;->atACT_GlosasExtraCCentro;->abACT_ImputacionUnica)
End for 
SORT ARRAY:C229(atACT_GlosasExtraGlosa;atACT_GlosasExtraCta;atACT_GlosasExtraCentro;atACT_GlosasExtraCCta;atACT_GlosasExtraCCentro;abACT_ImputacionUnica;>)
COPY ARRAY:C226(atACT_GlosasExtraGlosa;<>atACT_CargosExtraordinarios)
COPY ARRAY:C226(atACT_GlosasExtraCta;<>atACT_GlosasExtraCta)
COPY ARRAY:C226(atACT_GlosasExtraCentro;<>atACT_GlosasExtraCentro)
COPY ARRAY:C226(atACT_GlosasExtraCCta;<>atACT_GlosasExtraCCta)
COPY ARRAY:C226(atACT_GlosasExtraCCentro;<>atACT_GlosasExtraCCentro)
COPY ARRAY:C226(abACT_ImputacionUnica;<>abACT_ImputacionUnica)