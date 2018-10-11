//%attributes = {}
  // QR_BuildTableList()
  // Por: Alberto Bachler: 19/02/13, 16:06:32
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_indexado;$b_invisible;$b_unico)
C_LONGINT:C283($l_numeroColumnas;$i;$i_Campos;$i_tabla;$l_anchoColumna;$l_largoCampo;$l_modoLista;$l_numeroCampo;$l_numeroTabla;$l_oculto)
C_LONGINT:C283($l_referenciaCampo;$l_sublista;$l_tablaActual;$l_tipoCampo;$l_valoresRepetidos)
C_POINTER:C301($y_listaCampos)
C_TEXT:C284($t_encabezado;$t_formato;$t_nombreCampo;$t_nombreTabla;$t_objeto)

If (False:C215)
	C_POINTER:C301(QR_BuildTableList ;$1)
	C_LONGINT:C283(QR_BuildTableList ;$2)
	C_LONGINT:C283(QR_BuildTableList ;$3)
End if 


$y_listaCampos:=$1
$l_tablaActual:=$2
If (Count parameters:C259=3)
	$l_modoLista:=$3
Else 
	$l_modoLista:=3
End if 


HL_ClearList ($y_listaCampos->)
$y_listaCampos->:=New list:C375

$l_referenciaCampo:=0
Case of 
	: ($l_modoLista=1)
		$y_listaCampos->:=New list:C375
		$l_numeroTabla:=$l_tablaActual
		$t_nombreTabla:=XSvs_nombreTablaLocal_Numero ($l_numeroTabla)
		For ($i;1;Get last field number:C255($l_numeroTabla))
			If (Is field number valid:C1000($l_numeroTabla;$i))
				GET FIELD PROPERTIES:C258($l_tablaActual;$i;$l_tipoCampo;$l_largoCampo;$b_indexado;$b_unico;$b_invisible)
				Case of 
					: (($b_invisible) | ($l_tipoCampo=Is BLOB:K8:12) | ($l_tipoCampo=Is picture:K8:10) | ($l_tipoCampo=Is subtable:K8:11))
					Else 
						$l_numeroCampo:=$i
						$t_nombreCampo:=XSvs_nombreCampoLocal_Numero ($l_numeroTabla;$l_numeroCampo)
						$l_referenciaCampo:=$l_ReferenciaCampo+1
						If ($l_referenciaCampo=2)
							
						End if 
						APPEND TO LIST:C376($y_listaCampos->;$t_nombreCampo;$l_referenciaCampo)
						SET LIST ITEM PARAMETER:C986($y_listaCampos->;$l_referenciaCampo;"Tabla";String:C10($l_numeroTabla))
						SET LIST ITEM PARAMETER:C986($y_listaCampos->;$l_referenciaCampo;"Campo";String:C10($l_numeroCampo))
				End case 
			End if 
		End for 
		SORT LIST:C391($y_listaCampos->)
		
		
		
	: ($l_modoLista=2)
		ARRAY INTEGER:C220($al_numerosTablas;0)
		READ ONLY:C145([xShell_Tables_RelatedFiles:243])
		QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11=$l_tablaActual)
		AT_DistinctsFieldValues (->[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;->$al_numerosTablas)
		
		
	: ($l_modoLista=3)
		QUERY:C277([xShell_Tables:51];[xShell_Tables:51]EsTablaOcultaEnEditores:35=False:C215)
		AT_DistinctsFieldValues (->[xShell_Tables:51]NumeroDeTabla:5;->$al_numerosTablas)
		
		
		
	: ($l_modoLista=5)
		$l_numeroColumnas:=QR Count columns:C764(xQR_ReportArea)
		For ($i;1;$l_numeroColumnas)
			QR GET INFO COLUMN:C766(xQR_ReportArea;$i;$t_encabezado;$t_objeto;$l_oculto;$l_anchoColumna;$l_valoresRepetidos;$t_formato)
			API Resolve Fieldname ($t_objeto;$l_numeroTabla;$l_numeroCampo)
			
			If (($l_numeroTabla>0) & ($l_numeroCampo>0))
				$l_referenciaCampo:=$l_ReferenciaCampo+1
				$t_nombreCampo:=XSvs_nombreCampoLocal_Numero ($l_numeroTabla;$l_numeroCampo)
				APPEND TO LIST:C376($y_listaCampos->;$t_nombreCampo;$l_referenciaCampo)
				SET LIST ITEM PARAMETER:C986($y_listaCampos->;$l_referenciaCampo;"Tabla";String:C10($l_numeroTabla))
				SET LIST ITEM PARAMETER:C986($y_listaCampos->;$l_referenciaCampo;"Campo";String:C10($l_numeroCampo))
			Else 
				$l_referenciaCampo:=$i
				SET LIST ITEM PARAMETER:C986($y_listaCampos->;$l_referenciaCampo;"Tabla";"0")
				SET LIST ITEM PARAMETER:C986($y_listaCampos->;$l_referenciaCampo;"Campo";"0")
			End if 
		End for 
		
End case 

If (($l_modoLista=2) | ($l_modoLista=3))
	For ($i_tabla;1;Size of array:C274($al_numerosTablas))
		$l_numeroTabla:=$al_numerosTablas{$i_tabla}
		If (Is table number valid:C999($l_numeroTabla))
			If (USR_checkRights ("L";Table:C252($l_numeroTabla)))
				GET TABLE PROPERTIES:C687($al_numerosTablas{$i_tabla};$b_invisible)
				$t_nombreTabla:=XSvs_nombreTablaLocal_Numero ($l_numeroTabla)
				
				$l_sublista:=New list:C375
				For ($i_Campos;1;Get last field number:C255($l_numeroTabla))
					If (Is field number valid:C1000($l_numeroTabla;$i_Campos))
						GET FIELD PROPERTIES:C258($l_numeroTabla;$i_Campos;$l_tipoCampo;$l_largoCampo;$b_indexado;$b_unico;$b_invisible)
						$l_numeroCampo:=$i_Campos
						$t_nombreCampo:=XSvs_nombreCampoLocal_Numero ($l_numeroTabla;$l_numeroCampo)
						If (($b_invisible) | ($l_tipoCampo=Is BLOB:K8:12) | ($l_tipoCampo=Is picture:K8:10) | ($l_tipoCampo=Is subtable:K8:11) | ($t_nombreCampo=""))
						Else 
							$l_referenciaCampo:=$l_ReferenciaCampo+1
							APPEND TO LIST:C376($l_sublista;$t_nombreCampo;$l_referenciaCampo)
							SET LIST ITEM PARAMETER:C986($l_sublista;$l_referenciaCampo;"Tabla";String:C10($l_numeroTabla))
							SET LIST ITEM PARAMETER:C986($l_sublista;$l_referenciaCampo;"Campo";String:C10($l_numeroCampo))
						End if 
					End if 
				End for 
				APPEND TO LIST:C376($y_listaCampos->;$t_nombreTabla;$l_numeroTabla;$l_sublista;False:C215)
			End if 
		End if 
	End for 
	SORT LIST:C391($y_listaCampos->)
	
	  // inserto la tabla principal en la primera posicion de la lista
	$l_sublista:=New list:C375
	$l_numeroTabla:=$l_tablaActual
	$t_nombreTabla:=XSvs_nombreTablaLocal_Numero ($l_numeroTabla)
	For ($i;1;Get last field number:C255($l_numeroTabla))
		If (Is field number valid:C1000($l_numeroTabla;$i))
			GET FIELD PROPERTIES:C258($l_tablaActual;$i;$l_tipoCampo;$l_largoCampo;$b_indexado;$b_unico;$b_invisible)
			Case of 
				: (($b_invisible) | ($l_tipoCampo=Is BLOB:K8:12) | ($l_tipoCampo=Is picture:K8:10) | ($l_tipoCampo=Is subtable:K8:11))
					
				Else 
					$l_numeroCampo:=$i
					$t_nombreCampo:=XSvs_nombreCampoLocal_Numero ($l_numeroTabla;$l_numeroCampo)
					$l_referenciaCampo:=$l_ReferenciaCampo+1
					APPEND TO LIST:C376($l_sublista;$t_nombreCampo;$l_referenciaCampo)
					SET LIST ITEM PARAMETER:C986($l_sublista;$l_referenciaCampo;"Tabla";String:C10($l_numeroTabla))
					SET LIST ITEM PARAMETER:C986($l_sublista;$l_referenciaCampo;"Campo";String:C10($l_numeroCampo))
			End case 
		End if 
	End for 
	SELECT LIST ITEMS BY POSITION:C381($y_listaCampos->;1)
	GET LIST ITEM:C378($y_listaCampos->;Selected list items:C379($y_listaCampos->);$l_refElementoActual;$t_elementoActual)
	INSERT IN LIST:C625($y_listaCampos->;$l_refElementoActual;$t_nombreTabla;$l_numeroTabla;$l_sublista;True:C214)
	SELECT LIST ITEMS BY REFERENCE:C630($y_listaCampos->;$l_numeroTabla)
	OBJECT SET SCROLL POSITION:C906($y_listaCampos->;1)
End if 

