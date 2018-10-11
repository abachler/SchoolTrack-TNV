//%attributes = {}
  // BBLpat_ValidacionBarcode()
  // Por: Alberto Bachler K.: 05-12-13, 21:57:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$y_campoBarcode:=OBJECT Get pointer:C1124(Object current:K67:2)

Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		
	: (Form event:C388=On Data Change:K2:15)
		$b_rechazarCambio:=False:C215
		$b_ProtegerCodigo:=False:C215
		$t_BarcodeSinFormato:=[BBL_Lectores:72]BarCode_SinFormato:38
		
		
		
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_lectores)
		QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]BarCode_SinFormato:38=$t_BarcodeSinFormato;*)
		QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]ID:1;#;[BBL_Lectores:72]ID:1)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		Case of 
			: (Length:C16($t_BarcodeSinFormato)>18)
				OK:=CD_Dlog (0;__ ("El largo del código de barra no puede sobrepasar 18 caracteres."))
				$b_rechazarCambio:=True:C214
				
			: (Length:C16($t_BarcodeSinFormato)<3)
				OK:=CD_Dlog (0;__ ("El largo del código de barra no puede ser inferior a 3 caracteres."))
				$b_rechazarCambio:=True:C214
				
			: ($l_lectores>0)
				$t_mensaje:=__ ("El lector ^0 ya tiene asignado el código de barra ˆ1")+"\r\r"
				$t_mensaje:=$t_mensaje+__ ("Por favor asigne un código de barra distinto.")
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";String:C10(KRL_GetNumericFieldData (->[BBL_Lectores:72]BarCode_SinFormato:38;->$t_BarcodeSinFormato;->[BBL_Lectores:72]NombreCompleto:3)))
				$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_BarcodeSinFormato)
				OK:=CD_Dlog (0;$t_mensaje)
				$b_rechazarCambio:=True:C214
				
			: (Find in field:C653([BBL_Registros:66]Barcode_SinFormato:26;$t_BarcodeSinFormato)>=0)
				$t_mensaje:=__ ("La copia ^0 del item ^1 ya tiene asignado el código de barra ^2")+"\r\r"
				$t_mensaje:=$t_mensaje+__ ("Por favor asigne un código de barra sin conflictos.")
				$l_idItem:=KRL_GetNumericFieldData (->[BBL_Registros:66]Barcode_SinFormato:26;->$t_BarcodeSinFormato;->[BBL_Registros:66]Número_de_item:1)
				$t_Copia:=String:C10(KRL_GetNumericFieldData (->[BBL_Registros:66]Barcode_SinFormato:26;->$t_BarcodeSinFormato;->[BBL_Registros:66]Número_de_copia:2))
				$t_titulo:=KRL_GetTextFieldData (->[BBL_Items:61]Numero:1;->$l_idItem;->[BBL_Items:61]Primer_título:4)
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_Copia))
				$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_titulo))
				$t_mensaje:=Replace string:C233($t_mensaje;"^2";IT_SetTextStyle_Bold (->$t_BarcodeSinFormato))
				OK:=CD_Dlog (0;$t_mensaje)
				If (OK=1)
					$b_rechazarCambio:=True:C214
				Else 
					$b_ProtegerCodigo:=True:C214
				End if 
		End case 
		
		
		If (Not:C34($b_rechazarCambio))
			[BBL_Lectores:72]BarCode_SinFormato:38:=ST Get plain text:C1092($t_BarcodeSinFormato)
			$t_titulo:=__ ("Usted modificó manualmente el código de barra de este lector.")
			$t_Mensaje:=__ ("Si lo desea pueder proteger el código de barra para evitar que se le aplique el formato de código de barra por defecto si se regeneran los códigos de barra.")
			$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_Mensaje;"Proteger el Código de barra";"No")
			If ($l_opcionUsuario=1)
				[BBL_Lectores:72]Barcode_Protegido:39:=True:C214
			End if 
			BBLpat_fSave 
			OBJECT SET ENTERABLE:C238([BBL_Lectores:72]Barcode_Protegido:39;True:C214)
		Else 
			[BBL_Lectores:72]BarCode_SinFormato:38:=Old:C35([BBL_Lectores:72]BarCode_SinFormato:38)
		End if 
		
		
		
		
	: (Form event:C388=On Losing Focus:K2:8)
		
		
End case 







