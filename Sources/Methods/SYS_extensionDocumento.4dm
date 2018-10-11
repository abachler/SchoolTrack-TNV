//%attributes = {}
  // SYS_extensionDocumento()
  // Por: Alberto Bachler: 17/09/13, 13:45:05
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($0)

C_LONGINT:C283($i)
C_TEXT:C284($t_extension;$t_nombreDocumento)
If (False:C215)
	C_TEXT:C284(SYS_extensionDocumento ;$0)
End if 

$t_nombreDocumento:=$1
If ($t_nombreDocumento#"")
	For ($i;Length:C16($t_nombreDocumento);1;-1)
		$t_extension:=$t_nombreDocumento[[$i]]+$t_extension
		If ($t_nombreDocumento[[$i]]=".")
			$i:=0
		End if 
	End for 
End if 

$0:=$t_extension

