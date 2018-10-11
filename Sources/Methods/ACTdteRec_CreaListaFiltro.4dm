//%attributes = {}
  //ACTdteRec_CreaListaFiltro
C_REAL:C285(hlACT_FiltroDte)
C_REAL:C285($hl_tiposDTE;$hl_rs;$hl_ruts;$hl_folios;$hl_emision;$hl_recepcion)
C_LONGINT:C283($l_indiceFor;$l_proc)

ARRAY TEXT:C222($atACT_tipoDTE;0)
ARRAY TEXT:C222($atACT_rsDTE;0)
ARRAY TEXT:C222($atACT_rutEmisDTE;0)
ARRAY TEXT:C222($atACT_foliosDTE;0)
ARRAY DATE:C224($adACT_emision;0)
ARRAY DATE:C224($adACT_recepcion;0)

READ ONLY:C145([ACT_DTEs_Recibidos:238])
$l_proc:=IT_UThermometer (1;0;"Construyendo filtros...")

QUERY WITH ARRAY:C644([ACT_DTEs_Recibidos:238]id:1;alACT_IdDteRec)

SELECTION TO ARRAY:C260([ACT_DTEs_Recibidos:238]tipo_dte:5;$atACT_tipoDTE;\
[ACT_DTEs_Recibidos:238]razon_social_emiror:3;$atACT_rsDTE;\
[ACT_DTEs_Recibidos:238]rut_emisor:2;$atACT_rutEmisDTE;\
[ACT_DTEs_Recibidos:238]folio_dte:6;$atACT_foliosDTE;\
[ACT_DTEs_Recibidos:238]fecha_emision:7;$adACT_emision;\
[ACT_DTEs_Recibidos:238]fecha_registro:8;$adACT_recepcion)

For ($l_indiceFor;1;Size of array:C274($atACT_tipoDTE))
	$atACT_tipoDTE{$l_indiceFor}:=$atACT_tipoDTE{$l_indiceFor}+":"+ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->$atACT_tipoDTE{$l_indiceFor})
End for 

AT_DistinctsArrayValues (->$atACT_tipoDTE)
AT_DistinctsArrayValues (->$atACT_rsDTE)
AT_DistinctsArrayValues (->$atACT_rutEmisDTE)
AT_DistinctsArrayValues (->$atACT_foliosDTE)
AT_DistinctsArrayValues (->$adACT_emision)
AT_DistinctsArrayValues (->$adACT_recepcion)

  //lista tipos dte
$hl_tiposDTE:=New list:C375
For ($l_indiceFor;1;Size of array:C274($atACT_tipoDTE))
	If ($atACT_tipoDTE{$l_indiceFor}#"")
		APPEND TO LIST:C376($hl_tiposDTE;$atACT_tipoDTE{$l_indiceFor};10000+$l_indiceFor)
	End if 
End for 

  //lista razones sociales
$hl_rs:=New list:C375
For ($l_indiceFor;1;Size of array:C274($atACT_rsDTE))
	If ($atACT_rsDTE{$l_indiceFor}#"")
		APPEND TO LIST:C376($hl_rs;$atACT_rsDTE{$l_indiceFor};20000+$l_indiceFor)
	End if 
End for 

  //lista ruts
$hl_ruts:=New list:C375
For ($l_indiceFor;1;Size of array:C274($atACT_rutEmisDTE))
	If ($atACT_rutEmisDTE{$l_indiceFor}#"")
		APPEND TO LIST:C376($hl_ruts;$atACT_rutEmisDTE{$l_indiceFor};30000+$l_indiceFor)
	End if 
End for 

  //lista folios
$hl_folios:=New list:C375
For ($l_indiceFor;1;Size of array:C274($atACT_foliosDTE))
	If ($atACT_foliosDTE{$l_indiceFor}#"")
		APPEND TO LIST:C376($hl_folios;$atACT_foliosDTE{$l_indiceFor};40000+$l_indiceFor)
	End if 
End for 

  //lista fecha emision
$hl_emision:=New list:C375
For ($l_indiceFor;1;Size of array:C274($adACT_emision))
	If ($adACT_emision{$l_indiceFor}#!00-00-00!)
		APPEND TO LIST:C376($hl_emision;String:C10($adACT_emision{$l_indiceFor});50000+$l_indiceFor)
	End if 
End for 

  //lista fecha recepcion
$hl_recepcion:=New list:C375
For ($l_indiceFor;1;Size of array:C274($adACT_recepcion))
	If ($adACT_recepcion{$l_indiceFor}#!00-00-00!)
		APPEND TO LIST:C376($hl_recepcion;String:C10($adACT_recepcion{$l_indiceFor});60000+$l_indiceFor)
	End if 
End for 

If (Is a list:C621(hlACT_FiltroDte))
	CLEAR LIST:C377(hlACT_FiltroDte)
	hlACT_FiltroDte:=0
End if 

hlACT_FiltroDte:=New list:C375
APPEND TO LIST:C376(hlACT_FiltroDte;"Todos";1)
APPEND TO LIST:C376(hlACT_FiltroDte;"Tipos DTE";10000;$hl_tiposDTE;True:C214)
APPEND TO LIST:C376(hlACT_FiltroDte;"Razón Social";20000;$hl_rs;True:C214)
APPEND TO LIST:C376(hlACT_FiltroDte;"Rut Emisor";30000;$hl_ruts;True:C214)
APPEND TO LIST:C376(hlACT_FiltroDte;"Folio";40000;$hl_folios;True:C214)
APPEND TO LIST:C376(hlACT_FiltroDte;"Fecha Emisión";50000;$hl_emision;True:C214)
APPEND TO LIST:C376(hlACT_FiltroDte;"Fecha Recepción";60000;$hl_recepcion;True:C214)

SELECT LIST ITEMS BY REFERENCE:C630(hlACT_FiltroDte;1)

IT_UThermometer (-2;$l_proc)