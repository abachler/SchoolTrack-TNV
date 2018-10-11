//%attributes = {}
  //SRACTpp_MontosGenerales

C_TEXT:C284($vt_accion;$1)
C_LONGINT:C283($vl_idApdo;$2)

$vt_accion:=$1
$vl_idApdo:=$2

READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Documentos_en_Cartera:182])

Case of 
	: ($vt_accion="deudaSinDocumentar")
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=$vl_idApdo;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
		$0:=Abs:C99(Sum:C1([ACT_Cargos:173]Saldo:23))
		
	: ($vt_accion="chequesNoDepositados")
		QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Apoderado:2=$vl_idApdo;*)
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4;*)
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_estado:21#-2;*)
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_estado:21#-7)
		  //QUERY([ACT_Documentos_en_Cartera]; & ;[ACT_Documentos_en_Cartera]Estado#"Protestado.";*)
		  //QUERY([ACT_Documentos_en_Cartera]; & ;[ACT_Documentos_en_Cartera]Estado#"Protestado y Reemplazado@")
		$0:=Abs:C99(Sum:C1([ACT_Documentos_en_Cartera:182]Monto_Doc:7))
		
	: ($vt_accion="letrasNoPagadas")
		QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Apoderado:2=$vl_idApdo;*)
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-8;*)
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_estado:21#-51;*)
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_estado:21#-54)
		  //QUERY([ACT_Documentos_en_Cartera]; & ;[ACT_Documentos_en_Cartera]Estado#"Protestado.";*)
		  //QUERY([ACT_Documentos_en_Cartera]; & ;[ACT_Documentos_en_Cartera]Estado#"Protestado y Reemplazado@")
		$0:=Abs:C99(Sum:C1([ACT_Documentos_en_Cartera:182]Monto_Doc:7))
		
	: ($vt_accion="chequesProtestados")
		QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Apoderado:2=$vl_idApdo;*)
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4;*)
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_estado:21=-2)
		  //QUERY([ACT_Documentos_en_Cartera]; & ;[ACT_Documentos_en_Cartera]Estado="Protestado.")
		$0:=Abs:C99(Sum:C1([ACT_Documentos_en_Cartera:182]Monto_Doc:7))
		
	: ($vt_accion="letrasProtestadas")
		QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Apoderado:2=$vl_idApdo;*)
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-8;*)
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_estado:21=-51)
		  //QUERY([ACT_Documentos_en_Cartera]; & ;[ACT_Documentos_en_Cartera]Estado="Protestado.")
		$0:=Abs:C99(Sum:C1([ACT_Documentos_en_Cartera:182]Monto_Doc:7))
		
End case 