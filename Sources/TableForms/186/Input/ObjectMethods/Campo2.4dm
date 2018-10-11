Case of 
	: (Form event:C388=On Losing Focus:K2:8)
		
		
	: (Form event:C388=On Data Change:K2:15)
		If ((Is new record:C668([MPA_DefinicionAreas:186])) & ([MPA_DefinicionAreas:186]AreaAsignatura:4=""))
			  // nada, el usuario había dado un nombre al área y luego lo borra
		Else 
			If (MPAcfg_Area_EsValida )
				If ((Self:C308->#Old:C35(Self:C308->)) & (Size of array:C274(atMPA_AsignaturasArea)>0))
					QUERY WITH ARRAY:C644([xxSTR_Materias:20]Materia:2;atMPA_AsignaturasArea)
					ARRAY TEXT:C222($at_nombreArea;Records in selection:C76([xxSTR_Materias:20]))
					AT_Populate (->$at_nombreArea;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
					$l_transaccionOK:=KRL_Array2Selection (->$at_nombreArea;->[xxSTR_Materias:20]AreaMPA:4)
					If ($l_transaccionOK=1)
						MPAcfg_Area_AlGuardar 
						SAVE RECORD:C53([MPA_DefinicionAreas:186])
					End if 
				End if 
				SET WINDOW TITLE:C213(__ ("Area de Aprendizaje: ")+[MPA_DefinicionAreas:186]AreaAsignatura:4)
			End if 
		End if 
		
	: (Form event:C388=On After Keystroke:K2:26)
		[MPA_DefinicionAreas:186]AreaAsignatura:4:=Get edited text:C655
		SET WINDOW TITLE:C213(__ ("Area de Aprendizaje: ")+Get edited text:C655)
		If ([MPA_DefinicionAreas:186]AreaAsignatura:4#"")
			OBJECT SET VISIBLE:C603(*;"ot_MensajeEntrada";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"ot_MensajeEntrada";True:C214)
		End if 
		
End case 