  // [Familia_RelacionesFamiliares].Input.Variable2()
  // Por: Alberto Bachler: 13/05/13, 17:01:46
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


If (<>aParentesco>0)
	$l_refParentesco:=<>aParentesco
	$t_parentesco:=<>aParentesco{<>aParentesco}
	
	If ((<>aParentesco=1) | (<>aParentesco=2))
		PUSH RECORD:C176([Familia_RelacionesFamiliares:77])
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia_RelacionesFamiliares:77]ID_Familia:2;*)
		QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3#[Familia_RelacionesFamiliares:77]ID_Persona:3;*)
		QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]Tipo_Relación:4=$l_refParentesco)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		POP RECORD:C177([Familia_RelacionesFamiliares:77])
		
		If ($l_registros>0)
			CD_Dlog (0;__ ("La relación familiar ")+$t_parentesco+__ (", ya existe en esta familia y no puede repetirse"))
			<>aParentesco:=0
		End if 
	End if 
	
	
	If (<>aParentesco>0)
		vParentesco:=$t_parentesco
		[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=<>aParentesco
		If ($t_parentesco="Otros")
			[Familia_RelacionesFamiliares:77]Parentesco:6:=""
			OBJECT SET VISIBLE:C603([Familia_RelacionesFamiliares:77]Parentesco:6;True:C214)
			GOTO OBJECT:C206([Familia_RelacionesFamiliares:77]Parentesco:6)
		Else 
			[Familia_RelacionesFamiliares:77]Parentesco:6:=<>aParentesco{<>aParentesco}
			OBJECT SET VISIBLE:C603([Familia_RelacionesFamiliares:77]Parentesco:6;False:C215)
		End if 
	End if 
End if 