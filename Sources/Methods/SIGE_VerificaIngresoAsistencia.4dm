//%attributes = {}
  //SIGE_VerificaIngresoAsistencia

C_LONGINT:C283($1;$2;$vl_nivel;$vl_mes)
C_POINTER:C301($ptr_array_keys;$3)

$vl_nivel:=$1
$vl_mes:=$2
$ptr_array_keys:=$3  // arreglos con los códigos de solicitud de ingreso

ARRAY TEXT:C222($at_key_nivel;0)
ARRAY TEXT:C222($at_key_fecha_nivel;0)
ARRAY LONGINT:C221($al_cod_respuesta_asist;0)
ARRAY TEXT:C222($at_cod_envio_asist;0)  //código para consultar como fue procesado nuestro envío
ARRAY TEXT:C222($at_envio_asist_msg;0)
ARRAY LONGINT:C221($al_cod_envio_asist_resp;0)
ARRAY TEXT:C222($at_error_envio_asist_resp;0)

$vt_detalle_nivel:=SIGE_CargaBlobNivelesMes ($vl_nivel;$vl_mes;->$at_key_nivel;->$at_key_fecha_nivel;->$al_cod_respuesta_asist;->$at_cod_envio_asist;->$at_envio_asist_msg;->$al_cod_envio_asist_resp;->$at_error_envio_asist_resp)

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

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando envíos de asistencia...")

For ($i;1;Size of array:C274($ptr_array_keys->))
	$vi_try:=0
	$fia:=Find in array:C230($at_key_fecha_nivel;$ptr_array_keys->{$i})
	
	If ($fia>0)
		ARRAY TEXT:C222($at_exploded;0)
		AT_Text2Array (->$at_exploded;$at_key_fecha_nivel{$i};".")
		$vt_msg:=""
		If (Size of array:C274($at_exploded)>0)
			$resp:=""
			While ((($resp="6") | ($resp="")) & ($vi_try<2))
				
				DELAY PROCESS:C323(Current process:C322;160)
				$vt_detalle_verificacion:=""
				$resp:=WS_SIGE_VerificaIngresoAsist ($at_exploded{1};$at_cod_envio_asist{$fia};$seed;->$vt_detalle_verificacion)
				
				If ($resp="6")
					$seed:=WS_SIGE_Get_Semilla 
					$vi_try:=$vi_try+1
				Else 
					
					If ($resp#"0")
						$al_cod_envio_asist_resp{$fia}:=Num:C11($resp)
						$at_error_envio_asist_resp{$fia}:=$vt_detalle_verificacion
					End if 
					
				End if 
				
			End while 
		End if 
		
	End if 
	
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($ptr_array_keys->);"Verificando envíos de asistencia...")
	
End for 

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

C_BLOB:C604($xBlob)
SET BLOB SIZE:C606($xBlob;0)

BLOB_Variables2Blob (->$xBlob;0;->$at_key_nivel;->$at_key_fecha_nivel;->$al_cod_respuesta_asist;->$at_cod_envio_asist;->$at_envio_asist_msg;->$al_cod_envio_asist_resp;->$at_error_envio_asist_resp)
PREF_SetBlob (0;"SIGE_ASIST_NIVEL_"+String:C10($vl_nivel)+"_MES_"+String:C10($vl_mes)+"_AÑO_"+String:C10(<>gyear);$xBlob)
SET BLOB SIZE:C606($xBlob;0)

at_ultima_ejec{4}:=String:C10(Current date:C33(*))+" - "+String:C10(Current time:C178(*))
