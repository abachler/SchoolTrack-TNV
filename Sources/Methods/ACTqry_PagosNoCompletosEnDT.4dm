//%attributes = {}
  // Método: ACTqry_PagosNoCompletosEnDT
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 18-05-10, 12:19:36
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




  //ACTqry_PagosNoCompletosEnDT

If (Application type:C494#4D Server:K5:6)
	If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
		If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Pagos:172]))
			READ ONLY:C145([ACT_Boletas:181])
			READ ONLY:C145([ACT_Pagos:172])
			READ ONLY:C145([ACT_Transacciones:178])
			READ ONLY:C145([ACT_Cargos:173])
			
			C_LONGINT:C283($i;$proc;$x;$resp)
			C_REAL:C285($vr_monto)
			
			$resp:=CD_Dlog (0;__ ("Se buscarán los pagos que no estén completamente incluidos en Documentos Tributarios pero sin considerar los cargos ")+ST_Qte (__ ("No incluidos en Documentos Tributarios"))+__ (".\r\rEsta operación puede tomar varios minutos. ¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
			If ($resp=1)
				SRACT_SelFecha (4)
				If (ok=1)
					$proc:=IT_UThermometer (1;0;__ ("Validando Pagos v/s Documentos Tributarios para el período seleccionado..."))
					
					QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=vd_fecha1;*)
					QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=vd_fecha2;*)
					QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
					
					CREATE SET:C116([ACT_Pagos:172];"setPagos1")
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
					QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=0)
					CREATE SET:C116([ACT_Transacciones:178];"ACT_Transacciones1")
					KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]No_Incluir_en_DocTrib:50=True:C214)
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
					CREATE SET:C116([ACT_Transacciones:178];"ACT_Transacciones2")
					DIFFERENCE:C122("ACT_Transacciones1";"ACT_Transacciones2";"ACT_Transacciones3")
					USE SET:C118("ACT_Transacciones3")
					KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
					CREATE SET:C116([ACT_Pagos:172];"setPagos2")
					INTERSECTION:C121("setPagos1";"setPagos2";"setPagos1")
					USE SET:C118("setPagos1")
					
					SET_ClearSets ("setPagos1";"ACT_Transacciones1";"ACT_Transacciones2";"setPagos2")
					
					IT_UThermometer (-2;$proc)
					
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("Ejecute el script desde la pestaña Pagos."))
		End if 
	End if 
End if 

  //  // Método: ACTqry_PagosNoCompletosEnDT
  //  //----------------------------------------------
  //  // Usuario (OS): roberto
  //  // Fecha: 18-05-10, 12:19:36
  //  // ---------------------------------------------
  //  // Descripción: 
  //  // 
  //  // Parámetros:
  //  // 
  //  //----------------------------------------------
  //  // Declaraciones e inicializaciones
  //
  //
  //  // Código principal
  //
  //
  //
  //
  //  //ACTqry_PagosNoCompletosEnDT
  //
  //If (Application type#4D Server)
  //If (Not(Nil(yBWR_currentTable)))
  //If (Table(yBWR_currentTable)=Table(->[ACT_Pagos]))
  //READ ONLY([ACT_Boletas])
  //READ ONLY([ACT_Pagos])
  //READ ONLY([ACT_Transacciones])
  //READ ONLY([ACT_Cargos])
  //
  //C_LONGINT($i;$proc;$x;$resp)
  //C_REAL($vr_monto)
  //
  //$resp:=CD_Dlog (0;__ ("Se buscarán los pagos que no estén completamente incluidos en Documentos Tributarios pero sin considerar los cargos ")+ST_Qte (__ ("No incluidos en Documentos Tributarios"))+__ (".\r\rEsta operación puede tomar varios minutos. ¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
  //If ($resp=1)
  //SRACT_SelFecha (4)
  //If (ok=1)
  //$proc:=IT_UThermometer (1;0;__ ("Validando Pagos v/s Documentos Tributarios para el período seleccionado..."))
  //QUERY([ACT_Pagos];[ACT_Pagos]Fecha>=vd_fecha1;*)
  //QUERY([ACT_Pagos]; & ;[ACT_Pagos]Fecha<=vd_fecha2;*)
  //QUERY([ACT_Pagos]; & ;[ACT_Pagos]Nulo=False)
  //CREATE SET([ACT_Pagos];"setPagos1")
  //
  //KRL_RelateSelection (->[ACT_Transacciones]ID_Pago;->[ACT_Pagos]ID;"")
  //CREATE SET([ACT_Transacciones];"ACT_Transacciones1")
  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]No_Incluir_en_DocTrib=False)
  //KRL_RelateSelection (->[ACT_Transacciones]ID_Item;->[ACT_Cargos]ID;"")
  //CREATE SET([ACT_Transacciones];"ACT_Transacciones2")
  //INTERSECTION("ACT_Transacciones1";"ACT_Transacciones2";"ACT_Transacciones3")
  //KRL_RelateSelection (->[ACT_Pagos]ID;->[ACT_Transacciones]ID_Pago;"")
  //CREATE SET([ACT_Pagos];"setPagos2")
  //INTERSECTION("setPagos1";"setPagos2";"setPagos1")
  //USE SET("setPagos1")
  //SET_ClearSets ("setPagos1";"setPagos2")
  //
  //ARRAY LONGINT(aQR_Longint1;0)
  //ARRAY LONGINT(aQR_Longint2;0)
  //ARRAY LONGINT(aQR_Longint3;0)
  //LONGINT ARRAY FROM SELECTION([ACT_Pagos];aQR_Longint1;"")
  //IT_UThermometer (-2;$proc)
  //
  //ARRAY LONGINT(aQR_Longint4;0)
  //ARRAY LONGINT(aQR_Longint5;0)
  //ARRAY REAL(aQR_Real1;0)
  //
  //SET_ClearSets ("ACT_Transacciones1";"ACT_Transacciones2")
  //CD_THERMOMETREXSEC (1;0;__ ("Verificando montos de Pagos..."))
  //For ($i;1;Size of array(aQR_Longint1))
  //GOTO RECORD([ACT_Pagos];aQR_Longint1{$i})
  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Pago=[ACT_Pagos]ID)
  //CREATE SET([ACT_Transacciones];"ACT_Transacciones1")
  //INTERSECTION("ACT_Transacciones1";"ACT_Transacciones3";"ACT_Transacciones2")
  //
  //USE SET("ACT_Transacciones2")
  //  //ARRAY LONGINT(aQR_Longint2;0) //20140709 RCH 
  //  //LONGINT ARRAY FROM SELECTION([ACT_Transacciones];aQR_Longint2;"")
  //  //$vr_monto:=ACTtra_CalculaMontos ("calculaFromRecNum";->aQR_Longint2;->[ACT_Transacciones]Debito)
  //
  //USE SET("ACT_Transacciones2")
  //KRL_RelateSelection (->[ACT_Boletas]ID;->[ACT_Transacciones]No_Boleta;"")
  //
  //If (Records in selection([ACT_Boletas])>0)
  //While (Not(End selection([ACT_Boletas])))
  //USE SET("ACT_Transacciones2")
  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]No_Boleta=[ACT_Boletas]ID)
  //ARRAY LONGINT(aQR_Longint2;0)
  //LONGINT ARRAY FROM SELECTION([ACT_Transacciones];aQR_Longint2;"")
  //$vr_monto:=ACTtra_CalculaMontos ("calculaFromRecNum";->aQR_Longint2;->[ACT_Transacciones]Debito)
  //APPEND TO ARRAY(aQR_Longint4;[ACT_Pagos]ID)
  //APPEND TO ARRAY(aQR_Longint5;[ACT_Boletas]ID)
  //APPEND TO ARRAY(aQR_Real1;$vr_monto)
  //NEXT RECORD([ACT_Boletas])
  //End while 
  //End if 
  //
  //CD_THERMOMETREXSEC (0;$i/Size of array(aQR_Longint1)*100;__ ("Verificando montos de Pagos..."))
  //End for 
  //CD_THERMOMETREXSEC (-1)
  //
  //ARRAY LONGINT(aQR_Longint1;0)
  //ARRAY LONGINT(aQR_Longint2;0)
  //COPY ARRAY(aQR_Longint5;aQR_Longint1)
  //AT_DistinctsArrayValues (->aQR_Longint1)
  //CD_THERMOMETREXSEC (1;0;__ ("Comparando montos..."))
  //For ($i;1;Size of array(aQR_Longint1))
  //QUERY([ACT_Boletas];[ACT_Boletas]ID=aQR_Longint1{$i})
  //$vr_monto:=Round(AT_GetSumArrayByArrayPos (->[ACT_Boletas]ID;"=";->aQR_Longint5;->aQR_Real1);<>vlACT_Decimales)
  //
  //If (Round([ACT_Boletas]Monto_Total;<>vlACT_Decimales)#$vr_monto)
  //aQR_Longint5{0}:=[ACT_Boletas]ID
  //ARRAY LONGINT($DA_Return;0)
  //AT_SearchArray (->aQR_Longint5;"=";->$DA_Return)
  //For ($x;1;Size of array($DA_Return))
  //APPEND TO ARRAY(aQR_Longint2;aQR_Longint4{$DA_Return{$x}})
  //End for 
  //End if 
  //CD_THERMOMETREXSEC (0;$i/Size of array(aQR_Longint1)*100;__ ("Comparando montos..."))
  //End for 
  //CD_THERMOMETREXSEC (-1)
  //
  //QUERY WITH ARRAY([ACT_Pagos]ID;aQR_Longint2)
  //  //If (Records in selection([ACT_Pagos])=0)
  //  //CD_Dlog (0;"No hay pagos que cumplan con el criterio de búsqueda.")
  //  //End if 
  //  //CREATE SET(yBWR_currentTable->;"RecordSet_Table"+String(Table(yBWR_currentTable)))
  //  //BWR_SelectTableData 
  //
  //ARRAY LONGINT(aQR_Longint1;0)
  //ARRAY LONGINT(aQR_Longint2;0)
  //ARRAY LONGINT(aQR_Longint3;0)
  //ARRAY LONGINT(aQR_Longint4;0)
  //ARRAY LONGINT(aQR_Longint5;0)
  //ARRAY REAL(aQR_Real1;0)
  //
  //SET_ClearSets ("ACT_Transacciones1";"ACT_Transacciones2";"ACT_Transacciones3")
  //
  //End if 
  //End if 
  //Else 
  //CD_Dlog (0;__ ("Ejecute el script desde la pestaña Pagos."))
  //End if 
  //End if 
  //End if 