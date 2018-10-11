  // [xShell_Reports].QR_Editor.xQR_ReportArea()
  // Por: Alberto Bachler: 06/03/13, 08:43:15
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_columna;$l_referenciaItem;$l_numeroCampo;$l_numeroTabla;$l_fila;$l_elemento;$l_proceso)
C_POINTER:C301($y_objetoOrigen;$y_campo)
C_TEXT:C284($t_textoItem;$t_numeroCampo;$t_numeroTabla)


Case of 
	: (Form event:C388=On Drag Over:K2:13)
		DRAG AND DROP PROPERTIES:C607($y_objetoOrigen;$l_elemento;$l_proceso)
		If ($y_objetoOrigen=(->hlQR_FieldList))
			$0:=0
		Else 
			$0:=-1
		End if 
		
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($y_objetoOrigen;$l_elemento;$l_proceso)
		GET LIST ITEM:C378($y_objetoOrigen->;Selected list items:C379($y_objetoOrigen->);$l_referenciaItem;$t_textoItem)
		GET LIST ITEM PARAMETER:C985($y_objetoOrigen->;$l_referenciaItem;"Tabla";$t_numeroTabla)
		GET LIST ITEM PARAMETER:C985($y_objetoOrigen->;$l_referenciaItem;"Campo";$t_numeroCampo)
		
		$l_numeroTabla:=Num:C11($t_numeroTabla)
		$l_numeroCampo:=Num:C11($t_numeroCampo)
		
		If ($l_numeroCampo=0)
			BEEP:C151
		Else 
			$y_campo:=Field:C253($l_numeroTabla;$l_numeroCampo)
			QR INSERT COLUMN:C748(Self:C308->;QR Get drop column:C747(Self:C308->);$y_campo)
		End if 
End case 

