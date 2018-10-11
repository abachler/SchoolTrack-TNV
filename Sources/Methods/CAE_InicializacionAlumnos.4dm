//%attributes = {}
  //CAE_InicializacionAlumnos
C_BOOLEAN:C305($reprobado)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Inicialización de registros de alumnos…")+String:C10(<>gYear))

C_POINTER:C301($1;$y_al_idAlumno)  //MONO 184433
If (Count parameters:C259=1)
	$y_al_idAlumno:=$1  //MONO 184433
	QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$y_al_idAlumno->)  //MONO 184433
Else 
	QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelRegular)  //MONO 184433
End if 

QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT")
ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]no_de_lista:53;>)
ARRAY LONGINT:C221($aRecNum;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNum;"")

For ($i;1;Size of array:C274($aRecNum))
	READ WRITE:C146([Alumnos:2])
	GOTO RECORD:C242([Alumnos:2];$aRecNum{$i})
	[Alumnos:2]Observaciones_Periodo1:44:=""
	[Alumnos:2]Observaciones_Periodo2:45:=""
	[Alumnos:2]Observaciones_Periodo3:46:=""
	[Alumnos:2]Observaciones_Periodo4:55:=""
	[Alumnos:2]Observaciones_Periodo5:106:=""
	[Alumnos:2]Observaciones_finales:47:=""
	$reprobado:=False:C215
	Case of 
		: (<>vtXS_CountryCode="cl")
			If ([Alumnos:2]Situacion_final:33#"P")
				$reprobado:=True:C214
			End if 
			
		: (<>vtXS_CountryCode="pe")
			If (([Alumnos:2]Situacion_final:33#"A") & ([Alumnos:2]Situacion_final:33#"RR") & ([Alumnos:2]Situacion_final:33#"C"))
				$reprobado:=True:C214
			End if 
			
		: (<>vtXS_CountryCode="co")
			If ([Alumnos:2]Situacion_final:33="NP")  //en CO la situación de reprobación es NP
				$reprobado:=True:C214
			End if 
			
		: (<>vtXS_CountryCode="ve")
			If ([Alumnos:2]Situacion_final:33#"P")
				$reprobado:=True:C214
			End if 
			
		: (<>vtXS_CountryCode="ar")
			If ([Alumnos:2]Situacion_final:33#"P")
				$reprobado:=True:C214
			End if 
			
		Else 
			If ([Alumnos:2]Situacion_final:33#"P")
				$reprobado:=True:C214
			End if 
	End case 
	
	[Alumnos:2]Es_Repitente:77:=$reprobado
	[Alumnos:2]Situacion_final:33:=""
	[Alumnos:2]Porcentaje_asistencia:56:=100
	[Alumnos:2]Promedio_General_Numerico:57:=0
	[Alumnos:2]Promedio_Periodo1:59:=""
	[Alumnos:2]Promedio_Periodo2:60:=""
	[Alumnos:2]Promedio_Periodo3:61:=""
	[Alumnos:2]Promedio_Periodo4:62:=""
	[Alumnos:2]Promedio_Periodo5:107:=""
	[Alumnos:2]Promedio_Anual:63:=""
	[Alumnos:2]Observaciones_en_Acta:58:=""
	[Alumnos:2]Promedio_General_Oficial:32:=""
	[Alumnos:2]Comentario_Situacion_Final:31:=""
	[Alumnos:2]Promedio_General_Interno:88:=""
	If (bColacion=1)
		[Alumnos:2]Colación:52:=False:C215
	End if 
	If (bFotografia=1)
		[Alumnos:2]Fotografía:78:=[Alumnos:2]Fotografía:78*0
	End if 
	SAVE RECORD:C53([Alumnos:2])
	AL_CreaRegistros 
	BBL_CreateUserRecord (2)
	
	GOTO RECORD:C242([Alumnos:2];$aRecNum{$i})
	Case of 
		: (<>vtXS_CountryCode="cl")
			AL_CreateGradeRecords 
			
		: ((<>vtXS_CountryCode="co") | (<>vtXS_CountryCode="ar") | (<>vtXS_CountryCode="pe") | (<>vtXS_CountryCode="mx"))
			If (cb_InscribeEnAsignaturas=1)  // solo se inscribe a los alumnos en las asignaturas obligatorias cuando la opción   `ha sido seleccionada
				AL_CreateGradeRecords 
			Else 
				  // en caso contrario no se hace nada
			End if 
	End case 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNum);__ (""))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
