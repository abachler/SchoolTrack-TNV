//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket 175179
  // Fecha y hora: 09-05-17, 08:48:41
  // ----------------------------------------------------
  // Método: LOG_RegistraCambiosPropDeEval
  // Descripción: Registra los cambios efectuados en la ventana de propiedades de evaluación.
  // 
  //
  // Parámetros 
  // $1 de tipo texto, nombre del objeto sobre el que se efectuó una acción
  // $2 de tipo longint, valor que asumió el objeto sobre el que se efectuó una acción
  // $3 de tipo longint, id de la asignatura para la cual se modificaron las propiedades de evaluación
  // $4 de tipo boolean, para indicar si el mensaje debe ser retornado en $0
  // ----------------------------------------------------

C_POINTER:C301($y_variable)
C_DATE:C307($vd_fechaEnArray)
C_BOOLEAN:C305($vb_retornaTexto;$vb_registraLog)
C_LONGINT:C283($vl_valor;$vl_modulo;$vl_asignaturaNum;$vl_evento;$vl_fila;$vl_col)
C_TEXT:C284($vt_accion;$vt_opcion;$vt_winTitle;$vt_log;$vt_asignatura;$vt_curso;$vt_textoBoton;$0)


$vb_retornaTexto:=False:C215
$vb_registraLog:=False:C215
$vl_asignaturaNum:=0

$vt_accion:=$1

If (Count parameters:C259>=2)
	$vt_opcion:=$2
End if 
If (Count parameters:C259>=3)
	$vl_valor:=$3->
End if 
If (Count parameters:C259>=4)
	$vl_asignaturaNum:=$4
End if 
If (Count parameters:C259>=5)
	$vb_retornaTexto:=$5
End if 


Case of 
	: ("DeclaraArreglos"=$vt_accion)
		
		ARRAY DATE:C224(ad_temFechasBloqueo1;0)
		ARRAY DATE:C224(ad_temFechasBloqueo2;0)
		ARRAY DATE:C224(ad_temFechasBloqueo3;0)
		ARRAY DATE:C224(ad_temFechasBloqueo4;0)
		ARRAY DATE:C224(ad_temFechasBloqueo5;0)
		
	: ("CopiaArreglos"=$vt_accion)
		
		COPY ARRAY:C226(ad_BloqueoParcial_p1;ad_temFechasBloqueo1)
		COPY ARRAY:C226(ad_BloqueoParcial_p2;ad_temFechasBloqueo2)
		COPY ARRAY:C226(ad_BloqueoParcial_p3;ad_temFechasBloqueo3)
		COPY ARRAY:C226(ad_BloqueoParcial_p4;ad_temFechasBloqueo4)
		COPY ARRAY:C226(ad_BloqueoParcial_p5;ad_temFechasBloqueo5)
		
	: ("GuardaLog"=$vt_accion)
		
		If (Not:C34($vt_opcion="bOk") & Not:C34($vt_opcion="bCancel") & Not:C34($vt_opcion="bconsolidar") & Not:C34($vt_opcion="bbloqueoparciales"))  // botones entre formularios
			
			If (Not:C34((OBJECT Get pointer:C1124(Object with focus:K67:3)->=xALP_CsdList2)))
				
				If ($vt_opcion="FechaBloqueoParciales")  // nombre ListBox
					LISTBOX GET CELL POSITION:C971(*;"FechaBloqueoParciales";$vl_col;$vl_fila;$vy_arrayPeriodo)
					If ($vl_col>1)  //MONO Ticket 215087
						$vd_fechaEnArray:=$vy_arrayPeriodo->{$vl_fila}
						If ($vd_fechaEnArray#ad_temFechasBloqueo1{$vl_fila})
							$vb_registraLog:=True:C214
							$vt_log:="Asignación de fecha de límite para ingreso de evaluación Parcial "+String:C10($vl_fila)
							$vt_log:=$vt_log+", en el período "+String:C10($vl_col-1)+". Valor anterior: "+String:C10(ad_temFechasBloqueo1{$vl_fila})+", Nuevo Valor: "+String:C10($vd_fechaEnArray)+". "
						End if 
					End if 
				Else 
					$vb_registraLog:=True:C214
					$vt_winTitle:=Get window title:C450
					$vt_textoBoton:=OBJECT Get title:C1068(*;$vt_opcion)
					If ($vt_opcion#"ponderacion(2)")  // checkBox - optionButtom
						$vt_log:="Modificación en "+Choose:C955($vt_winTitle#"";$vt_winTitle;"")
						$vt_log:=$vt_log+" en el atributo "+ST_Qte ($vt_textoBoton)+", valor asignado: "+String:C10($vl_valor)+". "
					Else 
						If ($vt_opcion="ponderacion(2)")  // modificación de la caja de texto, cantidad de decimales
							$vt_log:="Modificación en Cálculo de resultado con "+String:C10(vi_DecimalesPonderacion)+"\" decimales; "+("con troncatura"*vi_PonderacionTruncada)+("con aproximación"*Num:C11(vi_PonderacionTruncada=0))+" "
						End if 
					End if 
				End if 
				
				If ($vl_asignaturaNum>0)
					$vt_asignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$vl_asignaturaNum;->[Asignaturas:18]denominacion_interna:16)
					$vt_log:=$vt_log+$vt_asignatura+" (id "+String:C10($vl_asignaturaNum)+")"
					$vt_curso:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$vl_asignaturaNum;->[Asignaturas:18]Curso:5)
					$vt_log:=$vt_log+" ["+$vt_curso+"]"
				End if 
				$vt_log:=$vt_log+"."
				
				If ($vb_retornaTexto)
					$0:=$vt_log
				Else 
					If (($vb_registraLog))
						APPEND TO ARRAY:C911(atSTR_EventLog;$vt_log)
					End if 
				End if 
				
			Else 
				  // los cambios en la grilla son logueado en el callBack 'xALCB_STR_PropiedadesEvaluacion'
			End if 
		End if 
		
		  //MONO TICKET 187619
		  //: ("LimpiaArreglos"=$vt_accion)
		  //AT_Initialize (->ad_BloqueoParcial_p1;->ad_BloqueoParcial_p2;->ad_BloqueoParcial_p3;->ad_BloqueoParcial_p4;->ad_BloqueoParcial_p5)
		
End case 