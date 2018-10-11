  // [xShell_Queries].QueryEditor.spanish4()
  // Por: Alberto Bachler: 05/03/13, 12:11:59
  //  ---------------------------------------------
  // 
  //
  //  --------------------------------------------

atQRY_NombreVirtualCampo:=0
atQRY_Conector_Literal:=0
atQRY_Operador_Literal:=0
ayQRY_Campos:=0
atQRY_NombreInternoCampo:=0
atQRY_ValorLiteral:=0
bSrchSel:=0

  //MONO 172659, si quitamos posiciones en el array deberíamos retirar las lineas de la interfaz tal cual se hace al presionar el botón -
C_LONGINT:C283($l_indexActual)
$y_index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")
$y_objectCount:=OBJECT Get pointer:C1124(Object named:K67:5;"objectCount")

For ($i;Size of array:C274(atQRY_NombreVirtualCampo);1;-1)
	If ((atQRY_NombreVirtualCampo{$i}="") | (atQRY_Operador_Literal{$i}=""))
		$l_indexActual:=$y_index->{$i}
		$t_nombreObjetos:="criterio"+String:C10($l_indexActual)+"@"
		OBJECT SET VISIBLE:C603(*;$t_nombreObjetos;False:C215)
		
		$l_elemento:=Find in array:C230($y_index->;$l_indexActual)
		$l_elemento:=$l_elemento+1
		For ($n;$l_elemento;Size of array:C274($y_index->))
			$t_nombreObjetos:="criterio"+String:C10($y_index->{$n})+"@"
			OBJECT MOVE:C664(*;$t_nombreObjetos;0;-30)
		End for 
		
		$l_elemento:=Find in array:C230($y_index->;$l_indexActual)
		
		AT_Delete ($i;1;->atQRY_NombreVirtualCampo;->ayQRY_Campos;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreInternoCampo;->alQRY_Operador_ID;->atQRY_Conector_Simbolo;->alQRY_numeroTabla;->alQRY_numeroCampo;$y_index)
		
		$l_filas:=Size of array:C274($y_index->)
		$l_altoFila:=LISTBOX Get rows height:C836(*;"lb_criterios")
		$l_altoListbox:=$l_altoFila*$l_filas
		
		OBJECT GET COORDINATES:C663(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_abajoLB)
		OBJECT SET COORDINATES:C1248(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_arribaLB+$l_altoListbox)
		GET WINDOW RECT:C443($l_izquierdaW;$l_arribaW;$l_derechaW;$l_abajoW)
		SET WINDOW RECT:C444($l_izquierdaW;$l_arribaW;$l_derechaW;$l_arribaW+$l_arribaLB+$l_altoListbox+40)
		
		$y_objectCount->:=$y_objectCount->-1
	End if 
End for 

$found:=QRY_RunQuery (vyQRY_TablePointer)
If ($found#0)
	CD_Dlog (0;Replace string:C233(__ ("La búsqueda fue ejecutada correctamente.\r^0 registros del archivo cumplen las condiciones especificadas.");__ ("^0");String:C10($found)))
Else 
	CD_Dlog (0;__ ("Ningún registro cumple con las condiciones especificadas en la fórmula de búsqueda.\rVerifique si la fórmula es correcta."))
End if 