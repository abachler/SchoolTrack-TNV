$proc:=IT_UThermometer (1;0;__ ("Enviando petición a Schoolnet ..."))


If (advice_op1=1)
	
	$res:=sn3ws_ActuaDatos_CorreoAvisoAct (<>gRolBD;<>vtXS_CountryCode)
	
Else 
	
	ARRAY LONGINT:C221($al_id_per;0)
	COPY ARRAY:C226(al_id_per_actuadatos_temp;$al_id_per)
	
	If (Size of array:C274($al_id_per)>500)
		
		$ws_calls:=Round:C94(Size of array:C274($al_id_per)/500;0)
		
		For ($n;1;$ws_calls)
			ARRAY LONGINT:C221($id_temp;0)
			$x:=0
			While (($x<500) & (Size of array:C274($al_id_per)>0))
				APPEND TO ARRAY:C911($id_temp;$al_id_per{1})
				DELETE FROM ARRAY:C228($al_id_per;1;1)
				$x:=$x+1
			End while 
			$vt_ids:="["+AT_array2text (->$id_temp;",")+"]"
			$res:=sn3ws_ActuaDatos_envia_correo_s (<>gRolBD;<>vtXS_CountryCode;$vt_ids)
			DELAY PROCESS:C323(Current process:C322;60)
		End for 
		
	Else 
		
		$vt_ids:="["+AT_array2text (->$al_id_per;",")+"]"
		sn3ws_ActuaDatos_envia_correo_s (<>gRolBD;<>vtXS_CountryCode;$vt_ids)
	End if 
	
End if 

$msg:="Se solicita el envío de notificación por correo a los padres para actualizar sus datos y los de sus hijos"
LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")
IT_UThermometer (-2;$proc)