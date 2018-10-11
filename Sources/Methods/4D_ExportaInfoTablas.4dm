//%attributes = {}
  // 4D_ExportaINfoTablas()
  //
  //
  // creado por: Alberto Bachler Klein: 14-10-16, 18:02:08
  // -----------------------------------------------------------
C_POINTER:C301(${1})

C_BOOLEAN:C305($b_indexado;$b_invisible;$b_triggerCreacion;$b_triggerEliminacion;$b_triggerModificacion;$b_unico)
C_LONGINT:C283($i;$i_campos;$i_fila;$i_tablas;$l_hoja;$l_largoAlpha;$l_OK;$l_refXLS;$l_tipoCampo)
C_TEXT:C284($t_fieldName;$t_nombrePlanilla;$t_rutaDocumento;$t_tipoDeCampo)

ARRAY POINTER:C280($ay_Tablas;0)



If (False:C215)
	C_POINTER:C301(4D_ExportaInfoTablas ;${1})
End if 

$t_rutaDocumento:=Select folder:C670("Guardar definicion de estructura en...")
$t_nombrePlanilla:="Tablas en "+SYS_GetServerProperty (XS_StructureName)+".xls"

$l_refXLS:=XLS Create (1)
$l_hoja:=1
XLS Set sheet name ($l_refXLS;$l_hoja;$t_nombrePlanilla)

$i_fila:=1
XLS Set text value ($l_refXLS;$l_hoja;$i_fila;1;"Número de tabla")
XLS Set text value ($l_refXLS;$l_hoja;$i_fila;2;"Nombre de tabla")
XLS Set text value ($l_refXLS;$l_hoja;$i_fila;3;"Invisible")
XLS Set text value ($l_refXLS;$l_hoja;$i_fila;4;"Trigger creacion")
XLS Set text value ($l_refXLS;$l_hoja;$i_fila;5;"Trigger modificacion")
XLS Set text value ($l_refXLS;$l_hoja;$i_fila;6;"Trigger eliminación")

For ($i_tablas;1;Get last table number:C254)
	$i_fila:=$i_fila+1
	If (Is table number valid:C999($i_tablas))
		GET TABLE PROPERTIES:C687($i_tablas;$b_invisible;$b_triggerCreacion;$b_triggerModificacion;$b_triggerEliminacion)
		XLS Set long value ($l_refXLS;$l_hoja;$i_fila;1;$i_tablas)
		XLS Set text value ($l_refXLS;$l_hoja;$i_fila;2;Table name:C256($i_tablas))
		XLS Set text value ($l_refXLS;$l_hoja;$i_fila;3;Choose:C955($b_invisible;"Si";"No"))
		XLS Set text value ($l_refXLS;$l_hoja;$i_fila;4;Choose:C955($b_triggerCreacion;"Si";"No"))
		XLS Set text value ($l_refXLS;$l_hoja;$i_fila;5;Choose:C955($b_triggerModificacion;"Si";"No"))
		XLS Set text value ($l_refXLS;$l_hoja;$i_fila;6;Choose:C955($b_triggerEliminacion;"Si";"No"))
	Else 
		XLS Set long value ($l_refXLS;$l_hoja;$i_fila;1;$i_tablas)
		XLS Set text value ($l_refXLS;$l_hoja;$i_fila;2;"Eliminada")
		XLS Set text value ($l_refXLS;$l_hoja;$i_fila;3;"")
		XLS Set text value ($l_refXLS;$l_hoja;$i_fila;4;"")
		XLS Set text value ($l_refXLS;$l_hoja;$i_fila;5;"")
		XLS Set text value ($l_refXLS;$l_hoja;$i_fila;6;"")
	End if 
End for 

$t_rutaDocumento:=$t_rutaDocumento+$t_nombrePlanilla
$l_OK:=XLS Save as ($l_refXLS;$t_rutaDocumento)
XLS CLOSE ($l_refXLS)
OPEN URL:C673($t_rutaDocumento)

