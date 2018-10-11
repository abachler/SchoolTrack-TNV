Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vMsg:=""
	: (Form event:C388=On Data Change:K2:15)
		If (vsPST_Persona="mother")
			$oldRUT:=vsPST_CodMOTHER
			$NoPersona:=vlPST_IDMOTHER
		Else 
			$oldRUT:=vsPST_CodFATHER
			$NoPersona:=vlPST_IDFATHER
		End if 
		vMsg:=""
		If (Self:C308->#"")
			SET QUERY LIMIT:C395(1)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
			QUERY:C277([Personas:7];[Personas:7]Codigo_interno:22=Self:C308->;*)
			QUERY:C277([Personas:7]; & ;[Personas:7]No:1#$NoPersona)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			SET QUERY LIMIT:C395(0)
			If ($recs>0)
				BEEP:C151
				vMsg:="Error: Ya existe una persona con el mismo Código Interno."
				OK:=0
				Self:C308->:=$oldRUT
				GOTO OBJECT:C206(Self:C308->)
			End if 
		End if 
End case 