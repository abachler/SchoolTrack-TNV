Case of 
	: (btn_ACSeleccionados=1)
		$vl_records:=BWR_SearchRecords 
	: (btn_ACListados=1)
		CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];alBWR_recordNumber;"")
End case 
QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=0)
If (vl_generarPorApdo=1)
	QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3#0)
End if 

If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
	ACCEPT:C269
Else 
	BEEP:C151
End if 