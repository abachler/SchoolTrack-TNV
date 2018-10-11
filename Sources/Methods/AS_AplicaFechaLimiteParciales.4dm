//%attributes = {}
  //AS_AplicaFechaLimiteParciales
  //MONO
ARRAY DATE:C224($ad_fechas;0)

C_TEXT:C284($t_nodo;$t_log)
C_LONGINT:C283($i;$n_periodo;$l_idTermometro)
C_POINTER:C301($1;$y_ArrayRecNumAsig)
C_OBJECT:C1216($2;$o_fechas)

$y_ArrayRecNumAsig:=$1
$o_fechas:=$2

$l_idTermometro:=IT_Progress (1;0;0;"Aplicando Fechas límites para parciales ...")

For ($i;1;Size of array:C274($y_ArrayRecNumAsig->))
	
	READ WRITE:C146([Asignaturas:18])
	GOTO RECORD:C242([Asignaturas:18];$y_ArrayRecNumAsig->{$i})
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($y_ArrayRecNumAsig->);"Aplicando Fechas límites para parciales: "+"\r"+[Asignaturas:18]denominacion_interna:16+" - "+[Asignaturas:18]Curso:5)
	
	$t_log:=[Asignaturas:18]denominacion_interna:16+" "+[Asignaturas:18]Curso:5
	
	If (Locked:C147([Asignaturas:18]))
		$t_log:=$t_log+" no fue posible aplicar masivamente bloqueo de parciales por registro en uso mientras se ejecutaba el proceso."
	Else 
		$t_log:=$t_log+" aplicada masivamente bloqueo de parciales de la siguiente forma:"+"\r"
		
		For ($n_periodo;1;5)  //periodos 
			$t_nodo:="LimiteIngresoParciales_P"+String:C10($n_periodo)
			If (OB Is defined:C1231($o_fechas;$t_nodo))
				ARRAY DATE:C224($ad_fechas;0)
				OB_GET ($o_fechas;->$ad_fechas;$t_nodo)
				If (Not:C34(OB Is defined:C1231([Asignaturas:18]Configuracion:63;$t_nodo)))
					OB_AppendNode ([Asignaturas:18]Configuracion:63;$t_nodo)
				End if 
				OB_SET ([Asignaturas:18]Configuracion:63;->$ad_fechas;$t_nodo)
				$t_log:=$t_log+"Periodo "+String:C10($n_periodo)+": "+AT_array2text (->$ad_fechas)+"\r"
			End if 
		End for 
		
		C_OBJECT:C1216($objeto)
		$objeto:=[Asignaturas:18]Configuracion:63
		[Asignaturas:18]Configuracion:63:=$objeto
		SAVE RECORD:C53([Asignaturas:18])
		
		LOG_RegisterEvt ($t_log)
	End if 
	
	KRL_UnloadReadOnly (->[Asignaturas:18])
	
End for 

  //HACER EL LOG DE ESTA ACCION 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)