  // [STR_Medicos].Input.boton()
  // Por: Alberto Bachler K.: 27-06-14, 15:53:42
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		Case of 
			: (OBJECT Get title:C1068(*;OBJECT Get name:C1087(Object current:K67:2))=__ ("Editar"))
				IT_MuestraTip (__ ("Modificar datos del médico"))
				
			: (OBJECT Get enabled:C1079(*;OBJECT Get name:C1087(Object current:K67:2)))
				IT_MuestraTip (__ ("Guardar los cambios"))
				
			Else 
				IT_MuestraTip (__ ("Guardar los cambios (inactivo porque falta el nombre o apellidos del médico)"))
		End case 
		
	: (Form event:C388=On Clicked:K2:4)
		$t_titulo:=OBJECT Get title:C1068(*;"boton")
		Case of 
			: ($t_titulo=__ ("Editar"))
				KRL_ReloadInReadWriteMode (->[STR_Medicos:89])
				OBJECT SET ENTERABLE:C238(*;"campo@";True:C214)
				GOTO OBJECT:C206([STR_Medicos:89]Nombres:1)
				HIGHLIGHT TEXT:C210([STR_Medicos:89]Nombres:1;Length:C16([STR_Medicos:89]Nombres:1)+1;256)
				OBJECT SET TITLE:C194(*;"boton";__ ("Aceptar"))
				OBJECT SET RGB COLORS:C628(*;"boton";Foreground color:K23:1;Background color:K23:2)
				OBJECT SET ENABLED:C1123(*;"boton";([STR_Medicos:89]Nombres:1#"") & ([STR_Medicos:89]Apellidos:7#""))
				
			: ($t_titulo=__ ("Aceptar"))
				If ((Records in set:C195("seleccionMedico")>0) | (Is new record:C668([STR_Medicos:89])))
					SAVE RECORD:C53([STR_Medicos:89])
					ONE RECORD SELECT:C189([STR_Medicos:89])
					CREATE SET:C116([STR_Medicos:89];"seleccionMedico")
					
					ALL RECORDS:C47([STR_Medicos:89])
					ORDER BY:C49([STR_Medicos:89];[STR_Medicos:89]Apellidos:7;>;[STR_Medicos:89]Nombres:1;>)
					FORM GOTO PAGE:C247(1)
					
					GOTO OBJECT:C206(*;"listaMedicos")
					OBJECT SET ENABLED:C1123(*;"boton";Records in set:C195("seleccionMedico")>0)
				Else 
					SAVE RECORD:C53([STR_Medicos:89])
					ACCEPT:C269
				End if 
				
		End case 
End case 

