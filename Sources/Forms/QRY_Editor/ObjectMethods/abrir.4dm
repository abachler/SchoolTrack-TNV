  // [xShell_Queries].QueryEditor.bLoad()
  // Por: Alberto Bachler: 12/04/13, 03:01:10
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_POINTER:C301(fieldP)
C_BOOLEAN:C305(vb_ConsultaMultiAño)
C_LONGINT:C283(bCurrentYearOnly)

QUERY:C277([xShell_Queries:53];[xShell_Queries:53]FileNo:5=Table:C252(vyQRY_TablePointer))
SELECTION TO ARRAY:C260([xShell_Queries:53]Name:2;aFormula;[xShell_Queries:53]No:1;aFormID)
SORT ARRAY:C229(aFormula;aFormId;>)

WDW_OpenFormWindow (->[xShell_Queries:53];"ToLoad";-1;Movable form dialog box:K39:8;__ ("Cargar consulta"))
DIALOG:C40([xShell_Queries:53];"ToLoad")
CLOSE WINDOW:C154


If (ok=1)
	QRY_Init 
	
	If (QRY_EsConsultaPermitida )
		$lines:=Size of array:C274(alQRY_numeroTabla)
		ARRAY POINTER:C280(ayQRY_Campos;$lines)
		For ($i;1;$lines)
			If (alQRY_numeroCampo{$i}>0)
				ayQRY_Campos{$i}:=Field:C253(alQRY_numeroTabla{$i};alQRY_numeroCampo{$i})
			Else 
				alQRY_numeroCampo{$i}:=-7
				EXECUTE FORMULA:C63("yFieldname:=»"+"["+Table name:C256(alQRY_numeroTabla{$i})+"]Userfields'Value")  //get the field pointer
				ayQRY_Campos{$i}:=yfieldname
			End if 
			
			$operatorIndex:=Find in array:C230(<>alXS_QueryOperators_NumRef;alQRY_Operador_ID{$i})
			If ($operatorIndex>0)
				atQRY_Operador_Literal{$i}:=<>atXS_QueryOperators_Text{$operatorIndex}
			Else 
				atQRY_Operador_Literal{$i}:="="
			End if 
			
			If (atQRY_Conector_Simbolo{$i}#"")
				$connectorIndex:=Find in array:C230(<>atXS_QueryConnectors_Symbol;atQRY_Conector_Simbolo{$i})
				If ($connectorIndex>0)
					atQRY_Conector_Literal{$i}:=<>atXS_QueryConnectors_Text{$connectorIndex}
				Else 
					atQRY_Conector_Literal{$i}:=""
					CD_Dlog (0;__ ("Conector de  condiciones de búsqueda indefinido."))
				End if 
			Else 
				atQRY_Conector_Literal{$i}:=""
			End if 
		End for 
		
		
		
		$y_objectCount:=OBJECT Get pointer:C1124(Object named:K67:5;"objectCount")
		FORM GET OBJECTS:C898($at_nombreObjetos;$ay_variables;$al_Paginas;Form current page:K67:6)
		SORT ARRAY:C229($at_nombreObjetos;$ay_variables;$al_Paginas)
		For ($i;1;Size of array:C274($at_nombreObjetos))
			If ($at_nombreObjetos{$i}="criterio@_campo")
				$y_objectCount->:=$y_objectCount->+1
			End if 
		End for 
		
		_O_ENABLE BUTTON:C192(btest)  //MONO 172659
		
		
		
	Else 
		REDUCE SELECTION:C351([xShell_Queries:53];0)
		AT_Initialize (->ayQRY_Campos;->alQRY_numeroTabla;->alQRY_numeroCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo;->alQRY_Operador_ID;->atQRY_Conector_Simbolo)
	End if 
Else 
	REDUCE SELECTION:C351([xShell_Queries:53];0)
End if 