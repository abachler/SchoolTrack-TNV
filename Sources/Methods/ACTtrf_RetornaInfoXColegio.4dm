//%attributes = {}
  //ACTtrf_RetornaInfoXColegio

C_LONGINT:C283($idDocPago)
C_TEXT:C284($0)

$dato:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
Case of 
	: ($dato="Código Auxiliar")
		Case of 
			: (<>gRolBD="88730")  //Villa Maria
				  //20120924 RCH ticket 113137
				  //If ([ACT_Pagos]No_Cuenta_Contable="1-1-01-003") | ([ACT_Pagos]No_Cuenta_Contable="1-1-03-010") | ([ACT_Pagos]No_Cuenta_Contable="1-1-01-004") | ([ACT_Pagos]No_Cuenta_Contable="5-1-01-001")
				If (([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-01-003") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-03-010") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-01-004") | ([ACT_Pagos:172]No_Cuenta_Contable:16="5-1-01-001") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-01-006") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-01-007"))
					$0:=""
				Else 
					$0:=ST_RigthChars (("0"*8)+Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1);8)
				End if 
				
			: (<>gRolBD="92169")  //suizo incidente 66393
				If ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-06-10") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-06-20")
					$0:=ST_Uppercase (Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1)+"-"+Substring:C12([Personas:7]RUT:6;Length:C16([Personas:7]RUT:6)))
				Else 
					$0:=""
				End if 
			Else 
				$0:=$ptr1->
		End case 
		
	: ($dato="Nro. dcto. referencia")
		FIRST RECORD:C50([ACT_Pagos:172])
		KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6)
		Case of 
			: (<>gRolBD="89508")  //Cía María Seminario Incidente 57638
				Case of 
					: ([ACT_Pagos:172]id_forma_de_pago:30=-4) | ([ACT_Pagos:172]id_forma_de_pago:30=-8)
						$0:=[ACT_Documentos_de_Pago:176]NoSerie:12
					Else 
						$0:="EFE 1"
				End case 
				
			: ((<>gRolBD="89729") & ([ACT_Pagos:172]id_forma_de_pago:30=-4))  //san benito. Incidente 55946
				$0:=[ACT_Documentos_de_Pago:176]NoSerie:12
			: (<>gRolBD="92169")  //suizo incidente 66393
				If ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-06-10") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-06-20")
					$0:=[ACT_Documentos_de_Pago:176]NoSerie:12
				End if 
			: (<>gRolBD="88730")  //Villa Maria
				If ([ACT_Pagos:172]No_Cuenta_Contable:16=vtACT_CPCAFecha)
					$0:=[ACT_Documentos_de_Pago:176]NoSerie:12
				Else 
					$0:=""
				End if 
			Else 
				FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
				Case of 
					: ([ACT_Avisos_de_Cobranza:124]Mes:6<=3)
						$0:="1"
					Else 
						$0:=String:C10(([ACT_Avisos_de_Cobranza:124]Mes:6-2))
				End case 
		End case 
		
	: ($dato="Fecha referencia documento")
		C_DATE:C307($vd_fecha)
		FIRST RECORD:C50([ACT_Pagos:172])
		KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6)
		Case of 
			: (<>gRolBD="92169")  //suizo incidente 66393
				If ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-06-10") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-06-20")
					$vd_fecha:=[ACT_Documentos_de_Pago:176]Fecha:13
				End if 
			: (<>gRolBD="88730")  //Villa Maria
				If ([ACT_Pagos:172]No_Cuenta_Contable:16=vtACT_CPCAFecha)
					$vd_fecha:=[ACT_Documentos_de_Pago:176]FechaPago:4
				End if 
			Else 
				If ([ACT_Pagos:172]id_forma_de_pago:30=-4)
					Case of 
						: (<>gRolBD="89508")  //Cía María Seminario Incidente 57638
							$vd_fecha:=[ACT_Documentos_de_Pago:176]Fecha:13
						: (<>gRolBD="89729")  //san benito. Incidente 55946
							$vd_fecha:=[ACT_Documentos_de_Pago:176]FechaVencimiento:27
						Else 
							If ([ACT_Documentos_de_Pago:176]Fecha:13>[ACT_Documentos_de_Pago:176]FechaPago:4)
								$vd_fecha:=[ACT_Documentos_de_Pago:176]Fecha:13
							End if 
					End case 
				End if 
		End case 
		If ($vd_fecha#!00-00-00!)
			$dia:=ST_RigthChars ("00"+String:C10(Day of:C23($vd_fecha));2)
			$mes:=ST_RigthChars ("00"+String:C10(Month of:C24($vd_fecha));2)
			$Agno:=String:C10(Year of:C25($vd_fecha))
			$0:=$mes+$dia+$agno
		Else 
			$0:=""
		End if 
		
	: ($dato="Fecha vencimiento documento")
		C_DATE:C307($vd_fecha)
		FIRST RECORD:C50([ACT_Pagos:172])
		$idDocPago:=[ACT_Pagos:172]ID_DocumentodePago:6
		KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->$idDocPago)
		Case of 
			: (<>gRolBD="92169")  //suizo incidente 66393
				If ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-06-10") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-06-20")
					$vd_fecha:=[ACT_Documentos_de_Pago:176]FechaVencimiento:27
				End if 
			: (<>gRolBD="88730")  //Villa Maria
				If ([ACT_Pagos:172]No_Cuenta_Contable:16=vtACT_CPCAFecha)
					$vd_fecha:=[ACT_Documentos_de_Pago:176]Fecha:13
				End if 
		End case 
		If ($vd_fecha#!00-00-00!)
			$dia:=ST_RigthChars ("00"+String:C10(Day of:C23($vd_fecha));2)
			$mes:=ST_RigthChars ("00"+String:C10(Month of:C24($vd_fecha));2)
			$Agno:=String:C10(Year of:C25($vd_fecha))
			$0:=$mes+$dia+$agno
		Else 
			$0:=""
		End if 
	: ($dato="CampoTextoDirecto")
		Case of 
			: (KRL_isSameField (->[Personas:7]RUT:6;$ptr1))
				Case of 
					: (<>gRolBD="88730")  //incidente 65504
						If (Table:C252(vp_tabla)=Table:C252(->[ACT_Pagos:172]))
							C_LONGINT:C283($vl_existe)
							$el:=Find in array:C230(<>asACT_GlosaCta;"Cheques en Cartera@")
							If ($el#-1)
								SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_existe)
								QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]No_Cuenta_Contable:16=<>asACT_CuentaCta{$el})
								SET QUERY DESTINATION:C396(Into current selection:K19:1)
								If ($vl_existe>0)
									$0:=$ptr1->
								Else 
									$0:=""
								End if 
							Else 
								$0:=""
							End if 
						Else 
							$0:=""
						End if 
					Else 
						$0:=$ptr1->
				End case 
			Else 
				$0:=$ptr1->
		End case 
		
	: ($dato="CampoNumDirecto")
		Case of 
			: (KRL_isSameField (->[ACT_Pagos:172]ID:1;$ptr1))
				Case of 
					: (<>gRolBD="92169")  //suizo incidente 66393
						If ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-02-01")
							$0:=String:C10($ptr1->)
						Else 
							$0:=""
						End if 
					Else 
						$0:=String:C10($ptr1->)
				End case 
			Else 
				$0:=String:C10($ptr1->)
		End case 
		
		
	: ($dato="Número documento conciliación")
		Case of 
			: (<>gRolBD="88730")  //Villa Maria
				  //20120924 RCH ticket 113137
				  //If ([ACT_Pagos]No_Cuenta_Contable="1-1-01-003") | ([ACT_Pagos]No_Cuenta_Contable="1-1-01-004")
				If (([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-01-003") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-01-004") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-01-006"))
					$0:=String:C10(Year of:C25([ACT_Pagos:172]Fecha:2);"0000")+String:C10(Month of:C24([ACT_Pagos:172]Fecha:2);"00")+String:C10(Day of:C23([ACT_Pagos:172]Fecha:2);"00")
				Else 
					$0:=""
				End if 
		End case 
		
	: ($dato="Tipo documento conciliación")
		Case of 
			: (<>gRolBD="88730")  //Villa Maria
				  //20120924 RCH ticket 113137
				  //If ([ACT_Pagos]No_Cuenta_Contable="1-1-01-003") | ([ACT_Pagos]No_Cuenta_Contable="1-1-01-004")
				If (([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-01-003") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-01-004") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-01-006") | ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-01-007"))
					$0:=ST_Qte ("AB")
				Else 
					$0:=""
				End if 
		End case 
		
	: ($dato="Correlativo")
		Case of 
			: (<>gRolBD="88730")  //Villa Maria
				If ([ACT_Pagos:172]No_Cuenta_Contable:16=vtACT_CPCAFecha)
					$0:=""
				Else 
					$0:="0"
				End if 
			Else 
				$0:=String:C10($ptr1->)
		End case 
		
	: ($dato="Tipo de movimiento")
		Case of 
			: (<>gRolBD="8002500161")  //Cumbres Medellin
				If ($ptr1->#0)
					$0:="C"
				Else 
					$0:="A"
				End if 
			Else 
				If ($ptr1->#0)
					$0:="1"
				Else 
					$0:="2"
				End if 
		End case 
		
End case 