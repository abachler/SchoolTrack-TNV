If ((<>alUSR_GroupIds{<>atUSR_GroupNames}#-15001) & (<>alUSR_GroupIds{<>atUSR_GroupNames}#-15002))
	If ((<>lUSR_CurrentUserID=[xShell_UserGroups:17]Propietary:3) | (<>lUSR_CurrentUserID<0))
		If (<>atUSR_GroupNames>0)
			$ok:=CD_Dlog (0;__ ("¿Desea realmente eliminar este grupo?");__ ("");__ ("No");__ ("Si"))
			If ($ok=2)
				USR_DeleteGroup (<>alUSR_GroupIds{<>atUSR_GroupNames})
				AT_Delete (<>atUSR_GroupNames;1;-><>atUSR_GroupNames;-><>alUSR_GroupIds)
				<>atUSR_GroupNames:=0
				ARRAY TEXT:C222(<>aMembers;0)
				ARRAY LONGINT:C221(<>aMembersID;0)
				USR_LoadPasswordTables   // AS. 20110719 Se agrega para que no haya problemas con los record number despues de eliminar algun grupo.
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("Usted no es propietario de este grupo.\rEl grupo no puede ser eliminado."))
	End if 
Else 
	CD_Dlog (0;__ ("El grupo ")+<>atUSR_GroupNames{<>atUSR_GroupNames}+__ (" es un grupo por defecto.\rEl grupo no puede ser eliminado."))
End if 
