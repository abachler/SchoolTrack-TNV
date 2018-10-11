  // [Alumnos].Editor.listaMedicos()
  // Por: Alberto Bachler K.: 26-06-14, 18:12:14
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_itemSeleccionado;$l_refVentana)
C_BOOLEAN:C305($b_Actualizar)
ARRAY TEXT:C222($at_popupItems;0)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			APPEND TO ARRAY:C911($at_popupItems;__ ("Seleccionar Médico…"))
			If (Records in set:C195("medicosAlumno")>0)
				GOTO SELECTED RECORD:C245([STR_Medicos:89];Selected record number:C246([STR_Medicos:89]))
				APPEND TO ARRAY:C911($at_popupItems;__ ("Detalles…"))
				APPEND TO ARRAY:C911($at_popupItems;"(-")
				If (SMTP_VerifyEmailAddress ([STR_Medicos:89]eMail:5;False:C215)#"")
					APPEND TO ARRAY:C911($at_popupItems;__ ("Enviar email…"))
				Else 
					APPEND TO ARRAY:C911($at_popupItems;"("+__ ("Enviar email…"))
				End if 
				APPEND TO ARRAY:C911($at_popupItems;"(-")
				APPEND TO ARRAY:C911($at_popupItems;__ ("Quitar"))
			Else 
				APPEND TO ARRAY:C911($at_popupItems;"("+__ ("Detalles…"))
				APPEND TO ARRAY:C911($at_popupItems;"(-")
				APPEND TO ARRAY:C911($at_popupItems;"("+("Enviar email…"))
				APPEND TO ARRAY:C911($at_popupItems;"(-")
				APPEND TO ARRAY:C911($at_popupItems;"("+__ ("Quitar"))
			End if 
			
			$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_popupItems)
			Case of 
					
				: ($l_itemSeleccionado=1)
					REDUCE SELECTION:C351([STR_Medicos:89];0)
					$l_refVentana:=WDW_OpenFormWindow (->[STR_Medicos:89];"Editor";-1;Plain form window:K39:10;__ ("Medicos"))
					DIALOG:C40([STR_Medicos:89];"Editor")
					$b_Actualizar:=True:C214
					
				: ($l_itemSeleccionado=2)
					$l_refVentana:=WDW_OpenFormWindow (->[STR_Medicos:89];"Editor";-1;Plain form window:K39:10;__ ("Medicos"))
					DIALOG:C40([STR_Medicos:89];"Editor")
					$b_Actualizar:=True:C214
					
					
				: ($l_itemSeleccionado=4)
					OPEN URL:C673("mailto:"+[STR_Medicos:89]eMail:5)
					
				: ($l_itemSeleccionado=6)
					QUERY:C277([xxSTR_Link_AlumnosMedicos:237];[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3=[STR_Medicos:89]Auto_UUID:6;*)
					QUERY:C277([xxSTR_Link_AlumnosMedicos:237]; & ;[xxSTR_Link_AlumnosMedicos:237]UUID_Alumno:2=[Alumnos:2]auto_uuid:72)
					KRL_DeleteRecord (->[xxSTR_Link_AlumnosMedicos:237])
					$b_Actualizar:=True:C214
					
			End case 
			
		End if 
		
		
	: (Form event:C388=On Double Clicked:K2:5)
		
		If (Records in set:C195("medicosAlumno")=1)
			USE SET:C118("medicosAlumno")
		Else 
			REDUCE SELECTION:C351([STR_Medicos:89];0)
		End if 
		$l_refVentana:=WDW_OpenFormWindow (->[STR_Medicos:89];"Editor";-1;Plain form window:K39:10;__ ("Medicos"))
		DIALOG:C40([STR_Medicos:89];"Editor")
		$b_Actualizar:=True:C214
		
End case 

If ($b_Actualizar)
	READ ONLY:C145([STR_Medicos:89])
	QUERY:C277([xxSTR_Link_AlumnosMedicos:237];[xxSTR_Link_AlumnosMedicos:237]UUID_Alumno:2=[Alumnos:2]auto_uuid:72)
	KRL_RelateSelection (->[STR_Medicos:89]Auto_UUID:6;->[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3)
	ORDER BY:C49([STR_Medicos:89];[STR_Medicos:89]Apellidos:7;>;[STR_Medicos:89]Nombres:1;>)
End if 