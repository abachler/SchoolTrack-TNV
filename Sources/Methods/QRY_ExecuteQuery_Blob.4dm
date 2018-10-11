//%attributes = {}
  // QRY_ExecuteQuery_Blob()
  //
  //
  // creado por: Alberto Bachler Klein: 15-12-16, 11:40:01
  // -----------------------------------------------------------
C_POINTER:C301($1)
C_BLOB:C604($2)

C_BLOB:C604($x_blob)
C_LONGINT:C283($i;$l_criterios;$l_indiceConectorLogico;$l_indiceOperador;$l_registrosEncontrados)
C_POINTER:C301($y_Tabla)



If (False:C215)
	C_POINTER:C301(QRY_ExecuteQuery_Blob ;$1)
	C_BLOB:C604(QRY_ExecuteQuery_Blob ;$2)
End if 

$y_Tabla:=$1
$x_blob:=$2

QRY_Init 
BLOB_Blob2Vars (->$x_blob;0;->alQRY_numeroTabla;->alQRY_numeroCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo;->vb_ConsultaMultiAño;->bCurrentYearOnly;->alQRY_Operador_ID;->atQRY_Conector_Simbolo)
$l_criterios:=Size of array:C274(alQRY_numeroTabla)
ARRAY INTEGER:C220(aFounded;$l_criterios)
ARRAY POINTER:C280(ayQRY_Campos;$l_criterios)
For ($i;1;$l_criterios)
	
	If (Is nil pointer:C315(ayQRY_Campos{$i}))
		EXECUTE FORMULA:C63("yFieldname:=»"+atQRY_NombreInternoCampo{$i})
		ayQRY_Campos{$i}:=yFieldname
	Else 
		ayQRY_Campos{$i}:=Field:C253(alQRY_numeroTabla{$i};alQRY_numeroCampo{$i})
	End if 
	
	$l_indiceOperador:=Find in array:C230(<>alXS_QueryOperators_NumRef;alQRY_Operador_ID{$i})
	If ($l_indiceOperador>0)
		atQRY_Operador_Literal{$i}:=<>atXS_QueryOperators_Text{$l_indiceOperador}
	Else 
		atQRY_Operador_Literal{$i}:="="
	End if 
	
	If (atQRY_Conector_Simbolo{$i}#"")
		$l_indiceConectorLogico:=Find in array:C230(<>atXS_QueryConnectors_Symbol;atQRY_Conector_Simbolo{$i})
		If ($l_indiceConectorLogico>0)
			atQRY_Conector_Literal{$i}:=<>atXS_QueryConnectors_Text{$l_indiceConectorLogico}
		Else 
			atQRY_Conector_Literal{$i}:=""
			CD_Dlog (0;__ ("Conector de  condiciones de búsqueda indefinido."))
		End if 
	Else 
		atQRY_Conector_Literal{$i}:=""
	End if 
End for 
MESSAGES ON:C181

QRY_ArreglosTablasRelacionadas 
If (QRY_EsConsultaPermitida )
	$l_registrosEncontrados:=QRY_RunQuery (vyQRY_TablePointer)
End if 

$0:=$l_registrosEncontrados



