If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Formule format : Input
	  //Autor: Alberto Bachler
	  //Creada el 30/6/96 a 4:25 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

$event:=Form event:C388


Case of 
	: ($event=On Load:K2:1)
		XS_SetInterface 
		viACT_ACTDecideApoderado:=Num:C11(PREF_fGet (0;"ACT_DecideApoderado"))
		aiACT_ChangeDeuda2NewAPdo:=0
		_O_DISABLE BUTTON:C193(aiACT_ChangeDeuda2NewAPdo)
		If (aPersID#0)
			OBJECT SET ENTERABLE:C238(vApNme;False:C215)
			vApNme:=[Personas:7]Apellidos_y_nombres:30
			OBJECT SET COLOR:C271(vApNme;-3078)
			If ([Familia_RelacionesFamiliares:77]Tipo_Relación:4>0)
				vParentesco:=<>aParentesco{[Familia_RelacionesFamiliares:77]Tipo_Relación:4}
			Else 
				vParentesco:=""
			End if 
			If ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) | (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175])))
				Case of 
					: (aApoderado{aPersID}="General")
						bAp1:=1
						bap2:=1
					: (aApoderado{aPersID}="Cuentas")
						bap2:=1
						bap1:=0
					: (aApoderado{aPersID}="Académico")
						bap1:=1
						bap2:=0
					Else 
						bap1:=0
						bap2:=0
				End case 
			End if 
			Case of 
				: (Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78]))
					OBJECT SET VISIBLE:C603(*;"messageSTR";False:C215)
					OBJECT SET VISIBLE:C603(*;"messageACT";False:C215)
					OBJECT SET VISIBLE:C603(bAp1;False:C215)
					OBJECT SET VISIBLE:C603(bAp2;False:C215)
				: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
					If (viACT_ACTDecideApoderado=1)
						_O_DISABLE BUTTON:C193(bAp2)
						OBJECT SET VISIBLE:C603(*;"messageSTR";True:C214)
					Else 
						OBJECT SET VISIBLE:C603(*;"messageSTR";False:C215)
					End if 
					OBJECT SET VISIBLE:C603(*;"messageACT";False:C215)
				: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
					If (viACT_ACTDecideApoderado=0)
						_O_DISABLE BUTTON:C193(bAp2)
						OBJECT SET VISIBLE:C603(*;"messageACT";False:C215)
					Else 
						OBJECT SET VISIBLE:C603(*;"messageACT";True:C214)
					End if 
					_O_DISABLE BUTTON:C193(bAp1)
					OBJECT SET VISIBLE:C603(*;"messageSTR";False:C215)
				Else 
					bap1:=0
					bap2:=0
					OBJECT SET VISIBLE:C603(bAp1;False:C215)
					OBJECT SET VISIBLE:C603(bAp2;False:C215)
			End case 
		Else 
			Case of 
				: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
					If (viACT_ACTDecideApoderado=1)
						_O_DISABLE BUTTON:C193(bAp2)
						OBJECT SET VISIBLE:C603(*;"messageSTR";True:C214)
					Else 
						OBJECT SET VISIBLE:C603(*;"messageSTR";False:C215)
					End if 
					OBJECT SET VISIBLE:C603(*;"messageACT";False:C215)
				: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
					If (viACT_ACTDecideApoderado=0)
						_O_DISABLE BUTTON:C193(bAp2)
						OBJECT SET VISIBLE:C603(*;"messageACT";False:C215)
					Else 
						OBJECT SET VISIBLE:C603(*;"messageACT";True:C214)
					End if 
					_O_DISABLE BUTTON:C193(bAp1)
					OBJECT SET VISIBLE:C603(*;"messageSTR";False:C215)
				Else 
					bap1:=0
					bap2:=0
					OBJECT SET VISIBLE:C603(bAp1;False:C215)
					OBJECT SET VISIBLE:C603(bAp2;False:C215)
					OBJECT SET VISIBLE:C603(*;"messageSTR";False:C215)
					OBJECT SET VISIBLE:C603(*;"messageACT";False:C215)
			End case 
			vApNme:=""
			vParentesco:=""
			bApdo:=0
			bap1:=0
			bap2:=0
			[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Alumnos:2]Familia_Número:24
			_O_DISABLE BUTTON:C193(b_Consultar)
			_O_DISABLE BUTTON:C193(b_Eliminar)
			_O_DISABLE BUTTON:C193(b_Guardar)
		End if 
		
		If (vParentesco="Otros")
			OBJECT SET VISIBLE:C603([Familia_RelacionesFamiliares:77]Parentesco:6;True:C214)
		Else 
			OBJECT SET VISIBLE:C603([Familia_RelacionesFamiliares:77]Parentesco:6;False:C215)
		End if 
		
		
		If (Not:C34(USR_checkRights ("M";->[Alumnos:2])))
			_O_DISABLE BUTTON:C193(bAp1)
			_O_DISABLE BUTTON:C193(bAp2)
			If (USR_GetMethodAcces ("ACTcc_ChangeAccountParent";0))
				  //20110415 RCH Cuando la condicion de apdo de cta es definida por ACT, en ST se podia editar el apoderado de cuenta...
				  //ENABLE BUTTON(bAp2)
				Case of 
					: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (viACT_ACTDecideApoderado=0))
						_O_ENABLE BUTTON:C192(bAp2)
					: ((Table:C252(yBWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175])) & (viACT_ACTDecideApoderado=1))
						_O_ENABLE BUTTON:C192(bAp2)
				End case 
			End if 
		End if 
		
		If (Not:C34(USR_checkRights ("M";->[Familia:78])))
			_O_DISABLE BUTTON:C193(b_Eliminar)
			OBJECT SET ENTERABLE:C238(vApName;False:C215)
			OBJECT SET ENTERABLE:C238(vParentesco;False:C215)
			OBJECT SET ENTERABLE:C238([Familia_RelacionesFamiliares:77]Parentesco:6;False:C215)
			OBJECT SET VISIBLE:C603(<>aParentesco;False:C215)
		End if 
		changeAP:=False:C215
		bap2InitialState:=bap2
		wref:=WDW_GetWindowID 
		
		If ([Personas:7]Fallecido:88)
			_O_DISABLE BUTTON:C193(<>aParentesco)
			_O_DISABLE BUTTON:C193(bAp1)
			_O_DISABLE BUTTON:C193(bap2)
		Else 
			_O_ENABLE BUTTON:C192(<>aParentesco)
		End if 
		
	: ($event=On Data Change:K2:15)
		If ((vApNme#"") & (([Familia_RelacionesFamiliares:77]ID_Persona:3>0) | ([Familia_RelacionesFamiliares:77]ID_Alumno:1>0)))
			IT_SetButtonState (True:C214;->b_Consultar;->b_Guardar)
			IT_SetButtonState ((aPersID>0);->b_Eliminar)
		Else 
			IT_SetButtonState (False:C215;->b_Consultar;->b_Eliminar;->b_Guardar)
		End if 
		
		If ([Personas:7]Fallecido:88)
			_O_DISABLE BUTTON:C193(<>aParentesco)
			_O_DISABLE BUTTON:C193(bAp1)
			_O_DISABLE BUTTON:C193(bap2)
		Else 
			_O_ENABLE BUTTON:C192(<>aParentesco)
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 

