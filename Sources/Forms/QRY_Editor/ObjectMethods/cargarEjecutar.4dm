  // [xShell_Queries].QueryEditor.bLoadExecute()
  // Por: Alberto Bachler: 12/04/13, 03:05:10
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$items:=AT_array2text (->aFormula)
$result:=Pop up menu:C542($items)


If ($result>0)
	ARRAY TEXT:C222(atQRY_Operador_Literal;0)
	ARRAY TEXT:C222(atQRY_ValorLiteral;0)
	ARRAY TEXT:C222(atQRY_Conector_Literal;0)
	ARRAY POINTER:C280(ayQRY_Campos;0)
	ARRAY TEXT:C222(atQRY_NombreVirtualCampo;0)
	ARRAY TEXT:C222(atQRY_NombreInternoCampo;0)
	ARRAY INTEGER:C220(aFounded;0)
	ARRAY LONGINT:C221(alQRY_numeroTabla;0)
	ARRAY LONGINT:C221(alQRY_numeroCampo;0)
	ARRAY TEXT:C222(atQRY_Conector_Simbolo;0)
	ARRAY LONGINT:C221(alQRY_Operador_ID;0)
	QUERY:C277([xShell_Queries:53];[xShell_Queries:53]No:1=aFormId{$result})
	BLOB_Blob2Vars (->[xShell_Queries:53]xFormula:9;0;->alQRY_numeroTabla;->alQRY_numeroCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo;->vb_ConsultaMultiAño;->bCurrentYearOnly)
	
	If (QRY_EsConsultaPermitida )
		
		For ($i;$lines;1;-1)
			If (Is field number valid:C1000(alQRY_numeroTabla{$i};alQRY_numeroCampo{$i})=False:C215)
				AT_Delete ($i;1;->ayQRY_Campos;->alQRY_numeroTabla;->alQRY_numeroCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo;->alQRY_Operador_ID;->atQRY_Conector_Simbolo)
			End if 
		End for 
		
		
		$lines:=Size of array:C274(alQRY_numeroTabla)
		ARRAY INTEGER:C220(aFounded;$lines)
		ARRAY POINTER:C280(ayQRY_Campos;$lines)
		For ($i;1;$lines)
			ayQRY_Campos{$i}:=Field:C253(alQRY_numeroTabla{$i};alQRY_numeroCampo{$i})
			atQRY_NombreInternoCampo{$i}:="["+Table name:C256(alQRY_numeroTabla{$i})+"]"+Field name:C257(alQRY_numeroTabla{$i};alQRY_numeroCampo{$i})
			atQRY_NombreVirtualCampo{$i}:="["+API Get Virtual Table Name (alQRY_numeroTabla{$i})+"]"+API Get Virtual Field Name (alQRY_numeroTabla{$i};alQRY_numeroCampo{$i})
		End for 
		
		POST KEY:C465(3;0)
		POST KEY:C465(Character code:C91("*");256)
	Else 
		AT_Initialize (->ayQRY_Campos;->alQRY_numeroTabla;->alQRY_numeroCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo;->alQRY_Operador_ID;->atQRY_Conector_Simbolo)
	End if 
End if 