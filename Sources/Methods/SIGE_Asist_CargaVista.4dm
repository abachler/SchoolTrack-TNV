//%attributes = {}
  //SIGE_Asist_CargaVista

C_LONGINT:C283($1;$2;$3;$vl_tipo_de_vista;$vl_mes;$id_config_periodo;$noNivel;$num_lineas_visibles)
C_BLOB:C604($xBlob)
C_TEXT:C284($vt_detalle_nivel;$vt_detalle_mes_nivel)
C_DATE:C307($vd_fecha)
C_BOOLEAN:C305($vb_VDate)

$num_lineas_visibles:=2
$vl_tipo_de_vista:=$1
$vl_mes:=$2
If (Count parameters:C259=3)
	$noNivel:=$3
End if 
NIV_LoadArrays 

Case of 
	: ($vl_tipo_de_vista=1)  //general : todos los niveles para el mes seleccionado
		
		ARRAY TEXT:C222(at_NivDetail;0)
		
		For ($i;1;Size of array:C274(<>al_NumeroNivelesActivos))
			
			ARRAY TEXT:C222($at_key_nivel;0)
			ARRAY TEXT:C222($at_key_fecha_nivel;0)
			ARRAY LONGINT:C221($al_cod_respuesta_asist;0)
			ARRAY TEXT:C222($at_cod_envio_asist;0)  //código para consultar como fue procesado nuestro envío
			ARRAY TEXT:C222($at_envio_asist_msg;0)
			ARRAY LONGINT:C221($al_cod_envio_asist_resp;0)
			ARRAY TEXT:C222($at_error_envio_asist_resp;0)
			
			ARRAY LONGINT:C221($al_codigos_pet;0)
			ARRAY LONGINT:C221($al_codigos_rev;0)
			
			$vt_detalle_nivel:=SIGE_CargaBlobNivelesMes (<>al_NumeroNivelesActivos{$i};$vl_mes;->$at_key_nivel;->$at_key_fecha_nivel;->$al_cod_respuesta_asist;->$at_cod_envio_asist;->$at_envio_asist_msg;->$al_cod_envio_asist_resp;->$at_error_envio_asist_resp)
			
			COPY ARRAY:C226($al_cod_respuesta_asist;$al_codigos_pet)
			AT_DistinctsArrayValues (->$al_codigos_pet)
			COPY ARRAY:C226($al_cod_envio_asist_resp;$al_codigos_rev)
			AT_DistinctsArrayValues (->$al_codigos_rev)
			
			ARRAY TEXT:C222($at_error_txt;0)
			
			For ($n;1;Size of array:C274($al_codigos_pet))
				Case of 
					: ($al_codigos_pet{$n}=0)
						APPEND TO ARRAY:C911($at_error_txt;"Proceso nunca ejecutado")
					: ($al_codigos_pet{$n}=2)
						APPEND TO ARRAY:C911($at_error_txt;"Error de validación de negocio")
					: ($al_codigos_pet{$n}=3)
						APPEND TO ARRAY:C911($at_error_txt;"RBD NO tiene servicio disponible")
					: ($al_codigos_pet{$n}=4)
						APPEND TO ARRAY:C911($at_error_txt;"Convenio NO tiene RBD asociado")
					: ($al_codigos_pet{$n}=5)
						APPEND TO ARRAY:C911($at_error_txt;"Servicio NO disponible")
					: ($al_codigos_pet{$n}=7)
						APPEND TO ARRAY:C911($at_error_txt;"Error interno del servicio")
				End case 
			End for 
			
			ARRAY LONGINT:C221($DA_return;0)
			$al_codigos_pet{0}:=0
			AT_SearchArray (->$al_codigos_pet;"#";->$DA_return)
			
			If (Size of array:C274($DA_return)>0)
				
				For ($n;1;Size of array:C274($al_codigos_rev))
					Case of 
						: ($al_codigos_rev{$n}=0)
							APPEND TO ARRAY:C911($at_error_txt;"Verificación de ingreso pendiente")
						: ($al_codigos_rev{$n}=1)
							APPEND TO ARRAY:C911($at_error_txt;"Asistencia procesada Existosamente")
						: ($al_codigos_rev{$n}=2)
							APPEND TO ARRAY:C911($at_error_txt;"Asistencia procesada con observaciones")
						: ($al_codigos_rev{$n}=3)
							APPEND TO ARRAY:C911($at_error_txt;"Asistencia procesada con errores")
						: ($al_codigos_rev{$n}=4)
							APPEND TO ARRAY:C911($at_error_txt;"Asistencia aun no procesada")
						: ($al_codigos_rev{$n}=5)
							APPEND TO ARRAY:C911($at_error_txt;"Parámetros no corresponden")
						: ($al_codigos_rev{$n}=6)
							APPEND TO ARRAY:C911($at_error_txt;"RBD NO tiene servicio disponible")
						: ($al_codigos_rev{$n}=7)
							APPEND TO ARRAY:C911($at_error_txt;"Convenio NO tiene asociado RBD")
						: ($al_codigos_rev{$n}=8)
							APPEND TO ARRAY:C911($at_error_txt;"Servicio no disponible")
						: ($al_codigos_rev{$n}=9)
							APPEND TO ARRAY:C911($at_error_txt;"Semilla para verificación ha caducado...")
						: ($al_codigos_rev{$n}=10)
							APPEND TO ARRAY:C911($at_error_txt;"Error interno de servicio")
					End case 
				End for 
				
			End if 
			
			APPEND TO ARRAY:C911(at_NivDetail;AT_array2text (->$at_error_txt;", "))
			
		End for 
		
		$Error:=ALP_DefaultColSettings (xALP_SIGE;1;"<>at_NombreNivelesActivos";"Niveles";100;"")
		$Error:=ALP_DefaultColSettings (xALP_SIGE;2;"at_NivDetail";"Detalle "+vt_mes;500;"")
		
	: ($vl_tipo_de_vista=2)
		
		ARRAY TEXT:C222($at_key_nivel;0)
		ARRAY TEXT:C222($at_key_fecha_nivel;0)
		ARRAY LONGINT:C221($al_cod_respuesta_asist;0)
		ARRAY TEXT:C222($at_cod_envio_asist;0)  //código para consultar como fue procesado nuestro envío
		ARRAY TEXT:C222($at_envio_asist_msg;0)
		ARRAY LONGINT:C221($al_cod_envio_asist_resp;0)
		ARRAY TEXT:C222($at_error_envio_asist_resp;0)
		
		$vt_detalle_nivel:=SIGE_CargaBlobNivelesMes ($noNivel;$vl_mes;->$at_key_nivel;->$at_key_fecha_nivel;->$al_cod_respuesta_asist;->$at_cod_envio_asist;->$at_envio_asist_msg;->$al_cod_envio_asist_resp;->$at_error_envio_asist_resp)
		
		ARRAY TEXT:C222(at_Fecha;0)
		ARRAY TEXT:C222(at_Rol;0)
		ARRAY TEXT:C222(at_Cod_ens;0)
		ARRAY TEXT:C222(at_Cod_grado;0)
		ARRAY TEXT:C222(at_Detalle;0)
		
		For ($i;1;Size of array:C274($at_key_fecha_nivel))
			If (opt3=1)
				
				If ($al_cod_respuesta_asist{$i}=1)  //LOS INGRESOS DE ASISTENCIA ENVIADOS SATISFACTORIAMENTE Y QUE NO HAN SIDO CONFIRMADOS POSITIVAMENTE
					ARRAY TEXT:C222($at_exploded;0)
					AT_Text2Array (->$at_exploded;$at_key_fecha_nivel{$i};".")
					If (Size of array:C274($at_exploded)=4)
						
						APPEND TO ARRAY:C911(at_Rol;$at_exploded{1})
						APPEND TO ARRAY:C911(at_Cod_ens;$at_exploded{2})
						APPEND TO ARRAY:C911(at_Cod_grado;$at_exploded{3})
						APPEND TO ARRAY:C911(at_Fecha;$at_exploded{4})
						
						Case of 
							: ($al_cod_envio_asist_resp{$i}=0)
								APPEND TO ARRAY:C911(at_Detalle;"Verificación de ingreso pendiente")
							: ($al_cod_envio_asist_resp{$i}=1)
								APPEND TO ARRAY:C911(at_Detalle;"Asistencia procesada exitosamente.")
							: ($al_cod_envio_asist_resp{$i}=2)
								APPEND TO ARRAY:C911(at_Detalle;"Asistencia procesada con observaciones. "+$at_error_envio_asist_resp{$i})
							: ($al_cod_envio_asist_resp{$i}=3)
								APPEND TO ARRAY:C911(at_Detalle;"Asistencia procesada con errores. "+$at_error_envio_asist_resp{$i})
							: ($al_cod_envio_asist_resp{$i}=4)
								APPEND TO ARRAY:C911(at_Detalle;"Asistencia aun no ha sido procesada.")
							: ($al_cod_envio_asist_resp{$i}=5)
								APPEND TO ARRAY:C911(at_Detalle;"Parámetros no corresponden. "+$at_error_envio_asist_resp{$i})
							: ($al_cod_envio_asist_resp{$i}=6)
								APPEND TO ARRAY:C911(at_Detalle;"RBD NO tiene Servicio Disponible")
							: ($al_cod_envio_asist_resp{$i}=7)
								APPEND TO ARRAY:C911(at_Detalle;"Convenio NO tiene RBD asociado")
							: ($al_cod_envio_asist_resp{$i}=8)
								APPEND TO ARRAY:C911(at_Detalle;"Servicio no disponible, intente nuevamente más tarde.")
							: ($al_cod_envio_asist_resp{$i}=9)
								APPEND TO ARRAY:C911(at_Detalle;"Semilla de operación no válida")
							: ($al_cod_envio_asist_resp{$i}=10)
								APPEND TO ARRAY:C911(at_Detalle;"Error interno del servicio")
								
						End case 
						
					End if 
					
				End if 
				
			Else 
				
				ARRAY TEXT:C222($at_exploded;0)
				AT_Text2Array (->$at_exploded;$at_key_fecha_nivel{$i};".")
				
				If (Size of array:C274($at_exploded)=4)
					
					APPEND TO ARRAY:C911(at_Rol;$at_exploded{1})
					APPEND TO ARRAY:C911(at_Cod_ens;$at_exploded{2})
					APPEND TO ARRAY:C911(at_Cod_grado;$at_exploded{3})
					APPEND TO ARRAY:C911(at_Fecha;$at_exploded{4})
					
					Case of 
						: ($al_cod_respuesta_asist{$i}=0)
							APPEND TO ARRAY:C911(at_Detalle;"Proceso nunca ejecutado")
						: ($al_cod_respuesta_asist{$i}=1)
							APPEND TO ARRAY:C911(at_Detalle;"Envío ejecutado exitosamente. "+$at_envio_asist_msg{$i})
						: ($al_cod_respuesta_asist{$i}=2)
							APPEND TO ARRAY:C911(at_Detalle;"Error de validación de negocio. "+$at_cod_envio_asist{$i}+". "+$at_envio_asist_msg{$i})  //cuando el código de respuesta es 2 guardo el detalle del error aquí...
						: ($al_cod_respuesta_asist{$i}=3)
							APPEND TO ARRAY:C911(at_Detalle;"RBD NO tiene Servicio Disponible")
						: ($al_cod_respuesta_asist{$i}=4)
							APPEND TO ARRAY:C911(at_Detalle;"Convenio NO tiene RBD asociado")
						: ($al_cod_respuesta_asist{$i}=5)
							APPEND TO ARRAY:C911(at_Detalle;"Servicio NO disponible")
						: ($al_cod_respuesta_asist{$i}=7)
							APPEND TO ARRAY:C911(at_Detalle;"Error interno del servicio")
					End case 
					
				End if 
				
			End if 
			
			$num_lineas_visibles_temp:=Round:C94((Length:C16(at_Detalle{Size of array:C274(at_Detalle)}))/100;0)
			If ($num_lineas_visibles<$num_lineas_visibles_temp)
				$num_lineas_visibles:=$num_lineas_visibles_temp
			End if 
			
		End for 
		
		$Error:=ALP_DefaultColSettings (xALP_SIGE;1;"at_Rol";"Rol";80;"")
		$Error:=ALP_DefaultColSettings (xALP_SIGE;2;"at_Cod_ens";"Código de\r Enseñanza";70;"")
		$Error:=ALP_DefaultColSettings (xALP_SIGE;3;"at_Cod_grado";"Código de\r Grado";80;"")
		$Error:=ALP_DefaultColSettings (xALP_SIGE;4;"at_Fecha";"Fecha";60;"")
		$Error:=ALP_DefaultColSettings (xALP_SIGE;5;"at_Detalle";"Detalle del Nivel ST "+<>at_NombreNivelesActivos{Find in array:C230(<>al_NumeroNivelesActivos;$noNivel)};500;"")
		
		
End case 


$0:=$num_lineas_visibles
