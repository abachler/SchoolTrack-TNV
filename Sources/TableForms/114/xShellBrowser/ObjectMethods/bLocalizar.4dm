C_REAL:C285($left;$top;$right;$bottom;$tableNum;$fieldNum)
C_TEXT:C284($varName)
C_POINTER:C301($btnptr)
$btnptr:=Self:C308
RESOLVE POINTER:C394($btnptr;$varName;$tableNum;$fieldNum)
OBJECT GET COORDINATES:C663($btnptr->;$left;$top;$right;$bottom)
Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		Case of 
			: (vsBWR_CurrentModule="SchoolTrack")
				Case of 
					: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
						API Create Tip ("Ubicación actual del alumno";$left;$top;$right;$bottom)
					: (Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4]))
						API Create Tip ("Ubicación actual del profesor";$left;$top;$right;$bottom)
				End case 
			: (vsBWR_CurrentModule="AccountTrack")
				
		End case 
	Else 
		ARRAY LONGINT:C221(ai_selected;0)
		ARRAY LONGINT:C221(al_recNums;0)
		C_LONGINT:C283($result;$i)
		$result:=AL_GetSelect (xALP_Browser;ai_selected)
		For ($i;1;Size of array:C274(ai_selected))
			APPEND TO ARRAY:C911(al_recNums;alBWR_recordNumber{ai_selected{$i}})
		End for 
		Case of 
			: (vsBWR_CurrentModule="SchoolTrack")
				Case of 
					: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
						If (Size of array:C274(al_recNums)>0)  //se valida por tabla para que en las pestañas que no esto no está implementado no aparezca mensaje alguno
							WDW_OpenPopupWindow (Self:C308;->[xShell_Dialogs:114];"Localiza_AlumnoProfesor";2)
							DIALOG:C40([xShell_Dialogs:114];"Localiza_AlumnoProfesor")
							CLOSE WINDOW:C154
						Else 
							CD_Dlog (0;__ ("Para utilizar esta función usted debe seleccionar uno o más registros del explorador."))
						End if 
					: (Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4]))
						If (Size of array:C274(al_recNums)>0)  //se valida por tabla para que en las pestañas que no esto no está implementado no aparezca mensaje alguno
							WDW_OpenPopupWindow (Self:C308;->[xShell_Dialogs:114];"Localiza_AlumnoProfesor";2)
							DIALOG:C40([xShell_Dialogs:114];"Localiza_AlumnoProfesor")
							CLOSE WINDOW:C154
						Else 
							CD_Dlog (0;__ ("Para utilizar esta función usted debe seleccionar uno o más registros del explorador"))
						End if 
				End case 
			: (vsBWR_CurrentModule="AccountTrack")
				
		End case 
End case 