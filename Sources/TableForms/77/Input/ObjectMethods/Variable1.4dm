If (vApNme#"")
	$famRecord:=Record number:C243([Familia:78])
	modNm:=True:C214
	READ ONLY:C145([Personas:7])
	QUERY:C277([Personas:7];[Personas:7]Apellidos_y_nombres:30=(vApNme+"@"))
	  //QUERY SELECTION([Personas];[Personas]Inactivo=False)
	If (Not:C34(IT_AltKeyIsDown ))  //20180129 RCH Ticket 197327. Para permitir asignar personas que puedan estar inactivas y así evitar que las vuelvan a crear.
		QUERY SELECTION:C341([Personas:7];[Personas:7]Inactivo:46=False:C215)
	End if 
	Case of 
		: (Records in selection:C76([Personas:7])=0)
			$r:=CD_Dlog (0;__ ("Persona inexistente.\r¿Desea Ud. crearla?");__ ("");__ ("Si");__ ("No"))
			If ($r=1)
				READ WRITE:C146([Personas:7])
				vb_inBrowsingMode:=False:C215
				$inBwr:=vbXS_inBrowser
				$crtFile:=yBWR_currentTable
				vbXS_inBrowser:=False:C215
				
				  //conservamos el metodo y parametros de navegación actuales (Explorador SchoolTrack)
				$vlBWR_BrowsingMethod:=vlBWR_BrowsingMethod
				$yBWR_currentTable:=yBWR_currentTable
				$vyBWR_CustonFieldRefPointer:=vyBWR_CustonFieldRefPointer
				$vyBWR_CustomArrayPointer:=vyBWR_CustomArrayPointer
				
				  //cambiamos el metodo de navegación para que esta se haga sobre la base de los arreglos del area
				yBWR_currentTable:=->[Personas:7]
				vyBWR_CustomArrayPointer:=->aPersID
				vyBWR_CustonFieldRefPointer:=->[Personas:7]No:1
				vlBWR_BrowsingMethod:=BWR Array Browsing
				
				
				PUSH RECORD:C176([Familia_RelacionesFamiliares:77])
				
				$vl_recNumAl:=Record number:C243([Alumnos:2])
				$vl_RecNumCta:=Record number:C243([ACT_CuentasCorrientes:175])
				
				KRL_UnloadReadOnly (->[Alumnos:2])
				If (vsBWR_CurrentModule="AccountTrack")
					FORM SET INPUT:C55([Personas:7];"Input_ACT")
					FORM GET PROPERTIES:C674([Personas:7];"Input_ACT";$width;$height)
				Else 
					FORM SET INPUT:C55([Personas:7];"Input")
					FORM GET PROPERTIES:C674([Personas:7];"Input";$width;$height)
				End if 
				WDW_Open ($width;$height;2;4;XSvs_nombreTablaLocal_puntero (yBWR_currentTable))
				ADD RECORD:C56([Personas:7];*)
				CLOSE WINDOW:C154
				
				  //20140515 ASM ticket 132735 . El registro de alumnos y cuentas corrientes quedaban tomados, produciendo problemas en ACT
				  //If ($vl_recNumAl>=0)
				  //KRL_GotoRecord (->[Alumnos];$vl_recNumAl;True)
				  //End if 
				  //
				  //If ($vl_RecNumCta>=0)
				  //KRL_GotoRecord (->[ACT_CuentasCorrientes];$vl_RecNumCta;True)
				  //End if 
				
				
				If ($famRecord>=0)
					READ WRITE:C146([Familia:78])
					GOTO RECORD:C242([Familia:78];$famRecord)
				End if 
				POP RECORD:C177([Familia_RelacionesFamiliares:77])
				vb_inBrowsingMode:=True:C214
				yBWR_currentTable:=$crtFile
				vbXS_inBrowser:=$inBwr
				If (viBWR_RecordWasSaved>0)
					READ ONLY:C145([Personas:7])
					LOAD RECORD:C52([Personas:7])
					vApNme:=[Personas:7]Apellidos_y_nombres:30
					[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
					[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
					Case of 
						: (<>aParentesco=1)
							[Familia:78]Madre_Número:6:=[Familia_RelacionesFamiliares:77]ID_Persona:3
							[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
						: (<>aParentesco=2)
							[Familia:78]Padre_Número:5:=[Familia_RelacionesFamiliares:77]ID_Persona:3
							[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
					End case 
				Else 
					[Familia_RelacionesFamiliares:77]ID_Persona:3:=0
					READ ONLY:C145([Personas:7])
					LOAD RECORD:C52([Personas:7])
					vApNme:=[Personas:7]Apellidos_y_nombres:30
				End if 
				READ ONLY:C145([Personas:7])
				
				  //reestablecemos el metodo de navegación previo
				vlBWR_BrowsingMethod:=$vlBWR_BrowsingMethod
				yBWR_currentTable:=$yBWR_currentTable
				vyBWR_CustonFieldRefPointer:=$vyBWR_CustonFieldRefPointer
				vyBWR_CustomArrayPointer:=$vyBWR_CustomArrayPointer
				  //agrego codigo para recargar al alumno debido a que se perdia el registro y al suceder
				  //esto no guardaba la informacion correspondiente a la relacion familiar, 
				  //ticket  148957 JVP 
				  //GOTO RECORD([Alumnos];$vl_recNumAl)
				KRL_GotoRecord (->[Alumnos:2];$vl_recNumAl)
				  //fin codigo
				
			End if 
		: (Records in selection:C76([Personas:7])=1)
			  //20122505 ASM Se realiza validación para que no se dupliquen las relaciones Familiares.
			$el:=Find in array:C230(al_IdPersona;[Personas:7]No:1)
			If ($el=-1)
				vApNme:=[Personas:7]Apellidos_y_nombres:30
				[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
				[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
				Case of 
					: (<>aParentesco=1)
						[Familia:78]Madre_Número:6:=[Familia_RelacionesFamiliares:77]ID_Persona:3
						[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
					: (<>aParentesco=2)
						[Familia:78]Padre_Número:5:=[Familia_RelacionesFamiliares:77]ID_Persona:3
						[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
				End case 
			Else 
				CD_Dlog (0;__ ("El apoderado ya existe como relación familiar."))
				vApNme:=""
			End if 
		: (Records in selection:C76([Personas:7])>1)
			READ ONLY:C145([Personas:7])
			SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;<>aGenNme;[Personas:7]No:1;<>aGenId)
			ARRAY POINTER:C280(<>aChoicePtrs;2)
			<>aChoicePtrs{1}:=-><>aGenNme
			<>aChoicePtrs{2}:=-><>aGenID
			TBL_ShowChoiceList (1)
			If ((ok=1) & (choiceIdx>0))
				$recNum:=Find in field:C653([Personas:7]No:1;<>aChoicePtrs{2}->{choiceIdx})
				KRL_GotoRecord (->[Personas:7];$recNum)
				  //20122505 ASM Se realiza validación para que no se dupliquen las relaciones Familiares.
				$el:=Find in array:C230(al_IdPersona;[Personas:7]No:1)
				If ($el=-1)
					vApNme:=<>aChoicePtrs{1}->{choiceIdx}
					[Familia_RelacionesFamiliares:77]ID_Persona:3:=<>aChoicePtrs{2}->{choiceIdx}
					[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
					Case of 
						: (<>aParentesco=1)
							[Familia:78]Madre_Número:6:=[Familia_RelacionesFamiliares:77]ID_Persona:3
							[Familia:78]Madre_Nombre:16:=<>aChoicePtrs{1}->{choiceIdx}
						: (<>aParentesco=2)
							[Familia:78]Padre_Número:5:=[Familia_RelacionesFamiliares:77]ID_Persona:3
							[Familia:78]Padre_Nombre:15:=<>aChoicePtrs{1}->{choiceIdx}
					End case 
				Else 
					CD_Dlog (0;__ ("El apoderado ya existe como relación familiar."))
					vApNme:=""
				End if 
			Else 
				vApName:=""
				[Familia_RelacionesFamiliares:77]ID_Persona:3:=0
			End if 
	End case 
End if 
