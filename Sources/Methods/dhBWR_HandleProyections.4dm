//%attributes = {}
  //dhBWR_HandleProyections
  //20111122 AS. agregue una validación para que no se muestren los alumnos retirados, a menos que se mantenga presionada la tecla Alt.
If (False:C215)
	<>xShellModificationDate:=!1903-05-20!
	  // 
End if 
C_LONGINT:C283($1;$line)
C_POINTER:C301($newTable)

$line:=$1
USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))

Case of 
	: (<>vsXS_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Asignaturas:18]))
				Case of 
					: ($line=1)
						$newTable:=->[Alumnos:2]
						KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
						QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
						KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
					: ($line=2)
						KRL_RelateSelection (->[Profesores:4]Numero:1;->[Asignaturas:18]profesor_numero:4;"")
						$newTable:=->[Profesores:4]
					: ($line=3)
						KRL_RelateSelection (->[Cursos:3]Curso:1;->[Asignaturas:18]Curso:5;"")
						$newTable:=->[Cursos:3]
					: ($line=4)
						  //         
				End case 
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
				Case of 
					: ($line=1)
						$newTable:=->[Familia:78]
						KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
					: ($line=2)
						KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Alumnos:2]Familia_Número:24;"")
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
						$newTable:=->[Personas:7]
					: ($line=3)
						KRL_RelateSelection (->[Personas:7]No:1;->[Alumnos:2]Apoderado_académico_Número:27;"")
						$newTable:=->[Personas:7]
					: ($line=4)
						KRL_RelateSelection (->[Personas:7]No:1;->[Alumnos:2]Apoderado_Cuentas_Número:28;"")
						$newTable:=->[Personas:7]
					: ($line=5)
						KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Padre_Número:5;"")
						CREATE SET:C116([Personas:7];"padres")
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Madre_Número:6;"")
						CREATE SET:C116([Personas:7];"madres")
						UNION:C120("madres";"padres";"padres")
						USE SET:C118("padres")
						CLEAR SET:C117("padres")
						CLEAR SET:C117("madres")
						$newTable:=->[Personas:7]
					: ($line=6)
						KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Padre_Número:5;"")
						$newTable:=->[Personas:7]
					: ($line=7)
						KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Madre_Número:6;"")
						$newTable:=->[Personas:7]
					: ($line=8)
						KRL_RelateSelection (->[Cursos:3]Curso:1;->[Alumnos:2]curso:20;"")
						$newTable:=->[Cursos:3]
					: ($line=9)
						$newTable:=->[Asignaturas:18]
						
						KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
						QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
						KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
						
				End case 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78]))
				Case of 
					: ($line=1)
						$newTable:=->[Alumnos:2]
						KRL_RelateSelection (->[Alumnos:2]Familia_Número:24;->[Familia:78]Numero:1;"")
						If (Not:C34(IT_AltKeyIsDown ))
							QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Ret@";*)
							QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29#Nivel_Retirados)
						End if 
						
					: ($line=2)
						KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Numero:1;"")
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
						$newTable:=->[Personas:7]
					: ($line=3)
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Padre_Número:5;"")
						CREATE SET:C116([Personas:7];"padres")
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Madre_Número:6;"")
						CREATE SET:C116([Personas:7];"madres")
						UNION:C120("madres";"padres";"padres")
						USE SET:C118("padres")
						CLEAR SET:C117("padres")
						CLEAR SET:C117("madres")
						$newTable:=->[Personas:7]
					: ($line=4)
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Padre_Número:5;"")
						$newTable:=->[Personas:7]
					: ($line=5)
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Madre_Número:6;"")
						$newTable:=->[Personas:7]
					: ($line=6)  // cursos
						$newTable:=->[Cursos:3]
						KRL_RelateSelection (->[Alumnos:2]Familia_Número:24;->[Familia:78]Numero:1;"")
						
						If (Not:C34(IT_AltKeyIsDown ))
							QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Ret@";*)
							QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29#Nivel_Retirados)
						End if 
						
						KRL_RelateSelection (->[Cursos:3]Curso:1;->[Alumnos:2]curso:20;"")
						
					: ($line=7)  // asignaturas
						$newTable:=->[Asignaturas:18]
						KRL_RelateSelection (->[Alumnos:2]Familia_Número:24;->[Familia:78]Numero:1;"")
						
						If (Not:C34(IT_AltKeyIsDown ))
							QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Ret@";*)
							QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29#Nivel_Retirados)
						End if 
						
						KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
						QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
						KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
						
				End case 
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
				Case of 
					: ($line=1)
						$newTable:=->[Alumnos:2]
						KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Persona:3;->[Personas:7]No:1;"")
						KRL_RelateSelection (->[Alumnos:2]Familia_Número:24;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
						If (Not:C34(IT_AltKeyIsDown ))
							QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Ret@";*)
							QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29#Nivel_Retirados)
						End if 
						
					: ($line=2)
						KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Persona:3;->[Personas:7]No:1;"")
						KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
						$newTable:=->[Familia:78]
					: ($line=3)
						  //        
					: ($line=4)
						  //         
				End case 
				
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4]))
				Case of 
					: ($line=1)
						$newTable:=->[Asignaturas:18]
						KRL_RelateSelection (->[Asignaturas:18]profesor_numero:4;->[Profesores:4]Numero:1;"")
					: ($line=2)
						KRL_RelateSelection (->[Asignaturas:18]profesor_numero:4;->[Profesores:4]Numero:1;"")
						KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
						QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
						KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
						
						If (Not:C34(IT_AltKeyIsDown ))
							QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Ret@";*)
							QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29#Nivel_Retirados)
						End if 
						
						$newTable:=->[Alumnos:2]
					: ($line=3)
						  //        
					: ($line=4)
						  //         
				End case 
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
				Case of 
					: ($line=1)
						$newTable:=->[Asignaturas:18]
						KRL_RelateSelection (->[Asignaturas:18]Curso:5;->[Cursos:3]Curso:1;"")
					: ($line=2)
						KRL_RelateSelection (->[Asignaturas:18]Curso:5;->[Cursos:3]Curso:1;"")
						KRL_RelateSelection (->[Profesores:4]Numero:1;->[Asignaturas:18]profesor_numero:4;"")
						$newTable:=->[Profesores:4]
					: ($line=3)
						KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
						If (Not:C34(IT_AltKeyIsDown ))
							QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Ret@";*)
							QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29#Nivel_Retirados)
						End if 
						$newTable:=->[Alumnos:2]
					: ($line=4)
						KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
						KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
						$newTable:=->[Familia:78]
					: ($line=5)
						KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
						KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Alumnos:2]Familia_Número:24;"")
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
						$newTable:=->[Personas:7]
				End case 
		End case 
		
	: (<>vsXS_CurrentModule="AccountTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				Case of 
					: ($line=1)
						$newTable:=->[Personas:7]
						ACT_relacionaCtasyApdos (1)
						
					: ($line=2)
						$newTable:=->[ACT_Terceros:138]
						KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;->[ACT_CuentasCorrientes:175]ID:1;"")
						KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Terceros_Pactado:139]Id_Tercero:2;"")
						
					: ($line=3)
						$newTable:=->[ACT_Avisos_de_Cobranza:124]
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
						QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10#0)
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10)
						
					: ($line=4)
						$newTable:=->[ACT_Pagares:184]
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
						KRL_RelateSelection (->[ACT_Pagares:184]ID:12;->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;"")
						
					: ($line=5)
						  //$newTable:=->[ACT_Pagos]
						  //READ ONLY([ACT_Pagos])
						  //If (cbDatosCta=1)
						  //KRL_RelateSelection (->[ACT_Pagos]ID_CtaCte;->[ACT_CuentasCorrientes]ID;"")
						  //CREATE SET([ACT_Pagos];"Pagos")
						  //Else 
						  //ACT_relacionaCtasyApdos (1)
						  //KRL_RelateSelection (->[ACT_Pagos]ID_Apoderado;->[Personas]No;"")
						  //CREATE SET([ACT_Pagos];"PagosApdos")
						  //KRL_RelateSelection (->[ACT_Pagos]ID_CtaCte;->[ACT_CuentasCorrientes]ID;"")
						  //CREATE SET([ACT_Pagos];"PagosCtas")
						  //UNION("PagosApdos";"PagosCtas";"Pagos")
						  //End if 
						  //
						  //If ((Windows Ctrl down) | (Macintosh command down))
						  //KRL_RelateSelection (->[ACT_Cargos]ID_CuentaCorriente;->[ACT_CuentasCorrientes]ID;"")
						  //KRL_RelateSelection (->[ACT_Transacciones]ID_Item;->[ACT_Cargos]ID;"")
						  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]ID_Pago#0)
						  //KRL_RelateSelection (->[ACT_Pagos]ID;->[ACT_Transacciones]ID_Pago;"")
						  //CREATE SET([ACT_Pagos];"PagosCtas")
						  //UNION("Pagos";"PagosCtas";"Pagos")
						  //End if 
						  //
						  //USE SET("Pagos")
						  //SET_ClearSets ("PagosApdos";"PagosCtas";"Pagos")
						
						  //$newTable:=->[ACT_Pagos]
						  //READ ONLY([ACT_Pagos])
						  //If (cbDatosCta=1)
						  //KRL_RelateSelection (->[ACT_Pagos]ID_CtaCte;->[ACT_CuentasCorrientes]ID;"")
						  //CREATE SET([ACT_Pagos];"Pagos")
						  //Else 
						  //ACT_relacionaCtasyApdos (1)
						  //KRL_RelateSelection (->[ACT_Pagos]ID_Apoderado;->[Personas]No;"")
						  //CREATE SET([ACT_Pagos];"PagosApdos")
						  //KRL_RelateSelection (->[ACT_Pagos]ID_CtaCte;->[ACT_CuentasCorrientes]ID;"")
						  //CREATE SET([ACT_Pagos];"PagosCtas")
						  //UNION("PagosApdos";"PagosCtas";"Pagos")
						  //End if 
						  //
						  //If ((Windows Ctrl down) | (Macintosh command down))
						  //KRL_RelateSelection (->[ACT_Cargos]ID_CuentaCorriente;->[ACT_CuentasCorrientes]ID;"")
						  //KRL_RelateSelection (->[ACT_Transacciones]ID_Item;->[ACT_Cargos]ID;"")
						  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]ID_Pago#0)
						  //KRL_RelateSelection (->[ACT_Pagos]ID;->[ACT_Transacciones]ID_Pago;"")
						  //CREATE SET([ACT_Pagos];"PagosCtas")
						  //UNION("Pagos";"PagosCtas";"Pagos")
						  //End if 
						  //
						  //USE SET("Pagos")
						  //SET_ClearSets ("PagosApdos";"PagosCtas";"Pagos")
						
						$newTable:=->[ACT_Pagos:172]
						READ ONLY:C145([ACT_Pagos:172])
						READ ONLY:C145([ACT_Transacciones:178])
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
						QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						CREATE SET:C116([ACT_Pagos:172];"Pagos")
						
						  //se comentan estas lineas por un problema en la proyeccion de los pagos
						  //desde las cuentas corrientes.
						  //se cargaban unos pagos que no se relacionan a los alumnos cargados en el
						  //explorador
						
						  //If (cbDatosCta=1)
						  //KRL_RelateSelection (->[ACT_Pagos]ID_CtaCte;->[ACT_Transacciones]ID_CuentaCorriente;"")
						  //Else 
						  //KRL_RelateSelection (->[ACT_Pagos]ID_Apoderado;->[ACT_Transacciones]ID_Apoderado;"")
						  //End if 
						  //CREATE SET([ACT_Pagos];"Pagos2")
						  //UNION("Pagos";"Pagos2";"Pagos")
						
						  //20140509 ASM ticket 132666
						If (Records in selection:C76([ACT_CuentasCorrientes:175])>1)
							ARRAY LONGINT:C221($al_IDCtasCorrientes;0)
							AT_DistinctsFieldValues (->[ACT_CuentasCorrientes:175]ID:1;->$al_IDCtasCorrientes)
							
							While (Find in array:C230($al_IDCtasCorrientes;0)#-1)
								DELETE FROM ARRAY:C228($al_IDCtasCorrientes;Find in array:C230($al_IDCtasCorrientes;0))
							End while 
							
							QRY_QueryWithArray (->[ACT_Pagos:172]ID_CtaCte:21;->$al_IDCtasCorrientes;False:C215)
							
						Else 
							QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_CtaCte:21=[ACT_CuentasCorrientes:175]ID:1)
						End if 
						CREATE SET:C116([ACT_Pagos:172];"Pagos3")
						UNION:C120("Pagos";"Pagos3";"Pagos")
						
						USE SET:C118("Pagos")
						SET_ClearSets ("Pagos";"Pagos2")
						
					: ($line=6)
						$newTable:=->[ACT_Boletas:181]
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
						KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
						ACTbol_BuscaDctosAsociados 
					: ($line=7)
						$newTable:=->[ACT_Documentos_en_Cartera:182]
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;"")
					: ($line=8)
						$newTable:=->[ACT_Documentos_de_Pago:176]
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
				End case 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				Case of 
					: ($line=1)
						$newTable:=->[ACT_CuentasCorrientes:175]
						ACT_relacionaCtasyApdos (2)
					: ($line=2)
						$newTable:=->[ACT_Terceros:138]
						ACT_relacionaCtasyApdos (2)
						KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;->[ACT_CuentasCorrientes:175]ID:1;"")
						KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Terceros_Pactado:139]Id_Tercero:2;"")
					: ($line=3)
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]No:1;"")
						$newTable:=->[ACT_Avisos_de_Cobranza:124]
					: ($line=4)
						KRL_RelateSelection (->[ACT_Pagares:184]ID_Apdo:17;->[Personas:7]No:1;"")
						$newTable:=->[ACT_Pagares:184]
					: ($line=5)
						KRL_RelateSelection (->[ACT_Pagos:172]ID_Apoderado:3;->[Personas:7]No:1;"")
						$newTable:=->[ACT_Pagos:172]
					: ($line=6)
						KRL_RelateSelection (->[ACT_Boletas:181]ID_Apoderado:14;->[Personas:7]No:1;"")
						ACTbol_BuscaDctosAsociados 
						$newTable:=->[ACT_Boletas:181]
					: ($line=7)
						KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_Apoderado:2;->[Personas:7]No:1;"")
						$newTable:=->[ACT_Documentos_en_Cartera:182]
					: ($line=8)
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Apoderado:11;->[Personas:7]No:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
						$newTable:=->[ACT_Documentos_de_Pago:176]
				End case 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				Case of 
					: ($line=1)
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
						$newTable:=->[ACT_CuentasCorrientes:175]
					: ($line=2)
						KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;"")
						$newTable:=->[Personas:7]
					: ($line=3)
						KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26;"")
						$newTable:=->[ACT_Terceros:138]
					: ($line=4)
						KRL_RelateSelection (->[ACT_Pagares:184]ID:12;->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;"")
						$newTable:=->[ACT_Pagares:184]
					: ($line=5)
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						$newTable:=->[ACT_Pagos:172]
					: ($line=6)
						$newTable:=->[ACT_Boletas:181]
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
						ACTbol_BuscaDctosAsociados 
					: ($line=7)
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;"")
						$newTable:=->[ACT_Documentos_en_Cartera:182]
					: ($line=8)
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
						$newTable:=->[ACT_Documentos_de_Pago:176]
				End case 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagares:184]))
				Case of 
					: ($line=1)
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;->[ACT_Pagares:184]ID:12;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
						$newTable:=->[ACT_CuentasCorrientes:175]
					: ($line=2)
						KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Pagares:184]ID_Apdo:17;"")
						$newTable:=->[Personas:7]
					: ($line=3)
						KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Pagares:184]ID_Tercero:22;"")
						$newTable:=->[ACT_Terceros:138]
					: ($line=4)
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;->[ACT_Pagares:184]ID:12;"")
						$newTable:=->[ACT_Avisos_de_Cobranza:124]
					: ($line=5)
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;->[ACT_Pagares:184]ID:12;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						$newTable:=->[ACT_Pagos:172]
					: ($line=6)
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;->[ACT_Pagares:184]ID:12;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
						$newTable:=->[ACT_Boletas:181]
					: ($line=7)
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;->[ACT_Pagares:184]ID:12;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;"")
						$newTable:=->[ACT_Documentos_en_Cartera:182]
					: ($line=8)
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;->[ACT_Pagares:184]ID:12;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
						$newTable:=->[ACT_Documentos_de_Pago:176]
				End case 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagos:172]))
				Case of 
					: ($line=1)
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
						
						  //20140509 ASM ticket 132666
						CREATE SET:C116([ACT_CuentasCorrientes:175];"Ctas1")
						ARRAY LONGINT:C221($al_IDCtasCorrientes;0)
						AT_DistinctsFieldValues (->[ACT_Pagos:172]ID_CtaCte:21;->$al_IDCtasCorrientes)
						
						While (Find in array:C230($al_IDCtasCorrientes;0)#-1)
							DELETE FROM ARRAY:C228($al_IDCtasCorrientes;Find in array:C230($al_IDCtasCorrientes;0))
						End while 
						
						QRY_QueryWithArray (->[ACT_CuentasCorrientes:175]ID:1;->$al_IDCtasCorrientes;False:C215)
						CREATE SET:C116([ACT_CuentasCorrientes:175];"Ctas2")
						UNION:C120("Ctas1";"Ctas2";"Ctas1")
						USE SET:C118("Ctas1")
						SET_ClearSets ("Ctas1";"Ctas2")
						
						$newTable:=->[ACT_CuentasCorrientes:175]
					: ($line=2)
						KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Pagos:172]ID_Apoderado:3;"")
						$newTable:=->[Personas:7]
					: ($line=3)
						KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Pagos:172]ID_Tercero:26;"")
						$newTable:=->[ACT_Terceros:138]
					: ($line=4)
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
						$newTable:=->[ACT_Avisos_de_Cobranza:124]
					: ($line=5)
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
						KRL_RelateSelection (->[ACT_Pagares:184]ID:12;->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;"")
						$newTable:=->[ACT_Pagares:184]
					: ($line=6)
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
						
						  //ACTbol_BuscaDctosAsociados 
						  //20180327 RCH Ticket 194756. Carga NC con devolucion asociadas
						CREATE SET:C116([ACT_Boletas:181];"$boletas1")
						QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_DctoRelacionado:15>0)
						KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]ID_DctoRelacionado:15;"")
						CREATE SET:C116([ACT_Boletas:181];"$boletas2")
						UNION:C120("$boletas1";"$boletas2";"$boletas1")
						USE SET:C118("$boletas1")
						SET_ClearSets ("$boletas1";"$boletas2")
						
						ACTbol_BuscaDctosAsociados 
						
						$newTable:=->[ACT_Boletas:181]
					: ($line=7)
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;"")
						$newTable:=->[ACT_Documentos_en_Cartera:182]
					: ($line=8)
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
						$newTable:=->[ACT_Documentos_de_Pago:176]
				End case 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
				Case of 
					: ($line=1)
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
						$newTable:=->[ACT_CuentasCorrientes:175]
					: ($line=2)
						KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14;"")
						$newTable:=->[Personas:7]
					: ($line=3)
						KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;"")
						$newTable:=->[ACT_Terceros:138]
					: ($line=4)
						ACTbol_BuscaDctosAsociados 
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
						$newTable:=->[ACT_Avisos_de_Cobranza:124]
					: ($line=5)
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
						KRL_RelateSelection (->[ACT_Pagares:184]ID:12;->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;"")
						$newTable:=->[ACT_Pagares:184]
					: ($line=6)
						ACTbol_BuscaDctosAsociados 
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						$newTable:=->[ACT_Pagos:172]
					: ($line=7)
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;"")
						$newTable:=->[ACT_Documentos_en_Cartera:182]
					: ($line=8)
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
						$newTable:=->[ACT_Documentos_de_Pago:176]
				End case 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
				Case of 
					: ($line=1)
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
						$newTable:=->[ACT_CuentasCorrientes:175]
					: ($line=2)
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
						KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Documentos_de_Pago:176]ID_Apoderado:2;"")
						  //KRL_RelateSelection (->[ACT_Documentos_de_Pago]ID;->[ACT_Documentos_en_Cartera]ID_DocdePago;"")
						  //KRL_RelateSelection (->[ACT_Pagos]ID_DocumentodePago;->[ACT_Documentos_de_Pago]ID;"")
						  //KRL_RelateSelection (->[ACT_Transacciones]ID_Pago;->[ACT_Pagos]ID;"")
						  //KRL_RelateSelection (->[Personas]No;->[ACT_Transacciones]ID_Apoderado;"")
						$newTable:=->[Personas:7]
					: ($line=3)
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
						KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Documentos_de_Pago:176]ID_Tercero:48;"")
						$newTable:=->[ACT_Terceros:138]
					: ($line=4)
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
						$newTable:=->[ACT_Avisos_de_Cobranza:124]
					: ($line=5)
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
						KRL_RelateSelection (->[ACT_Pagares:184]ID:12;->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;"")
						$newTable:=->[ACT_Pagares:184]
					: ($line=6)
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
						$newTable:=->[ACT_Pagos:172]
					: ($line=7)
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
						ACTbol_BuscaDctosAsociados 
						$newTable:=->[ACT_Boletas:181]
				End case 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
				Case of 
					: ($line=1)
						KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
						$newTable:=->[ACT_CuentasCorrientes:175]
					: ($line=2)
						KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Transacciones:178]ID_Apoderado:11;"")
						$newTable:=->[Personas:7]
					: ($line=3)
						KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Documentos_de_Pago:176]ID_Tercero:48;"")
						$newTable:=->[ACT_Terceros:138]
					: ($line=4)
						KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
						$newTable:=->[ACT_Avisos_de_Cobranza:124]
					: ($line=5)
						KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
						KRL_RelateSelection (->[ACT_Pagares:184]ID:12;->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;"")
						$newTable:=->[ACT_Pagares:184]
					: ($line=6)
						KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
						$newTable:=->[ACT_Pagos:172]
					: ($line=7)
						KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
						ACTbol_BuscaDctosAsociados 
						$newTable:=->[ACT_Boletas:181]
				End case 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Terceros:138]))
				Case of 
					: ($line=1)
						$newTable:=->[ACT_CuentasCorrientes:175]
						KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->[ACT_Terceros:138]Id:1;"")
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;"")
					: ($line=2)
						$newTable:=->[Personas:7]
						KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->[ACT_Terceros:138]Id:1;"")
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;"")
						ACT_relacionaCtasyApdos (1)
					: ($line=3)
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26;->[ACT_Terceros:138]Id:1;"")
						$newTable:=->[ACT_Avisos_de_Cobranza:124]
					: ($line=4)
						KRL_RelateSelection (->[ACT_Pagares:184]ID_Tercero:22;->[ACT_Terceros:138]Id:1;"")
						$newTable:=->[ACT_Pagares:184]
					: ($line=5)
						KRL_RelateSelection (->[ACT_Pagos:172]ID_Tercero:26;->[ACT_Terceros:138]Id:1;"")
						$newTable:=->[ACT_Pagos:172]
					: ($line=6)
						KRL_RelateSelection (->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]Id:1;"")
						$newTable:=->[ACT_Boletas:181]
					: ($line=7)
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID_Tercero:48;->[ACT_Terceros:138]Id:1;"")
						KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;"")
						$newTable:=->[ACT_Documentos_en_Cartera:182]
					: ($line=8)
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID_Tercero:48;->[ACT_Terceros:138]Id:1;"")
						QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
						$newTable:=->[ACT_Documentos_de_Pago:176]
				End case 
		End case 
End case 

If (Not:C34(Is nil pointer:C315($newTable)))
	If (USR_checkRights ("L";$newTable))
		If (Records in selection:C76($newTable->)>0)
			AL_RemoveArrays (xALP_Browser;1;30)
			yBWR_currentTable:=$newTable
			CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
			SELECT LIST ITEMS BY REFERENCE:C630(vlXS_BrowserTab;Table:C252($newTable))
			$tab:=Selected list items:C379(vlXS_BrowserTab)
			GET LIST ITEM:C378(vlXS_BrowserTab;$tab;vlBWR_SelectedTableRef;vsBWR_selectedTableName)
			BWR_PanelSettings 
			BWR_SelectTableData 
			XS_SetInterface 
			ALP_SetInterface (xALP_Browser)
			_O_REDRAW LIST:C382(vlXS_BrowserTab)
		Else 
			CD_Dlog (0;__ ("No existen registros relacionados."))
		End if 
	Else 
		CD_Dlog (0;__ ("Usted no dispone de los derechos necesarios para ver registros de esta tabla."))
	End if 
End if 