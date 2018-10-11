  // EditorFormulas.Lista jerárquica2()
  // Por: Alberto Bachler: 19/02/13, 10:14:23
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------






Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$l_referencia;$t_texto)
		GET LIST ITEM PARAMETER:C985(Self:C308->;$l_referencia;"Operador";$t_operador)
		If (vl_PosicionCursorInicio=vl_PosicionCursorFin)
			vt_formula:=Insert string:C231(vt_formula;$t_operador;vl_PosicionCursorInicio)
		Else 
			$t_textoSeleccionado:=Substring:C12(vt_formula;vl_PosicionCursorInicio;vl_PosicionCursorFin-vl_PosicionCursorInicio+1)
			vt_formula:=Replace string:C233(vt_formula;$t_textoSeleccionado;$t_operador)
		End if 
		
		
		
	: (Form event:C388=On Drag Over:K2:13)
		DRAG AND DROP PROPERTIES:C607($sourceObject;$sourceNumber;$sourceProcess)
		
		
		
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($sourceObject;$sourceNumber;$sourceProcess)
		
End case 


  //****LIMPIEZA****

