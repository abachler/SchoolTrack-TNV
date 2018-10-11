//%attributes = {}
  //ACTutl_EstimaInteres

C_LONGINT:C283($l_idCargo;$1)
C_DATE:C307($d_date;$2)
C_REAL:C285($0;$r_saldo;$porInt)
C_REAL:C285($r_rn;$r_days)
C_BOOLEAN:C305($b_apdoAfecto;$b_ctaAfecta;$b_itemAfecto;$b_tipo)
C_LONGINT:C283($vl_decimales)
C_TEXT:C284($vt_moneda)
C_REAL:C285($r_tasaMensual;$r_months;$r_intereses;$vr_montoPesos;$vr_montoMoneda)

$l_idCargo:=$1
$d_date:=$2
$0:=0
$r_intereses:=0

READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])
$r_rn:=Find in field:C653([ACT_Cargos:173]ID:1;$l_idCargo)
If ($r_rn#-1)
	GOTO RECORD:C242([ACT_Cargos:173];$r_rn)
	QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Cargos:173]ID_Apoderado:18)
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
	  //If ($d_date>[ACT_Cargos]LastInterestsUpdate)
	If (($d_date>[ACT_Cargos:173]LastInterestsUpdate:42) & ($d_date>[ACT_Cargos:173]Fecha_de_Vencimiento:7))  //20140825 RCH Intereses
		$r_days:=$d_date-[ACT_Cargos:173]LastInterestsUpdate:42
	Else 
		$r_days:=0
	End if 
	$b_apdoAfecto:=[Personas:7]ACT_AfectoIntereses:64
	If ([ACT_Cargos:173]ID_CuentaCorriente:2#0)  //para el caso de los cargos asociados solo al tercero
		$b_ctaAfecta:=[ACT_CuentasCorrientes:175]AfectoIntereses:28
	Else 
		$b_ctaAfecta:=True:C214
	End if 
	$b_itemAfecto:=[xxACT_Items:179]AfectoInteres:26
	$b_tipo:=[xxACT_Items:179]TipoInteres:29
	
	C_DATE:C307($d_fechaCalculo)
	If (<>b_usarFechaVencimiento=1)
		$d_fechaCalculo:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
	Else 
		$d_fechaCalculo:=$d_date
	End if 
	
	If (($b_apdoAfecto) & ($b_ctaAfecta) & ($b_itemAfecto))
		If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
			$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Cargos:173]Moneda:28))
			$vt_moneda:=[ACT_Cargos:173]Moneda:28
		Else 
			$vl_decimales:=<>vlACT_Decimales
			$vt_moneda:=<>vtACT_monedaPais
		End if 
		$r_tasaMensual:=[xxACT_Items:179]TasaInteresMensual:25/100
		$r_months:=$r_days/30
		If ($b_tipo)
			  //20161011 RCH Se buscan los cargos asociados no intereses.
			  //$r_saldo:=[ACT_Cargos]Saldo*-1
			  //$r_intereses:=Round($r_saldo*$r_months*$r_tasaMensual;$vl_decimales)
			
			PUSH RECORD:C176([ACT_Cargos:173])
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$l_idCargo;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-100)
			
			  //20161114 RCH
			  //$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;$fecha)
			  //$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;<>vtACT_monedaPais;$fecha;$vt_moneda)
			$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;$d_date)
			$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;<>vtACT_monedaPais;$d_date;$vt_moneda)
			
			POP RECORD:C177([ACT_Cargos:173])
			$r_saldo:=([ACT_Cargos:173]Saldo:23+$vr_montoMoneda)*-1
			$r_intereses:=Round:C94($r_saldo*$r_months*$r_tasaMensual;$vl_decimales)
			
		Else 
			$l_idCargo:=[ACT_Cargos:173]ID:1
			PUSH RECORD:C176([ACT_Cargos:173])
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$l_idCargo;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
			
			  //20161011 RCH Se comenta línea siguiente porque ahora se puede usar cualquier cargo para descuentos
			  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Saldo#0;*)
			  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item<0)  //para incluir todos los cargos relacionados...
			
			
			  //$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;$d_date)
			  //$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;<>vtACT_monedaPais;$d_date;$vt_moneda)
			$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;$d_fechaCalculo)
			$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;<>vtACT_monedaPais;$d_fechaCalculo;$vt_moneda)
			
			POP RECORD:C177([ACT_Cargos:173])
			$r_saldo:=([ACT_Cargos:173]Saldo:23+$vr_montoMoneda)*-1
			$r_intereses:=Round:C94($r_saldo*(((1+$r_tasaMensual)^$r_months)-1);$vl_decimales)
			
		End if 
		  //$r_intereses:=ACTut_retornaMontoEnMoneda ($r_intereses;$vt_moneda;Current date(*);<>vtACT_monedaPais)
		
		  //$r_intereses:=ACTut_retornaMontoEnMoneda ($r_intereses;$vt_moneda;$d_fechaCalculo;<>vtACT_monedaPais)
		
		If (<>bint_CalculaEnMonedaPais=1)
			  //$intereses:=ACTut_retornaMontoEnMoneda ($intereses;$vt_moneda;$d_fechaCalculo;<>vtACT_monedaPais)
			$r_intereses:=ACTut_retornaMontoEnMoneda ($r_intereses;$vt_moneda;$d_fechaCalculo;<>vtACT_monedaPais)
		End if 
		
	End if 
End if 
$0:=$r_intereses