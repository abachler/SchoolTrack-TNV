//%attributes = {}
  // CIM_registrosEnBD()
  // Por: Alberto Bachler K.: 28-09-14, 13:12:06
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_esBaseDatosNueva)
_O_C_INTEGER:C282($i_numeroTabla)
C_LONGINT:C283($l_registros)


If (False:C215)
	C_BOOLEAN:C305(CIM_esBaseDeDatosNueva ;$0)
End if 

$b_esBaseDatosNueva:=True:C214
For ($i_numeroTabla;1;Get last table number:C254)
	If (Is table number valid:C999($i_numeroTabla))
		$l_registros:=Records in table:C83(Table:C252($i_numeroTabla)->)
		If ($l_registros>0)
			$b_esBaseDatosNueva:=False:C215
			$i_numeroTabla:=Get last table number:C254
		End if 
	End if 
End for 

$0:=$b_esBaseDatosNueva


