//%attributes = {}
  // QRY_LoadQuery()
  //
  //
  // creado por: Alberto Bachler Klein: 25-02-16, 09:24:59
  // -----------------------------------------------------------
C_LONGINT:C283($i_fila;$l_abajoLB;$l_abajoW;$l_altoFila;$l_altoListbox;$l_altoPantalla;$l_arribaLB;$l_arribaW;$l_derechaLB;$l_derechaW)
C_LONGINT:C283($l_elemento;$l_fila;$l_filas;$l_indexActual;$l_indexCondicion;$l_indexConector;$l_izquierdaLB;$l_izquierdaW;$l_maxFilas;$l_maxSize)
C_POINTER:C301($y_index;$y_indexCount;$y_menuCampo;$y_menuCondicion;$y_menuConector;$y_menuLista;$y_nil;$y_objectCount;$y_variable)
C_OBJECT:C1216($ob_opciones)

ARRAY TEXT:C222($at_opciones;0)

$y_index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")
$y_objectCount:=OBJECT Get pointer:C1124(Object named:K67:5;"objectCount")
$y_indexCount:=OBJECT Get pointer:C1124(Object named:K67:5;"indexCount")

If (Count parameters:C259=1)
	$x_blob:=$1
Else 
	$x_blob:=[xShell_Queries:53]xFormula:9
End if 

QRY_Init 
If (BLOB size:C605($x_blob)>0)
	BLOB_Blob2Vars (->$x_blob;0;->alQRY_numeroTabla;->alQRY_numeroCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo;->vb_ConsultaMultiAño;->bCurrentYearOnly;->alQRY_Operador_ID;->atQRY_Conector_Simbolo;$y_index)
	$l_criterios:=Size of array:C274(alQRY_numeroTabla)
	AT_RedimArrays ($l_criterios;->alQRY_numeroTabla;->alQRY_numeroCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo;->alQRY_Operador_ID;->atQRY_Conector_Simbolo;$y_index)
	
	
	If ($l_criterios>0)
		ARRAY POINTER:C280(ayQRY_Campos;$l_criterios)
		For ($i_fila;1;$l_criterios)
			$y_index->{$i_fila}:=$i_fila
			$y_menuConector:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($i_fila)+"_conector")
			$y_menuCampo:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($i_fila)+"_campo")
			$y_menuCondicion:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($i_fila)+"_condicion")
			$y_menuLista:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($i_fila)+"_lista")
			$y_variable:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($i_fila)+"_variable")
			
			
			If (alQRY_numeroCampo{$i_fila}>0)
				ayQRY_Campos{$i_fila}:=Field:C253(alQRY_numeroTabla{$i_fila};alQRY_numeroCampo{$i_fila})
			Else 
				alQRY_numeroCampo{$i_fila}:=-7
				EXECUTE FORMULA:C63("yFieldname:=»"+"["+Table name:C256(alQRY_numeroTabla{$i_fila})+"]Userfields'Value")  //get the field pointer
				ayQRY_Campos{$i_fila}:=yfieldname
			End if 
			$y_campo:=ayQRY_Campos{$i_fila}
			$b_esCampoPropio:=(atQRY_NombreInternoCampo{$i_fila}="@userfields'value")
			$l_tipoCampo:=Choose:C955($b_esCampoPropio;7;Type:C295($y_campo->))
			
			
			If (alQRY_Operador_ID{$i_fila}>0)
				$l_indexCondicion:=Find in array:C230(<>alXS_QueryOperators_NumRef;alQRY_Operador_ID{$i_fila})
				If ($l_indexCondicion>0)
					atQRY_Operador_Literal{$i_fila}:=<>atXS_QueryOperators_Text{$l_indexCondicion}
				Else 
					atQRY_Operador_Literal{$i_fila}:="="
				End if 
			Else 
				$l_indexCondicion:=Find in array:C230(<>atXS_QueryOperators_Text;atQRY_Operador_Literal{$i_fila})
				If ($l_indexCondicion>0)
					alQRY_Operador_ID{$i_fila}:=<>alXS_QueryOperators_NumRef{$l_indexCondicion}
				Else 
					alQRY_Operador_ID{$i_fila}:=1
				End if 
			End if 
			
			
			If (atQRY_Conector_Simbolo{$i_fila}#"")
				$l_indexConector:=Find in array:C230(<>atXS_QueryConnectors_Symbol;atQRY_Conector_Simbolo{$i_fila})
				If ($l_indexConector>0)
					atQRY_Conector_Literal{$i_fila}:=<>atXS_QueryConnectors_Text{$l_indexConector}
				Else 
					atQRY_Conector_Literal{$i_fila}:=""
					CD_Dlog (0;__ ("Conector de  condiciones de búsqueda indefinido."))
				End if 
			Else 
				$l_indexConector:=Find in array:C230(<>atXS_QueryConnectors_Text;atQRY_Conector_Literal{$i_fila})
				If ($l_indexConector>0)
					atQRY_Conector_Simbolo{$i_fila}:=<>atXS_QueryConnectors_Symbol{$l_indexConector}
				Else 
					atQRY_Conector_Simbolo{$i_fila}:=""
				End if 
			End if 
			
			$l_indexActual:=1
			If ($i_fila>1)
				OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($i_fila-1)+"_nuevaLinea";"criterio"+String:C10($i_fila)+"_nuevaLinea";$y_nil;"";0;30)
				If (OK=1)
					OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($i_fila-1)+"_eliminaLinea";"criterio"+String:C10($i_fila)+"_eliminaLinea";$y_nil;"";0;30)
				End if 
				If (OK=1)
					OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($i_fila-1)+"_conector";"criterio"+String:C10($i_fila)+"_conector";$y_nil;"";0;30)
				End if 
				If (OK=1)
					OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($i_fila-1)+"_campo";"criterio"+String:C10($i_fila)+"_campo";$y_nil;"";0;30)
				End if 
				If (OK=1)
					OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($i_fila-1)+"_condicion";"criterio"+String:C10($i_fila)+"_condicion";$y_nil;"";0;30)
				End if 
				If (OK=1)
					OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($i_fila-1)+"_lista";"criterio"+String:C10($i_fila)+"_lista";$y_nil;"";0;30)
				End if 
				If (OK=1)
					OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($i_fila-1)+"_btnConector";"criterio"+String:C10($i_fila)+"_btnConector";$y_nil;"";0;30)
				End if 
				If (OK=1)
					OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($i_fila-1)+"_btnCampo";"criterio"+String:C10($i_fila)+"_btnCampo";$y_nil;"";0;30)
				End if 
				If (OK=1)
					OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($i_fila-1)+"_btnCondicion";"criterio"+String:C10($i_fila)+"_btnCondicion";$y_nil;"";0;30)
				End if 
				If (OK=1)
					OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($i_fila-1)+"_variable";"criterio"+String:C10($i_fila)+"_variable";$y_nil;"criterio"+String:C10($i_fila-1)+"_variable";0;30)
				End if 
				$y_objectCount->:=$y_objectCount->+1
				$y_indexCount->:=$y_indexCount->+1
				$y_index->{$i_fila}:=$i_fila
			End if 
			
			
			$y_menuConector:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($i_fila)+"_conector")
			$y_menuCampo:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($i_fila)+"_campo")
			$y_menuCondicion:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($i_fila)+"_condicion")
			$y_menuLista:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($i_fila)+"_lista")
			$y_variable:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($i_fila)+"_variable")
			$t_objetoLista:="criterio"+String:C10($i_fila)+"_lista"
			
			
			  // conector
			If (atQRY_Conector_Literal{$i_fila}#"")
				If (Size of array:C274($y_menuConector->)=0)
					APPEND TO ARRAY:C911($y_menuConector->;atQRY_Conector_Literal{$i_fila})
				Else 
					$y_menuConector->{1}:=atQRY_Conector_Literal{$i_fila}
				End if 
				$y_menuConector->:=1
			End if 
			
			  //campo
			If (atQRY_NombreVirtualCampo{$i_fila}#"")
				If (Size of array:C274($y_menuCampo->)=0)
					APPEND TO ARRAY:C911($y_menuCampo->;atQRY_NombreVirtualCampo{$i_fila})
				Else 
					$y_menuCampo->{1}:=atQRY_NombreVirtualCampo{$i_fila}
				End if 
				$y_menuCampo->:=1
				Case of 
					: (Type:C295(ayQRY_Campos{$i_fila}->)=Is boolean:K8:9)
						AT_Initialize (->$at_opciones)
						APPEND TO ARRAY:C911($at_opciones;__ ("Verdadero"))
						APPEND TO ARRAY:C911($at_opciones;__ ("Falso"))
						
						
					: (alQRY_numeroCampo{$i_fila}>0)
						$ob_opciones:=XS_GetFieldChoicesArray (ayQRY_Campos{$i_fila})
						
					: (alQRY_numeroCampo{$i_fila}=-7)
						$ob_opciones:=XS_GetFieldChoicesArray (ayQRY_Campos{$i_fila};Substring:C12(atQRY_NombreVirtualCampo{$i_fila};Position:C15("]";atQRY_NombreVirtualCampo{$i_fila})+1))
						If (OB Is defined:C1231($ob_opciones))
							OB GET ARRAY:C1229($ob_opciones;"opciones";$y_menuLista->)
						End if 
						$y_menuLista->:=Find in array:C230($y_menuLista->;atQRY_ValorLiteral{$i_fila})
				End case 
				
				
				If (OB Is defined:C1231($ob_opciones))
					AT_Initialize (->$at_opciones)
					OB GET ARRAY:C1229($ob_opciones;"opciones";$at_opciones)
					CLEAR VARIABLE:C89($ob_opciones)
				End if 
			End if 
			
			  // condicion
			If (atQRY_Operador_Literal{$i_fila}#"")
				If (Size of array:C274($y_menuCondicion->)=0)
					APPEND TO ARRAY:C911($y_menuCondicion->;"")
				End if 
				If ($l_tipoCampo=Is picture:K8:10)
					$y_menuCondicion->{1}:=Choose:C955(alQRY_Operador_ID{$i_fila}=3;__ ("Existe");__ ("No existe"))
				Else 
					$y_menuCondicion->{1}:=atQRY_Operador_Literal{$i_fila}
				End if 
				$y_menuCondicion->:=1
			End if 
			
			  // valor
			If (Size of array:C274($at_opciones)=0)
				If (atQRY_ValorLiteral{$i_fila}#"")
					$y_variable->:=atQRY_ValorLiteral{$i_fila}
				End if 
			Else 
				If (Type:C295(ayQRY_Campos{$i_fila}->)=Is boolean:K8:9)
					COPY ARRAY:C226($at_opciones;$y_menuLista->)
					$y_menuLista->:=Choose:C955(atQRY_ValorLiteral{$i_fila}="True";1;2)
				Else 
					$l_elemento:=Find in array:C230($at_opciones;atQRY_ValorLiteral{$i_fila})
					If ($l_elemento>0)
						COPY ARRAY:C226($at_opciones;$y_menuLista->)
						$y_menuLista->:=$l_elemento
					End if 
				End if 
			End if 
			
			If ($l_tipoCampo=Is picture:K8:10)
				OBJECT SET VISIBLE:C603($y_variable->;False:C215)
				OBJECT SET VISIBLE:C603($y_menuLista->;False:C215)
			Else 
				$b_visible:=OBJECT Get visible:C1075(*;$t_objetoLista)
				OBJECT SET VISIBLE:C603($y_menuLista->;Size of array:C274($y_menuLista->)>0)
				$b_visible:=OBJECT Get visible:C1075(*;$t_objetoLista)
				OBJECT SET VISIBLE:C603($y_variable->;Size of array:C274($y_menuLista->)=0)
			End if 
			
		End for 
		
		OBJECT SET VISIBLE:C603(*;"criterio@_conector";True:C214)
		OBJECT SET VISIBLE:C603(*;"criterio"+String:C10($y_index->{1})+"_conector";False:C215)
		OBJECT SET VISIBLE:C603(*;"criterio@_btnconector";True:C214)
		OBJECT SET VISIBLE:C603(*;"criterio"+String:C10($y_index->{1})+"_btnconector";False:C215)
		
		  // redimensiono
		$l_altoFila:=LISTBOX Get rows height:C836(*;"lb_criterios")
		$l_filas:=Size of array:C274($y_Index->)
		$l_altoListbox:=$l_altoFila*$l_filas
		OBJECT GET COORDINATES:C663(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_abajoLB)
		GET WINDOW RECT:C443($l_izquierdaW;$l_arribaW;$l_derechaW;$l_abajoW)
		$l_altoPantalla:=Screen height:C188
		$l_maxSize:=$l_altoPantalla-$l_arribaLB-$l_arribaW
		$l_maxFilas:=Int:C8($l_maxSize/$l_altoFila)-1
		$l_maxFilas:=Choose:C955($l_maxFilas>20;20;$l_maxFilas)
		If ($l_filas<=$l_maxFilas)
			OBJECT GET COORDINATES:C663(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_abajoLB)
			OBJECT SET COORDINATES:C1248(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_arribaLB+$l_altoListbox)
			
			GET WINDOW RECT:C443($l_izquierdaW;$l_arribaW;$l_derechaW;$l_abajoW)
			SET WINDOW RECT:C444($l_izquierdaW;$l_arribaW;$l_derechaW;$l_arribaW+$l_arribaLB+($l_filas*$l_altoFila)+40)
		End if 
		
	End if 
End if 