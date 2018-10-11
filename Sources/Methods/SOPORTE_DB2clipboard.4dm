//%attributes = {}
  //SOPORTE_DB2clipboard

ARRAY LONGINT:C221($aExclusiones;0)
APPEND TO ARRAY:C911($aExclusiones;Table:C252(->[xShell_BatchRequests:48]))
APPEND TO ARRAY:C911($aExclusiones;Table:C252(->[xShell_Dialogs:114]))
APPEND TO ARRAY:C911($aExclusiones;Table:C252(->[xShell_ErrorLog:34]))
APPEND TO ARRAY:C911($aExclusiones;Table:C252(->[xShell_Feriados:71]))
APPEND TO ARRAY:C911($aExclusiones;Table:C252(->[xShell_FieldAlias:198]))
APPEND TO ARRAY:C911($aExclusiones;Table:C252(->[xShell_Fields:52]))
APPEND TO ARRAY:C911($aExclusiones;Table:C252(->[xShell_InfoMachines:151]))
APPEND TO ARRAY:C911($aExclusiones;Table:C252(->[xShell_Logs:37]))
APPEND TO ARRAY:C911($aExclusiones;Table:C252(->[xShell_TableAlias:199]))
APPEND TO ARRAY:C911($aExclusiones;Table:C252(->[xShell_Tables:51]))
APPEND TO ARRAY:C911($aExclusiones;Table:C252(->[xxSNT_RegistrosModificados:97]))
$text:=""
For ($i;1;Get last table number:C254)
	  //20130321 RCH. Por la eliminacion de tablas se agrega la validacion
	If (Is table number valid:C999($i))
		If (Find in array:C230($aExclusiones;$i)=-1)
			$text:=$text+String:C10($i)+Char:C90(Tab:K15:37)+Table name:C256($i)+Char:C90(Tab:K15:37)+String:C10(Records in table:C83(Table:C252($i)->))+Char:C90(Carriage return:K15:38)
		End if 
	Else 
		$text:=$text+String:C10($i)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+Char:C90(Carriage return:K15:38)  //20130606 RCH Para facilitar verificacion
	End if 
End for 
SET TEXT TO PASTEBOARD:C523($text)