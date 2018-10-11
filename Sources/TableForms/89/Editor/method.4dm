  // [STR_Medicos].Editor()
  // Por: Alberto Bachler K.: 01-07-14, 19:33:21
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_registroModificado;$b_registroValido)
C_TEXT:C284($t_textoEditado)


Case of 
	: (Form event:C388=On Load:K2:1)
		CREATE EMPTY SET:C140([STR_Medicos:89];"listaMedicos")
		If (Records in selection:C76([STR_Medicos:89])=0)
			ALL RECORDS:C47([STR_Medicos:89])
			ORDER BY:C49([STR_Medicos:89];[STR_Medicos:89]Apellidos:7;>;[STR_Medicos:89]Nombres:1;>)
			FORM GOTO PAGE:C247(1)
		Else 
			OBJECT SET VISIBLE:C603(*;"campoEspecialidad";True:C214)
			OBJECT SET VISIBLE:C603(*;"botonEspecialidad";False:C215)
			OBJECT SET RGB COLORS:C628(*;"boton";Foreground color:K23:1;Background color:K23:2)
			OBJECT SET TITLE:C194(*;"boton";__ ("Editar"))
			OBJECT SET ENTERABLE:C238(*;"campo@";False:C215)
			FORM GOTO PAGE:C247(2)
		End if 
		OBJECT SET ENABLED:C1123(*;"eliminarMedico";False:C215)
		OBJECT SET ENABLED:C1123(*;"seleccionarMedico";False:C215)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On After Keystroke:K2:26) & (FORM Get current page:C276=2))
		$b_registroModificado:=KRL_FieldChanges (->[STR_Medicos:89]Nombres:1;->[STR_Medicos:89]Apellidos:7;->[STR_Medicos:89]Especialidad:2;->[STR_Medicos:89]eMail:5;->[STR_Medicos:89]Telefono_movil:4;->[STR_Medicos:89]Telefono_Domicilio:8;->[STR_Medicos:89]Telefono_Profesional:9)
		$b_registroValido:=([STR_Medicos:89]Nombres:1#"") & ([STR_Medicos:89]Apellidos:7#"")
		If ($b_registroModificado)
			OBJECT SET RGB COLORS:C628(*;"boton";<>vl_ColorTextoBoton_Azul;Background color:K23:2)
			OBJECT SET TITLE:C194(*;"boton";__ ("Aceptar"))
			OBJECT SET ENABLED:C1123(*;"boton";([STR_Medicos:89]Nombres:1#"") & ([STR_Medicos:89]Apellidos:7#""))
		Else 
			OBJECT SET RGB COLORS:C628(*;"boton";Foreground color:K23:1;Background color:K23:2)
			OBJECT SET TITLE:C194(*;"boton";__ ("Aceptar"))
			OBJECT SET ENABLED:C1123(*;"boton";([STR_Medicos:89]Nombres:1#"") & ([STR_Medicos:89]Apellidos:7#""))
		End if 
		
	: (Form event:C388=On After Keystroke:K2:26)
		If (OBJECT Get name:C1087(Object with focus:K67:3)="SearchText_@")
			$t_textoEditado:="@"+Get edited text:C655+"@"
			READ ONLY:C145([STR_Medicos:89])
			If ($t_textoEditado#"")
				QUERY:C277([STR_Medicos:89];[STR_Medicos:89]Nombres:1=$t_textoEditado;*)
				QUERY:C277([STR_Medicos:89]; | ;[STR_Medicos:89]Apellidos:7=$t_textoEditado)
				ORDER BY:C49([STR_Medicos:89];[STR_Medicos:89]Apellidos:7;>;[STR_Medicos:89]Nombres:1;>)
			End if 
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		SET_ClearSets ("seleccionMedico";"medicoSeleccionado")
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

