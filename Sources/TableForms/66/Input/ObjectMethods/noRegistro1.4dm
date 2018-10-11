  // [BBL_Registros].Input.noRegistro()
  // Por: Alberto Bachler: 05/09/13, 15:22:09
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		If ((Is new record:C668([BBL_Registros:66])))
			C_LONGINT:C283(vl_numregold)
			  //para registros nuevos
			vl_numregold:=[BBL_Registros:66]No_Registro:25
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
				[BBL_Registros:66]No_Registro:25:=vl_numregold
			End if 
		Else 
			If (Old:C35([BBL_Registros:66]No_Registro:25)#0)
				If ([BBL_Registros:66]Barcode_Protegido:28)
					$t_mensaje:=__ ("El codigo de barra actual de este registro no está basado en el número de registro y está protegido.")+"\r"
					$t_mensaje:=$t_mensaje+__ ("¿Desea usted mantener el código de barra existente o generar un nuevo código sobre la base del número de registro y el prefijo correspondiente al tipo de media?")+"\r\r"
					$t_mensaje:=$t_mensaje+__ ("Tenga en cuenta que si cambia el código de barra deberá imprimirlo y cambiarlo fisicamente en el documento.")
					OK:=CD_Dlog (0;$t_mensaje;"";__ ("Mantener código");__ ("Nuevo código");__ ("Cancelar"))
				Else 
					$t_mensaje:=__ ("El codigo de barra actual está basado en el número de registro anterior.")+"\r"
					$t_mensaje:=$t_mensaje+__ ("Desea usted mantener el código de barra existente o generar un nuevo código sobre la base del número de registro ingresado y el prefijo correspondiente al tipo de media?")+"\r\r"
					$t_mensaje:=$t_mensaje+__ ("Si mantiene el código de barra anterior este será protegido de toda operación global de regeneración de código desde Configuración.")+"\r\r"
					$t_mensaje:=$t_mensaje+__ ("Tenga en cuenta también que si cambia el código de barra deberá imprimirlo y cambiarlo fisicamente en el documento.")
					OK:=CD_Dlog (0;$t_mensaje;"";__ ("Mantener código");__ ("Nuevo código");__ ("Cancelar"))
				End if 
			Else 
				OK:=2
			End if 
			Case of 
				: (OK=3)
					[BBL_Registros:66]No_Registro:25:=Old:C35([BBL_Registros:66]No_Registro:25)
				: (OK=2)
					[BBL_Registros:66]Código_de_barra:20:=""
					[BBL_Registros:66]Barcode_SinFormato:26:=""
					[BBL_Registros:66]CodigoBarra_Imagen:24:=[BBL_Registros:66]CodigoBarra_Imagen:24*0
					[BBL_Registros:66]Barcode_Protegido:28:=False:C215
					BBLreg_GeneraCodigoBarra 
					BBLreg_guardar 
					C_LONGINT:C283($vl_records)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
					QUERY:C277([BBL_Registros:66];[BBL_Registros:66]No_Registro:25>=[BBL_Registros:66]No_Registro:25)
					If ($vl_records=0)
						SQ_EstableceSecuencia (->[BBL_Registros:66]No_Registro:25;[BBL_Registros:66]No_Registro:25)
					End if 
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					$idRegistro:=[BBL_Registros:66]No_Registro:25
				: (OK=1)
					SQ_EstableceSecuencia (->[BBL_Registros:66]No_Registro:25;[BBL_Registros:66]No_Registro:25)
					BBLreg_guardar 
			End case 
		End if 
		CLEAR SEMAPHORE:C144("BBLModificandoNumeroRegistro")
End case 