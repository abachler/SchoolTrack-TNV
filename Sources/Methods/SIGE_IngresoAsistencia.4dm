//%attributes = {}
  //SIGE_IngresoAsistencia 
C_LONGINT:C283($1;$2;$vl_nivel;$vl_mes)
C_BOOLEAN:C305($vb_verif_fecha;$3)

$vl_nivel:=$1
$vl_mes:=$2

If (Count parameters:C259=4)
	$vb_verif_fecha:=$3
	$ptr_array_keys:=$4  //key = rol+tipo_enseñanza+cod_grado+fecha
End if 

ARRAY LONGINT:C221($al_alu_num;0)
C_LONGINT:C283($i;$x;$j;$d)
C_DATE:C307($fecha_indice;$vd_ini;$vd_fin)
C_TEXT:C284($vt_msg;$vt_msg_envio)

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

If ($seed="")
	CD_Dlog (0;"El servicio web del Mineduc no responde. Por favor intentar más tarde")
	
Else 
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Enviado asistencia ")
	
	For ($i;1;Size of array:C274($at_key_fecha_nivel))
		$vi_try:=0
		  //If ($al_cod_respuesta_asist{$i}=0)
		ARRAY TEXT:C222($at_exploded;0)
		AT_Text2Array (->$at_exploded;$at_key_fecha_nivel{$i};".")
		$vt_msg:=""
		If (Size of array:C274($at_exploded)=4)
			
			$resp:=""
			
			While ((($resp="") | ($resp="2") | ($resp="5") | ($resp="6") | ($resp="7")) & ($vi_try<3))
				  //esto valida cuando el usuario seleccionó días en la visualización de detalle por mes para el envío
				$fia:=1
				If ($vb_verif_fecha)  //para solo consultar las fechas seleccionadas en el formulario
					$fia:=Find in array:C230($ptr_array_keys->;$at_key_fecha_nivel{$i})
				End if 
				
				If ($fia>0)
					$vt_msg_envio:=""
					$vt_codigo_envio_asistencia:=""  //esto es para consultar el estado de la petición de ingreso de asistencia otro WS y también el detalle del cuando hay un error en este llamado
					$resp:=WS_SIGE_IngresoAsistencia ($vl_nivel;$at_exploded{1};$at_exploded{2};$at_exploded{3};$at_exploded{4};$seed;->$vt_codigo_envio_asistencia;->$vt_msg_envio)
					DELAY PROCESS:C323(Current process:C322;160)
					$vt_msg:="Enviado asistencia "+$at_exploded{4}+" del nivel "+String:C10($vl_nivel)+" ROLBD "+$at_exploded{4}
				Else 
					$resp:="0"
				End if 
				
				
				If ($resp="6")
					$seed:=WS_SIGE_Get_Semilla 
				Else 
					If ($resp#"0")
						$al_cod_respuesta_asist{$i}:=Num:C11($resp)
						$at_cod_envio_asist{$i}:=$vt_codigo_envio_asistencia
						$at_envio_asist_msg{$i}:=$vt_msg_envio
						$al_cod_envio_asist_resp{$i}:=0
						$at_error_envio_asist_resp{$i}:=""
					End if 
				End if 
				
				$vi_try:=$vi_try+1
			End while 
			
		End if 
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($at_key_fecha_nivel);$vt_msg)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
End if 

C_BLOB:C604($xBlob)
SET BLOB SIZE:C606($xBlob;0)

BLOB_Variables2Blob (->$xBlob;0;->$at_key_nivel;->$at_key_fecha_nivel;->$al_cod_respuesta_asist;->$at_cod_envio_asist;->$at_envio_asist_msg;->$al_cod_envio_asist_resp;->$at_error_envio_asist_resp)
PREF_SetBlob (0;"SIGE_ASIST_NIVEL_"+String:C10($vl_nivel)+"_MES_"+String:C10($vl_mes)+"_AÑO_"+String:C10(<>gyear);$xBlob)
SET BLOB SIZE:C606($xBlob;0)

at_ultima_ejec{4}:=String:C10(Current date:C33(*))+" - "+String:C10(Current time:C178(*))
