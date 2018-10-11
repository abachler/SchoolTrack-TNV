//%attributes = {}
  //`PF_fSave 

C_LONGINT:C283($0)
$0:=0
If (USR_checkRights ("M";->[Profesores:4]))
	  //If (KRL_RegistroFueModificado (->[Profesores]) | (AsigAutorizada) | (ProfCarrera) | (campopropio))  //sub records de carreras y asignaturasAutorizadas.ABC//197852 
	
	  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
	If (KRL_RegistroFueModificado (->[Profesores:4]) | (AsigAutorizada) | (ProfCarrera) | (vb_guardarCambios))
		
		If ((<>al_IDNational_Mandatory{2} ?? 1) & ([Profesores:4]RUT:27="") & ($0>=0))
			$ignore:=CD_Dlog (0;__ ("Debe completar el campo ^0";<>at_IDNacional_Names{1}))
			$0:=-1
		End if 
		
		If ((<>al_IDNational_Mandatory{2} ?? 2) & ([Profesores:4]IDNacional_2:42="") & ($0>=0))
			$ignore:=CD_Dlog (0;__ ("Debe completar el campo ^0";<>at_IDNacional_Names{2}))
			$0:=-1
		End if 
		
		If ((<>al_IDNational_Mandatory{2} ?? 3) & ([Profesores:4]IDNacional_3:43="") & ($0>=0))
			$ignore:=CD_Dlog (0;__ ("Debe completar el campo ^0";<>at_IDNacional_Names{3}))
			$0:=-1
		End if 
		
		
		If (([Profesores:4]Apellido_paterno:3="") & ($0>=0))
			$ignore:=CD_Dlog (0;__ ("Debe completar el campo apellido paterno"))
			$0:=-1
		End if 
		
		If ($0>=0)
			[Profesores:4]Apellido_paterno:3:=ST_Format (->[Profesores:4]Apellido_paterno:3)
			[Profesores:4]Apellido_materno:4:=ST_Format (->[Profesores:4]Apellido_materno:4)
			[Profesores:4]Nombres:2:=ST_Format (->[Profesores:4]Nombres:2)
			[Profesores:4]Apellidos_y_nombres:28:=Replace string:C233([Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4+" "+[Profesores:4]Nombres:2;"  ";" ")
			[Profesores:4]Apellidos_y_nombres:28:=ST_Format (->[Profesores:4]Apellidos_y_nombres:28)
			[Profesores:4]Nombres_apellidos:40:=Replace string:C233([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
			[Profesores:4]Nombres_apellidos:40:=ST_Format (->[Profesores:4]Nombres_apellidos:40)
			[Profesores:4]Iniciales:29:=ST_Uppercase (Substring:C12([Profesores:4]Nombres:2;1;1)+Substring:C12([Profesores:4]Apellido_paterno:3;1;1)+Substring:C12([Profesores:4]Apellido_materno:4;1;1))
			
			If (([Profesores:4]Nombre_comun:21="") & ([Profesores:4]Apellido_paterno:3#"") & ([Profesores:4]Nombres:2#""))
				[Profesores:4]Nombre_comun:21:=ST_GetWord ([Profesores:4]Nombres:2;1)+" "+[Profesores:4]Apellido_paterno:3
			End if 
			If ([Profesores:4]Numero:1=<>lUSR_RelatedTableUserID)
				<>tUSR_CurrentUserName:=[Profesores:4]Nombre_comun:21
			End if 
			[Profesores:4]_ModifiedBy:48:=<>tUSR_CurrentUser
			SAVE RECORD:C53([Profesores:4])
			
			If ([Profesores:4]Inactivo:62)  //MONO TICKET 207269
				NIV_QuitarResponbleNivel ([Profesores:4]Numero:1)
			End if 
			
			TGR_Profesores 
			
			$0:=1
		End if 
	End if 
End if 