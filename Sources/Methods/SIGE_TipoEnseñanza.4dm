//%attributes = {}
  //SIGE_TipoEnseñanza

C_BLOB:C604($x_blob)
C_POINTER:C301($1;$vptr_array_TipoEn)
$vptr_array_TipoEn:=$1
ARRAY TEXT:C222($at_DatosUnidadesEduc_Values;0)
C_TEXT:C284($error)
C_LONGINT:C283($resp_continuar)

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
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Ingreso de Tipo de enseñanaza...")
	
	For ($i;1;Size of array:C274($vptr_array_TipoEn->))
		$vi_try:=0
		$fia:=Find in array:C230(al_cod_tipo_ens;Num:C11($vptr_array_TipoEn->{$i}))
		$resp_continuar:=1
		
		If (al_cod_ejec_tipo_ens{$fia}=1)
			$resp_continuar:=CD_Dlog (0;"El tipo de enseñanza "+$vptr_array_TipoEn->{$i}+", ya cuenta con un envío satisfactorio. ¿Desea continuar?";"";"Si";"No")
		End if 
		
		If ($resp_continuar=1)
			
			$prefRecord:="MatriculaInicial_"+$vptr_array_TipoEn->{$i}
			BLOB_Variables2Blob (->$x_blob;0;->$at_DatosUnidadesEduc_Values)
			$x_Blob:=PREF_fGetBlob (0;$prefRecord;$x_Blob)
			BLOB_Blob2Vars (->$x_Blob;0;->$at_DatosUnidadesEduc_Values)
			
			If (Size of array:C274($at_DatosUnidadesEduc_Values)=0)
				CD_Dlog (0;"Por favor proceda a configurar el tipo de enseñanza "+$vptr_array_TipoEn->{$i}+", haciendo clic en Configurar tipos de enseñanzas y vuelva a inetentar el envío")
				$i:=Size of array:C274($vptr_array_TipoEn->)
			Else 
				$resp:=""
				While ((($resp="6") | ($resp="")) & ($vi_try<2))
					$resp:=WS_SIGE_TipoEnsenanza (->$at_DatosUnidadesEduc_Values;$seed;->$error)
					DELAY PROCESS:C323(Current process:C322;150)
					If ($resp="6")
						$seed:=WS_SIGE_Get_Semilla 
						$vi_try:=$vi_try+1
					End if 
				End while 
				
				If ($fia>0)
					al_cod_ejec_tipo_ens{$fia}:=Num:C11($resp)
					If ($resp="1")
						$error:="Ingreso satisfactorio "+String:C10(Current date:C33(*))+" - "+String:C10(Current time:C178(*))
					End if 
					at_listado_error_tipo_ens{$fia}:=$error
				End if 
				
			End if 
			
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($vptr_array_TipoEn->))
		
	End for 
	
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	at_ultima_ejec{2}:=String:C10(Current date:C33(*))+" - "+String:C10(Current time:C178(*))
	SIGE_LoadDataArrays (2)
End if 