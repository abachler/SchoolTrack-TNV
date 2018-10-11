//%attributes = {}
  //UD_v20121127_EliminaSintAnual
  // ----------------------------------------------------
  // Usuario (SO): roberto
  // Fecha y hora: 27-11-12, 20:13:07
  // ----------------------------------------------------
  // Método: UD_v20121127_EliminaSintAnual
  // Descripción:
  // Metodo creado para eliminar registros sintesis anuales duplicadas con numero nivel distinto del nivel actual del alumno.
  // No se consideran como duplicados los registros de sintesis anual del mismo año con nivel inmediatamente inferior al nivel actual
  // si ese nivel esta configurado como nivel subanual (para tener en cuenta el caso de México en que el alumno puede cursar dos niveles en un mismo año
  // ESTE METODO NO DEBE SER USADO TAL CUAL SI HAY ALUMNOS QUE PUEDAN CURSAR MÁS DE DOS NIVELES EN EL MISMO AÑO
  // ----------------------------------------------------

  // Modificado por: Alberto Bachler (28-11-12)
  // - En vez de buscar todos los registrode sintesis anual del año creo una selección que contiene solo los registros de síntesis anual con ID duplicados.
  // - Excluyo de la selección de sintesis anual duplicados los registros que corresponden al nivel anterior, si ese nivel está definido como un nivel subanual (caso de México)
  // - generación de un evento en el centro de notificaciones
  // - Precisiones en la descripción del método
C_LONGINT:C283($0)

C_BOOLEAN:C305($b_esNivelSubAnual;$vb_continuar)
C_LONGINT:C283($i;$l_recNumAlumno;$l_registrosSA;$vl_cuenta;$vl_idAlumno;$vl_proc)
C_TEXT:C284($key;$t_contenidoTexto;$t_descripcion;$t_Encabezado;$t_llaveCorrecta;$t_mensajeExito;$t_mensajeFalla;$t_obsActitudP1;$t_obsActitudP2;$t_obsActitudP3;$t_obsActitudP4)
C_TEXT:C284($t_obsActitudP5;$t_obsP1;$t_obsP2;$t_obsP3;$t_obsP4;$t_obsP5;$t_uuid;$vt_obs1;$vt_obs2;$vt_obs3)

  //===== ABK =====
  // para el centro de notificaciones
ARRAY LONGINT:C221($al_colores;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY LONGINT:C221($al_IdAlumnosSA_doble;0)
ARRAY LONGINT:C221($al_recNumAlumnos;0)
ARRAY LONGINT:C221($aQR_longint1;0)
ARRAY LONGINT:C221($aRecNums;0)
ARRAY TEXT:C222($at_Alumnos;0)
ARRAY TEXT:C222($at_Errores;0)
ARRAY TEXT:C222($at_llaveCorrecta;0)
ARRAY TEXT:C222($at_llaveDuplicada;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)

If (False:C215)
	C_LONGINT:C283(UD_v20121127_EliminaSintAnual ;$0)
End if 
  //===== ABK =====



MESSAGES OFF:C175
$vl_cuenta:=0

$vl_proc:=IT_UThermometer (1;0;"Verificando registros de síntesis anual para el año "+String:C10(<>gYear)+"...")
READ WRITE:C146([Alumnos_SintesisAnual:210])
READ WRITE:C146([Alumnos:2])

STR_ReadGlobals   //para asegurarme de que las variables interproceso esten cargadas

  //===== ABK =====
  // creo una selección que contiene solo los registros de síntesis anual con ID duplicados
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
  // busco los registro de síntesis anual con nivel distinto del nivel actual de los alumnos
QUERY WITH ARRAY:C644([Alumnos_SintesisAnual:210]ID_Alumno:4;$al_IdAlumnosSA_doble)  // reemplaza la búsqueda de todos los registros SA del año
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
QUERY SELECTION BY FORMULA:C207([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6#[Alumnos:2]nivel_numero:29)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
CREATE SET:C116([Alumnos_SintesisAnual:210];"setSA")
  //===== ABK =====

  //===== ABK =====
  // excluyo de la selección de sintesis anual duplicados los registros que corresponden al nivel anterior
  // si ese nivel es un nivel subanual (mexico)
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
  //===== ABK =====

  // recorro los registros de sintesis anual para recuperar eventuales observaciones académicas que puedan
  // haber sido registradas en el registro de síntesis anual duplicado (con nivel incorrecto) y las asigno al
  // registro de síntesis anual correcto
USE SET:C118("setSA")
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Observaciones_Academicas:47#"";*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; | ;[Alumnos_SintesisAnual:210]Observaciones_Actitud:48#"";*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; | ;[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9#"")
LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$aQR_longint1;"")
For ($i;1;Size of array:C274($aQR_longint1))
	GOTO RECORD:C242([Alumnos_SintesisAnual:210];$aQR_longint1{$i})
	$t_obsP1:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
	$t_obsP2:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
	$t_obsP3:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
	$t_obsP4:=[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
	$t_obsP5:=[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230
	$t_obsActitudP1:=[Alumnos_SintesisAnual:210]P01_Observaciones_Actitud:115
	$t_obsActitudP2:=[Alumnos_SintesisAnual:210]P02_Observaciones_Actitud:144
	$t_obsActitudP3:=[Alumnos_SintesisAnual:210]P03_Observaciones_Actitud:173
	$t_obsActitudP4:=[Alumnos_SintesisAnual:210]P04_Observaciones_Actitud:202
	$t_obsActitudP5:=[Alumnos_SintesisAnual:210]P05_Observaciones_Actitud:231
	$vt_obs1:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
	$vt_obs2:=[Alumnos_SintesisAnual:210]Observaciones_Actitud:48
	$vt_obs3:=[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9
	KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_SintesisAnual:210]ID_Alumno:4)
	KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->[Alumnos:2]LlaveRegistroCicloActual:76;True:C214)
	[Alumnos_SintesisAnual:210]Observaciones_Academicas:47:=Choose:C955([Alumnos_SintesisAnual:210]Observaciones_Academicas:47#"";[Alumnos_SintesisAnual:210]Observaciones_Academicas:47;$vt_obs1)
	[Alumnos_SintesisAnual:210]Observaciones_Actitud:48:=Choose:C955([Alumnos_SintesisAnual:210]Observaciones_Actitud:48#"";[Alumnos_SintesisAnual:210]Observaciones_Actitud:48;$vt_obs2)
	[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9:=Choose:C955([Alumnos_SintesisAnual:210]ObservacionesActas_cl:9#"";[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9;$vt_obs3)
	[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114:=Choose:C955([Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114#"";[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114;$t_obsP1)
	[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143:=Choose:C955([Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143#"";[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143;$t_obsP2)
	[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172:=Choose:C955([Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172#"";[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172;$t_obsP3)
	[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201:=Choose:C955([Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201#"";[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201;$t_obsP4)
	[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230:=Choose:C955([Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230#"";[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230;$t_obsP5)
	[Alumnos_SintesisAnual:210]P01_Observaciones_Actitud:115:=Choose:C955([Alumnos_SintesisAnual:210]P01_Observaciones_Actitud:115#"";[Alumnos_SintesisAnual:210]P01_Observaciones_Actitud:115;$t_obsActitudP1)
	[Alumnos_SintesisAnual:210]P02_Observaciones_Actitud:144:=Choose:C955([Alumnos_SintesisAnual:210]P02_Observaciones_Actitud:144#"";[Alumnos_SintesisAnual:210]P02_Observaciones_Actitud:144;$t_obsActitudP2)
	[Alumnos_SintesisAnual:210]P03_Observaciones_Actitud:173:=Choose:C955([Alumnos_SintesisAnual:210]P03_Observaciones_Actitud:173#"";[Alumnos_SintesisAnual:210]P03_Observaciones_Actitud:173;$t_obsActitudP3)
	[Alumnos_SintesisAnual:210]P04_Observaciones_Actitud:202:=Choose:C955([Alumnos_SintesisAnual:210]P04_Observaciones_Actitud:202#"";[Alumnos_SintesisAnual:210]P04_Observaciones_Actitud:202;$t_obsActitudP4)
	[Alumnos_SintesisAnual:210]P05_Observaciones_Actitud:231:=Choose:C955([Alumnos_SintesisAnual:210]P05_Observaciones_Actitud:231#"";[Alumnos_SintesisAnual:210]P05_Observaciones_Actitud:231;$t_obsActitudP5)
	
	SAVE RECORD:C53([Alumnos_SintesisAnual:210])
	KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
End for 

  //elimino y verifico que no tengan registros de calificaciones
If (Records in set:C195("setSA")>0)
	USE SET:C118("setSA")
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$aQR_longint1;"")
	For ($i;1;Size of array:C274($aQR_longint1))
		READ WRITE:C146([Alumnos_SintesisAnual:210])
		GOTO RECORD:C242([Alumnos_SintesisAnual:210];$aQR_longint1{$i})
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Llave_Alumno:495=[Alumnos_SintesisAnual:210]LlavePrincipal:5)
		If (Records in selection:C76([Alumnos_Calificaciones:208])=0)
			$vl_idAlumno:=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$vl_idAlumno)
			$t_llaveCorrecta:=KRL_MakeStringAccesKey (-><>ginstitucion;-><>gYear;->[Alumnos:2]nivel_numero:29;->$vl_idAlumno)
			$key:=KRL_MakeStringAccesKey (-><>ginstitucion;-><>gYear;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->$vl_idAlumno)
			QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]LlavePrincipal:5=$key)
			$vb_continuar:=False:C215
			Case of 
				: ([Alumnos_SintesisAnual:210]NumeroNivel:6=0)  //nivel 0 no existe. Se elimina
					$vb_continuar:=True:C214
				: ([Alumnos_SintesisAnual:210]NumeroNivel:6<-6)  //sintesis para alumnos en admision no existen
					$vb_continuar:=True:C214
				: (([Alumnos_SintesisAnual:210]NumeroNivel:6>18) & ([Alumnos_SintesisAnual:210]NumeroNivel:6#Nivel_Egresados) & ([Alumnos_SintesisAnual:210]NumeroNivel:6#Nivel_Retirados))  //sintesis con nivel mayor a 12 y distinto de retirados y egresados no deberian existir.
					$vb_continuar:=True:C214
				: ([Alumnos_SintesisAnual:210]NumeroNivel:6>[Alumnos:2]nivel_numero:29)  //no puede haber SA con numero de nivel superior al del alumno
					$vb_continuar:=True:C214
				Else 
					
			End case 
			If ($vb_continuar)
				  //===== ABK =====
				APPEND TO ARRAY:C911($al_colores;Green:K11:9)
				APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
				APPEND TO ARRAY:C911($at_Errores;"Alumno con registro de síntesis anual duplicada")
				APPEND TO ARRAY:C911($at_Alumnos;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]apellidos_y_nombres:40))
				APPEND TO ARRAY:C911($at_llaveCorrecta;$t_llaveCorrecta)
				APPEND TO ARRAY:C911($at_llaveDuplicada;[Alumnos_SintesisAnual:210]LlavePrincipal:5)
				$l_recNumAlumno:=Find in field:C653([Alumnos:2]numero:1;[Alumnos_SintesisAnual:210]ID_Alumno:4)
				If ($l_recNumAlumno>=0)
					APPEND TO ARRAY:C911($al_recNumAlumnos;$l_recNumAlumno)
				End if 
				  //===== ABK =====
				DELETE RECORD:C58([Alumnos_SintesisAnual:210])
				$vl_cuenta:=$vl_cuenta+1
			Else 
				
			End if 
		End if 
		KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
	End for 
	KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
Else 
	
End if 
IT_UThermometer (-2;$vl_proc)
SET_ClearSets ("setSA")

  //===== ABK =====
  //Para mostrar el resultado en el centro de notificaciones
If (Size of array:C274($at_Errores)>0)
	$t_Encabezado:="Verificación de registros de síntesis anual"
	$t_descripcion:="Se detectaron registros de síntesis anual duplicados para algunos alumnos.\rLos duplicados fueron eliminados.\r"
	$t_descripcion:=$t_descripcion+"La lista a continuación muestra el detalle de las anomalías detectadas."
	$t_contenidoTexto:=""
	
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Alumno")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Llave correcta")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Llave Duplicada")
	
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
  //===== ABK =====

