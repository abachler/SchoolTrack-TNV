  // [BBL_Registros].Periodicals.noRegistro()
  // Por: Alberto Bachler: 25/11/13, 22:22:17
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_CodigoDuplicadoEnLectores;$b_CodigoDuplicadoEnRegistros)
C_LONGINT:C283($l_BBL_refCampoBarcodeDocumento;$l_opcionUsuario;$l_recNum;$l_numeroEnBarcode)
C_PICTURE:C286($p_imagenCodigoActual)
C_TEXT:C284($t_barcodeSinFormatoActual;$t_codigoDeBarraActual;$t_Mensaje;$t_titulo)
C_LONGINT:C283(vl_numeroRegistroEnCreacion)


Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		If (Is new record:C668([BBL_Registros:66]))
			vl_numeroRegistroEnCreacion:=[BBL_Registros:66]No_Registro:25
		End if 
		
	: (Form event:C388=On Data Change:K2:15)
		While (Semaphore:C143("BBLModificandoNumeroRegistro"))
			DELAY PROCESS:C323(Current process:C322;10)
		End while 
		
		$l_recNum:=Record number:C243([BBL_Registros:66])
		If (KRL_RecordExists (->[BBL_Registros:66]No_Registro:25))
			OK:=CD_Dlog (0;__ ("El Nº ingresado ya ha sido asignado a otro registro.\rNo es posible utilizar el mismo número en más de un registro."))
			If (Not:C34(Is new record:C668([BBL_Registros:66])))
				[BBL_Registros:66]No_Registro:25:=Old:C35([BBL_Registros:66]No_Registro:25)
			Else 
				[BBL_Registros:66]No_Registro:25:=vl_numeroRegistroEnCreacion
			End if 
		Else 
			$l_numeroEnBarcode:=Num:C11([BBL_Registros:66]Barcode_SinFormato:26)
			
			  // si el código de barra actual está basado en el número de registro
			If (Old:C35([BBL_Registros:66]No_Registro:25)=$l_numeroEnBarcode)
				
				  //Me aseguro que no haya otro registro con el mismo código de barra basado en el nuevo numero de registro
				$l_BBL_refCampoBarcodeDocumento:=<>lBBL_refCampoBarcodeDocumento
				<>lBBL_refCampoBarcodeDocumento:=Field:C253(->[BBL_Registros:66]No_Registro:25)
				$t_codigoDeBarraActual:=[BBL_Registros:66]Código_de_barra:20
				$p_imagenCodigoActual:=[BBL_Registros:66]CodigoBarra_Imagen:24
				$t_barcodeSinFormatoActual:=[BBL_Registros:66]Barcode_SinFormato:26
				[BBL_Registros:66]Código_de_barra:20:=""
				BBLreg_GeneraCodigoBarra 
				<>lBBL_refCampoBarcodeDocumento:=$l_BBL_refCampoBarcodeDocumento
				$b_CodigoDuplicadoEnRegistros:=KRL_RecordExists (->[BBL_Registros:66]Barcode_SinFormato:26)
				$b_CodigoDuplicadoEnLectores:=(Find in field:C653([BBL_Lectores:72]BarCode_SinFormato:38;[BBL_Registros:66]Barcode_SinFormato:26)>=No current record:K29:2)
				If ($b_CodigoDuplicadoEnRegistros | $b_CodigoDuplicadoEnLectores)
					  // si existe un registro con el potencial nuevo código, mantengo el anterior y protego el código de barra
					$t_titulo:=__ ("Usted modificó manualmente el número de registro")
					$t_Mensaje:=__ ("No es posible generar un código de barra único basado en el nuevo número de registro.")
					$t_mensaje:=$t_mensaje+"\r"+__ ("¿Desea mantener y proteger el código de barra actual y conservar el nuevo número de registro o volver al número de registro anterior?")
					$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_Mensaje;__ ("Mantener código actual");__ ("Volver al número de registro anterior"))
					If ($l_opcionUsuario=1)
						[BBL_Registros:66]Código_de_barra:20:=$t_codigoDeBarraActual
						[BBL_Registros:66]CodigoBarra_Imagen:24:=$p_imagenCodigoActual
						[BBL_Registros:66]Barcode_SinFormato:26:=$t_barcodeSinFormatoActual
						[BBL_Registros:66]Barcode_Protegido:28:=True:C214
						BBLreg_guardar 
						SQ_EstableceSecuencia (->[BBL_Registros:66]No_Registro:25;[BBL_Registros:66]No_Registro:25)
						OBJECT SET VISIBLE:C603([BBL_Registros:66]Barcode_Protegido:28;True:C214)
						OBJECT SET ENTERABLE:C238([BBL_Registros:66]Barcode_Protegido:28;True:C214)
					Else 
						[BBL_Registros:66]Código_de_barra:20:=$t_codigoDeBarraActual
						[BBL_Registros:66]CodigoBarra_Imagen:24:=$p_imagenCodigoActual
						[BBL_Registros:66]Barcode_SinFormato:26:=$t_barcodeSinFormatoActual
						[BBL_Registros:66]No_Registro:25:=Old:C35([BBL_Registros:66]No_Registro:25)
						BBLreg_guardar 
					End if 
				Else 
					  // en caso contrario doy la opción al usuario entre conservar el código de barra anterio o generar uno nuevo basado en el nuevo número de registro
					[BBL_Registros:66]Código_de_barra:20:=$t_codigoDeBarraActual
					$t_titulo:=__ ("Usted modificó el número de registro sobre el que está basado el código de barra.")
					$t_mensaje:=__ ("Puede conservar y proteger el código de barra actual y mantener el nuevo número de registro o generar un nuevo código de barra basado en el nuevo número de registro.")
					$t_mensaje:=$t_mensaje+"\r"+__ ("Si vuelve a generar el código de barra deberá reemplazarlo físicamente en el documento.")
					$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Código de barra actual");__ ("Generar Nuevo");__ ("Cancelar"))
					Case of 
						: ($l_opcionUsuario=1)
							[BBL_Registros:66]Barcode_Protegido:28:=True:C214
							BBLreg_guardar 
							SQ_EstableceSecuencia (->[BBL_Registros:66]No_Registro:25;[BBL_Registros:66]No_Registro:25)
							OBJECT SET VISIBLE:C603([BBL_Registros:66]Barcode_Protegido:28;True:C214)
							OBJECT SET ENTERABLE:C238([BBL_Registros:66]Barcode_Protegido:28;True:C214)
							
						: ($l_opcionUsuario=2)
							$l_BBL_refCampoBarcodeDocumento:=<>lBBL_refCampoBarcodeDocumento
							<>lBBL_refCampoBarcodeDocumento:=Field:C253(->[BBL_Registros:66]No_Registro:25)
							[BBL_Registros:66]Código_de_barra:20:=""
							BBLreg_guardar 
							SQ_EstableceSecuencia (->[BBL_Registros:66]No_Registro:25;[BBL_Registros:66]No_Registro:25)
							<>lBBL_refCampoBarcodeDocumento:=$l_BBL_refCampoBarcodeDocumento
							
						: ($l_opcionUsuario=3)
							[BBL_Registros:66]No_Registro:25:=Old:C35([BBL_Registros:66]No_Registro:25)
							[BBL_Registros:66]Código_de_barra:20:=$t_codigoDeBarraActual
							[BBL_Registros:66]CodigoBarra_Imagen:24:=$p_imagenCodigoActual
							[BBL_Registros:66]Barcode_SinFormato:26:=$t_barcodeSinFormatoActual
							BBLreg_guardar 
							
					End case 
				End if 
			Else 
				BBLreg_guardar 
			End if 
		End if 
		CLEAR SEMAPHORE:C144("BBLModificandoNumeroRegistro")
End case 