//%attributes = {}
  //ACTwp_RevisaPagos
  //20130813 RCH Webpay

  //metodo para que sea ejecutado en las tareas de fin de dia. es el encargado de revisar que los pagos ingresados sean los que tiene SN.
C_BOOLEAN:C305($0;$vb_ejecutado)
If (<>bXS_esServidorOficial)
	If (ACT_AccountTrackInicializado )
		If (LICENCIA_esModuloAutorizado (1;16))
			
			C_TEXT:C284($t_fecha;$t_dts)
			C_DATE:C307($d_fecha)
			ARRAY DATE:C224($adACT_fechaPagos;0)
			C_BOOLEAN:C305($vb_ejecutado)
			
			READ ONLY:C145([ACT_Pagos:172])
			
			  //hago la verificacion diaria desde el ultimo dia verificado
			  //$d_fecha:=Current date(*)-1
			$d_fecha:=Add to date:C393(Current date:C33(*);0;0;-1)
			$t_dts:=DTS_MakeFromDateTime ($d_fecha)
			$d_fecha:=DTS_GetDate (PREF_fGet (0;"ACT_DTS_REVISIONDIARIA_WEBPAY";$t_dts))
			
			While ($d_fecha<=Add to date:C393(Current date:C33(*);0;0;-1))
				$vb_ejecutado:=ACTwp_RevisaPagosXDia ($d_fecha;True:C214)
				If ($vb_ejecutado)
					$d_fecha:=Add to date:C393($d_fecha;0;0;1)
					$t_dts:=DTS_MakeFromDateTime ($d_fecha)
					PREF_Set (0;"ACT_DTS_REVISIONDIARIA_WEBPAY";$t_dts)
				Else 
					$d_fecha:=Current date:C33(*)
				End if 
			End while 
			
			If ($vb_ejecutado)
				  //busco pagos Webpay importados que no hayan sido validados.
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_WebpayOC:32=0;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]id_forma_de_pago:30=-18)
				DISTINCT VALUES:C339([ACT_Pagos:172]Fecha:2;$adACT_fechaPagos)
				For ($l_pagos;1;Size of array:C274($adACT_fechaPagos))
					  //$vb_ejecutado:=ACTwp_RevisaPagosXDia ($adACT_fechaPagos{$l_pagos})
					$vb_ejecutado:=ACTwp_RevisaPagosXDia ($adACT_fechaPagos{$l_pagos};True:C214)
				End for 
			End if 
			
		End if 
	End if 
End if 
$0:=$vb_ejecutado