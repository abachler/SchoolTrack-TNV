//%attributes = {}
  //SIGE_IngresoCurso

READ ONLY:C145([Cursos:3])
C_POINTER:C301($1;$vptr_arr_cur)
C_LONGINT:C283($i;$vi_try)
C_TEXT:C284($resp;$seed;$error)
$vptr_arr_cur:=$1
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
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Ingresando curso ...")
	
	For ($i;1;Size of array:C274($vptr_arr_cur->))
		$vi_try:=0
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$vptr_arr_cur->{$i})
		$resp:=""
		
		$fia:=Find in array:C230(at_curso;$vptr_arr_cur->{$i})
		$resp_continuar:=1
		
		If (al_cod_ejec_curso{$fia}=1)
			$resp_continuar:=CD_Dlog (0;"El curso "+$vptr_arr_cur->{$i}+", ya cuenta con un envío satisfactorio. ¿Desea continuar?";"";"Si";"No")
		End if 
		
		If ($resp_continuar=1)
			
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($vptr_arr_cur->);"Ingresando curso "+[Cursos:3]Curso:1)
			
			While ((($resp="6") | ($resp="")) & ($vi_try<2))
				
				$resp:=WS_SIGE_IngresoCurso ($seed;->$error)
				DELAY PROCESS:C323(Current process:C322;150)
				If ($resp="6")
					$seed:=WS_SIGE_Get_Semilla 
					$vi_try:=$vi_try+1
				End if 
				
			End while 
			
			$fia:=Find in array:C230(at_curso;$vptr_arr_cur->{$i})
			
			If ($fia>0)
				al_cod_ejec_curso{$fia}:=Num:C11($resp)
				Case of 
					: (al_cod_ejec_curso{$fia}=1)
						at_listado_error_curso{$fia}:="Ingreso satisfactorio "+String:C10(Current date:C33(*))+" - "+String:C10(Current time:C178(*))
					: (al_cod_ejec_curso{$fia}=-10)
						at_listado_error_curso{$fia}:=$error
					: (al_cod_ejec_curso{$fia}=-9)
						at_listado_error_curso{$fia}:=vt_sige_ing_cur_log
					: (al_cod_ejec_curso{$fia}=2)
						at_listado_error_curso{$fia}:=$error
				End case 
			End if 
			
		End if 
		
	End for 
	
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	at_ultima_ejec{3}:=String:C10(Current date:C33(*))+" - "+String:C10(Current time:C178(*))
	SIGE_LoadDataArrays (3)
	
End if 