//%attributes = {}
  //ACTdte_RecibeDocumentosMasivos

C_LONGINT:C283($vl_proc;$vl_records;$vl_procesados)

$vl_records:=BWR_SearchRecords 
If ($vl_records>0)
	If (LICENCIA_esModuloAutorizado (1;12))  //20130227 RCH Se valida licencia.
		
		ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
		
		$vl_proc:=IT_UThermometer (1;0;__ ("Recibiendo registros de documentos tributarios..."))
		
		QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];([ACT_Boletas:181]documento_electronico:29=True:C214) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 1) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 2) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 3)))
		$vl_procesados:=Num:C11(ACTdte_EnviaRecibeArchivos ("RecibeRegistrosDT"))
		SET_ClearSets ("setBoletas")
		KRL_UnloadReadOnly (->[ACT_Boletas:181])
		IT_UThermometer (-2;$vl_proc)
		
		If ($vl_procesados>0)
			POST KEY:C465(-96)
		End if 
	Else 
		CD_Dlog (0;__ ("Su licencia no permite ejecutar esta opción."))
	End if 
End if 