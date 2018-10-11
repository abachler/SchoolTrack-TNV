//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 14-08-18, 10:08:54
  // ----------------------------------------------------
  // Método: UD_v20180814_FixNameAuthProcess
  // Descripción: actualizar los nombres de los procesos autorizados en lso grupos cuando este cambia en el Shell
  // ----------------------------------------------------

C_LONGINT:C283($i;$m;$fia;$l_soa_Alias;$l_soa_MethodName;$l_idTermometro)
C_BOOLEAN:C305($b_actualizar;$b_save)
ARRAY LONGINT:C221($al_UsrGps;0)
ARRAY TEXT:C222($at_AliasMetodosUG;0)  //Nombres de los procesos Autorizados en los grupos (Alias para los métodos)
ARRAY TEXT:C222($at_NombresMetodosUG;0)  //Nombres de los métodos de los procesos Autorizados en los grupos

READ ONLY:C145([xShell_UserGroups:17])
QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1#-15001)  //dejamos fuera al grupo de administración
LONGINT ARRAY FROM SELECTION:C647([xShell_UserGroups:17];$al_UsrGps;"")

$l_idTermometro:=IT_Progress (1;0;0;__ ("Actualizando Nombres de procesos autorizados ..."))

For ($i;1;Size of array:C274($al_UsrGps))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_UsrGps))
	
	READ WRITE:C146([xShell_UserGroups:17])
	GOTO RECORD:C242([xShell_UserGroups:17];$al_UsrGps{$i})
	$b_save:=False:C215
	If (BLOB size:C605([xShell_UserGroups:17]xCommands:5)>0)
		BLOB_Blob2Vars (->[xShell_UserGroups:17]xCommands:5;0;->$at_AliasMetodosUG;->$at_NombresMetodosUG)
		$b_actualizar:=True:C214
		$l_soa_Alias:=Size of array:C274($at_AliasMetodosUG)
		$l_soa_MethodName:=Size of array:C274($at_NombresMetodosUG)
		  //revisar los tamaños de los arrays, en pruebas encontré que algunos no estaban con el mimso tamaño
		Case of 
			: ($l_soa_Alias>$l_soa_MethodName)  //Alias mayor a Metodos
				  //Quizas eliminar porque no sabemos si corresponden realmente a un método, podemos buscar en <>atUSR_Commands para actualizar
				  //Por ahora no lo voy a actualizar
				$b_actualizar:=False:C215
			: ($l_soa_MethodName>$l_soa_Alias)  //Metodo mayor que Alias 
				  //reseteamos el array de alias para que se actualice completo
				ARRAY TEXT:C222($at_AliasMetodosUG;0)
				ARRAY TEXT:C222($at_AliasMetodosUG;$l_soa_MethodName)
		End case 
		
		If ($b_actualizar)
			For ($m;1;Size of array:C274($at_NombresMetodosUG))
				$fia:=Find in array:C230(<>atUSR_MethodNames;$at_NombresMetodosUG{$m})
				
				If ($fia>0)
					If (<>atUSR_Commands{$fia}#$at_AliasMetodosUG{$m})  //Si los alias son distintos actualizamos el del grupo
						$at_AliasMetodosUG{$m}:=<>atUSR_Commands{$fia}
						$b_save:=True:C214
					End if 
				End if 
				
			End for 
			
			If ($b_save)
				BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;->$at_AliasMetodosUG;->$at_NombresMetodosUG)
				SAVE RECORD:C53([xShell_UserGroups:17])
			End if 
		End if 
		
	End if 
	KRL_UnloadReadOnly (->[xShell_UserGroups:17])
End for 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)