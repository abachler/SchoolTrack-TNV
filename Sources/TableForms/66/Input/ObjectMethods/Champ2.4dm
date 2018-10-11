  // [BBL_Registros].Input.Champ2()
  // Por: Alberto Bachler: 04/09/13, 12:47:13
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_ProtegerCodigo;$b_rechazarCambio)
C_LONGINT:C283($l_idItem;$l_indiceBarCode;$l_registros)
C_TEXT:C284($t_BarcodeSinFormato;$t_mensaje;$t_mensajeSinPrefijo;$t_prefijoBarcode)


Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		
	: (Form event:C388=On Data Change:K2:15)
		$b_rechazarCambio:=False:C215
		$b_ProtegerCodigo:=False:C215
		$t_BarcodeSinFormato:=[BBL_Registros:66]Barcode_SinFormato:26
		
		
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Barcode_SinFormato:26=$t_BarcodeSinFormato;*)
		QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]ID:3;#;[BBL_Registros:66]ID:3)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		Case of 
			: (Length:C16($t_BarcodeSinFormato)>18)
				OK:=CD_Dlog (0;__ ("El largo del código de barra no puede sobrepasar 18 caracteres."))
				$b_rechazarCambio:=True:C214
				
			: (Length:C16($t_BarcodeSinFormato)<3)
				OK:=CD_Dlog (0;__ ("El largo del código de barra no puede ser inferior a 3 caracteres."))
				$b_rechazarCambio:=True:C214
				
			: ($l_Registros>0)
				$t_mensaje:=__ ("La copia ^0 del item ^1 ya tiene asignado el código de barra ^2")+"\r\r"
				$t_mensaje:=$t_mensaje+__ ("Por favor asigne un código de barra que sin conflictos.")
				$l_idItem:=KRL_GetNumericFieldData (->[BBL_Registros:66]Barcode_SinFormato:26;->$t_BarcodeSinFormato;->[BBL_Registros:66]Número_de_item:1)
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";String:C10(KRL_GetNumericFieldData (->[BBL_Registros:66]Barcode_SinFormato:26;->$t_BarcodeSinFormato;->[BBL_Registros:66]Número_de_copia:2)))
				$t_mensaje:=Replace string:C233($t_mensaje;"^1";KRL_GetTextFieldData (->[BBL_Items:61]Numero:1;->$l_idItem;->[BBL_Items:61]Primer_título:4))
				$t_mensaje:=Replace string:C233($t_mensaje;"^2";$t_BarcodeSinFormato)
				OK:=CD_Dlog (0;$t_mensaje)
				$b_rechazarCambio:=True:C214
				
			: (Find in field:C653([BBL_Lectores:72]BarCode_SinFormato:38;$t_BarcodeSinFormato)>=0)
				$t_lector:=KRL_GetTextFieldData (->[BBL_Lectores:72]BarCode_SinFormato:38;->$t_BarcodeSinFormato;->[BBL_Lectores:72]NombreCompleto:3)
				$t_mensaje:=__ ("El lector ^0 tiene asignado el código de barra ^1.")+"\r"
				$t_mensaje:=$t_mensaje+__ ("Por favor asigne un código de barra sin conflictos.")
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_lector)
				$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_BarcodeSinFormato)
				OK:=CD_Dlog (0;$t_mensaje;"")
				$b_rechazarCambio:=True:C214
				
		End case 
		
		
		
		If (Not:C34($b_rechazarCambio))
			If ([BBL_Registros:66]Barcode_SinFormato:26#Old:C35([BBL_Registros:66]Barcode_SinFormato:26))
				[BBL_Registros:66]Barcode_SinFormato:26:=$t_BarcodeSinFormato
				[BBL_Registros:66]Código_de_barra:20:="*"+Replace string:C233($t_BarcodeSinFormato;"*";"")+"*"
				$t_titulo:=__ ("Usted modificó manualmente el código de barra de este documento.")
				$t_Mensaje:=__ ("Si lo desea pueder proteger el código de barra para evitar que se le aplique el formato de código de barra por defecto si se regeneran los códigos de barra.")
				$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_Mensaje;"Proteger el Código de barra";"No")
				If ($l_opcionUsuario=1)
					[BBL_Registros:66]Barcode_Protegido:28:=True:C214
				End if 
				
				OBJECT SET VISIBLE:C603(*;"padlockUnlocked";False:C215)
				OBJECT SET VISIBLE:C603(*;"padlockLocked";True:C214)
				OBJECT SET ENTERABLE:C238([BBL_Registros:66]Código_de_barra:20;False:C215)
				BBLreg_guardar 
				OBJECT SET VISIBLE:C603([BBL_Registros:66]Barcode_Protegido:28;True:C214)
				OBJECT SET ENTERABLE:C238([BBL_Registros:66]Barcode_Protegido:28;True:C214)
				viBBL_BarCodeEnterable:=0
			End if 
		Else 
			[BBL_Registros:66]Código_de_barra:20:=Old:C35([BBL_Registros:66]Código_de_barra:20)
			[BBL_Registros:66]Barcode_SinFormato:26:=Old:C35([BBL_Registros:66]Barcode_SinFormato:26)
			HIGHLIGHT TEXT:C210([BBL_Registros:66]Código_de_barra:20;Length:C16([BBL_Registros:66]Código_de_barra:20)+1;Length:C16([BBL_Registros:66]Código_de_barra:20)+1)
		End if 
		
		BBLmarc_UpdateMARCField (->[BBL_Registros:66]Barcode_SinFormato:26)
		
	: (Form event:C388=On Losing Focus:K2:8)
		
End case 