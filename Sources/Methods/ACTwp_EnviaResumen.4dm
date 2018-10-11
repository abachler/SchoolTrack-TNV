//%attributes = {}
  //ACTwp_EnviaResumen

C_BOOLEAN:C305($0;$vb_ejecutado)
If (<>bXS_esServidorOficial)
	If (ACT_AccountTrackInicializado )
		If (LICENCIA_esModuloAutorizado (1;16))
			
			ACTcfg_OpcionesRazonesSociales ("LoadConfig")
			
			If (SMTP_VerifyEmailAddress ([ACT_RazonesSociales:279]contacto_eMail:15;False:C215)#"")
				
				C_TEXT:C284($t_fecha;$t_dts)
				C_DATE:C307($d_fecha)
				
				C_DATE:C307($d_fecha2;$d_fechaRevisada)
				C_TEXT:C284($t_dts2)
				
				READ ONLY:C145([ACT_Pagos:172])
				
				$d_fecha:=Add to date:C393(Current date:C33(*);0;0;-1)
				$t_dts:=DTS_MakeFromDateTime ($d_fecha)
				$d_fecha:=DTS_GetDate (PREF_fGet (0;"ACT_DTS_EMAILDIARIO_WEBPAY";$t_dts))
				
				$d_fecha2:=Add to date:C393(Current date:C33(*);0;0;-1)
				$t_dts2:=DTS_MakeFromDateTime ($d_fecha2)
				$d_fechaRevisada:=DTS_GetDate (PREF_fGet (0;"ACT_DTS_REVISIONDIARIA_WEBPAY";$t_dts2))
				
				While (($d_fecha<=$d_fechaRevisada) & ($d_fecha<=Add to date:C393(Current date:C33(*);0;0;-1)))  //solo se envia mail hasta la fecha revisada en SN y fecha menor a la actual
					$vb_ejecutado:=ACTwp_EnviaResumenXDia ($d_fecha)
					If ($vb_ejecutado)
						$d_fecha:=Add to date:C393($d_fecha;0;0;1)
						$t_dts:=DTS_MakeFromDateTime ($d_fecha)
						PREF_Set (0;"ACT_DTS_EMAILDIARIO_WEBPAY";$t_dts)
					Else 
						$d_fecha:=Add to date:C393($d_fechaRevisada;0;0;1)
					End if 
				End while 
				
			Else 
				
				  //genero mensaje en el centro de notificaciones para que ingresen el correo.
				C_TEXT:C284($t_Encabezado;$t_descripcion;$t_uuid)
				ARRAY TEXT:C222($atACT_descripcionMensaje;0)
				ARRAY LONGINT:C221($al_colores;0)
				ARRAY LONGINT:C221($al_estilos;0)
				APPEND TO ARRAY:C911($atACT_descripcionMensaje;"Envío de resumen diario de pagos Webpay no realizado debido a que no hay un email válido registrado en los datos de Contacto en el colegio, en la configuración, generales, datos institución.")
				APPEND TO ARRAY:C911($al_colores;Red:K11:4)
				APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
				C_TEXT:C284($t_Encabezado;$t_descripcion;$t_uuid)
				ARRAY TEXT:C222($at_TitulosColumnas;0)
				$t_Encabezado:="Error en envío de Email con resumen de pagos Webpay."
				$t_descripcion:="Verificación diaria de email registrado en AccountTrack.\r\rEmail se configura en: /Archivo/Configuración/Generales/Datos institución/Contacto en el Colegio"
				APPEND TO ARRAY:C911($at_TitulosColumnas;"Mensaje")
				
				$t_uuid:=NTC_CreaMensaje ("AccountTrack";$t_Encabezado;$t_descripcion)
				NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$atACT_descripcionMensaje)
				NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
				
			End if 
			
		End if 
	End if 
End if 
$0:=$vb_ejecutado