//%attributes = {"executedOnServer":true}
  // XSvs_LimpiaRelacionesObsoletas()
  // Por: Alberto Bachler: 13/03/13, 18:42:16
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------


C_BOOLEAN:C305($b_hayRelacion;$b_muchos_a_uno;$b_relacionValida;$b_tablaDestinoEsInvisible;$b_tablaOrigenEsInvisible;$b_uno_a_muchos)
C_LONGINT:C283($i;$l_campoRelacionado;$l_numeroCampoDiscriminante;$l_tablaRelacionada)

ARRAY LONGINT:C221($al_recNumRelaciones;0)
CREATE SET:C116([xShell_Tables_RelatedFiles:243];"Relaciones inválidas")
ALL RECORDS:C47([xShell_Tables_RelatedFiles:243])
LONGINT ARRAY FROM SELECTION:C647([xShell_Tables_RelatedFiles:243];$al_recNumRelaciones)
For ($i;1;Size of array:C274($al_recNumRelaciones))
	READ WRITE:C146([xShell_Tables_RelatedFiles:243])
	GOTO RECORD:C242([xShell_Tables_RelatedFiles:243];$al_recNumRelaciones{$i})
	$b_relacionValida:=False:C215
	If (Is table number valid:C999([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11))
		GET TABLE PROPERTIES:C687([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;$b_tablaOrigenEsInvisible)
		$b_tablaOrigenEsInvisible:=$b_tablaOrigenEsInvisible | (Table name:C256([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11)="zz@") | (Table name:C256([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11)="xShell@") | (Table name:C256([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11)="xx@")
		If (Is table number valid:C999([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1))
			GET TABLE PROPERTIES:C687([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;$b_tablaDestinoEsInvisible)
			$b_tablaDestinoEsInvisible:=$b_tablaDestinoEsInvisible | (Table name:C256([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1)="zz@") | (Table name:C256([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1)="xShell@") | (Table name:C256([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1)="xx@")
			$b_relacionValida:=Is table number valid:C999([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11)
			$b_relacionValida:=$b_relacionValida & Is table number valid:C999([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1)
			$b_relacionValida:=$b_relacionValida & Is field number valid:C1000([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)
			$b_relacionValida:=$b_relacionValida & Is field number valid:C1000([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4)
			$b_relacionValida:=$b_relacionValida & Not:C34($b_tablaOrigenEsInvisible | $b_tablaDestinoEsInvisible)
		End if 
	End if 
	If ($b_relacionValida)
		If (Type:C295(Field:C253([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)->)#Is subtable:K8:11)
			If (Type:C295(Field:C253([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)->)=Type:C295(Field:C253([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4)->))
				GET RELATION PROPERTIES:C686([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3;$l_tablaRelacionada;$l_campoRelacionado;$l_numeroCampoDiscriminante;$b_muchos_a_uno;$b_uno_a_muchos)
				$b_hayRelacion:=($l_tablaRelacionada>0)
				GET RELATION PROPERTIES:C686([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4;$l_tablaRelacionada;$l_campoRelacionado;$l_numeroCampoDiscriminante;$b_muchos_a_uno;$b_uno_a_muchos)
				$b_hayRelacion:=$b_hayRelacion | ($l_tablaRelacionada>0)
				If (Not:C34($b_hayRelacion))
					[xShell_Tables_RelatedFiles:243]TipoRelacion:9:="Relacion por código"
				End if 
				SAVE RECORD:C53([xShell_Tables_RelatedFiles:243])
			Else 
				[xShell_Tables_RelatedFiles:243]OrigenRelacion_NombreCampo:16:="["+Table name:C256([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11)+"]"+Field name:C257([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)
				[xShell_Tables_RelatedFiles:243]TipoRelacion:9:="Tipos incompatibles"
				SAVE RECORD:C53([xShell_Tables_RelatedFiles:243])
				ADD TO SET:C119([xShell_Tables_RelatedFiles:243];"Relaciones inválidas")
			End if 
		Else 
			[xShell_Tables_RelatedFiles:243]OrigenRelacion_NombreCampo:16:="["+Table name:C256([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11)+"]"+Field name:C257([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)
			[xShell_Tables_RelatedFiles:243]TipoRelacion:9:="Subtabla"
			SAVE RECORD:C53([xShell_Tables_RelatedFiles:243])
			ADD TO SET:C119([xShell_Tables_RelatedFiles:243];"Relaciones inválidas")
		End if 
	Else 
		[xShell_Tables_RelatedFiles:243]OrigenRelacion_NombreCampo:16:="["+Table name:C256([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11)+"]"+Field name:C257([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)
		[xShell_Tables_RelatedFiles:243]TipoRelacion:9:="Relacion Inválida"
		SAVE RECORD:C53([xShell_Tables_RelatedFiles:243])
		ADD TO SET:C119([xShell_Tables_RelatedFiles:243];"Relaciones inválidas")
	End if 
End for 
KRL_UnloadReadOnly (->[xShell_Tables_RelatedFiles:243])

USE SET:C118("Relaciones inválidas")
KRL_DeleteSelection (->[xShell_Tables_RelatedFiles:243])

