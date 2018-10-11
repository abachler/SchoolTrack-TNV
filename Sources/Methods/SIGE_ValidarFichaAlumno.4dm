//%attributes = {}
  //SIGE_ValidarFichaAlumno 
READ ONLY:C145([Alumnos:2])

C_LONGINT:C283($i)
C_TEXT:C284($resp;$seed;$error)
C_POINTER:C301($1)
ARRAY LONGINT:C221($al_rn_alu;0)

If (Count parameters:C259=0)
	QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesActivos)
	QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)  //filtrar Cursos ADT
	KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
Else 
	QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$1->)
End if 

ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_rn_alu;"")

$seed:=""
$vi_try:=0

While ($vi_try<2)
	$seed:=WS_SIGE_Get_Semilla 
	If ($seed="")
		$vi_try:=$vi_try+1
	Else 
		$vi_try:=2
	End if 
End while 

If ($seed="")
	CD_Dlog (0;"El servicio web del Mineduc no responde. Por favor intentar más tarde")
	
Else 
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando Alumnos...")
	
	For ($i;1;Size of array:C274($al_rn_alu))
		GOTO RECORD:C242([Alumnos:2];$al_rn_alu{$i})
		$resp:=""
		$vi_try:=0
		
		If ([Alumnos:2]RUT:5#"")
			
			While ((($resp="6") | ($resp="")) & ($vi_try<2))
				
				$resp:=WS_SIGE_GetValidacionAlumno ($seed;->$error)
				DELAY PROCESS:C323(Current process:C322;150)
				If ($resp="6")
					$seed:=WS_SIGE_Get_Semilla 
					$vi_try:=$vi_try+1
				End if 
				
			End while 
			
		Else 
			$resp:="-1"
		End if 
		
		$fia:=Find in array:C230(al_id_alumno;[Alumnos:2]numero:1)
		If ($fia>0)
			al_cod_ejec_alu{$fia}:=Num:C11($resp)
		End if 
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_rn_alu);"Verificando Alumno..."+[Alumnos:2]apellidos_y_nombres:40)
		
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	at_ultima_ejec{1}:=String:C10(Current date:C33(*))+" - "+String:C10(Current time:C178(*))
	SIGE_LoadDataArrays (1)
End if 