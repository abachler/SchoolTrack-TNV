//%attributes = {}
  //ACTdteEmi_CreaListaFiltro

C_REAL:C285(hlACT_FiltroDte)
C_REAL:C285($hl_tiposDTE;$hl_folios;$hl_emision)
C_LONGINT:C283($l_indiceFor;$l_proc)

ARRAY TEXT:C222($atACT_tipoDTE;0)
ARRAY LONGINT:C221($alACT_foliosDTE;0)
ARRAY DATE:C224($adACT_emision;0)

READ ONLY:C145([ACT_Boletas:181])

$l_proc:=IT_UThermometer (1;0;"Creando filtros...")

QUERY WITH ARRAY:C644([ACT_Boletas:181]ID:1;alACT_IdDteEmi)

SELECTION TO ARRAY:C260([ACT_Boletas:181]codigo_SII:33;$atACT_tipoDTE;[ACT_Boletas:181]Numero:11;$alACT_foliosDTE;[ACT_Boletas:181]FechaEmision:3;$adACT_emision)

For ($l_indiceFor;1;Size of array:C274($atACT_tipoDTE))
	$atACT_tipoDTE{$l_indiceFor}:=$atACT_tipoDTE{$l_indiceFor}+":"+ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->$atACT_tipoDTE{$l_indiceFor})
End for 

AT_DistinctsArrayValues (->$atACT_tipoDTE)
AT_DistinctsArrayValues (->$alACT_foliosDTE)
AT_DistinctsArrayValues (->$adACT_emision)

  //lista tipos dte
$hl_tiposDTE:=New list:C375
For ($l_indiceFor;1;Size of array:C274($atACT_tipoDTE))
	If ($atACT_tipoDTE{$l_indiceFor}#"")
		APPEND TO LIST:C376($hl_tiposDTE;$atACT_tipoDTE{$l_indiceFor};10000+$l_indiceFor)
	End if 
End for 

  //lista folios
$hl_folios:=New list:C375
For ($l_indiceFor;1;Size of array:C274($alACT_foliosDTE))
	If ($alACT_foliosDTE{$l_indiceFor}#0)
		APPEND TO LIST:C376($hl_folios;String:C10($alACT_foliosDTE{$l_indiceFor});20000+$l_indiceFor)
	End if 
End for 

  //lista fecha emision
$hl_emision:=New list:C375
For ($l_indiceFor;1;Size of array:C274($adACT_emision))
	If ($adACT_emision{$l_indiceFor}#!00-00-00!)
		APPEND TO LIST:C376($hl_emision;String:C10($adACT_emision{$l_indiceFor});30000+$l_indiceFor)
	End if 
End for 

If (Is a list:C621(hlACT_FiltroDte))
	CLEAR LIST:C377(hlACT_FiltroDte)
	hlACT_FiltroDte:=0
End if 

hlACT_FiltroDte:=New list:C375
APPEND TO LIST:C376(hlACT_FiltroDte;"Todos";1)
APPEND TO LIST:C376(hlACT_FiltroDte;"Tipos DTE";10000;$hl_tiposDTE;True:C214)
APPEND TO LIST:C376(hlACT_FiltroDte;"Folio";20000;$hl_folios;True:C214)
APPEND TO LIST:C376(hlACT_FiltroDte;"Fecha Emisión";30000;$hl_emision;True:C214)

SELECT LIST ITEMS BY REFERENCE:C630(hlACT_FiltroDte;1)

IT_UThermometer (-2;$l_proc)