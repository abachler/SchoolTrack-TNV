ARRAY TEXT:C222(aNombRechazo;0)
ARRAY TEXT:C222(aTelDom;0)
ARRAY TEXT:C222(aTelOf;0)
ARRAY TEXT:C222(aCel;0)

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])
If (Size of array:C274(aRUTRechazo)=0)
	AT_RedimArrays (1;->aNombRechazo;->aTelDom;->aTelOf;->aCel;->aRUTRechazo;->aDescRechazo;->aNumTarjetaRe)
Else 
	vLinkingField:=Field:C253(vRUTTable;vRUTField)
	vLinkingTable:=Table:C252(vRUTTable)
	For ($i;1;Size of array:C274(aRUTRechazo))
		AT_Insert (0;1;->aNombRechazo;->aTelDom;->aTelOf;->aCel)
		  //If (al_idAvisoAPagar2{$i}#0)
		If (aIDAvisoRechazo{$i}#0)
			  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Aviso=al_idAvisoAPagar2{$i})
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=Num:C11(aRUTRechazo{$i}))
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		Else 
			If (vLabelLink="ID")
				$vl_valor:=Num:C11(aRUTRechazo{$i})
				$ptr_Id:=->$vl_valor
			Else 
				$vt_valor:=aRUTRechazo{$i}
				$ptr_Id:=->$vt_valor
			End if 
			QUERY:C277(vLinkingTable->;vLinkingField->=$ptr_Id->)
			If (Table:C252(vLinkingTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
			End if 
		End if 
		aNombRechazo{Size of array:C274(aNombRechazo)}:=[Personas:7]Apellidos_y_nombres:30
		aTelDom{Size of array:C274(aTelDom)}:=[Personas:7]Telefono_domicilio:19
		aTelOf{Size of array:C274(aTelOf)}:=[Personas:7]Telefono_profesional:29
		aCel{Size of array:C274(aCel)}:=[Personas:7]Celular:24
	End for 
End if 
If (Size of array:C274(aRUTNoIdentif)=0)
	AT_RedimArrays (1;->aRUTNoIdentif;->aARXTransbankNoIdentif)
End if 
If (Size of array:C274(aRUTDoble)=0)
	AT_RedimArrays (1;->aRUTDoble;->aARXTransbankDoble)
End if 
If (Size of array:C274(aRUTInvalidos)=0)
	AT_RedimArrays (1;->aRUTInvalidos;->aARXTransbankInvalidos)
End if 
If (Size of array:C274(aRUTApdoNoCta)=0)
	AT_RedimArrays (1;->aRUTApdoNoCta;->aARXTransbankApdoNoCta)
End if 
If (Size of array:C274(aMontoCero)=0)
	AT_RedimArrays (1;->aMontoCero)
End if 
If (Size of array:C274(aSinDeuda)=0)
	AT_RedimArrays (1;->aSinDeuda)
End if 


  //20131118 ASM Ticket  126668
  //Genero informe de detalles de Pagos
ARRAY TEXT:C222(atACT_NoPago;0)
ARRAY DATE:C224(adACT_FechaPago;0)
ARRAY TEXT:C222(atACT_FormaDePago;0)
ARRAY TEXT:C222(atACT_MontoDePago;0)
ARRAY TEXT:C222(atACT_GlosaCargo;0)
ARRAY TEXT:C222(atACT_NomApoderado;0)
ARRAY TEXT:C222(atACT_NomAlumno;0)
ARRAY TEXT:C222(atACT_Curso;0)

SORT ARRAY:C229(alACT_RecNumPagosInforme;>)
For ($l_indice;1;Size of array:C274(alACT_RecNumPagosInforme))
	AT_Insert (0;1;->atACT_NoPago;->adACT_FechaPago;->atACT_FormaDePago;->atACT_MontoDePago;->atACT_GlosaCargo;->atACT_NomApoderado;->atACT_NomAlumno;->atACT_Curso)
	GOTO RECORD:C242([ACT_Pagos:172];alACT_RecNumPagosInforme{$l_indice})
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
	QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Pagos:172]ID_Apoderado:3)
	SELECTION TO ARRAY:C260([ACT_Cargos:173]Glosa:12;$at_glosaCargo)
	SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_Alumnos;[Alumnos:2]curso:20;$at_Cursos)
	atACT_NoPago{Size of array:C274(atACT_NoPago)}:=String:C10([ACT_Pagos:172]ID:1)
	adACT_FechaPago{Size of array:C274(adACT_FechaPago)}:=[ACT_Pagos:172]Fecha:2
	atACT_FormaDePago{Size of array:C274(atACT_FormaDePago)}:=[ACT_Pagos:172]forma_de_pago_new:31
	atACT_MontoDePago{Size of array:C274(atACT_MontoDePago)}:=String:C10([ACT_Pagos:172]Monto_Pagado:5;"|Despliegue_ACT")
	atACT_GlosaCargo{Size of array:C274(atACT_GlosaCargo)}:=AT_array2text (->$at_glosaCargo)
	atACT_NomApoderado{Size of array:C274(atACT_NomApoderado)}:=[Personas:7]Apellidos_y_nombres:30
	If (Size of array:C274($at_Alumnos)>1)
		For ($l_indice2;1;Size of array:C274($at_Alumnos))
			atACT_NomAlumno{Size of array:C274(atACT_NomAlumno)}:=$at_Alumnos{$l_indice2}+";"
			atACT_Curso{Size of array:C274(atACT_Curso)}:=$at_Cursos{$l_indice2}+";"
		End for 
	Else 
		If (Size of array:C274($at_Alumnos)=1)
			atACT_NomAlumno{Size of array:C274(atACT_NomAlumno)}:=$at_Alumnos{1}
			atACT_Curso{Size of array:C274(atACT_Curso)}:=$at_Cursos{1}
		End if 
	End if 
End for 
KRL_UnloadReadOnly (->[ACT_Pagos:172])

READ ONLY:C145([xxSTR_Constants:1])
ALL RECORDS:C47([xxSTR_Constants:1])
ONE RECORD SELECT:C189([xxSTR_Constants:1])
FORM SET OUTPUT:C54([xxSTR_Constants:1];"ACTwiz_PrintResultados")
PRINT SELECTION:C60([xxSTR_Constants:1])
FORM SET OUTPUT:C54([xxSTR_Constants:1];"Output")

AT_Initialize (->aNombRechazo;->aTelDom;->aTelOf;->aCel)