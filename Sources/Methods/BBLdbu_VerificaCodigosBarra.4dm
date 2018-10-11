//%attributes = {}
  // BBLdbu_VerificaCodigosBarra()
  // Por: Alberto Bachler K.: 20-04-14, 11:56:17
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_corregirAnomalias;$b_mostrarAviso)
C_LONGINT:C283($i_registros)
C_LONGINT:C283($i;$l_opcionUsuario;$l_registros;$l_ultimonúmeroRegistro;$l_codigosRegenerados;$l_registrosEnPrestamo;$l_numeroRegistroAsignado;$l_sinCodigoBarra)
C_TEXT:C284($t_códigoBarraAnterior;$t_descripcion;$t_encabezado;$t_mensaje;$t_parametros;$t_titulo;$t_ultimocódigoBarra;$t_uuid)

ARRAY LONGINT:C221($al_Colores;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_codigoBarraAnterior;0)
ARRAY TEXT:C222($at_Copia;0)
ARRAY TEXT:C222($at_errores;0)
ARRAY TEXT:C222($at_Item;0)
ARRAY TEXT:C222($at_nuevocódigoBarra;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)

$b_mostrarAviso:=False:C215

  // Modificado por: Saúl Ponce (18-02-2017) - Ticket Nº 175311
  // Asegura la ejecución cuando el llamado del método es desde Herramientas/Ejecutar.
$b_corregirAnomalias:=True:C214

If (Count parameters:C259=1)
	$t_parametros:=$1
	$b_corregirAnomalias:=($t_parametros="true")
End if 

If (Records in table:C83([BBL_Registros:66])>0)
	CREATE EMPTY SET:C140([BBL_Registros:66];"códigoBarraDuplicado")
	ALL RECORDS:C47([BBL_Registros:66])
	
	If (Records in selection:C76([BBL_Registros:66])>0)
		ORDER BY:C49([BBL_Registros:66];[BBL_Registros:66]Barcode_SinFormato:26;>)
		LONGINT ARRAY FROM SELECTION:C647([BBL_Registros:66];$al_RecNums;"")
		GOTO RECORD:C242([BBL_Registros:66];$al_RecNums{1})
		$t_ultimocódigoBarra:=[BBL_Registros:66]Barcode_SinFormato:26
		For ($i_registros;2;Size of array:C274($al_RecNums))
			GOTO RECORD:C242([BBL_Registros:66];$al_RecNums{$i_registros})
			If ([BBL_Registros:66]Barcode_SinFormato:26=$t_ultimocódigoBarra)
				ADD TO SET:C119([BBL_Registros:66];"códigoBarraDuplicado")
			End if 
			$t_ultimocódigoBarra:=[BBL_Registros:66]Barcode_SinFormato:26
		End for 
	End if 
	
	CREATE EMPTY SET:C140([BBL_Registros:66];"númeroRegistroDuplicado")
	ALL RECORDS:C47([BBL_Registros:66])
	ORDER BY:C49([BBL_Registros:66];[BBL_Registros:66]No_Registro:25;>)
	LONGINT ARRAY FROM SELECTION:C647([BBL_Registros:66];$al_RecNums;"")
	GOTO RECORD:C242([BBL_Registros:66];$al_RecNums{1})
	$l_ultimonúmeroRegistro:=[BBL_Registros:66]No_Registro:25
	For ($i_registros;2;Size of array:C274($al_RecNums))
		GOTO RECORD:C242([BBL_Registros:66];$al_RecNums{$i_registros})
		If ([BBL_Registros:66]No_Registro:25=$l_ultimonúmeroRegistro)
			ADD TO SET:C119([BBL_Registros:66];"númeroRegistroDuplicado")
		End if 
		$l_ultimonúmeroRegistro:=[BBL_Registros:66]No_Registro:25
	End for 
	
	QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Barcode_SinFormato:26="")
	CREATE SET:C116([BBL_Registros:66];"códigoBarraNulo")
	
	QUERY:C277([BBL_Registros:66];[BBL_Registros:66]No_Registro:25=0)
	CREATE SET:C116([BBL_Registros:66];"NoRegistroNulo")
	
	UNION:C120("códigoBarraDuplicado";"númeroRegistroDuplicado";"registros_a_procesar")
	UNION:C120("registros_a_procesar";"códigoBarraNulo";"registros_a_procesar")
	UNION:C120("registros_a_procesar";"NoRegistroNulo";"registros_a_procesar")
	
	If (Records in set:C195("registros_a_procesar")>0)
		
		If ($b_corregirAnomalias)
			$t_titulo:=__ ("Se detectaron ^0 con código de barra o número de registro duplicado o inválido.")
			$t_mensaje:=__ ("Para evitar errores en circulación es necesario asignar nuevos nuevos números de registros y código de barra a estos documentos.")
			$t_mensaje:=$t_mensaje+__ ("¿Desea usted efectuar corregir esta situación ahora o hacerlo manualmente en otro momento?\r")
			$t_titulo:=Replace string:C233($t_titulo;"^0";String:C10(Records in set:C195("registros_a_procesar")))
			
			$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Corregir ahora");__ ("Mas tarde"))
		Else 
			$l_opcionUsuario:=0
		End if 
		
		USE SET:C118("registros_a_procesar")
		
		LONGINT ARRAY FROM SELECTION:C647([BBL_Registros:66];$al_RecNums;"")
		For ($i;1;Size of array:C274($al_RecNums))
			READ WRITE:C146([BBL_Registros:66])
			GOTO RECORD:C242([BBL_Registros:66];$al_RecNums{$i})
			$t_códigoBarraAnterior:=[BBL_Registros:66]Barcode_SinFormato:26
			
			
			APPEND TO ARRAY:C911($at_Item;KRL_GetTextFieldData (->[BBL_Items:61]Numero:1;->[BBL_Registros:66]Número_de_item:1;->[BBL_Items:61]Primer_título:4))
			APPEND TO ARRAY:C911($at_Copia;String:C10([BBL_Registros:66]Número_de_copia:2))
			APPEND TO ARRAY:C911($at_codigoBarraAnterior;$t_códigoBarraAnterior)
			
			If ($l_opcionUsuario=1)
				If ([BBL_Registros:66]StatusID:34=Prestado)
					APPEND TO ARRAY:C911($at_nuevocódigoBarra;"En prestamo (sin cambios)")
					Case of 
						: ([BBL_Registros:66]Barcode_SinFormato:26="")
							APPEND TO ARRAY:C911($at_errores;"Código de barra nulo")
						: (Is in set:C273("códigoBarraDuplicado"))
							APPEND TO ARRAY:C911($at_errores;"Código de barra duplicado")
						: ([BBL_Registros:66]No_Registro:25=0)
							APPEND TO ARRAY:C911($at_errores;"Número de registro nulo")
						Else 
							APPEND TO ARRAY:C911($at_errores;"Código de barra invalido")
					End case 
					APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
					APPEND TO ARRAY:C911($al_Colores;Red:K11:4)
					$l_registrosEnPrestamo:=$l_registrosEnPrestamo+1
					
				Else 
					If ([BBL_Registros:66]Barcode_SinFormato:26="")
						$l_sinCodigoBarra:=$l_sinCodigoBarra+1
					End if 
					
					Case of 
						: ([BBL_Registros:66]Barcode_SinFormato:26="")
							APPEND TO ARRAY:C911($at_errores;"Código de barra generado")
						: (Is in set:C273("códigoBarraDuplicado"))
							APPEND TO ARRAY:C911($at_errores;"Código de barra reemplazado")
						: ([BBL_Registros:66]No_Registro:25=0)
							APPEND TO ARRAY:C911($at_errores;"Número de registro asignado")
						Else 
							APPEND TO ARRAY:C911($at_errores;"Código de barra reemplazado")
					End case 
					
					If (([BBL_Registros:66]No_Registro:25=0) | (Is in set:C273("númeroRegistroDuplicado")))
						[BBL_Registros:66]No_Registro:25:=SQ_SeqNumber (->[BBL_Registros:66]No_Registro:25)
						If (<>lBBL_refCampoBarcodeDocumento=(Field:C253(->[BBL_Registros:66]No_Registro:25)))
							[BBL_Registros:66]Barcode_SinFormato:26:=""
						End if 
						$l_numeroRegistroAsignado:=$l_numeroRegistroAsignado+1
					End if 
					
					
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
					QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Barcode_SinFormato:26=[BBL_Registros:66]Barcode_SinFormato:26;*)
					QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]ID:3;#;[BBL_Registros:66]ID:3)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					
					While (($l_registros>0) | ([BBL_Registros:66]Barcode_SinFormato:26=""))
						[BBL_Registros:66]No_Registro:25:=SQ_SeqNumber (->[BBL_Registros:66]No_Registro:25)
						[BBL_Registros:66]Código_de_barra:20:=""
						BBLreg_GeneraCodigoBarra 
						SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
						QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Barcode_SinFormato:26=[BBL_Registros:66]Barcode_SinFormato:26;*)
						QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]ID:3;#;[BBL_Registros:66]ID:3)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
					End while 
					
					SAVE RECORD:C53([BBL_Registros:66])
					APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
					APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
					APPEND TO ARRAY:C911($at_nuevocódigoBarra;[BBL_Registros:66]Barcode_SinFormato:26)
					If ([BBL_Registros:66]Barcode_SinFormato:26#$t_códigoBarraAnterior)
						$l_codigosRegenerados:=$l_codigosRegenerados+1
					End if 
				End if 
				
				
			Else 
				Case of 
					: ([BBL_Registros:66]Barcode_SinFormato:26="")
						APPEND TO ARRAY:C911($at_errores;"Código de barra nulo")
					: (Is in set:C273("códigoBarraDuplicado"))
						APPEND TO ARRAY:C911($at_errores;"Código de barra duplicado")
					: ([BBL_Registros:66]No_Registro:25=0)
						APPEND TO ARRAY:C911($at_errores;"Número de registro nulo")
					Else 
						APPEND TO ARRAY:C911($at_errores;"Código de barra invalido")
				End case 
				APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
				APPEND TO ARRAY:C911($al_Colores;Red:K11:4)
			End if 
			
		End for 
		KRL_UnloadReadOnly (->[BBL_Registros:66])
		
		USE SET:C118("registros_a_procesar")
		KRL_RelateSelection (->[BBL_Items:61]Numero:1;->[BBL_Registros:66]Número_de_item:1)
		ORDER BY:C49([BBL_Items:61];[BBL_Items:61]Primer_título:4;>)
		LONGINT ARRAY FROM SELECTION:C647([BBL_Items:61];$al_recNums)
		BLOB_Variables2Blob (->$x_blob;0;->$al_recNums)
		
		If ($l_opcionUsuario=1)
			$t_encabezado:=__ ("Anomalías corregidas en códigos de barra o número de registro")
			If ($l_registrosEnPrestamo=0)
				$t_descripcion:=__ ("Se corrigieron las siguientes anomalías en códigos de barra o números de registros:")+"\r"
				If ($l_codigosRegenerados>0)
					$t_descripcion:=$t_descripcion+__ ("- documentos con códigos de barra duplicados: ")+String:C10($l_codigosRegenerados)+"\r"
				End if 
				If ($l_sinCodigoBarra>0)
					$t_descripcion:=$t_descripcion+__ ("- documentos sin códigos de barra: ")+String:C10($l_sinCodigoBarra)+"\r"
				End if 
				If ($l_numeroRegistroAsignado>0)
					$t_descripcion:=$t_descripcion+__ ("- documentos sin número de registro: ")+String:C10($l_numeroRegistroAsignado)+"\r"
				End if 
			Else 
				$t_encabezado:=__ ("Anomalías detectadas en códigos de barra o número de registro")
				$t_descripcion:=__ ("Se detectaron las siguientes anomalías en códigos de barra o números de registros:")+"\r"
				If (Records in set:C195("códigoBarraDuplicado")>0)
					$t_descripcion:=$t_descripcion+__ ("- documentos con códigos de barra duplicados: ")+String:C10(Records in set:C195("códigoBarraDuplicado"))+"\r"
				End if 
				If (Records in set:C195("códigoBarraNulo")>0)
					$t_descripcion:=$t_descripcion+__ ("- documentos sin códigos de barra: ")+String:C10(Records in set:C195("códigoBarraNulo"))+"\r"
				End if 
				If (Records in set:C195("NoRegistroNulo")>0)
					$t_descripcion:=$t_descripcion+__ ("- documentos sin número de registro: ")+String:C10(Records in set:C195("NoRegistroNulo"))+"\r"
				End if 
			End if 
			
			
			
		Else 
			$t_encabezado:=__ ("Anomalías detectadas en códigos de barra o número de registro")
			$t_descripcion:=__ ("Se detectaron las siguientes anomalías en códigos de barra o números de registros:")+"\r"
			If (Records in set:C195("códigoBarraDuplicado")>0)
				$t_descripcion:=$t_descripcion+__ ("- documentos con códigos de barra duplicados: ")+String:C10(Records in set:C195("códigoBarraDuplicado"))+"\r"
			End if 
			If (Records in set:C195("códigoBarraNulo")>0)
				$t_descripcion:=$t_descripcion+__ ("- documentos sin códigos de barra: ")+String:C10(Records in set:C195("códigoBarraNulo"))+"\r"
			End if 
			If (Records in set:C195("NoRegistroNulo")>0)
				$t_descripcion:=$t_descripcion+__ ("- documentos sin número de registro: ")+String:C10(Records in set:C195("NoRegistroNulo"))+"\r"
			End if 
		End if 
		
		
		
		APPEND TO ARRAY:C911($at_TitulosColumnas;"Error o advertencia")
		APPEND TO ARRAY:C911($at_TitulosColumnas;"Item")
		APPEND TO ARRAY:C911($at_TitulosColumnas;"Copia")
		If ($l_opcionUsuario=1)
			SORT ARRAY:C229($at_Item;$at_Copia;$at_nuevocódigoBarra;$at_codigoBarraAnterior;$at_errores;$al_estilos;$al_Colores;>)
			APPEND TO ARRAY:C911($at_TitulosColumnas;"Código de barra anterior")
			APPEND TO ARRAY:C911($at_TitulosColumnas;"Nuevo Código de barra")
			If (USR_GetUserID #0)
				$t_uuid:=NTC_CreaMensaje ("MediaTrack";$t_Encabezado;$t_descripcion;USR_GetUserID )
			Else 
				$t_uuid:=NTC_CreaMensaje ("MediaTrack";$t_Encabezado;$t_descripcion)
			End if 
			NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_Item;->$at_Copia;->$at_codigoBarraAnterior;->$at_nuevocódigoBarra)
			If ($l_registrosEnPrestamo>0)
				$t_itemMenuTareas:="Corregir anomalías y volver a verificar"
				$t_descripcion:=$t_descripcion+"\r\r"+__ ("Si desea corregir estas anomalías seleccione ^0  en el menu asociado a la rueda de tareas")
				$t_descripcion:=Replace string:C233($t_descripcion;"^0";IT_SetTextStyle_Bold (->$t_itemMenuTareas))
				$0:=-1
			Else 
				$t_itemMenuTareas:="Volver a verificar"
				$t_descripcion:=$t_descripcion+"\r\r"+__ ("Si desea volver a verificar los códigos de barra y números de registro seleccione ^0  en el menu asociado a la rueda de tareas")
				$t_descripcion:=Replace string:C233($t_descripcion;"^0";IT_SetTextStyle_Bold (->$t_itemMenuTareas))
				$0:=0
			End if 
			
		Else 
			$t_itemMenuTareas:="Corregir anomalías y volver a verificar"
			$t_descripcion:=$t_descripcion+"\r\r"+__ ("Si desea corregir estas anomalías seleccione ^0  en el menu asociado a la rueda de tareas")
			$t_descripcion:=Replace string:C233($t_descripcion;"^0";IT_SetTextStyle_Bold (->$t_itemMenuTareas))
			SORT ARRAY:C229($at_Item;$at_Copia;$at_codigoBarraAnterior;$at_errores;$al_estilos;$al_Colores;>)
			APPEND TO ARRAY:C911($at_TitulosColumnas;"Código de barra")
			If (USR_GetUserID #0)
				$t_uuid:=NTC_CreaMensaje ("MediaTrack";$t_Encabezado;$t_descripcion;USR_GetUserID )
			Else 
				$t_uuid:=NTC_CreaMensaje ("MediaTrack";$t_Encabezado;$t_descripcion)
			End if 
			NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_Item;->$at_Copia;->$at_codigoBarraAnterior)
			$0:=-1
		End if 
		$t_mensajeExito:=__ ("Todas las anomalías en códigos de barra o número de registros fueron corregidas.")
		$t_mensajeFalla:=__ ("Persisten anomalías en códigos de barra o número de registros.")
		NTC_Mensaje_DatosExplorador ($t_uuid;"MediaTrack";Table:C252(->[BBL_Items:61]);->$al_RecNums)
		NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
		NTC_Mensaje_DatosExplorador ($t_uuid;"MediaTrack";Table:C252(->[BBL_Items:61]);->$al_RecNums)
		NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name:C684+";True";$t_mensajeFalla;$t_mensajeExito;"Corregir anomalías y volver a verificar")
	Else 
		$0:=0
	End if 
Else 
	$0:=0
End if 

