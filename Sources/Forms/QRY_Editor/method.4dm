  // QRY_Editor()
  //
  //
  // creado por: Alberto Bachler Klein: 23-02-16, 18:38:19
  // -----------------------------------------------------------
C_LONGINT:C283($l_abajoLB;$l_abajoW;$l_altoFila;$l_altoListbox;$l_altoPantalla;$l_arribaLB;$l_arribaW;$l_busquedasAlmacenadas;$l_color;$l_criterios)
C_LONGINT:C283($l_derechaLB;$l_derechaW;$l_fila;$l_filas;$l_izquierdaLB;$l_izquierdaW;$l_lineasVacias;$l_maxFilas;$l_maxSize)
C_POINTER:C301($y_fila;$y_index;$y_indexCount;$y_menuCampos;$y_menuCondicion;$y_Nil;$y_objectCount)

C_TEXT:C284(sSrchTitle)
C_PICTURE:C286(NULLPICT)
C_BOOLEAN:C305(wSrchInSel)


$y_index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")
$y_objectCount:=OBJECT Get pointer:C1124(Object named:K67:5;"objectCount")
$y_indexCount:=OBJECT Get pointer:C1124(Object named:K67:5;"indexCount")
Case of 
	: (Form event:C388=On Load:K2:1)
		QRY_LoadInterface 
		ARRAY TEXT:C222(AFORMULA;0)  //MONO 172659
		C_BOOLEAN:C305(vb_ConsultaMultiAño)
		
		  //vl_currentFormula:=-1
		sSrchTitle:="Búsqueda de "+XSvs_nombreTablaLocal_puntero (vyQRY_TablePointer)
		vtQRY_ValorLiteral:=""
		r1:=0
		r2:=0
		r3:=0
		
		IT_SetButtonState (False:C215;->bclear;->bsave;->bOk;->btest)  //MONO 172659
		QRY_LoadLogicalConectorsArray 
		QRY_LoadOperatorsArray 
		
		
		bSrchSel:=0
		vtQRY_ValorLiteral:=""
		
		If (Type:C295(vb_DontExecSearch)=5)
			OBJECT SET VISIBLE:C603(*;"Report@";False:C215)
		Else 
			If (Not:C34(vb_DontExecSearch))
				vb_ConsultaMultiAño:=False:C215
				FORM GOTO PAGE:C247(1)
			Else 
				FORM GOTO PAGE:C247(2)
			End if 
		End if 
		OBJECT SET VISIBLE:C603(vtQRY_ValorLiteral;True:C214)
		OBJECT SET VISIBLE:C603(*;"YesOrNo@";False:C215)
		
		
		
		QRY_CreaMenuCampos 
		
		Case of 
			: (BLOB size:C605(vx_QueryBlob)>0)
				QRY_LoadQuery (vx_QueryBlob)
				
			: (Records in selection:C76([xShell_Queries:53])>0)
				QRY_LoadQuery 
		End case 
		
		$l_criterios:=Size of array:C274(atQRY_NombreVirtualCampo)
		
		If (Size of array:C274(atQRY_NombreVirtualCampo)=0)
			AT_Initialize (->atQRY_NombreVirtualCampo;->ayQRY_Campos;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreInternoCampo;->alQRY_Operador_ID;->atQRY_Conector_Simbolo;->alQRY_numeroTabla;->alQRY_numeroCampo;$y_index)
			APPEND TO ARRAY:C911(atQRY_NombreVirtualCampo;"")
			APPEND TO ARRAY:C911(ayQRY_Campos;$y_Nil)
			APPEND TO ARRAY:C911(atQRY_Operador_Literal;"comienza con")
			APPEND TO ARRAY:C911(atQRY_ValorLiteral;"")
			APPEND TO ARRAY:C911(atQRY_Conector_Literal;"")
			APPEND TO ARRAY:C911(atQRY_NombreInternoCampo;"")
			APPEND TO ARRAY:C911(alQRY_Operador_ID;1)
			APPEND TO ARRAY:C911(atQRY_Conector_Simbolo;"")
			APPEND TO ARRAY:C911(alQRY_numeroTabla;0)
			APPEND TO ARRAY:C911(alQRY_numeroCampo;0)
			APPEND TO ARRAY:C911($y_index->;1)
			$l_criterios:=1
		Else 
			$l_criterios:=Size of array:C274(atQRY_NombreVirtualCampo)
			  //MONO 181575: al recargar este formulario el array local de "index" pierde sus posiciones con respecto a los criterios, cuando abrimos la ventana de "Abrir" consultas 
			If (Size of array:C274($y_index->)#$l_criterios)
				AT_RedimArrays (0;$y_index)
				For ($i_criterio;1;$l_criterios)
					APPEND TO ARRAY:C911($y_index->;$i_criterio)
				End for 
			End if 
		End if 
		$y_objectCount->:=$l_criterios
		$y_indexCount->:=$l_criterios
		
		OBJECT SET VISIBLE:C603(*;"criterio1_@Conector";False:C215)
		If (Is nil pointer:C315(ayQRY_Campos{1}))
			OBJECT SET VISIBLE:C603(*;"criterio1_@lista";False:C215)
			
			$y_menuCampos:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio1_campo")
			APPEND TO ARRAY:C911($y_menuCampos->;"Seleccione el campo…")
			$y_menuCampos->:=1
			
			$y_menuCondicion:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio1_condicion")
			APPEND TO ARRAY:C911($y_menuCondicion->;"comienza con…")
			$y_menuCondicion->:=1
		End if 
		
		  //$l_color:=(251 << 16)+(251 << 8)+251
		  //OBJECT SET RGB COLORS(*;"lb_criterios";0x00FFFFFF;0x00FFFFFF;$l_color)
		
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_busquedasAlmacenadas)
		QUERY:C277([xShell_Queries:53];[xShell_Queries:53]FileNo:5=Table:C252(vyQRY_TablePointer))
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		
		  //IT_SetButtonState (Size of array(atQRY_ValorLiteral)#0;->bclear;->bsave;->bOk;->bAsociate;->bTest)  //MONO 172659
		IT_SetButtonState (Size of array:C274(atQRY_ValorLiteral)#0;->bclear;->bsave;->bOk;->bAsociate)
		IT_SetButtonState ($l_busquedasAlmacenadas>0;->bloadExecute)
		OBJECT SET VISIBLE:C603(bCurrentYearOnly;False:C215)
		
		  // Modificado por: Saúl Ponce (02-02-2017) - Ticket Nº 174602
		  // Para que el criterio seleccionado al cargar el formulario sea  "buscar en todos los registros"
		o1:=1
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		$l_lineasVacias:=AT_CountNulValues (->atQRY_NombreVirtualCampo)
		IT_SetButtonState (Size of array:C274(atQRY_ValorLiteral)>$l_lineasVacias;->bclear;->bsave;->bOk;->bAsociate;->bTest)
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		  //vl_currentformula:=-1
		
End case 


$l_altoFila:=LISTBOX Get rows height:C836(*;"lb_criterios")
$l_filas:=Size of array:C274($y_index->)
$l_altoListbox:=$l_altoFila*$l_filas
OBJECT GET COORDINATES:C663(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_abajoLB)
GET WINDOW RECT:C443($l_izquierdaW;$l_arribaW;$l_derechaW;$l_abajoW)
$l_altoPantalla:=Screen height:C188
$l_maxSize:=$l_altoPantalla-$l_arribaLB-$l_arribaW
$l_maxFilas:=Int:C8($l_maxSize/$l_altoFila)-1
$l_maxFilas:=Choose:C955($l_maxFilas>20;20;$l_maxFilas)

OBJECT SET ENABLED:C1123(*;"criterio@_nuevaLinea";$l_filas<$l_maxFilas)
If ($l_filas>0)
	OBJECT SET ENABLED:C1123(*;"criterio"+String:C10($y_index->{1})+"_eliminalinea";$y_objectCount->>1)
End if 
OBJECT SET ENABLED:C1123(*;"criterio@_btnConector";True:C214)
OBJECT SET ENABLED:C1123(*;"criterio1_btnConector";False:C215)

OBJECT SET ENABLED:C1123(*;"criterio1_eliminalinea";False:C215)

