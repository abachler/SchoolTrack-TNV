//%attributes = {}
  //SIGE_CargaBlobNivelesMes

C_LONGINT:C283($1;$vl_no_nivel;$2;$vl_mes;$id_config_periodo)
C_POINTER:C301($3;$4;$5;$6;$7;$8;$9;$vptr_a_key_nivel;$vptr_a_key_fecha_nivel;$vptr_a_cod_respuesta_asist;$vptr_a_cod_envio_asist)
C_POINTER:C301($vptr_a_cod_envio_asist_resp;$vptr_a_error_envio_asist_resp;$vptr_a_cod_envio_msg)
C_TEXT:C284($0;$vt_detalle_nivel)

$vl_no_nivel:=$1
$vl_mes:=$2
$vptr_a_key_nivel:=$3
$vptr_a_key_fecha_nivel:=$4
$vptr_a_cod_respuesta_asist:=$5
$vptr_a_cod_envio_asist:=$6
$vptr_a_cod_envio_msg:=$7
$vptr_a_cod_envio_asist_resp:=$8
$vptr_a_error_envio_asist_resp:=$9

C_BLOB:C604($xBlob)
C_TEXT:C284($vt_detalle_nivel)

$id_config_periodo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$vl_no_nivel;->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
$vt_detalle_nivel:=""

SET BLOB SIZE:C606($xBlob;0)
$xBlob:=PREF_fGetBlob (0;"SIGE_ASIST_NIVEL_"+String:C10($vl_no_nivel)+"_MES_"+String:C10($vl_mes)+"_AÑO_"+String:C10(<>gyear);$xBlob)
BLOB_Blob2Vars (->$xBlob;0;$vptr_a_key_nivel;$vptr_a_key_fecha_nivel;$vptr_a_cod_respuesta_asist;$vptr_a_cod_envio_asist;$vptr_a_cod_envio_msg;$vptr_a_cod_envio_asist_resp;$vptr_a_error_envio_asist_resp)
SET BLOB SIZE:C606($xBlob;0)

  //Un nivel ST puede contener varios niveles con distintos roles y distintos tipos de enseñanza
ARRAY TEXT:C222($at_key_nivel_comp;0)  //para comparar lo que existe actualmente con los que hay guardado en el blob
$vt_detalle_nivel:=$vt_detalle_nivel+SIGE_Check_Niveles_en_Nivel ($vl_no_nivel;->$at_key_nivel_comp)

For ($x;1;Size of array:C274($at_key_nivel_comp))
	If (Find in array:C230($vptr_a_key_nivel->;$at_key_nivel_comp{$x})=-1)
		APPEND TO ARRAY:C911($vptr_a_key_nivel->;$at_key_nivel_comp{$x})
	End if 
End for 


  //ahora verificar los días creados para cada nivel registrado en at_key_nivel
For ($x;1;Size of array:C274($vptr_a_key_nivel->))
	
	For ($d;1;DT_GetLastDay ($vl_mes;<>gyear))
		
		$vd_fecha:=DT_GetDateFromDayMonthYear ($d;$vl_mes;<>gyear)
		$vt_key_niv_fecha:=$vptr_a_key_nivel->{$x}+"."+String:C10($vd_fecha)
		$fia:=Find in array:C230($vptr_a_key_fecha_nivel->;$vt_key_niv_fecha)
		$vb_VDate:=DateIsValid ($vd_fecha;0;$id_config_periodo)
		
		If ($fia=-1)
			If ($vb_VDate)
				APPEND TO ARRAY:C911($vptr_a_key_fecha_nivel->;$vt_key_niv_fecha)
				APPEND TO ARRAY:C911($vptr_a_cod_respuesta_asist->;0)
				APPEND TO ARRAY:C911($vptr_a_cod_envio_asist->;"")
				APPEND TO ARRAY:C911($vptr_a_cod_envio_msg->;"")
				APPEND TO ARRAY:C911($vptr_a_cod_envio_asist_resp->;0)
				APPEND TO ARRAY:C911($vptr_a_error_envio_asist_resp->;"")
			End if 
		Else 
			If (Not:C34($vb_VDate))
				DELETE FROM ARRAY:C228($vptr_a_key_fecha_nivel->;$fia;1)
				DELETE FROM ARRAY:C228($vptr_a_cod_respuesta_asist->;$fia;1)
				DELETE FROM ARRAY:C228($vptr_a_cod_envio_asist->;$fia;1)
				DELETE FROM ARRAY:C228($vptr_a_cod_envio_msg->;$fia;1)
				DELETE FROM ARRAY:C228($vptr_a_cod_envio_asist_resp->;$fia;1)
				DELETE FROM ARRAY:C228($vptr_a_error_envio_asist_resp->;$fia;1)
			End if 
		End if 
		
	End for 
	
End for 

BLOB_Variables2Blob (->$xBlob;0;$vptr_a_key_nivel;$vptr_a_key_fecha_nivel;$vptr_a_cod_respuesta_asist;$vptr_a_cod_envio_asist;$vptr_a_cod_envio_msg;$vptr_a_cod_envio_asist_resp;$vptr_a_error_envio_asist_resp)
PREF_SetBlob (0;"SIGE_ASIST_NIVEL_"+String:C10($vl_no_nivel)+"_MES_"+String:C10($vl_mes)+"_AÑO_"+String:C10(<>gyear);$xBlob)
SET BLOB SIZE:C606($xBlob;0)

$0:=$vt_detalle_nivel
