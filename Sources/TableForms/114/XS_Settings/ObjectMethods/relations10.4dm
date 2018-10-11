  // [xShell_Dialogs].XS_Settings.relations10()
  // Por: Alberto Bachler: 13/03/13, 19:00:36
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_muchos_a_uno;$b_relacionValida;$b_tablaDestinoEsInvisible;$b_tablaOrigenEsInvisible;$b_uno_a_muchos)
C_LONGINT:C283($l_campoRelacionado;$l_numeroCampoDiscriminante;$l_tablaRelacionada)


C_POINTER:C301(vy_RelationSource;vy_RelationDestination)

If ((Type:C295(vy_RelationSource->))=(Type:C295(vy_RelationDestination->)))
	GET TABLE PROPERTIES:C687(Table:C252(vy_RelationSource);$b_tablaOrigenEsInvisible)
	$b_tablaOrigenEsInvisible:=$b_tablaOrigenEsInvisible | (Table name:C256(Table:C252(vy_RelationSource))="zz@") | (Table name:C256(Table:C252(vy_RelationSource))="xShell@") | (Table name:C256(Table:C252(vy_RelationSource))="xx@")
	GET TABLE PROPERTIES:C687(Table:C252(vy_RelationDestination);$b_tablaDestinoEsInvisible)
	$b_tablaDestinoEsInvisible:=$b_tablaDestinoEsInvisible | (Table name:C256(Table:C252(vy_RelationDestination))="zz@") | (Table name:C256(Table:C252(vy_RelationDestination))="xShell@") | (Table name:C256(Table:C252(vy_RelationDestination))="xx@")
	$b_relacionValida:=Is table number valid:C999(Table:C252(vy_RelationSource))
	$b_relacionValida:=$b_relacionValida & Is table number valid:C999(Table:C252(vy_RelationDestination))
	$b_relacionValida:=$b_relacionValida & Is field number valid:C1000(Table:C252(vy_RelationSource);Field:C253(vy_RelationSource))
	$b_relacionValida:=$b_relacionValida & Is field number valid:C1000(Table:C252(vy_RelationDestination);Field:C253(vy_RelationDestination))
	$b_relacionValida:=$b_relacionValida & Not:C34($b_tablaOrigenEsInvisible | $b_tablaDestinoEsInvisible)
	
	If ($b_relacionValida)
		GET RELATION PROPERTIES:C686(vy_RelationSource;$l_tablaRelacionada;$l_campoRelacionado;$l_numeroCampoDiscriminante;$b_muchos_a_uno;$b_uno_a_muchos)
		CREATE RECORD:C68([xShell_Tables_RelatedFiles:243])
		[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11:=Table:C252(vy_RelationSource)
		[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3:=Field:C253(vy_RelationSource)
		[xShell_Tables_RelatedFiles:243]DestinoRelacion_NombreTabla:2:=Table name:C256(vy_RelationDestination)
		[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1:=Table:C252(vy_RelationDestination)
		[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4:=Field:C253(vy_RelationDestination)
		[xShell_Tables_RelatedFiles:243]DestinoRelacion_NombreCampo:8:=Field name:C257(vy_RelationDestination)
		Case of 
			: ($b_muchos_a_uno | $b_uno_a_muchos)
				[xShell_Tables_RelatedFiles:243]TipoRelacion:9:="Auto bidereccional"
			: ($b_muchos_a_uno)
				[xShell_Tables_RelatedFiles:243]TipoRelacion:9:="Auto N a 1"
			: ($b_uno_a_muchos)
				[xShell_Tables_RelatedFiles:243]TipoRelacion:9:="Auto 1 a N"
			Else 
				[xShell_Tables_RelatedFiles:243]TipoRelacion:9:="Manual"
		End case 
		SAVE RECORD:C53([xShell_Tables_RelatedFiles:243])
		KRL_UnloadReadOnly (->[xShell_Tables_RelatedFiles:243])
		VS_RelationsALPsettings (Table:C252(vy_RelationSource))
	End if 
End if 