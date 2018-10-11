//%attributes = {}
  // Método: SR_ResizeTextObject
  // código original de: ABK
  // modificado por Alberto Bachler Klein, 28/06/18, 11:48:11
  // reemplazo de comando de plugin HMFree_Text2Array por comando nativo TEXT TO ARRAY
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_alturaLinea;$l_ancho;$l_estiloFuente;$l_expansion;$l_expansionArreglo;$l_ignorado;$l_tamañoFuente)
C_TEXT:C284($t_fuente;$t_texto)


If (False:C215)
	C_TEXT:C284(SR_ResizeTextObject ;$1)
	C_LONGINT:C283(SR_ResizeTextObject ;$2)
End if 

$t_texto:=$1
$l_ignorado:=$2
If ($t_texto#"")
	$l_variableV:=SR_GetLongProperty (SRArea;SRObjectPrintRef;SRP_Object_VariableSizeV)
	SR_SetLongProperty (SRArea;SRObjectPrintRef;SRP_Object_VariableSizeV;1)  // impresión variable verticalmente según el contenido
	$0:=$t_texto
Else 
	$0:=""
End if 