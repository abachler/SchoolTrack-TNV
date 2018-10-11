  //[Asignaturas].Input.Champ2

IT_Clairvoyance (Self:C308;-><>aAsign;"";True:C214)
If (Form event:C388=On Data Change:K2:15)
	If ([Asignaturas:18]Asignatura:3#(Old:C35([Asignaturas:18]Asignatura:3)))
		[Asignaturas:18]Asignatura:3:=ST_GetCleanString ([Asignaturas:18]Asignatura:3)
		  //[Asignaturas]Asignatura:=Replace string(Replace string([Asignaturas]Asignatura;"(";"[");")";"]")Cambia el contenido de un sebsector y no lo encuentra en la busqueda previa
		[Asignaturas:18]Asignatura:3:=ST_Format (Self:C308)
		
		If (Find in array:C230(<>aAsign;[Asignaturas:18]Asignatura:3)=-1)
			$r:=CD_Dlog (0;__ ("El nombre ingresado no corresponde a ningún subsector existente.\r\rEsto es posible pero una asignatura sin relación con un subsector existente no puede figurar en actas ni incidir en el promedio.\r\r¿Continuar o modificar el nombre de la asignatura?\r");__ ("");__ ("Modificar");__ ("Continuar"))
			If ($r=2)
				[Asignaturas:18]Asignatura_No_Oficial:71:=True:C214
				[Asignaturas:18]denominacion_interna:16:=[Asignaturas:18]Asignatura:3
				[Asignaturas:18]Incide_en_promedio:27:=False:C215
				[Asignaturas:18]Incluida_en_Actas:44:=False:C215
				[Asignaturas:18]Es_Optativa:70:=False:C215
				[Asignaturas:18]Eximible:28:=False:C215
			Else 
				[Asignaturas:18]Asignatura:3:=Old:C35([Asignaturas:18]Asignatura:3)
				If ([Asignaturas:18]Asignatura_No_Oficial:71)
					[Asignaturas:18]Incide_en_promedio:27:=False:C215
					[Asignaturas:18]Incluida_en_Actas:44:=False:C215
					[Asignaturas:18]Es_Optativa:70:=False:C215
					[Asignaturas:18]Eximible:28:=False:C215
				Else 
					[Asignaturas:18]Asignatura_No_Oficial:71:=False:C215
				End if 
				GOTO OBJECT:C206([Asignaturas:18]Asignatura:3)
			End if 
		Else 
			READ ONLY:C145([xxSTR_Materias:20])
			QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=[Asignaturas:18]Asignatura:3)
			[Asignaturas:18]Asignatura_No_Oficial:71:=False:C215
			[Asignaturas:18]CHILE_CodigoMineduc:41:=[xxSTR_Materias:20]Codigo:10
			[Asignaturas:18]Abreviación:26:=[xxSTR_Materias:20]Abreviatura:8
			[Asignaturas:18]Materia_UUID:46:=[xxSTR_Materias:20]Auto_UUID:21  //Asignatura, Materia Auto uuid
			[Asignaturas:18]Sector:9:=[xxSTR_Materias:20]Area:12
			[Asignaturas:18]Asignatura:3:=ST_GetCleanString ([Asignaturas:18]Asignatura:3)
			If (([Asignaturas:18]denominacion_interna:16#"") & ([Asignaturas:18]denominacion_interna:16#[xxSTR_Materias:20]Denominación_Interna:18))
				OK:=CD_Dlog (0;__ ("Usted modificó el el nombre oficial de la asignatura\r\r¿Desea conservar el nombre interno actual de la asignatura?");__ ("");__ ("Si, conservar");__ ("No, cambiar"))
				If (OK=2)
					If ([Asignaturas:18]Asignatura:3#Old:C35([Asignaturas:18]Asignatura:3))
						[Asignaturas:18]denominacion_interna:16:=[xxSTR_Materias:20]Denominación_Interna:18
					End if 
				End if 
			Else 
				[Asignaturas:18]denominacion_interna:16:=[xxSTR_Materias:20]Denominación_Interna:18
			End if 
		End if 
		
		OBJECT SET VISIBLE:C603([Asignaturas:18]Incide_en_promedio:27;Not:C34([Asignaturas:18]Asignatura_No_Oficial:71))
		OBJECT SET VISIBLE:C603([Asignaturas:18]Incluida_en_Actas:44;Not:C34([Asignaturas:18]Asignatura_No_Oficial:71))
		OBJECT SET VISIBLE:C603([Asignaturas:18]Eximible:28;Not:C34([Asignaturas:18]Asignatura_No_Oficial:71))
		OBJECT SET VISIBLE:C603([Asignaturas:18]Es_Optativa:70;Not:C34([Asignaturas:18]Asignatura_No_Oficial:71))
		OBJECT SET VISIBLE:C603([Asignaturas:18]CHILE_CodigoMineduc:41;Not:C34([Asignaturas:18]Asignatura_No_Oficial:71))
		
		AS_AsignaNumeroOrdenamiento 
		If ([Asignaturas:18]Asignatura_No_Oficial:71)
			ALL RECORDS:C47([Profesores:4])
		Else 
			QUERY:C277([Profesores:4];[Profesores]Asignaturas'Asignatura=[Asignaturas:18]Asignatura:3;*)
			QUERY:C277([Profesores:4]; | [Profesores:4]AutorizadoTodaAsignatura:9=True:C214)
		End if 
		ORDER BY:C49([Profesores:4];[Profesores:4]Apellido_paterno:3;>)
		SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;at_Profesores_Nombres;[Profesores:4]Numero:1;al_Profesores_ID)
		
		
		AS_fSave 
		EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
		AS_OnActivate 
		KRL_ReloadInReadWriteMode (->[Asignaturas:18])
		
	End if 
End if 