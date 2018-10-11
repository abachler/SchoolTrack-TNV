//%attributes = {}
  //UD_v20131017_VerificaIndiceDocT
C_LONGINT:C283($i;$l_IDReporte;$l_NuevoIDReporte;$l_resultado;$l_table;$l_tableAvisos;$l_tableBoletas;$l_therm)
ARRAY LONGINT:C221($aIDs;0)

$l_therm:=IT_UThermometer (1;0;"Verificando identificadores en modelos de Avisos de Cobranza y Documentos Tributarios…")
READ WRITE:C146([xShell_Reports:54])
$l_tableBoletas:=Table:C252(->[ACT_Boletas:181])*-1
$l_tableAvisos:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$l_tableBoletas;*)
QUERY:C277([xShell_Reports:54]; | ;[xShell_Reports:54]MainTable:3=$l_tableAvisos)
QUERY SELECTION:C341([xShell_Reports:54]; & ;[xShell_Reports:54]IsStandard:38=False:C215;*)
QUERY SELECTION:C341([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7>=0)
CREATE SET:C116([xShell_Reports:54];"todos")
DISTINCT VALUES:C339([xShell_Reports:54]ID:7;$aIDs)
For ($i;1;Size of array:C274($aIDs))
	QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ID:7=$aIDs{$i})
	If (Records in selection:C76([xShell_Reports:54])>1)
		APPLY TO SELECTION:C70([xShell_Reports:54];[xShell_Reports:54]ID:7:=SQ_SeqNumber (->[xShell_Reports:54]ID:7))
	End if 
	USE SET:C118("todos")
End for 
CLEAR SET:C117("todos")
IT_UThermometer (-2;$l_therm)
KRL_UnloadReadOnly (->[xShell_Reports:54])

