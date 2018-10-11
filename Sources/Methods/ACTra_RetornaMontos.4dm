//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 31/07/13, 10:26:58
  // ----------------------------------------------------
  // Método: ACTra_RetornaMontos
  // Descripción
  // Metodo que retorna el monto de los recargos afectos o exentos
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($vt_monedaPago)
C_LONGINT:C283($vl_decimales)
C_LONGINT:C283($1;$l_idCtaCte;$l_idItemRecargo;$l_recNumACT;$0;$vl_idCargo)
C_REAL:C285($r_montoExtraExento;$r_montoExtraAfecto)

$l_recNumACT:=$1
$l_idItemRecargo:=$2
$l_idCtaCte:=$3
$r_montoExtraExento:=$4
$r_montoExtraAfecto:=$5

$0:=0

GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$l_recNumACT)
KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$l_idItemRecargo)
USE SET:C118("setCargos")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$l_idCtaCte)
$vl_idCargo:=[ACT_Cargos:173]ID:1

Case of 
	: (c_RecAutFijo=1)
		vrACT_MontoMulta:=[xxACT_Items:179]Monto:7
		
	: (c_RecAutPct=1)
		If (vr_PctMontoRecAut>0)
			$vt_monedaPago:=ST_GetWord (ACT_DivisaPais ;1;";")
			$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaPago))
			
			If (cs_CargoAfectoSeparado=0)
				$r_montoExtraExento:=$r_montoExtraExento+$r_montoExtraAfecto
				vrACT_MontoMulta:=ACTcfg_OpcionesRecargosAut ("CalculaMontoMultaPCT";->$vl_decimales;->$vt_monedaPago;->$r_montoExtraExento)
			Else 
				CREATE SET:C116([ACT_Cargos:173];"setCargosMulta")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21=0)
				vrACT_MontoMulta:=ACTcfg_OpcionesRecargosAut ("CalculaMontoMultaPCT";->$vl_decimales;->$vt_monedaPago;->$r_montoExtraExento)
				USE SET:C118("setCargosMulta")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21#0)
				vrACT_MontoMultaAfecta:=ACTcfg_OpcionesRecargosAut ("CalculaMontoMultaPCT";->$vl_decimales;->$vt_monedaPago;->$r_montoExtraAfecto)
				CLEAR SET:C117("setCargosMulta")
			End if 
		Else 
			LOG_RegisterEvt ("El recargo automático no pudo ser generado porque se tiene configurado obtener el"+" m"+"onto desde un porcentaje pero el porcentaje no"+" fue ingresado o está en 0 en la configuración.")
		End if 
End case 

$0:=$vl_idCargo