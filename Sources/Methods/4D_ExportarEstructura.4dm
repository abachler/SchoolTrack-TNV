//%attributes = {}
  // 4D_ExportarEstructura()
  // Por: Alberto Bachler K.: 14-01-15, 10:06:32
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_indexado;$b_invisible;$b_unico)
C_LONGINT:C283($i_campos;$i_tablas;$l_error;$l_largoAlpha;$l_refHoja;$l_refXLS;$l_tipoCampo)
C_TEXT:C284($t_fieldName;$t_nombrePlanilla;$t_rutaDocumento)

ARRAY BOOLEAN:C223($ab_indexado;0)
ARRAY BOOLEAN:C223($ab_unico;0)
ARRAY BOOLEAN:C223($ab_invisible;0)
ARRAY LONGINT:C221($al_numeroCampo;0)
ARRAY LONGINT:C221($al_numeroTabla;0)
ARRAY POINTER:C280($ay_columnas;0)
ARRAY TEXT:C222($at_campos;0)
ARRAY TEXT:C222($at_encabezados;0)
ARRAY TEXT:C222($at_TipoCampo;0)


For ($i_tablas;1;Get last table number:C254)
	If (Is table number valid:C999($i_tablas))
		For ($i_campos;1;Get last field number:C255($i_tablas))
			If (Is field number valid:C1000($i_tablas;$i_campos))
				$t_fieldName:="["+Table name:C256($i_tablas)+"]"+Field name:C257($i_tablas;$i_campos)
				GET FIELD PROPERTIES:C258($i_tablas;$i_campos;$l_tipoCampo;$l_largoAlpha;$b_indexado;$b_unico;$b_invisible)
				APPEND TO ARRAY:C911($at_campos;$t_fieldName)
				APPEND TO ARRAY:C911($al_numeroTabla;$i_tablas)
				APPEND TO ARRAY:C911($al_numeroCampo;$i_campos)
				APPEND TO ARRAY:C911($at_TipoCampo;4D_GetFieldType ($l_tipoCampo))
				APPEND TO ARRAY:C911($ab_indexado;$b_indexado)
				APPEND TO ARRAY:C911($ab_unico;$b_unico)
				APPEND TO ARRAY:C911($ab_invisible;$b_invisible)
			End if 
		End for 
	End if 
End for 


$t_nombrePlanilla:="Estructura "+SYS_GetServerProperty (XS_StructureName)+" ["+DTS_MakeFromDateTime +"].xls"
$t_rutaDocumento:=Temporary folder:C486+$t_nombrePlanilla

AT_AppendItems2TextArray (->$at_encabezados;"Nombre de tabla y campo";"Número de tabla";"Número de campo";"Tipo de campo";"Indexado";"Unico";"Invisible")
AT_AppendToPointerArray (->$ay_columnas;->$at_campos;->$al_numeroTabla;->$al_numeroCampo;->$at_TipoCampo;->$ab_indexado;->$ab_unico;->$ab_invisible)

$l_refXLS:=XLS_CreateBook 
$l_refHoja:=XLS_CreateSheet ($l_refXLS;"Tablas y campos")
XLS_SetColumns ($l_refHoja;->$ay_columnas;->$at_encabezados)

If (Test path name:C476($t_rutaDocumento)=Is a document:K24:1)
	DELETE DOCUMENT:C159($t_rutaDocumento)
End if 

$l_error:=XLS_SaveDocument ($l_refXLS;$t_rutaDocumento)
XLS_ClearSheet ($l_refHoja)
XLS_ClearBook ($l_refxls)
OPEN URL:C673($t_rutaDocumento)

