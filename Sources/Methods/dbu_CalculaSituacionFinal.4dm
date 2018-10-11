//%attributes = {}
  //dbu_CalculaSituacionFinal`


C_LONGINT:C283($0)
C_BLOB:C604($blob;$1)
C_BOOLEAN:C305($avisaBloqueo;$2)
ARRAY LONGINT:C221($aRecNums;0)
PERIODOS_Init 
C_LONGINT:C283($l_proc)

$avisaBloqueo:=True:C214
Case of 
	: (Count parameters:C259=2)
		$blob:=$1
		$avisaBloqueo:=$2
		
	: (Count parameters:C259=1)
		$blob:=$1
	Else 
		QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
End case 

  //QUERY([Alumnos];[Alumnos]Número=26)
  //SELECTION TO ARRAY([Alumnos];$aRecNums)

  //lee la fecha de bloque de recalculos automaticos
<>vd_FechaBloqueoSchoolTrack:=Date:C102(PREF_fGet (0;"BloqueoRecalculosSchoolTrack";String:C10(!00-00-00!)))

<>vb_CalculandoSitFinal:=True:C214
EVS_LoadStyles 
If (BLOB size:C605($blob)>0)
	BLOB TO VARIABLE:C533($blob;$aRecNums)
Else 
	QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
	
	  //20170126 RCH Se quitan alumnos de admisión.
	SET FIELD RELATION:C919([Alumnos:2]curso:20;Automatic:K51:4;Do not modify:K51:1)
	QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0)
	SET FIELD RELATION:C919([Alumnos:2]curso:20;Structure configuration:K51:2;Structure configuration:K51:2)
	
	ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
	SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
End if 

If (Application type:C494=4D Server:K5:6)
	vb_AsignaSituacionFinal:=False:C215
	If (<>vb_BloquearModifSituacionFinal)
		For ($i;1;Size of array:C274($aRecNums))
			GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
			$id_alumno:=[Alumnos:2]numero:1
			dbu_fEvalStudentSit2 ($id_alumno)
		End for 
	Else 
		  //CD_THERMOMETREXSEC (1;0;"Recalculando situación final de ...")
		
		$l_proc:=IT_Progress (1)
		vb_AsignaSituacionFinal:=False:C215
		For ($i;1;Size of array:C274($aRecNums))
			GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
			$id_alumno:=[Alumnos:2]numero:1
			  //CD_THERMOMETREXSEC (0;$i/Size of array($aRecNums)*100;"Recalculando situación final de "+[Alumnos]Curso+"...")
			IT_Progress (0;$l_proc;$i/Size of array:C274($aRecNums);__ ("Recalculando situación final de ")+[Alumnos:2]curso:20+__ ("..."))
			dbu_fEvalStudentSit2 ($id_alumno)
		End for 
		  //CD_THERMOMETREXSEC (-1)
		IT_Progress (-1;$l_proc)
	End if 
Else 
	If (<>vb_BloquearModifSituacionFinal)
		If ($avisaBloqueo)
			CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
		End if 
	Else 
		  //CD_THERMOMETREXSEC (1;0;__ ("Recalculando situación final de ..."))
		$l_proc:=IT_Progress (1)
		vb_AsignaSituacionFinal:=False:C215
		For ($i;1;Size of array:C274($aRecNums))
			GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
			$id_alumno:=[Alumnos:2]numero:1
			  //CD_THERMOMETREXSEC (0;$i/Size of array($aRecNums)*100;__ ("Recalculando situación final de ")+[Alumnos]Curso+__ ("..."))
			IT_Progress (0;$l_proc;$i/Size of array:C274($aRecNums);__ ("Recalculando situación final de ")+[Alumnos:2]curso:20+__ ("..."))
			dbu_fEvalStudentSit2 ($id_alumno)
		End for 
		  //CD_THERMOMETREXSEC (-1)
		IT_Progress (-1;$l_proc)
	End if 
End if 
<>vb_CalculandoSitFinal:=False:C215

