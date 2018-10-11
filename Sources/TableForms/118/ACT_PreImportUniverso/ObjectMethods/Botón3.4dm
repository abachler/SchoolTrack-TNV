ARRAY TEXT:C222(aTelDom;0)
ARRAY TEXT:C222(aTelOf;0)
ARRAY TEXT:C222(aCel;0)

READ ONLY:C145([Personas:7])
If (Size of array:C274(at_rutExApdoPAC)=0)
	AT_RedimArrays (1;->at_rutExApdoPAC;->at_nombreExApdoPAC;->aTelOf;->aTelDom;->aCel)
Else 
	For ($i;1;Size of array:C274(at_rutExApdoPAC))
		AT_Insert (0;1;->aTelDom;->aTelOf;->aCel)
		QUERY:C277([Personas:7];[Personas:7]RUT:6=Replace string:C233(Replace string:C233(at_rutExApdoPAC{$i};".";"");"-";""))
		aTelDom{Size of array:C274(aTelDom)}:=[Personas:7]Telefono_domicilio:19
		aTelOf{Size of array:C274(aTelOf)}:=[Personas:7]Telefono_profesional:29
		aCel{Size of array:C274(aCel)}:=[Personas:7]Celular:24
	End for 
End if 
If (Size of array:C274(at_rutNoIdentificados)=0)
	AT_RedimArrays (1;->at_rutNoIdentificados)
End if 
If (Size of array:C274(at_rutMasDeUnaPersona)=0)
	AT_RedimArrays (1;->at_rutMasDeUnaPersona)
End if 
If (Size of array:C274(at_rutInvalido)=0)
	AT_RedimArrays (1;->at_rutInvalido)
End if 
If (Size of array:C274(at_rutNoApoCta)=0)
	AT_RedimArrays (1;->at_rutNoApoCta)
End if 

READ ONLY:C145([xxACT_ArchivosBancarios:118])
ALL RECORDS:C47([xxACT_ArchivosBancarios:118])
ONE RECORD SELECT:C189([xxACT_ArchivosBancarios:118])
FORM SET OUTPUT:C54([xxACT_ArchivosBancarios:118];"PrintPreImportUniverso")
PRINT SELECTION:C60([xxACT_ArchivosBancarios:118])
FORM SET OUTPUT:C54([xxACT_ArchivosBancarios:118];"Output")

AT_Initialize (->aTelDom;->aTelOf;->aCel)