//%attributes = {}
  // dbu_VerificaSintesisAnualActual()
  // Verifica que los registros de síntesis anual sean únicos para el año actual
  // teniendo en cuenta que es posible que un alumno puede tener dos registros de sintesis actual
  // si el nivel inmediatamente anterior al nivel actual del alumno ha sido configurado como nivel subanual
  // Muestra el resultado en el centro de notificaciones
  // - nombre del alumno
  // - llave correcta del registro de síntesis anual
  // - llaves incorrectas
  // Este método no corrige las anomalías detectadas
  // Para corregir anomalías con registros duplicados con nivel incorrecto se puede usar el método UD_v20121127_EliminaSintAnual
  // después de leer atentamenta la descripción y los comentarios en ese método
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 28/11/12, 15:38:17
  // ---------------------------------------------
C_LONGINT:C283($0)

C_BOOLEAN:C305($b_esNivelSubAnual)
C_LONGINT:C283($i;$l_proc;$l_registrosSA)
C_TEXT:C284($t_contenidoTexto;$t_descripcion;$t_Encabezado;$t_llavesIncorrectas;$t_mensajeExito;$t_mensajeFalla;$t_uuid)

ARRAY LONGINT:C221($al_colores;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY LONGINT:C221($al_IdAlumnosSA_doble;0)
ARRAY LONGINT:C221($al_recNumAlumnos;0)
ARRAY LONGINT:C221($aRecNums;0)
ARRAY TEXT:C222($at_Alumnos;0)
ARRAY TEXT:C222($at_Errores;0)
ARRAY TEXT:C222($at_llaveCorrecta;0)
ARRAY TEXT:C222($at_llaveDuplicada;0)
ARRAY TEXT:C222($at_LLavesIncorrectas;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)
If (False:C215)
	C_LONGINT:C283(dbu_VerificaSintesisAnualActual ;$0)
End if 

  // CODIGO
$l_proc:=IT_UThermometer (1;0;"Verificando registros de síntesis anual para el año "+String:C10(<>gYear)+"...")
  // genero un arreglo con los alumnos que realmente tienen más de un registro de sintesis anual duplicados
QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta;*)
QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<Nivel_Egresados)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums;"")
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosSA)
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1)
	If ($l_registrosSA>1)
		APPEND TO ARRAY:C911($al_IdAlumnosSA_doble;[Alumnos:2]numero:1)
	End if 
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)

  // busco los registro de síntesis anual de esos alumnos
QUERY WITH ARRAY:C644([Alumnos_SintesisAnual:210]ID_Alumno:4;$al_IdAlumnosSA_doble)  // reemplaza la búsqueda de todos los registros SA del año
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
QUERY SELECTION BY FORMULA:C207([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6#[Alumnos:2]nivel_numero:29)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
CREATE SET:C116([Alumnos_SintesisAnual:210];"setSA")

  // exluyo de la selección de sintesis anual duplicados los registros que corresponden al nivel anterior
  // si ese nivel es un nivel subanual
LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$aRecNums;"")
  //Recorro los registros de síntesis anual con numero de nivel distinto al nivel actual del alumno
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Alumnos_SintesisAnual:210];$aRecNums{$i})
	$b_esNivelSubAnual:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]Es_Nivel_SubAnual:50)
	If (([Alumnos_SintesisAnual:210]NumeroNivel:6=([Alumnos:2]nivel_numero:29-1)) & ($b_esNivelSubAnual))
		  // si el numero de nivel del registro de síntesis es igual al nivel inmediatamente inferior al nivel actual del alumno
		  // y el atributo [xxSTR_Niveles]Es_Nivel_SubAnual para ese nivel es verdadero
		REMOVE FROM SET:C561([Alumnos_SintesisAnual:210];"setSA")
	End if 
End for 

USE SET:C118("setSA")
KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_SintesisAnual:210]ID_Alumno:4)
If (Records in set:C195("setSA")>0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]ID_Alumno:4;=;[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]LlavePrincipal:5;#;[Alumnos:2]LlaveRegistroCicloActual:76)
		If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
			$t_llavesIncorrectas:=""
			While (Not:C34(End selection:C36([Alumnos_SintesisAnual:210])))
				If (Is in set:C273("setSA"))
					$t_llavesIncorrectas:=$t_llavesIncorrectas+[Alumnos_SintesisAnual:210]LlavePrincipal:5+"; "
				End if 
				NEXT RECORD:C51([Alumnos_SintesisAnual:210])
			End while 
			APPEND TO ARRAY:C911($al_colores;Red:K11:4)
			APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
			APPEND TO ARRAY:C911($at_Errores;"Alumno con registro de síntesis anual duplicada")
			APPEND TO ARRAY:C911($at_Alumnos;[Alumnos:2]apellidos_y_nombres:40)
			APPEND TO ARRAY:C911($at_llaveDuplicada;Substring:C12($t_llavesIncorrectas;1;Length:C16($t_llavesIncorrectas)-2))
			APPEND TO ARRAY:C911($at_llaveCorrecta;[Alumnos:2]LlaveRegistroCicloActual:76)
			APPEND TO ARRAY:C911($al_recNumAlumnos;Record number:C243([Alumnos:2]))
		End if 
	End for 
End if 
IT_UThermometer (-2;$l_proc)
SET_ClearSets ("setSA")

If (Size of array:C274($at_Errores)>0)
	$t_Encabezado:="Verificación de registros de síntesis anual"
	$t_descripcion:="Se detectaron registros de síntesis anual con llaves incorrectas para algunos alumnos."
	$t_descripcion:=$t_descripcion+"La lista a continuación muestra el detalle de las anomalías detectadas."
	$t_contenidoTexto:=""
	
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Alumno")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Llave correcta")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Llaves incorrectas")
	
	  // creo el registro de notificación y obtengo su UUID que me servirá para pasarle la información de despliegue
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	  // paso los arreglos (siempre texto) que se mostrarán en el centro de notificaciones, el primer arreglo contiene los títulos de columnas
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_Alumnos;->$at_llaveCorrecta;->$at_llaveDuplicada)
	  // paso los arreglos con los estilos y colores para el despliegue en el centro de notificaciones
	NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
	
	  // si quiero que el usuario pueda listar los registros relacionados con los problemas detectados en el Centro de notificaciones
	NTC_Mensaje_DatosExplorador ($t_uuid;"SchoolTrack";Table:C252(->[Alumnos:2]);->$al_recNumAlumnos)
	
	  // si quiero que este mismo método pueda ser reejecutado desde el centro de notificaciones
	  // paso el nombre del método, y los mensajes que se mostrarán después de la ejecución
	$t_mensajeFalla:="Se detectaron registros de síntesis anual duplicados para algunos alumnos."
	$t_mensajeExito:="No se detectaron anomalías con los registros de síntesis anual."
	NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name:C684;$t_mensajeFalla;$t_mensajeExito)
	$0:=-1
Else 
	$0:=0
End if 

