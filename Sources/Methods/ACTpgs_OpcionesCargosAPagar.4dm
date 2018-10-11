//%attributes = {}
  //ACTpgs_OpcionesCargosAPagar

C_LONGINT:C283($1;$accion)
C_BOOLEAN:C305($2;$ejecutar)
C_POINTER:C301($puntero;$3)
$accion:=$1
$ejecutar:=$2
$puntero:=$3
If ($ejecutar)
	Case of 
		: ($accion=1)  //reduce seleccion de ítems a pagar
			For ($i;Size of array:C274(alACT_CIdsCargos);1;-1)
				If (Find in array:C230($puntero->;alACT_CIdsCargos{$i})=-1)
					For ($j;1;Size of array:C274(ap_arrays2Pay))
						AT_Delete ($i;1;ap_arrays2Pay{$j})
					End for 
				End if 
			End for 
			
		: ($accion=2)  //reduce de acuerdo al mes seleccionado
			ARRAY LONGINT:C221(al_rnCagosFiltrados;0)
			C_LONGINT:C283($año)
			C_REAL:C285(vi_selectedMonth)
			vi_selectedMonth:=$puntero->
			If (vlACTimp_Year=0)
				$año:=Year of:C25(Current date:C33(*))
			Else 
				$año:=vlACTimp_Year
			End if 
			CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];alACT_RecNumsCargos)
			CREATE SET:C116([ACT_Cargos:173];"CargosTodos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=vi_selectedMonth;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$año)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
			CREATE SET:C116([ACT_Cargos:173];"CargosFiltrados")
			INTERSECTION:C121("CargosFiltrados";"CargosTodos";"CargosFiltrados")
			USE SET:C118("CargosFiltrados")
			SET_ClearSets ("CargosFiltrados";"CargosTodos")
			SELECTION TO ARRAY:C260([ACT_Cargos:173];al_rnCagosFiltrados)
			For ($i;Size of array:C274(alACT_RecNumsCargos);1;-1)
				If (Find in array:C230(al_rnCagosFiltrados;alACT_RecNumsCargos{$i})=-1)
					  //AT_Delete ($i;1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
					For ($j;1;Size of array:C274(ap_arrays2Pay))
						AT_Delete ($i;1;ap_arrays2Pay{$j})
					End for 
				End if 
			End for 
			AT_Initialize (->al_rnCagosFiltrados)
			
		: ($accion=3)  //ordena cargos
			AT_OrderArraysByArray (0;$puntero;->alACT_CIdsCargos;->alACT_CRefs;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->alACT_CIdsAvisos;->atACT_CAlumno;->atACT_CGlosa;->arACT_MontoMoneda;->arACT_CMontoNeto;->arACT_CSaldo;->arACT_CIntereses;->alACT_RecNumsCargos;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->alACT_CIDCtaCte;->arACT_MontoPagado;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->asACT_Marcas)
			
		: ($accion=4)
			C_LONGINT:C283($año)
			vi_selectedMonth:=$puntero->
			If (vlACTimp_Year=0)
				$año:=Year of:C25(Current date:C33(*))
			Else 
				$año:=vlACTimp_Year
			End if 
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=vi_selectedMonth;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$año)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
		: ($accion=5)
			ARRAY LONGINT:C221(alMesesCargosT;Size of array:C274(adACT_CFechaEmision))
			For ($i;1;Size of array:C274(adACT_CFechaEmision))
				alMesesCargosT{$i}:=Month of:C24(adACT_CFechaEmision{$i})
			End for 
			AT_OrderArraysByArray (0;$puntero;->alMesesCargosT;->alACT_CRefs;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->alACT_CIdsAvisos;->atACT_CAlumno;->atACT_CGlosa;->arACT_MontoMoneda;->arACT_CMontoNeto;->arACT_CSaldo;->arACT_CIntereses;->alACT_RecNumsCargos;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->alACT_CIDCtaCte;->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->asACT_Marcas)
	End case 
End if 