//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 27-09-17, 18:03:24
  // ----------------------------------------------------
  // Método: UFDL_CreaRegistroUserFieldEnTab
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------
C_LONGINT:C283($1;$2;$l_RecNuTable)  //MONO FIX 216513
C_LONGINT:C283($l_llaveSubtabla;$l_numeroTabla;$l_RecNuUserField;$x)
C_POINTER:C301($y_tabla;$y_tablacampoID;$y_tablacampoValue;$y_tablaID_Converter;$y_tableSubtabla)
C_TEXT:C284($t_prefijoGuardar;$t_prefijoValor)

ARRAY LONGINT:C221($al_recNumTabla;0)
$l_RecNuUserField:=-1  //MONO FIX 216513
$l_RecNuTable:=-1  //MONO FIX 216513

Case of   //MONO FIX 216513
	: (Count parameters:C259=1)
		$l_RecNuUserField:=$1
	: (Count parameters:C259=2)
		$l_RecNuUserField:=$1
		$l_RecNuTable:=$2
End case 

If ($l_RecNuUserField>=0)
	GOTO RECORD:C242([xShell_Userfields:76];$l_RecNuUserField)
End if 

$t_prefijoValor:=String:C10([xShell_Userfields:76]FieldID:7;"00000/")+"@"
$t_prefijoGuardar:=String:C10([xShell_Userfields:76]FieldID:7;"00000/")
$l_numeroTabla:=[xShell_Userfields:76]FileNo:6
$y_tabla:=Table:C252($l_numeroTabla)


$y_tablacampoID:=KRL_GetFieldPointerByName ("["+Table name:C256($l_numeroTabla)+"_UserField]id_added_by_converter")
If (Is nil pointer:C315($y_tablacampoID))
	$y_tablacampoID:=KRL_GetFieldPointerByName ("["+Table name:C256($l_numeroTabla)+"_Userfields]id_added_by_converter")
	$y_tablaID_Converter:=KRL_GetFieldPointerByName ("["+Table name:C256($l_numeroTabla)+"]Userfields")
Else 
	If ($l_numeroTabla=Table:C252(->[ACT_CuentasCorrientes:175]))
		$y_tablaID_Converter:=KRL_GetFieldPointerByName ("["+Table name:C256($l_numeroTabla)+"]Userfields")
	Else 
		$y_tablaID_Converter:=KRL_GetFieldPointerByName ("["+Table name:C256($l_numeroTabla)+"]UserField")
	End if 
End if 

$y_tablacampoValue:=KRL_GetFieldPointerByName ("["+Table name:C256($l_numeroTabla)+"_UserField]value")
If (Is nil pointer:C315($y_tablacampoValue))
	$y_tablacampoValue:=KRL_GetFieldPointerByName ("["+Table name:C256($l_numeroTabla)+"_Userfields]value")
End if 

$y_tableSubtabla:=Table:C252(Table:C252($y_tablacampoID))

If ($l_RecNuTable>=0)  //MONO FIX 216513
	APPEND TO ARRAY:C911($al_recNumTabla;$l_RecNuTable)
Else 
	ALL RECORDS:C47($y_tabla->)
	LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNumTabla;"")
End if 

For ($x;1;Size of array:C274($al_recNumTabla))
	GOTO RECORD:C242($y_tabla->;$al_recNumTabla{$x})
	$l_llaveSubtabla:=Get subrecord key:C1137($y_tablaID_Converter->)
	
	QUERY:C277($y_tableSubtabla->;$y_tablacampoValue->=$t_prefijoValor;*)
	QUERY:C277($y_tableSubtabla->; & ;$y_tablacampoID->=$l_llaveSubtabla)
	
	If (Records in selection:C76($y_tableSubtabla->)=0)
		CREATE RECORD:C68($y_tableSubtabla->)
		$y_tablacampoValue->:=$t_prefijoGuardar
		$y_tablacampoID->:=$l_llaveSubtabla
		SAVE RECORD:C53($y_tableSubtabla->)
	End if 
End for 


