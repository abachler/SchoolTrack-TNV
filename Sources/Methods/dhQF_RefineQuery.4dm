//%attributes = {}
  //dhQF_RefineQuery

  //xShell, Alberto Bachler
  //Metodo: dhQF_RefineQuery
  //Por abachler
  //Creada el 29/09/2003, 12:30:18
  //Modificaciones:
If ("INSTRUCCIONES"="")
	  //llamado desde: QF_RefineQuery
	  //utilizar para refinar la búsqueda una vez ejecutada la buscada en el dialogo de busqueda rápida
	  //En el Case of poner las instrucciones necesarias para procesar el evento para cada tabla en que se requiera
End if 

  //****DECLARACIONES****


  //****INICIALIZACIONES****

  //****CUERPO****
Case of 
	: (<>vsXS_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
				If (Not:C34(IT_AltKeyIsDown ))
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0;*)
					QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]curso:20#"POST";*)  //para no mostrar los cursos de admissiontrack
					QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]ocultoEnNominas:89=False:C215)
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				End if 
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
				If (Not:C34(IT_AltKeyIsDown ))  //para no mostrar los de ADT
					If (Records in selection:C76([Cursos:3])>0)
						QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
					End if 
				End if 
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4]))
				If (Not:C34(IT_AltKeyIsDown ))  //para no mostrar los inactivos
					If (Records in selection:C76([Profesores:4])>0)
						QUERY SELECTION:C341([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
					End if 
				End if 
				  //20141211 ASM Ticket 139616
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78]))
				If (Not:C34(IT_AltKeyIsDown ))  //para no mostrar las familias inactivas
					If (Records in selection:C76([Familia:78])>0)
						QUERY SELECTION:C341([Familia:78];[Familia:78]Inactiva:31=False:C215)
					End if 
				End if 
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
				If (Not:C34(IT_AltKeyIsDown ))  //para no mostrar las personas inactivas desde la pestaña relaciones familiares
					If (Records in selection:C76([Personas:7])>0)
						QUERY SELECTION:C341([Personas:7];[Personas:7]Inactivo:46=False:C215)
					End if 
				End if 
		End case 
		
		
	: (<>vsXS_CurrentModule="AccountTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
					If (Not:C34(IT_AltKeyIsDown ))
						QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					End if 
				End if 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				If (Records in selection:C76([Personas:7])>0)
					If (IT_AltKeyIsDown )
						QUERY SELECTION:C341([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214;*)
						QUERY SELECTION:C341([Personas:7]; | ;[Personas:7]MontosEmitidos_Ejercicio:82>0)
					Else 
						QUERY SELECTION:C341([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
					End if 
				End if 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
				If (Records in selection:C76([ACT_Documentos_de_Pago:176])>0)
					QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
				End if 
		End case 
		
		
	: (<>vsXS_CurrentModule="AdmissionTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Profesores:4]))
				If (Records in selection:C76([Profesores:4])>0)
					QUERY SELECTION:C341([Profesores:4];[Profesores:4]Es_Entrevistador_Admisiones:35=True:C214)
				End if 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ADT_Candidatos:49]))
				  //Mono 17-05-2011 Los datos de los candidatos transferidos ya no son eliminados ticket 97847 
				  //Candidatos marcfados como obsoletos y transferidos a ST no deben aparecer con búsquedas normales
				If (Not:C34(IT_AltKeyIsDown ))
					If (Records in selection:C76([ADT_Candidatos:49])>0)
						QUERY SELECTION:C341([ADT_Candidatos:49];[ADT_Candidatos:49]Candidato_Obsoleto:67=False:C215;*)
						QUERY SELECTION:C341([ADT_Candidatos:49]; & ;[ADT_Candidatos:49]Transf_ST:68=False:C215)
					End if 
				End if 
		End case 
End case 