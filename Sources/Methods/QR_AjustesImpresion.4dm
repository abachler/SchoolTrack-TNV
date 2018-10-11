//%attributes = {}
  // QR_PrintSettings()
  //
  //
  // creado por: Alberto Bachler Klein: 31-03-16, 09:56:28
  // -----------------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_TEXT:C284($3)

C_LONGINT:C283($l_formatoImpresion)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_aliasPlataforma;$t_formulario)


If (False:C215)
	C_LONGINT:C283(QR_AjustesImpresion ;$0)
	C_LONGINT:C283(QR_AjustesImpresion ;$1)
	C_POINTER:C301(QR_AjustesImpresion ;$2)
	C_TEXT:C284(QR_AjustesImpresion ;$3)
End if 

Case of 
	: (Count parameters:C259=0)
		
	: (Count parameters:C259=1)
		$l_formatoImpresion:=$1
		
	: (Count parameters:C259>=1)
		$l_formatoImpresion:=$1
		$y_tabla:=$2
		$t_formulario:=$3
End case 

If (SYS_IsWindows )
	$t_aliasPlataforma:="Win"
Else 
	$t_aliasPlataforma:="Mac"
End if 

Case of 
	: ($t_formulario#"")
		  // se utilizan los ajustes del formulario de impresión
	: ($l_formatoImpresion=0)
		$y_tabla:=->[xShell_Reports:54]
		$t_formulario:="USLetterPortrait_"+$t_aliasPlataforma
		
	: ($l_formatoImpresion=Letter_Portrait)
		$y_tabla:=->[xShell_Reports:54]
		$t_formulario:="USLetterPortrait_"+$t_aliasPlataforma
		
	: ($l_formatoImpresion=Letter_Paysage)
		$y_tabla:=->[xShell_Reports:54]
		$t_formulario:="USLetterPaysage_"+$t_aliasPlataforma
		
	: ($l_formatoImpresion=Legal_Portrait)
		$y_tabla:=->[xShell_Reports:54]
		$t_formulario:="USLegalPortrait_"+$t_aliasPlataforma
		
	: ($l_formatoImpresion=Legal_Paysage)
		$y_tabla:=->[xShell_Reports:54]
		$t_formulario:="USLegalPaysage_"+$t_aliasPlataforma
		
End case 
OK:=1

If ((Not:C34(Is in print preview:C1198)) & (Not:C34(Get print preview:C1197)))
	PAGE SETUP:C299($y_tabla->;$t_formulario)
Else 
	PAGE SETUP:C299($y_tabla->;$t_formulario)
End if 
PRINT SETTINGS:C106
  //ABC193355 dejo fuera PRINT SETTINGS para que siempre se pregunte tamaño de hoja e impresora (así estaba en v11)
$0:=OK