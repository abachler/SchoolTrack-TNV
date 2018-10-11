//%attributes = {}
  // Método: QRY_CreaMenuCampos
  // 
  // 
  // por Alberto Bachler Klein
  // creado por: Alberto Bachler Klein: 19-02-16, 18:12:22
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($b_tablaAccesible)
C_LONGINT:C283($i_campos;$i_subcampos;$l_numeroTabla;$i)
C_POINTER:C301($y_menuRef)
C_TEXT:C284($t_aliasCampo;$t_menuCamposTabla;$t_menuRef;$t_nombreTabla)

ARRAY BOOLEAN:C223($ab_CampoIndexado;0)
ARRAY INTEGER:C220($ai_campoRelacionado_Destino;0)
ARRAY INTEGER:C220($ai_campoRelacionado_Origen;0)
ARRAY LONGINT:C221($al_numeroCampoPropio;0)
ARRAY LONGINT:C221($al_numeroCampos;0)
ARRAY INTEGER:C220($ai_TablaRelacionada;0)
ARRAY TEXT:C222($at_nombreCampoPropio;0)
ARRAY TEXT:C222($at_nombreCampos;0)
ARRAY TEXT:C222($at_nombreTablasRelacionadas;0)

$l_numeroTabla:=Table:C252(vyQRY_TablePointer)


$t_menuRef:=Create menu:C408
$t_menuCamposTabla:=Create menu:C408

GET TABLE TITLES:C803($at_NombreTablas;$al_numeroTablas)


  // construyo el submenu para la tabla principal
GET FIELD TITLES:C804(Table:C252($l_numeroTabla)->;$at_nombreCampos;$al_numeroCampos)
ARRAY BOOLEAN:C223($ab_CampoIndexado;Size of array:C274($al_numeroCampos))
For ($i;1;Size of array:C274($al_numeroCampos))
	$ab_CampoIndexado{$i}:=KRL_IsFieldIndexed (Field:C253($l_numeroTabla;$al_numeroCampos{$i}))
	  //$at_nombreCampos:=$at_nombreCampos{$i}
	  // Modificado por: Saúl Ponce (27-03-2018) Ticket 202323, mostrar el nombre de la estructura virtual en lugar del nombre del campo.
	$at_nombreCampos{$i}:=XSvs_nombreCampoLocal_puntero (Field:C253($l_numeroTabla;$al_numeroCampos{$i});<>vtXS_CountryCode;<>vtXS_langage;False:C215)
	$at_nombreCampos{$i}:=Replace string:C233($at_nombreCampos{$i};"...";" – ")
	$at_nombreCampos{$i}:=Replace string:C233($at_nombreCampos{$i};"..";" – ")
	$at_nombreCampos{$i}:=Replace string:C233($at_nombreCampos{$i};".";" – ")
	$at_nombreCampos{$i}:=Replace string:C233($at_nombreCampos{$i};"(";"[")
	$at_nombreCampos{$i}:=Replace string:C233($at_nombreCampos{$i};")";"]")
End for 
SORT ARRAY:C229($at_nombreCampos;$al_numeroCampos;$ab_CampoIndexado;>)
For ($i;1;Size of array:C274($at_nombreCampos))
	MNU_Append ($t_menuCamposTabla;$at_nombreCampos{$i};String:C10($l_numeroTabla)+"."+String:C10($al_numeroCampos{$i})+"."+$at_nombreCampos{$i})
	If ($ab_CampoIndexado{$i})
		SET MENU ITEM STYLE:C425($t_menuCamposTabla;-1;Bold:K14:2)
	End if 
End for 

QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FileNo:6=$l_numeroTabla;*)
QUERY:C277([xShell_Userfields:76]; & ;[xShell_Userfields:76]ModuleName:10=<>vsXS_CurrentModule)
If (Records in selection:C76([xShell_Userfields:76])>0)
	MNU_Append ($t_menuCamposTabla;"(-")
	SELECTION TO ARRAY:C260([xShell_Userfields:76]UserFieldName:1;$at_nombreCampoPropio;[xShell_Userfields:76]FieldID:7;$al_numeroCampoPropio)
	For ($i;1;Size of array:C274($al_numeroCampoPropio))
		MNU_Append ($t_menuCamposTabla;$at_nombreCampoPropio{$i};String:C10($l_numeroTabla)+"."+String:C10(-7)+"."+$at_nombreCampoPropio{$i})
	End for 
End if 

  // agrego la lista de campos de la tabla principal al menu maestro
$t_NombreTabla:=$at_NombreTablas{Find in array:C230($al_numeroTablas;$l_numeroTabla)}
APPEND MENU ITEM:C411($t_menuRef;$t_nombreTabla;$t_menuCamposTabla)
MNU_Append ($t_menuRef;"(-")

  // agrego al menu maestro las tablas y campos relacionados
$b_tablaAccesible:=True:C214
READ ONLY:C145([xShell_Tables_RelatedFiles:243])
QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11=Table:C252(vyQRY_TablePointer))
SELECTION TO ARRAY:C260([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;$ai_TablaRelacionada;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3;$ai_campoRelacionado_Origen;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4;$ai_campoRelacionado_Destino)
AT_Initialize (->$at_nombreTablasRelacionadas)
For ($i;1;Size of array:C274($ai_TablaRelacionada))
	APPEND TO ARRAY:C911($at_nombreTablasRelacionadas;Table name:C256($ai_TablaRelacionada{$i}))
End for 

For ($i;Size of array:C274($ai_TablaRelacionada);1;-1)
	$l_index:=Find in array:C230($al_numeroTablas;$ai_TablaRelacionada{$i})
	  //If ($l_index>0)
	  //APPEND TO ARRAY($at_nombreTablasRelacionadas;$at_NombreTablas{$l_index})
	  //Else 
	  //AT_Delete ($i;1;->$ai_TablaRelacionada;->$ai_campoRelacionado_Origen;->$ai_campoRelacionado_Destino;->$at_nombreTablasRelacionadas)
	  //End if 
	If ($l_index=-1)
		AT_Delete ($i;1;->$ai_TablaRelacionada;->$ai_campoRelacionado_Origen;->$ai_campoRelacionado_Destino;->$at_nombreTablasRelacionadas)
	End if 
End for 
SORT ARRAY:C229($at_nombreTablasRelacionadas;$ai_TablaRelacionada;$ai_campoRelacionado_Origen;$ai_campoRelacionado_Destino;>)

For ($i;1;Size of array:C274($ai_TablaRelacionada))
	$t_menuCamposTabla:=Create menu:C408
	$t_nombreTabla:=$at_nombreTablasRelacionadas{$i}
	If ($t_nombreTabla#"") & (Is table number valid:C999($ai_TablaRelacionada{$i}))
		If (USR_checkRights ("L";Table:C252($ai_TablaRelacionada{$i})))
			GET FIELD TITLES:C804(Table:C252($ai_TablaRelacionada{$i})->;$at_nombreCampos;$al_numeroCampos)
			
			  //MONO 205211:Por ahora voy a excluir a los campos tipo blob y objeto.
			For ($i_campos;Size of array:C274($al_numeroCampos);1;-1)
				$y_relatedField:=Field:C253($ai_TablaRelacionada{$i};$al_numeroCampos{$i_campos})
				If ((Type:C295($y_relatedField->)=Is BLOB:K8:12) | (Type:C295($y_relatedField->)=Is object:K8:27))
					AT_Delete ($i_campos;1;->$at_nombreCampos;->$al_numeroCampos)
				End if 
			End for 
			
			AT_Initialize (->$ab_CampoIndexado)
			ARRAY BOOLEAN:C223($ab_CampoIndexado;Size of array:C274($al_numeroCampos))
			For ($i_campos;1;Size of array:C274($al_numeroCampos))
				  //$at_nombreCampos{0}:=$at_nombreCampos{$i_campos}
				  // Modificado por: Saúl Ponce (27-03-2018) Ticket 202323, mostrar el nombre de la estructura virtual en lugar del nombre del campo.
				$at_nombreCampos{$i_campos}:=XSvs_nombreCampoLocal_puntero (Field:C253($ai_TablaRelacionada{$i};$al_numeroCampos{$i_campos});<>vtXS_CountryCode;<>vtXS_langage;False:C215)
				$at_nombreCampos{$i_campos}:=Replace string:C233($at_nombreCampos{$i_campos};"...";" – ")
				$at_nombreCampos{$i_campos}:=Replace string:C233($at_nombreCampos{$i_campos};"..";" – ")
				$at_nombreCampos{$i_campos}:=Replace string:C233($at_nombreCampos{$i_campos};".";" – ")
				$at_nombreCampos{$i_campos}:=Replace string:C233($at_nombreCampos{$i_campos};"(";"[")
				$at_nombreCampos{$i_campos}:=Replace string:C233($at_nombreCampos{$i_campos};")";"]")
				$ab_CampoIndexado{$i_campos}:=KRL_IsFieldIndexed (Field:C253($ai_TablaRelacionada{$i};$al_numeroCampos{$i_campos}))
			End for 
			SORT ARRAY:C229($at_nombreCampos;$al_numeroCampos;$ab_CampoIndexado;>)
			For ($i_campos;1;Size of array:C274($at_nombreCampos))
				MNU_Append ($t_menuCamposTabla;$at_nombreCampos{$i_campos};String:C10($ai_TablaRelacionada{$i})+"."+String:C10($al_numeroCampos{$i_campos})+"."+$at_nombreCampos{$i_campos})
				If ($ab_CampoIndexado{$i_campos})
					SET MENU ITEM STYLE:C425($t_menuCamposTabla;-1;Bold:K14:2)
				End if 
			End for 
			QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FileNo:6=$ai_TablaRelacionada{$i};*)
			QUERY:C277([xShell_Userfields:76]; & ;[xShell_Userfields:76]ModuleName:10=<>vsXS_CurrentModule)
			If (Records in selection:C76([xShell_Userfields:76])>0)
				MNU_Append ($t_menuCamposTabla;"(-")
				SELECTION TO ARRAY:C260([xShell_Userfields:76]UserFieldName:1;$at_nombreCampoPropio;[xShell_Userfields:76]FieldID:7;$al_numeroCampoPropio)
				For ($i_subcampos;1;Size of array:C274($al_numeroCampoPropio))
					MNU_Append ($t_menuCamposTabla;$at_nombreCampoPropio{$i_subcampos};String:C10($ai_TablaRelacionada{$i})+"."+String:C10(-7)+"."+$at_nombreCampoPropio{$i_subcampos})
				End for 
			End if 
			APPEND MENU ITEM:C411($t_menuRef;$t_nombreTabla;$t_menuCamposTabla)
		Else 
			$b_tablaAccesible:=False:C215
		End if 
	End if 
End for 
$y_menuRef:=OBJECT Get pointer:C1124(Object named:K67:5;"refMenuCampos")
$y_menuRef->:=$t_menuRef