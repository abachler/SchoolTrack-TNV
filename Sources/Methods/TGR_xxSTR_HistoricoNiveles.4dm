//%attributes = {}
  // MÉTODO: TGR_xxSTR_HistoricoNiveles
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 12/03/12, 17:59:36
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // TGR_xxSTR_HistoricoNiveles()
  // ----------------------------------------------------
C_BLOB:C604($x_blob)
C_LONGINT:C283($i;$l_OTref_Periodos)
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)



  // CODIGO PRINCIPAL
If (Not:C34(<>vb_ImportHistoricos_STX))
	PERIODOS_Init 
	
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[xxSTR_HistoricoNiveles:191]LlavePrimaria:11:=String:C10([xxSTR_HistoricoNiveles:191]ID_Institucion:1)+"."+String:C10([xxSTR_HistoricoNiveles:191]NumeroNivel:3)+"."+String:C10([xxSTR_HistoricoNiveles:191]Año:2)
			
			$x_blob:=[xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7
			If (BLOB size:C605($x_blob)>32)
				$l_OTref_Periodos:=OT BLOBToObject ($x_blob)
				OT GetArray ($l_OTref_Periodos;"aiSTR_Periodos_Numero";aiSTR_Periodos_Numero)
				OT GetArray ($l_OTref_Periodos;"atSTR_Periodos_Nombre";atSTR_Periodos_Nombre)
				OT GetArray ($l_OTref_Periodos;"adSTR_Periodos_Desde";adSTR_Periodos_Desde)
				OT GetArray ($l_OTref_Periodos;"adSTR_Periodos_Hasta";adSTR_Periodos_Hasta)
				OT GetArray ($l_OTref_Periodos;"adSTR_Periodos_Cierre";adSTR_Periodos_Cierre)
				OT GetArray ($l_OTref_Periodos;"aiSTR_Periodos_Dias";aiSTR_Periodos_Dias)
				OT Clear ($l_OTref_Periodos)
				
				For ($i;1;Size of array:C274(aiSTR_Periodos_Numero))
					aiSTR_Periodos_Numero{$i}:=$i
				End for 
				
				If (Size of array:C274(atSTR_Periodos_Nombre)>0)
					vdSTR_Periodos_InicioEjercicio:=adSTR_Periodos_Desde{1}
					vdSTR_Periodos_FinEjercicio:=adSTR_Periodos_Hasta{Size of array:C274(aiSTR_Periodos_Numero)}
					viSTR_Periodos_DiasAgno:=AT_GetSumArray (->aiSTR_Periodos_Dias)
					viSTR_Periodos_NumeroPeriodos:=Size of array:C274(atSTR_Periodos_Nombre)
				Else 
					viSTR_Periodos_NumeroPeriodos:=2
					vdSTR_Periodos_InicioEjercicio:=!00-00-00!
					vdSTR_Periodos_FinEjercicio:=!00-00-00!
				End if 
			End if 
			
			  //20120120 RCH Se agrega if para evitar perdida de periodos cuando el campo [xxSTR_HistoricoNiveles]NumeroDePeriodos no tenga el valor correcto...
			If ([xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16>0)
				If (Size of array:C274(aiSTR_Periodos_Numero)#[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					ARRAY INTEGER:C220(aiSTR_Periodos_Numero;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					ARRAY TEXT:C222(atSTR_Periodos_Nombre;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					ARRAY DATE:C224(adSTR_Periodos_Desde;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					ARRAY DATE:C224(adSTR_Periodos_Hasta;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					ARRAY DATE:C224(adSTR_Periodos_Cierre;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					ARRAY INTEGER:C220(aiSTR_Periodos_Dias;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					For ($i;1;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
						If (atSTR_Periodos_Nombre{$i}="")
							atSTR_Periodos_Nombre{$i}:="Período "+String:C10($i)
						End if 
					End for 
					
					$l_OTref_Periodos:=OT New 
					OT PutArray ($l_OTref_Periodos;"aiSTR_Periodos_Numero";aiSTR_Periodos_Numero)
					OT PutArray ($l_OTref_Periodos;"atSTR_Periodos_Nombre";atSTR_Periodos_Nombre)
					OT PutArray ($l_OTref_Periodos;"adSTR_Periodos_Desde";adSTR_Periodos_Desde)
					OT PutArray ($l_OTref_Periodos;"adSTR_Periodos_Hasta";adSTR_Periodos_Hasta)
					OT PutArray ($l_OTref_Periodos;"adSTR_Periodos_Cierre";adSTR_Periodos_Cierre)
					OT PutArray ($l_OTref_Periodos;"aiSTR_Periodos_Dias";aiSTR_Periodos_Dias)
					$x_blob:=OT ObjectToNewBLOB ($l_OTref_Periodos)
					OT Clear ($l_OTref_Periodos)
					[xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7:=$x_blob
					[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=viSTR_Periodos_NumeroPeriodos
					[xxSTR_HistoricoNiveles:191]InicioAgnoEscolar:17:=vdSTR_Periodos_InicioEjercicio
					[xxSTR_HistoricoNiveles:191]TerminoAgnoEscolar:18:=vdSTR_Periodos_FinEjercicio
				End if 
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[xxSTR_HistoricoNiveles:191]LlavePrimaria:11:=String:C10([xxSTR_HistoricoNiveles:191]ID_Institucion:1)+"."+String:C10([xxSTR_HistoricoNiveles:191]NumeroNivel:3)+"."+String:C10([xxSTR_HistoricoNiveles:191]Año:2)
			
			$x_blob:=[xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7
			If (BLOB size:C605($x_blob)>32)
				$l_OTref_Periodos:=OT BLOBToObject ($x_blob)
				OT GetArray ($l_OTref_Periodos;"aiSTR_Periodos_Numero";aiSTR_Periodos_Numero)
				OT GetArray ($l_OTref_Periodos;"atSTR_Periodos_Nombre";atSTR_Periodos_Nombre)
				OT GetArray ($l_OTref_Periodos;"adSTR_Periodos_Desde";adSTR_Periodos_Desde)
				OT GetArray ($l_OTref_Periodos;"adSTR_Periodos_Hasta";adSTR_Periodos_Hasta)
				OT GetArray ($l_OTref_Periodos;"adSTR_Periodos_Cierre";adSTR_Periodos_Cierre)
				OT GetArray ($l_OTref_Periodos;"aiSTR_Periodos_Dias";aiSTR_Periodos_Dias)
				OT Clear ($l_OTref_Periodos)
				
				For ($i;1;Size of array:C274(aiSTR_Periodos_Numero))
					aiSTR_Periodos_Numero{$i}:=$i
				End for 
				
				If (Size of array:C274(atSTR_Periodos_Nombre)>0)
					vdSTR_Periodos_InicioEjercicio:=adSTR_Periodos_Desde{1}
					vdSTR_Periodos_FinEjercicio:=adSTR_Periodos_Hasta{Size of array:C274(aiSTR_Periodos_Numero)}
					viSTR_Periodos_DiasAgno:=AT_GetSumArray (->aiSTR_Periodos_Dias)
					viSTR_Periodos_NumeroPeriodos:=Size of array:C274(atSTR_Periodos_Nombre)
				Else 
					viSTR_Periodos_NumeroPeriodos:=2
					vdSTR_Periodos_InicioEjercicio:=!00-00-00!
					vdSTR_Periodos_FinEjercicio:=!00-00-00!
				End if 
			End if 
			
			  //20120120 RCH Se agrega if para evitar perdida de periodos cuando el campo [xxSTR_HistoricoNiveles]NumeroDePeriodos no tenga el valor correcto...
			If ([xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16>0)
				If (Size of array:C274(aiSTR_Periodos_Numero)#[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					ARRAY INTEGER:C220(aiSTR_Periodos_Numero;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					ARRAY TEXT:C222(atSTR_Periodos_Nombre;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					ARRAY DATE:C224(adSTR_Periodos_Desde;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					ARRAY DATE:C224(adSTR_Periodos_Hasta;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					ARRAY DATE:C224(adSTR_Periodos_Cierre;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					ARRAY INTEGER:C220(aiSTR_Periodos_Dias;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
					For ($i;1;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
						If (atSTR_Periodos_Nombre{$i}="")
							atSTR_Periodos_Nombre{$i}:="Período "+String:C10($i)
						End if 
					End for 
					
					$l_OTref_Periodos:=OT New 
					OT PutArray ($l_OTref_Periodos;"aiSTR_Periodos_Numero";aiSTR_Periodos_Numero)
					OT PutArray ($l_OTref_Periodos;"atSTR_Periodos_Nombre";atSTR_Periodos_Nombre)
					OT PutArray ($l_OTref_Periodos;"adSTR_Periodos_Desde";adSTR_Periodos_Desde)
					OT PutArray ($l_OTref_Periodos;"adSTR_Periodos_Hasta";adSTR_Periodos_Hasta)
					OT PutArray ($l_OTref_Periodos;"adSTR_Periodos_Cierre";adSTR_Periodos_Cierre)
					OT PutArray ($l_OTref_Periodos;"aiSTR_Periodos_Dias";aiSTR_Periodos_Dias)
					$x_blob:=OT ObjectToNewBLOB ($l_OTref_Periodos)
					OT Clear ($l_OTref_Periodos)
					[xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7:=$x_blob
					[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=viSTR_Periodos_NumeroPeriodos
					[xxSTR_HistoricoNiveles:191]InicioAgnoEscolar:17:=vdSTR_Periodos_InicioEjercicio
					[xxSTR_HistoricoNiveles:191]TerminoAgnoEscolar:18:=vdSTR_Periodos_FinEjercicio
				End if 
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 
