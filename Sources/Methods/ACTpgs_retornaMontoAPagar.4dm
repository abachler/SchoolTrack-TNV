//%attributes = {}
  //ACTpgs_retornaMontoAPagar

  //RCH 20080416
  //método que calcula el monto a pagar en base a una fecha de los arreglos de pagos. Se utiliza en el método lectura de archivo de importación y en el método que procesa las opciones de importación.
  //' El  métod recibe las fechas de vencimiento del aviso o de los cargos y la fecha del pago. Con la fecha del pago calcula los montos que el apoderado pdebería pagar y con la fecha de venc busca los cargos que debería pagar con este monto.
  //--- ahora este métod busca todos los cargos que vencen en determinado mes debido a problemas que se presentaban con algunas fechas específicas.
C_REAL:C285($deudaTotal;$deudaCargos;$intereses)
C_DATE:C307($vd_fechaVenc;$vd_fechaPago)
C_BOOLEAN:C305($vb_ordenar)
ARRAY LONGINT:C221($al_orden;0)
ARRAY LONGINT:C221($al_fechasDesde;0)
ARRAY LONGINT:C221($al_fechasHasta;0)
ARRAY LONGINT:C221($al_fechasFinales;0)
C_LONGINT:C283($vl_mes;$vl_agno)
C_DATE:C307($vd_fechaInicio;$vd_fechaTermino)
C_LONGINT:C283($vl_idAviso)
C_DATE:C307($vdACTpgs_fechaDesde)
ARRAY DATE:C224($ad_fechas;0)

$vd_fechaVenc:=$1
$vd_fechaPago:=$2
If ($vd_fechaPago=!00-00-00!)
	$vd_fechaPago:=Current date:C33(*)
End if 
If (Count parameters:C259>=3)
	$vl_idAviso:=$3
End if 
If (Count parameters:C259>=4)
	$vdACTpgs_fechaDesde:=$4
End if 
If (Size of array:C274(arACT_CSaldo)>0)
	ARRAY REAL:C219($ar_SaldosACT;0)
	For ($i;1;Size of array:C274(alACT_CRefs))
		$vl_idCargo:=alACT_CIdsCargos{$i}
		If (KRL_GetBooleanFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11))
			APPEND TO ARRAY:C911($ar_SaldosACT;ACTut_retornaMontoEnMoneda (arACT_CSaldo{$i};atACT_MonedaCargo{$i};$vd_fechaPago;ST_GetWord (ACT_DivisaPais ;1;";")))
		Else 
			APPEND TO ARRAY:C911($ar_SaldosACT;arACT_CSaldo{$i})
		End if 
	End for 
	  //$deudaCargos:=AT_GetSumArrayByArrayPos (-100;"#";->alACT_CRefs;->arACT_CSaldo)
	$deudaCargos:=AT_GetSumArray (->$ar_SaldosACT)
	If ($vd_fechaVenc>!00-00-00!)
		$vl_mes:=Month of:C24($vd_fechaVenc)
		$vl_agno:=Year of:C25($vd_fechaVenc)
		If ($vdACTpgs_fechaDesde#!00-00-00!)
			$vd_fechaInicio:=$vdACTpgs_fechaDesde
		Else 
			$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;$vl_mes;$vl_agno)
		End if 
		$vd_fechaTermino:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($vl_mes;$vl_agno);$vl_mes;$vl_agno)
		adACT_CFechaVencimiento{0}:=$vd_fechaInicio
		AT_SearchArray (->adACT_CFechaVencimiento;">=";->$al_fechasDesde)
		adACT_CFechaVencimiento{0}:=$vd_fechaTermino
		AT_SearchArray (->adACT_CFechaVencimiento;"<=";->$al_fechasHasta)
		AT_intersect (->$al_fechasDesde;->$al_fechasHasta;->$al_fechasFinales)
		
		If ($vl_idAviso#0)
			COPY ARRAY:C226($al_fechasFinales;$al_fechasDesde)
			alACT_CIdsAvisos{0}:=$vl_idAviso
			AT_SearchArray (->alACT_CIdsAvisos;"=";->$al_fechasHasta)
			AT_intersect (->$al_fechasDesde;->$al_fechasHasta;->$al_fechasFinales)
		End if 
		
		If (Size of array:C274($al_fechasFinales)>0)
			$vb_ordenar:=True:C214
			$deudaCargos:=0
			For ($i;1;Size of array:C274($al_fechasFinales))
				  //$deudaCargos:=$deudaCargos+arACT_CSaldo{$al_fechasFinales{$i}}
				$deudaCargos:=$deudaCargos+$ar_SaldosACT{$al_fechasFinales{$i}}
				APPEND TO ARRAY:C911($al_orden;alACT_RecNumsCargos{$al_fechasFinales{$i}})
				If ($vdACTpgs_fechaDesde#!00-00-00!)
					APPEND TO ARRAY:C911($ad_fechas;adACT_CFechaVencimiento{$al_fechasFinales{$i}})
				End if 
			End for 
			If ($vdACTpgs_fechaDesde#!00-00-00!)
				SORT ARRAY:C229($ad_fechas;$al_orden;<)
			End if 
		End if 
		If ($vb_ordenar)
			AT_OrderArraysByArray (-10;->$al_orden;->alACT_RecNumsCargos;->alACT_CRefs;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
		End if 
	Else 
		
	End if 
	$deudaTotal:=Abs:C99($deudaCargos)
	$0:=$deudaTotal
Else 
	$0:=-1
End if 