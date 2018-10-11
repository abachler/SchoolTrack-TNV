//%attributes = {"executedOnServer":true}
  // XSvs_ActualizaRelaciones()
  // Por: Alberto Bachler: 07/03/13, 12:20:26
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)

C_BOOLEAN:C305($b_muchos_a_uno;$b_uno_a_muchos)
C_LONGINT:C283($l_campoRelacion_1aN;$l_campoRelacionado;$l_numeroCampo;$l_numeroCampoDiscriminante;$l_numeroTabla;$l_tablaRelacion_1aN;$l_tablaRelacionada)
C_POINTER:C301($y_campo)
C_TEXT:C284($t_llaveTablaPrincipal;$t_llaveTablaRelacionada)

If (False:C215)
	C_POINTER:C301(XSvs_ActualizaRelaciones ;$1)
End if 

$y_campo:=$1
$l_numeroTabla:=Table:C252($y_Campo)
$l_numeroCampo:=Field:C253($y_campo)
$l_tipoCampo:=Type:C295($y_campo->)
GET TABLE PROPERTIES:C687($l_numeroTabla;$b_tablaOrigenEsInvisible)

If ($l_numeroTabla=Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
	
End if 

If ($l_tipoCampo#Is subtable:K8:11)
	GET RELATION PROPERTIES:C686($l_numeroTabla;$l_numeroCampo;$l_tablaRelacionada;$l_campoRelacionado;$l_numeroCampoDiscriminante;$b_muchos_a_uno;$b_uno_a_muchos)
	GET TABLE PROPERTIES:C687($l_numeroTabla;$b_tablaDestinoEsInvisible)
	If (($l_tablaRelacionada>0) & (Not:C34($b_tablaDestinoEsInvisible | $b_tablaOrigenEsInvisible)))
		READ WRITE:C146([xShell_Tables_RelatedFiles:243])
		[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11:=$l_numeroTabla
		[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3:=$l_numeroCampo
		$t_llaveTablaPrincipal:=KRL_MakeStringAccesKey (->$l_numeroTabla;->$l_numeroCampo)
		$t_llaveTablaRelacionada:=KRL_MakeStringAccesKey (->$l_tablaRelacionada;->$l_campoRelacionado)
		QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_RefTablaCampo:12=$t_llaveTablaPrincipal;*)
		QUERY:C277([xShell_Tables_RelatedFiles:243]; & ;[xShell_Tables_RelatedFiles:243]DestinoRelacion_RefTablaCampo:13=$t_llaveTablaRelacionada)
		If (Records in selection:C76([xShell_Tables_RelatedFiles:243])=0)
			CREATE RECORD:C68([xShell_Tables_RelatedFiles:243])
			[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11:=$l_numeroTabla
			[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3:=$l_numeroCampo
		End if 
		[xShell_Tables_RelatedFiles:243]OrigenRelacion_NombreCampo:16:="["+Table name:C256($l_numeroTabla)+"]"+Field name:C257($l_numeroTabla;$l_numeroCampo)
		[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1:=$l_tablaRelacionada
		[xShell_Tables_RelatedFiles:243]DestinoRelacion_NombreTabla:2:=Table name:C256($l_tablaRelacionada)
		[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4:=$l_campoRelacionado
		[xShell_Tables_RelatedFiles:243]DestinoRelacion_NombreCampo:8:="["+Table name:C256($l_tablaRelacionada)+"]"+Field name:C257([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4)
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
		
		
		  // creo un registro para la relacion inversa
		$l_tablaRelacion_1aN:=$l_numeroTabla
		$l_campoRelacion_1aN:=$l_numeroCampo
		$t_llaveTablaPrincipal:=KRL_MakeStringAccesKey (->$l_tablaRelacionada;->$l_campoRelacionado)
		$t_llaveTablaRelacionada:=KRL_MakeStringAccesKey (->$l_tablaRelacion_1aN;->$l_campoRelacion_1aN)
		QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_RefTablaCampo:12=$t_llaveTablaPrincipal;*)
		QUERY:C277([xShell_Tables_RelatedFiles:243]; & ;[xShell_Tables_RelatedFiles:243]DestinoRelacion_RefTablaCampo:13=$t_llaveTablaRelacionada)
		If (Records in selection:C76([xShell_Tables_RelatedFiles:243])=0)
			CREATE RECORD:C68([xShell_Tables_RelatedFiles:243])
			[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11:=$l_numeroTabla
			[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3:=$l_numeroCampo
		End if 
		[xShell_Tables_RelatedFiles:243]OrigenRelacion_NombreCampo:16:="["+Table name:C256($l_numeroTabla)+"]"+Field name:C257($l_numeroTabla;$l_numeroCampo)
		[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1:=$l_tablaRelacion_1aN
		[xShell_Tables_RelatedFiles:243]DestinoRelacion_NombreTabla:2:=Table name:C256($l_tablaRelacion_1aN)
		[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4:=$l_campoRelacion_1aN
		[xShell_Tables_RelatedFiles:243]DestinoRelacion_NombreCampo:8:="["+Table name:C256($l_tablaRelacion_1aN)+"]"+Field name:C257($l_tablaRelacion_1aN;$l_campoRelacion_1aN)
		[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11:=$l_tablaRelacionada
		[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3:=$l_campoRelacionado
		[xShell_Tables_RelatedFiles:243]TipoRelacion:9:="Relacion inversa (código)"
		SAVE RECORD:C53([xShell_Tables_RelatedFiles:243])
	End if 
	KRL_UnloadReadOnly (->[xShell_Tables_RelatedFiles:243])
Else 
End if 
