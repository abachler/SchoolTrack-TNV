//%attributes = {}
  // XS_GetFieldChoicesArray()
  //
  //
  // creado por: Alberto Bachler Klein: 25-02-16, 10:00:10
  // -----------------------------------------------------------
C_OBJECT:C1216($0)

C_LONGINT:C283($l_campo;$l_tabla)
C_POINTER:C301($y_campo;$y_listaValores;$y_menuLista;$y_variable)
C_TEXT:C284($t_nombreCampoPropio)
C_OBJECT:C1216($ob_opciones)

ARRAY TEXT:C222($at_opciones;0)


If (False:C215)
	C_OBJECT:C1216(XS_GetFieldChoicesArray ;$0)
End if 

$y_campo:=$1
If (Count parameters:C259=2)
	$t_nombreCampoPropio:=$2
Else 
	
End if 

$l_tabla:=Table:C252($y_campo)
$l_campo:=Field:C253($y_campo)

Case of 
	: (($l_campo>0) & ($t_nombreCampoPropio=""))
		$l_tabla:=Table:C252($y_campo)
		$l_campo:=Field:C253($y_campo)
		$l_tipo:=Type:C295($y_campo->)
		
		READ ONLY:C145([xShell_Fields:52])
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$l_tabla;*)
		QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]NumeroCampo:2;=;$l_campo)
		If ([xShell_Fields:52]ListaDeValoresAsociados:11#"")
			Case of 
				: ([xShell_Fields:52]ListaDeValoresAsociados:11="Usuarios")
					COPY ARRAY:C226(<>aUsers;$at_opciones)
				Else 
					$y_listaValores:=Get pointer:C304([xShell_Fields:52]ListaDeValoresAsociados:11)
					COPY ARRAY:C226($y_listaValores->;$at_opciones)
			End case 
			  //OBJECT SET VISIBLE($y_menuLista->;True)
			  //OBJECT SET VISIBLE($y_variable->;False)
			$at_opciones:=0
		Else 
			  //OBJECT SET VISIBLE($y_menuLista->;False)
			  //OBJECT SET VISIBLE($y_variable->;True)
		End if 
		OB SET ARRAY:C1227($ob_opciones;"opciones";$at_opciones)
		
		
	: ($t_nombreCampoPropio#"")
		READ ONLY:C145([xShell_Userfields:76])
		QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]UserFieldName:1=$t_nombreCampoPropio;*)
		QUERY:C277([xShell_Userfields:76]; & ;[xShell_Userfields:76]FileNo:6=$l_tabla;*)
		QUERY:C277([xShell_Userfields:76]; & ;[xShell_Userfields:76]ModuleName:10=vsBWR_CurrentModule)
		If ([xShell_Userfields:76]ListOfValues:4)
			BLOB_Blob2Vars (->[xShell_Userfields:76]xListOfValues:9;0;->$at_opciones)
		End if 
		OB SET ARRAY:C1227($ob_opciones;"opciones";$at_opciones)
		
End case 

$0:=$ob_opciones


  //QRY_UserFieldChoiceList