//%attributes = {}
  // Método: ACTbol_OpcionesGenerales
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 23-06-10, 19:14:39
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal


C_TEXT:C284($vt_accion;$1;$vt_retorno;$0)
C_POINTER:C301($ptr1;$ptr2;$ptr3;$ptr4;$ptr5)
C_POINTER:C301(${2})

$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
If (Count parameters:C259>=5)
	$ptr4:=$5
End if 
If (Count parameters:C259>=6)
	$ptr5:=$6
End if 

Case of 
	: ($vt_accion="RecalculoAvisosNC")
		  //recalculo de ctas, apdos y terceros si es nc...
		  //$ptr1 -> id apoderado
		  //$ptr2 -> id tercero
		Case of 
			: ($ptr1->#0)
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=$ptr1->;*)
				QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					ARRAY LONGINT:C221($alACT_recNumsAvisos;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAvisos;"")
					ACTmnu_RecalcularSaldosAvisos (->$alACT_recNumsAvisos;Current date:C33(*);False:C215;True:C214)
				Else 
					READ ONLY:C145([Personas:7])
					QUERY:C277([Personas:7];[Personas:7]No:1=$ptr1->)
					BM_CreateRequest ("ACTpp_Calcula_Montos_Ejercicio";String:C10(Record number:C243([Personas:7])))
				End if 
			: ($ptr2->#0)
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=$ptr2->;*)
				QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					ARRAY LONGINT:C221($alACT_recNumsAvisos;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAvisos;"")
					ACTmnu_RecalcularSaldosAvisos (->$alACT_recNumsAvisos;Current date:C33(*);False:C215;True:C214)
				Else 
					BM_CreateRequest ("ACTter_ActualizaValores";String:C10($ptr2->);String:C10($ptr2->))
				End if 
		End case 
		
	: ($vt_accion="ObtieneNombreCategoriaPorID")
		C_LONGINT:C283($vl_idCategoria;$vl_existe)
		$vl_idCategoria:=$ptr1->
		If ($vl_idCategoria#0)
			ACTcfg_LeeBlob ("ACT_DocsTributarios")
			$vl_existe:=Find in array:C230(alACT_IDsCats;$vl_idCategoria)
			If ($vl_existe>0)
				$vt_retorno:=atACT_Categorias{$vl_existe}
			End if 
		End if 
		
	: ($vt_accion="FijaMontosMonedaVariable")
		
		For ($i;1;Size of array:C274($ptr1->))
			READ ONLY:C145([ACT_Transacciones:178])
			GOTO RECORD:C242([ACT_Transacciones:178];$ptr1->{$i})
			If (Records in selection:C76([ACT_Transacciones:178])=1)
				$vt_retorno:=ACTcar_OpcionesGenerales ("FijaMontoMonedaVariableCargo";->[ACT_Transacciones:178]ID_Item:3)
				If ($vt_retorno="0")
					$i:=Size of array:C274($ptr1->)
				End if 
			Else 
				$vt_retorno:="0"
				$i:=Size of array:C274($ptr1->)
			End if 
		End for 
		
	: ($vt_accion="BuscaDocDuplicado")
		C_LONGINT:C283($vl_docs;$vl_numDoc;$vl_catDoc;$vl_idRazonSocial)
		C_REAL:C285($vr_tasaIVA)
		C_BOOLEAN:C305($vbACT_EsDigital;$vb_afecta)
		
		$vr_tasaIVA:=$ptr1->
		If ($vr_tasaIVA#0)
			$vb_afecta:=True:C214
		End if 
		$vl_numDoc:=$ptr2->
		$vl_catDoc:=$ptr3->
		$vbACT_EsDigital:=$ptr4->
		$vl_idRazonSocial:=$ptr5->
		
		$vb_continuar:=True:C214
		If ((at_proveedores{at_proveedores}="Colegium") & (cs_emitirCFDI=1))
			  //proveedor colegium emite los documentos en 0
			If ($vl_numDoc=0)
				$vb_continuar:=False:C215
			End if 
		End if 
		
		If ($vb_continuar)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_docs)
			If ($vb_afecta)
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=$vl_numDoc;*)
				QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Categoria:12=$vl_catDoc;*)
				QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]TasaIVA:16#0;*)
				QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=$vbACT_EsDigital;*)
				QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_RazonSocial:25=$vl_idRazonSocial)
			Else 
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=$vl_numDoc;*)
				QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Categoria:12=$vl_catDoc;*)
				QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]TasaIVA:16=0;*)
				QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=$vbACT_EsDigital;*)
				QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_RazonSocial:25=$vl_idRazonSocial)
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
		End if 
		
		$vt_retorno:=String:C10($vl_docs)
		
End case 

$0:=$vt_retorno