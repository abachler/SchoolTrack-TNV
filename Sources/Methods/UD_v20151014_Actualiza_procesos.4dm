//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Jorge Valenzuela
  // Fecha y hora: 19-10-15, 13:43:01
  // ----------------------------------------------------
  // Método: UD_v20151014_Actualiza_procesos_SN3
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------
C_LONGINT:C283($element;$element2;$i;$x)
C_TEXT:C284($itemText;$Metodo_SN)

ARRAY LONGINT:C221($al_grupos_recnum;0)
ARRAY TEXT:C222($at_alias_procesos;0)

APPEND TO ARRAY:C911($at_alias_procesos;"SchoolNet 3 Opciones Generales")
APPEND TO ARRAY:C911($at_alias_procesos;"SchoolNet 3 Opciones de Publicación")
APPEND TO ARRAY:C911($at_alias_procesos;"SchoolNet 3 Plantillas de Publicación")
APPEND TO ARRAY:C911($at_alias_procesos;"SchoolNet 3 Usuarios y Contraseñas")
APPEND TO ARRAY:C911($at_alias_procesos;"SchoolNet 3 Opciones de Envío")
APPEND TO ARRAY:C911($at_alias_procesos;"SchoolNet 3 Consulta de Usuarios")
APPEND TO ARRAY:C911($at_alias_procesos;"SchoolNet 3 Registro de Actividades")
APPEND TO ARRAY:C911($at_alias_procesos;"SchoolNet 3 Actualización de Datos")
  //validacion de
$Metodo_SN:="CFG_SchoolNetConfiguration"
READ ONLY:C145([xShell_UserGroups:17])
ALL RECORDS:C47([xShell_UserGroups:17])
SELECTION TO ARRAY:C260([xShell_UserGroups:17];$al_grupos_recnum)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Actualizando Grupos...")
For ($i;1;Size of array:C274($al_grupos_recnum))
	GOTO RECORD:C242([xShell_UserGroups:17];$al_grupos_recnum{$i})
	BLOB_Blob2Vars (->[xShell_UserGroups:17]xCommands:5;0;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
	$element:=Find in array:C230(<>aAuthMethodsNames;$Metodo_SN)
	If ($element>0)
		  //elimino el proceso que antes se validaba para realizar validacion de cada menu
		  //AT_Delete ($element;1;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
		For ($x;1;Size of array:C274($at_alias_procesos))
			
			  //agrego validacion de menu SN
			$itemText:=$at_alias_procesos{$x}
			$element2:=Find in array:C230(<>aAuthMethodsAlias;$itemText)
			If ($element2<0)
				AT_Insert (0;1;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
				  //<>aAuthMethodsAlias{Size of array(<>aAuthMethodsAlias)}:=$itemText
				READ ONLY:C145([xShell_ExecutableCommands:19])
				XS_SearchCommandAlias (<>vtXS_CountryCode;<>vtXS_Langage;$itemText)
				<>aAuthMethodsAlias{Size of array:C274(<>aAuthMethodsAlias)}:=$itemText
				<>aAuthMethodsNames{Size of array:C274(<>aAuthMethodsNames)}:=[xShell_ExecutableCommands:19]MethodName:2
			End if 
		End for 
		READ WRITE:C146([xShell_UserGroups:17])
		GOTO RECORD:C242([xShell_UserGroups:17];$al_grupos_recnum{$i})
		BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
		SAVE RECORD:C53([xShell_UserGroups:17])
		KRL_UnloadReadOnly (->[xShell_UserGroups:17])
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_grupos_recnum))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
