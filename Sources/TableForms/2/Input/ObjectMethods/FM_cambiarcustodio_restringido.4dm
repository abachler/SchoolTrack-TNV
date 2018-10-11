READ ONLY:C145([Personas:7])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24;*)
QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3#0)
ORDER BY:C49([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]Tipo_Relación:4;>)
SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]Parentesco:6;aParentescoCust;[Personas:7]Apellidos_y_nombres:30;aRelNameCust;[Personas:7]No:1;aPersIDCust)
If (Size of array:C274(aParentescoCust)>0)
	ARRAY POINTER:C280(<>aChoicePtrs;0)
	ARRAY POINTER:C280(<>aChoicePtrs;3)
	<>aChoicePtrs{1}:=->aParentescoCust
	<>aChoicePtrs{2}:=->aRelNameCust
	<>aChoicePtrs{3}:=->aPersIDCust
	TBL_ShowChoiceList (1;"Seleccione la relación familiar";1;Self:C308)
	If (ok=1)
		$rn:=Find in field:C653([Personas:7]No:1;aPersIDCust{choiceIdx})
		If ($rn#-1)
			GOTO RECORD:C242([Personas:7];$rn)
			$rn:=Find in field:C653([Familia_RelacionesFamiliares:77]ID_Persona:3;[Personas:7]No:1)
			If ($rn#-1)
				GOTO RECORD:C242([Familia_RelacionesFamiliares:77];$rn)
				vCustTipo:=[Familia_RelacionesFamiliares:77]Parentesco:6
				vCustNombres:=[Personas:7]Apellidos_y_nombres:30
				vCustCel:=[Personas:7]Celular:24
				vCustCasa:=[Personas:7]Telefono_domicilio:19
				[Alumnos:2]ID_Custodio:99:=[Personas:7]No:1
				SAVE RECORD:C53([Alumnos:2])
			Else 
				BEEP:C151
				vCustTipo:=""
				vCustNombres:=""
				vCustCel:=""
				vCustCasa:=""
			End if 
		Else 
			BEEP:C151
			vCustTipo:=""
			vCustNombres:=""
			vCustCel:=""
			vCustCasa:=""
		End if 
	Else 
		Self:C308->:=0
	End if 
Else 
	Self:C308->:=0
End if 