//%attributes = {}
  // KRL_HayRegistrosBloqueados()
  // Por: Alberto Bachler K.: 18-04-15, 22:03:29
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_HayRegistrosBloqueados)
C_LONGINT:C283($i;$l_campo;$l_Proceso;$l_tabla)
C_POINTER:C301($y_campo;$y_tabla;$y_nil)
C_TEXT:C284($t_nombreCampo;$t_nombreProceso;$t_sesion;$t_usuario)


If (False:C215)
	C_BOOLEAN:C305(KRL_HayRegistrosBloqueados ;$0)
End if 

START TRANSACTION:C239
SET QUERY AND LOCK:C661(True:C214)

For ($i;1;Get last table number:C254)
	If (Is table number valid:C999($i))
		$y_tabla:=Table:C252($i)
		$y_Campo:=$y_nil
		$t_nombreCampo:="["+Table name:C256($i)+"]Auto_UUID"
		API Resolve Fieldname ($t_nombreCampo;$l_tabla;$l_campo)
		If ($l_campo>0)
			$y_campo:=Field:C253($l_tabla;$l_campo)
		Else 
			$t_nombreCampo:="["+Table name:C256($i)+"]Autouuid"
			API Resolve Fieldname ($t_nombreCampo;$l_tabla;$l_campo)
			If ($l_campo>0)
				$y_campo:=Field:C253($l_tabla;$l_campo)
			End if 
		End if 
		If (Not:C34(Is nil pointer:C315($y_campo)))
			READ WRITE:C146($y_tabla->)
			QUERY:C277($y_tabla->;$y_campo->#"")
			If (Records in set:C195("lockedSet")>0)
				USE SET:C118("lockedSet")
				LOCKED BY:C353($y_tabla->;$l_Proceso;$t_usuario;$t_sesion;$t_nombreProceso)
				If ($l_Proceso>0)
					$b_HayRegistrosBloqueados:=True:C214
					$i:=Get last table number:C254
				End if 
			End if 
		End if 
	Else 
		TRACE:C157
	End if 
End for 
SET QUERY AND LOCK:C661(True:C214)
CANCEL TRANSACTION:C241

$0:=$b_HayRegistrosBloqueados

