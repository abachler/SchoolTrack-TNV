//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 24-07-18, 11:05:03
  // ----------------------------------------------------
  // Método: ACTcc_ModificaFechasEmisVencAC
  // Descripción
  // Método para controlar el acceso a la función
  //
  // Parámetros
  // ----------------------------------------------------
C_TEXT:C284($t_accion;$1)
C_LONGINT:C283($0;$2;$l_respuesta)

$t_accion:=$1

Case of 
	: ($t_accion="VerificaProceso")
		If (USR_GetMethodAcces (Current method name:C684;0))
			$l_respuesta:=$2
		Else 
			$l_respuesta:=1
			$t_msg:=__ ("Lo siento, Ud. no está autorizado para utilizar esta función.")
			$t_msg:=$t_msg+__ ("\n\nLa función se hablita en la configuración de Usuarios y Grupos, habilitando el proceso autorizado: ")+ST_Qte (__ ("Permitir modificar Emisión y Vencimiento durante emisión de Avisos de Cobranza"))+"."
			CD_Dlog (0;$t_msg)
		End if 
		
	: ($t_accion="SetObjetos")
		If (cbVctoSegunConf=1)
			vdACT_DiaAviso:=viACT_DiaDeuda
			l_diasEmision:=viACT_DiaVencimiento
			vdACT_FechaAviso:=DT_GetDateFromDayMonthYear (vdACT_DiaAviso;aMeses;vdACT_AñoAviso)
			vdACT_DiaVctoAviso:=Day of:C23(vdACT_FechaAviso+l_diasEmision)
			
			cbUltimoDiaMes:=0
		Else 
			If (cbUltimoDiaMes=1)
				l_diasEmision:=0
				vdACT_DiaVctoAviso:=Day of:C23(ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear (DT_GetLastDay (aMeses;vdACT_AñoAviso);aMeses;vdACT_AñoAviso)))
			Else 
				If (l_diasEmision=0)
					l_diasEmision:=viACT_DiaVencimiento
				End if 
				vdACT_FechaAviso:=DT_GetDateFromDayMonthYear (vdACT_DiaAviso;aMeses;vdACT_AñoAviso)
				vdACT_DiaVctoAviso:=Day of:C23(vdACT_FechaAviso+l_diasEmision)
			End if 
		End if 
		
End case 

$0:=$l_respuesta