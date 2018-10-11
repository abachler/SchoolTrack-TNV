//%attributes = {}
  // Método: SR_GetVariableFieldInfo ({nombreVariable | refCampo:Y {;tipoObjeto:Y}}) --> puntero
  // retorna un puntero sobre el campo o variable correspondiente al objeto SRP
  // - nombreVariable | refCampo (opcional), retorna el nombre de la variable o una referencia sobre el campo en la forma [numeroTabla]numeroCampo
  // - tipoObjeto (opcional) retorna el tipo de objeto (var: variable, field:campo)
  // por Alberto Bachler Klein
  // creación 08/06/17, 12:36:12
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––



C_POINTER:C301($0)

C_LONGINT:C283($l_campo;$l_numeroCampo;$l_numeroTabla)
C_POINTER:C301($y_objeto)
C_TEXT:C284($t_nombreObjeto;$t_nombreVariable;$t_RefCampo;$t_tipoObjeto)


If (False:C215)
	C_POINTER:C301(SR_GetObjectPointer;$0)
End if 

$t_tipoObjeto:=SR_GetTextProperty (SRArea;SRObjectPrintRef;SRP_Object_Kind)
$t_nombreObjeto:=SR_GetTextProperty (SRArea;SRObjectPrintRef;SRP_Object_Name)
$t_RefCampo:=SR_GetTextProperty (SRArea;SRObjectPrintRef;SRP_Field_Source)
$t_nombreVariable:=SR_GetTextProperty (SRArea;SRObjectPrintRef;SRP_Variable_Source)

Case of 
	: ($t_tipoObjeto="field")
		$l_numeroTabla:=Num:C11(Substring:C12($t_RefCampo;2;Position:C15("]";$t_RefCampo)-2))
		$l_numeroCampo:=Num:C11(Substring:C12($t_RefCampo;Position:C15("]";$t_RefCampo)+1))  //MONO Ticket 182430
		$y_objeto:=Field:C253($l_numeroTabla;$l_numeroCampo)
		
	: ($t_tipoObjeto="var")
		$y_objeto:=Get pointer:C304($t_nombreVariable)
End case 

Case of 
	: (Count parameters:C259=2)
		$1->:=$t_nombreVariable
		$2->:=$t_tipoObjeto
	: (Count parameters:C259=1)
		$1->:=$t_nombreVariable
End case 


$0:=$y_objeto
