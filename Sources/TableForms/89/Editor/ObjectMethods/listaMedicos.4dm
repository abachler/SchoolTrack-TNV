  // [STR_Medicos].Input.listaMedicos()
  // Por: Alberto Bachler K.: 27-06-14, 16:54:00
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_registroSeleccionado)
C_POINTER:C301($y_listaMedicos)


Case of 
	: (Form event:C388=On Selection Change:K2:29)
		If (Records in set:C195("seleccionMedico")=1)
			CUT NAMED SELECTION:C334([STR_Medicos:89];"listaMedicos")
			USE SET:C118("seleccionMedico")
			CREATE SET:C116([STR_Medicos:89];"medicoSeleccionado")
			If (Find in field:C653([xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3;[STR_Medicos:89]Auto_UUID:6)<0)
				OBJECT SET ENABLED:C1123(*;"eliminarMedico";True:C214)
			Else 
				OBJECT SET ENABLED:C1123(*;"eliminarMedico";False:C215)
			End if 
			
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_medicoAsignado)
			QUERY:C277([xxSTR_Link_AlumnosMedicos:237];[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3=[STR_Medicos:89]Auto_UUID:6;*)
			QUERY:C277([xxSTR_Link_AlumnosMedicos:237]; & ;[xxSTR_Link_AlumnosMedicos:237]UUID_Alumno:2=[Alumnos:2]auto_uuid:72)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ($l_medicoAsignado=0)
				OBJECT SET ENABLED:C1123(*;"seleccionarMedico";True:C214)
			Else 
				OBJECT SET ENABLED:C1123(*;"seleccionarMedico";False:C215)
			End if 
			
			USE NAMED SELECTION:C332("listaMedicos")
			$l_registroSeleccionado:=Selected record number:C246([STR_Medicos:89])
			COPY SET:C600("medicoSeleccionado";"seleccionMedico")
			
			
		Else 
			OBJECT SET ENABLED:C1123(*;"eliminarMedico";False:C215)
			OBJECT SET ENABLED:C1123(*;"seleccionarMedico";False:C215)
		End if 
		
		
	: (Form event:C388=On Double Clicked:K2:5)
		  // MOD Ticket N° 216021 Patricio Aliaga 20180905
		If (Records in set:C195("medicoSeleccionado")>0)
			CUT NAMED SELECTION:C334([STR_Medicos:89];"listaMedicos")
			USE SET:C118("seleccionMedico")
			KRL_ReloadInReadWriteMode (->[STR_Medicos:89])
			OBJECT SET RGB COLORS:C628(*;"boton";Foreground color:K23:1;Background color:K23:2)
			OBJECT SET TITLE:C194(*;"boton";__ ("Editar"))
			OBJECT SET ENTERABLE:C238(*;"campo@";False:C215)
			FORM GOTO PAGE:C247(2)
			USE NAMED SELECTION:C332("listaMedicos")
			$l_registroSeleccionado:=Selected record number:C246([STR_Medicos:89])
			COPY SET:C600("medicoSeleccionado";"seleccionMedico")
		End if 
End case 
