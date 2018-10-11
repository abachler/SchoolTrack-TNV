If (<>aParentesco>0)
	vparentesco:=<>aParentesco{<>aParentesco}
	
	PUSH RECORD:C176([Familia_RelacionesFamiliares:77])
	
	QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia_RelacionesFamiliares:77]ID_Familia:2)
	SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]Tipo_Relación:4;$al_TRelacion;[Familia_RelacionesFamiliares:77];$rns)
	
	POP RECORD:C177([Familia_RelacionesFamiliares:77])
	
	$fia:=Find in array:C230($al_TRelacion;<>aParentesco)
	C_BOOLEAN:C305($vb_Padres)
	$vb_Padres:=True:C214
	
	If (((<>aParentesco=1) | (<>aParentesco=2)) & ($fia>0))
		If (Record number:C243([Familia_RelacionesFamiliares:77])#$rns{$fia})
			CD_Dlog (0;__ ("La relación familiar ")+vparentesco+__ (", ya existe en esta familia y no puede repetirse."))
			$vb_Padres:=False:C215
			<>aParentesco:=[Familia_RelacionesFamiliares:77]Tipo_Relación:4
			vParentesco:=""
		End if 
	End if 
	
	If ($vb_Padres)
		[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=<>aParentesco
		If (<>aParentesco{<>aParentesco}="Otros")
			[Familia_RelacionesFamiliares:77]Parentesco:6:=""
			OBJECT SET VISIBLE:C603([Familia_RelacionesFamiliares:77]Parentesco:6;True:C214)
			OBJECT MOVE:C664(<>aParentesco;87;33;267;50;*)
			GOTO OBJECT:C206([Familia_RelacionesFamiliares:77]Parentesco:6)
		Else 
			[Familia_RelacionesFamiliares:77]Parentesco:6:=<>aParentesco{<>aParentesco}
			OBJECT MOVE:C664(<>aParentesco;87;33;504;50;*)
			OBJECT SET VISIBLE:C603([Familia_RelacionesFamiliares:77]Parentesco:6;False:C215)
		End if 
		
	End if 
	
End if 