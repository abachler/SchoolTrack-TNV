//%attributes = {}
  // Método: SR_ShowHideSection
  //
  //
  // por Alberto Bachler Klein
  // creación 15/12/17, 10:33:56
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)

C_LONGINT:C283($l_ignorado;$l_print)

If (False:C215)
	C_LONGINT:C283(SR_ShowHideSection ;$1)
	C_BOOLEAN:C305(SR_ShowHideSection ;$2)
End if 

$l_ignorado:=$1  // no se usa pero debe mantenerse en el llamdo a este método por razones de compatibilidad
$l_print:=Num:C11($2)

SRPrintSection:=$l_print



