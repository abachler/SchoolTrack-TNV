//%attributes = {}
  // Método: ACTac_Delete
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 27-10-10, 11:37:07
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal


C_LONGINT:C283($recNumAviso;$t;$vl_idAviso)
C_BOOLEAN:C305($abort;$0)

$recNumAviso:=$1
$vl_idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1

ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)

QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$vl_idAviso)
KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
CREATE SET:C116([ACT_Cargos:173];"cargosAviso2M")
ARRAY LONGINT:C221($aIDsApdos;0)

  //se verifica si hay cargos divididos por responsable. Si es así, se eliminan, no se desemiten ya que las configuraciones podrían cambiar
C_LONGINT:C283($l_recs)
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recs)
QUERY SELECTION BY FORMULA:C207([ACT_Cargos:173];Not:C34(OB Is empty:C1297([ACT_Cargos:173]OB_Responsable:70)))
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ((cb_EliminarCargos=1) | ($l_recs>0))
	DISTINCT VALUES:C339([ACT_Cargos:173]ID_Apoderado:18;$aIDsApdos)
	ACTcc_EliminaCargosLoop 
Else 
	$abort:=ACTcc_DesEmitirCargos (False:C215)
	If (Not:C34($abort))
		  //se eliminan cargos de multas automaticas aunque no se tenga marcada la preferencia.
		  //esto es porque las multas estan asociadas a los avisos... Si se elimina el aviso, se elimina la multa.
		USE SET:C118("cargosAviso2M")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"")
		If (Records in selection:C76([ACT_Cargos:173])>0)
			DISTINCT VALUES:C339([ACT_Cargos:173]ID_Apoderado:18;$aIDsApdos)
			ACTcc_EliminaCargosLoop 
			For ($t;1;Size of array:C274($aIDsApdos))
				$vl_idApdo:=$aIDsApdos{$t}
				ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->$vl_idApdo)
			End for 
			LOG_RegisterEvt ("Eliminación de recargos automáticos para el aviso número: "+String:C10($vl_idAviso)+".")
		End if 
	End if 
End if 
SET_ClearSets ("cargosAviso2M")
READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$recNumAviso)
ACTac_OpcionesGenerales ("CreaRegistroActividadesEliminaciónAviso")
DELETE RECORD:C58([ACT_Avisos_de_Cobranza:124])
If (Locked:C147([ACT_Avisos_de_Cobranza:124]))
	$abort:=True:C214
End if 

$0:=$abort