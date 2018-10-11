//%attributes = {}
  //ACTvr_LoadItems

ARRAY LONGINT:C221(alACT_RecNumVR;0)
ARRAY TEXT:C222(atACT_GlosaVR;0)
ARRAY LONGINT:C221(alACT_IDVR;0)
ARRAY BOOLEAN:C223(abACT_AfectoIVAVR;0)
ARRAY PICTURE:C279(apACT_AfectoIVAVR;0)
ARRAY REAL:C219(arACT_MontoMoneda;0)
ARRAY TEXT:C222(atACT_MonedaVR;0)
ARRAY TEXT:C222(atACT_MonedaCargo;0)
ARRAY REAL:C219(arACT_MontoPesosVR;0)
ARRAY TEXT:C222(atACT_MonedaSimbolo;0)
QUERY:C277([xxACT_Items:179];[xxACT_Items:179]VentaRapida:3=True:C214)
LONGINT ARRAY FROM SELECTION:C647([xxACT_Items:179];alACT_RecNumVR)
SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_GlosaVR;[xxACT_Items:179]ID:1;alACT_IDVR;[xxACT_Items:179]Afecto_IVA:12;abACT_AfectoIVAVR;[xxACT_Items:179]Monto:7;arACT_MontoMoneda;[xxACT_Items:179]Moneda:10;atACT_MonedaVR)
ARRAY PICTURE:C279(apACT_AfectoIVAVR;Size of array:C274(abACT_AfectoIVAVR))
ARRAY REAL:C219(arACT_MontoPesosVR;Size of array:C274(abACT_AfectoIVAVR))
COPY ARRAY:C226(atACT_MonedaVR;atACT_MonedaCargo)
ARRAY TEXT:C222(atACT_MonedaSimbolo;Size of array:C274(abACT_AfectoIVAVR))
For ($i;1;Size of array:C274(abACT_AfectoIVAVR))
	If (abACT_AfectoIVAVR{$i})
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_AfectoIVAVR{$i})
	Else 
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_AfectoIVAVR{$i})
	End if 
	
	Case of 
		: (atACT_MonedaVR{$i}="UF")
			$ValorUF:=ACTut_fValorUF (Current date:C33(*))
			$montomoneda:=arACT_MontoMoneda{$i}
			$montopesos:=$montomoneda*$ValorUF
			arACT_MontoPesosVR{$i}:=$montopesos
			  //: (atACT_MonedaVR{$i}#"Peso Chileno")
		: (atACT_MonedaVR{$i}#<>vsACT_MonedaColegio)
			$ValorDivisaCargo:=ACTut_fValorDivisa (atACT_MonedaVR{$i})
			$montomoneda:=arACT_MontoMoneda{$i}
			$montopesos:=$montomoneda*$ValorDivisaCargo
			arACT_MontoPesosVR{$i}:=$montopesos
		Else 
			$montomoneda:=arACT_MontoMoneda{$i}
			$montopesos:=arACT_MontoMoneda{$i}
			arACT_MontoPesosVR{$i}:=$montopesos
	End case 
End for 
SORT ARRAY:C229(atACT_GlosaVR;alACT_IDVR;abACT_AfectoIVAVR;alACT_RecNumVR;apACT_AfectoIVAVR;arACT_MontoMoneda;atACT_MonedaVR;arACT_MontoPesosVR;>)
ACTpgs_SimboloMoneda 