//%attributes = {}
  // QRY_AppendUserFields2FieldList()
  // Por: Alberto Bachler: 04/03/13, 18:26:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($i;$l_ultimoElemento;$l_numeroTabla)
C_POINTER:C301($y_nombresCampos_at;$y_numerosCampos_al)

ARRAY LONGINT:C221($al_numeroCampoPropio;0)
ARRAY TEXT:C222($at_nombreCampoPropio;0)
If (False:C215)
	C_LONGINT:C283(QRY_AppendUserFields2FieldList ;$1)
	C_POINTER:C301(QRY_AppendUserFields2FieldList ;$2)
	C_POINTER:C301(QRY_AppendUserFields2FieldList ;$3)
End if 
$l_numeroTabla:=$1
$y_nombresCampos_at:=$2
$y_numerosCampos_al:=$3

$l_ultimoElemento:=Size of array:C274($y_nombresCampos_at->)
QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FileNo:6=$l_numeroTabla;*)
QUERY:C277([xShell_Userfields:76]; & ;[xShell_Userfields:76]ModuleName:10=<>vsXS_CurrentModule)
If (Records in selection:C76([xShell_Userfields:76])>0)
	SELECTION TO ARRAY:C260([xShell_Userfields:76]UserFieldName:1;$at_nombreCampoPropio;[xShell_Userfields:76]FieldID:7;$al_numeroCampoPropio)
	For ($i;1;Size of array:C274($al_numeroCampoPropio))
		APPEND TO ARRAY:C911($y_nombresCampos_at->;$at_nombreCampoPropio{$i})
		APPEND TO ARRAY:C911($y_numerosCampos_al->;-7)
	End for 
End if 




