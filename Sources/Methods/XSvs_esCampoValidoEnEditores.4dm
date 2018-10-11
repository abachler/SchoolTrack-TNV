//%attributes = {}
  // XSvs_esCampoValidoEnEditores()
  // Por: Alberto Bachler: 07/03/13, 09:00:04
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_POINTER:C301($1)

C_BOOLEAN:C305($b_Indexado;$b_invisible;$b_tablaInvisible;$b_unico)
C_LONGINT:C283($l_largo;$l_numeroCampo;$l_numeroTabla;$l_tipo;$l_tipoCampo)
C_POINTER:C301($y_campo)
C_TEXT:C284($t_nombreTabla)

If (False:C215)
	C_BOOLEAN:C305(XSvs_esCampoValidoEnEditores ;$0)
	C_POINTER:C301(XSvs_esCampoValidoEnEditores ;$1)
End if 

$y_campo:=$1
$l_numeroTabla:=Table:C252($y_campo)
$l_numeroCampo:=Field:C253($y_campo)
$t_nombreTabla:=Table name:C256($l_numeroTabla)

If ((Is table number valid:C999($l_numeroTabla)) & (Is field number valid:C1000($l_numeroTabla;$l_numeroCampo)))
	GET TABLE PROPERTIES:C687($l_numeroTabla;$b_tablaInvisible)
	If ((Not:C34($b_tablaInvisible)) & ($t_nombreTabla#"xx@") & ($t_nombreTabla#"xShell@") & ($t_nombreTabla#"zz@"))
		GET FIELD PROPERTIES:C258($y_campo;$l_tipo;$l_largo;$b_Indexado;$b_unico;$b_invisible)
		$l_tipoCampo:=Type:C295($y_campo->)
		If (($l_tipoCampo#Is BLOB:K8:12) & ($l_tipoCampo#Is subtable:K8:11) & (Not:C34($b_invisible)))
			$0:=True:C214
		End if 
	End if 
End if 

