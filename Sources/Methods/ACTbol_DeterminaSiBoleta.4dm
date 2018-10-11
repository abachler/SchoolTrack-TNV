//%attributes = {}
  //ACTbol_DeterminaSiBoleta

  //20080509 RCH se compara el monto del aviso con lo que hay boleteado sólo para el aviso (la emisión pudo haber sido agrupada)

ARRAY LONGINT:C221($aIDsAvisosTodos;0)
ARRAY LONGINT:C221($aRNAvisosTodos;0)
ARRAY REAL:C219($aMontosAvisosTodos;0)
ARRAY REAL:C219($ar_Intereses;0)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Boletas:181])

  //SELECTION TO ARRAY([ACT_Avisos_de_Cobranza];$aRNAvisosTodos;[ACT_Avisos_de_Cobranza]ID_Aviso;$aIDsAvisosTodos;[ACT_Avisos_de_Cobranza]Monto_Neto;$aMontosAvisosTodos)
  //SELECTION TO ARRAY([ACT_Avisos_de_Cobranza]Intereses;$ar_Intereses)
  // 20120322 RCH 20120322 RCH se obtienen el monto del aviso desde metodo. El monto del aviso podria estar en UF.
SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124];$aRNAvisosTodos;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$aIDsAvisosTodos)

KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
CREATE SET:C116([ACT_Transacciones:178];"transAvisos")
For ($i;Size of array:C274($aIDsAvisosTodos);1;-1)
	USE SET:C118("transAvisos")
	QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=$aIDsAvisosTodos{$i})
	If (Records in selection:C76([ACT_Transacciones:178])>0)
		KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
		CREATE SET:C116([ACT_Boletas:181];"boletas")
		$montoBolEnTrans:=ACTbol_GetMontoLinea2 ("boletas";$aIDsAvisosTodos{$i})
		CLEAR SET:C117("boletas")
		  //If ($montoBolEnTrans=($aMontosAvisosTodos{$i}+$ar_Intereses{$i}))
		  //  20120322 RCH se obtienen el monto del aviso desde metodo. El monto del aviso podria estar en UF.
		  //$vr_montoAviso:=ACTcar_CalculaMontos ("calcMontoFromNumAvisoMPago";->[ACT_Avisos_de_Cobranza]ID_Aviso;->[ACT_Cargos]Monto_Neto;Current date(*))
		  //20120410 RCH Se cambia campo por elemento de arreglo
		$vr_montoAviso:=ACTcar_CalculaMontos ("calcMontoFromNumAvisoMPago";->$aIDsAvisosTodos{$i};->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
		If ($montoBolEnTrans=$vr_montoAviso)
			DELETE FROM ARRAY:C228($aRNAvisosTodos;$i;1)
			DELETE FROM ARRAY:C228($aIDsAvisosTodos;$i;1)
		End if 
		CREATE SET:C116([ACT_Transacciones:178];"boletas")
		DIFFERENCE:C122("transAvisos";"boletas";"transAvisos")
	End if 
End for 
SET_ClearSets ("transAvisos";"boletas")
CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$aRNAvisosTodos;"")

  //20150323 RCH quito personas a las que no se les emite
ARRAY LONGINT:C221($al_idsResp;0)
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"$avisosTodos")
QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3#0)
KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;"")
QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_ReceptorDT_Tipo:112=4)
SELECTION TO ARRAY:C260([Personas:7]No:1;$al_idsResp)
QUERY SELECTION WITH ARRAY:C1050([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;$al_idsResp)
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"$avisosAQuitar")
DIFFERENCE:C122("$avisosTodos";"$avisosAQuitar";"$avisosTodos")
USE SET:C118("$avisosTodos")
SET_ClearSets ("$avisosTodos";"$avisosAQuitar")

  //20150323 RCH quito terceros
ARRAY LONGINT:C221($al_idsResp;0)
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"$avisosTodos")
QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26#0)
KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26;"")
QUERY SELECTION:C341([ACT_Terceros:138];[ACT_Terceros:138]ReceptorDT_tipo:76=4)
SELECTION TO ARRAY:C260([ACT_Terceros:138]Id:1;$al_idsResp)
QUERY SELECTION WITH ARRAY:C1050([ACT_Avisos_de_Cobranza:124]ID_Tercero:26;$al_idsResp)
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"$avisosAQuitar")
DIFFERENCE:C122("$avisosTodos";"$avisosAQuitar";"$avisosTodos")
USE SET:C118("$avisosTodos")
SET_ClearSets ("$avisosTodos";"$avisosAQuitar")
