  // Método: CIM_Principal.Botón
  //
  //
  // por Alberto Bachler Klein
  // creación 05/05/17, 17:09:17
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($i;$i_descripciones;$l_desde;$l_documentos;$l_filas;$l_hasta;$l_maxRegistros;$l_numeroFilas;$l_progreso;$l_resultado)
C_TIME:C306($h_refDoc)
C_POINTER:C301($y_pointer1)
C_TEXT:C284($t_carpeta;$t_nombreDoc;$t_ruta;$t_texto)

ARRAY POINTER:C280($ay_datos;0)
ARRAY TEXT:C222($at_descripcion;0)
ARRAY TEXT:C222($at_docs;0)
ARRAY TEXT:C222($at_dts;0)
ARRAY TEXT:C222($at_encabezados;0)
ARRAY TEXT:C222($at_modulo;0)
ARRAY TEXT:C222($at_texto;0)
ARRAY TEXT:C222($at_usuario;0)

$l_numeroFilas:=Records in selection:C76([xShell_Logs:37])


COPY NAMED SELECTION:C331([xShell_Logs:37];"$actividad")


$l_maxRegistros:=30000
If (Dec:C9(Records in selection:C76([xShell_Logs:37])/$l_maxRegistros)>0)
	$l_documentos:=Int:C8(Records in selection:C76([xShell_Logs:37])/$l_maxRegistros)+1
Else 
	$l_documentos:=Records in selection:C76([xShell_Logs:37])/$l_maxRegistros
End if 

ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
If ($l_documentos=1)
	$t_nombreDoc:=Select document:C905(SYS_CarpetaAplicacion (CLG_DocumentosLocal);".xls";"Guardar como…";File name entry:K24:17;$at_docs)
	If ($t_nombreDoc#"")
		$t_ruta:=$at_docs{1}
	End if 
	SELECTION TO ARRAY:C260([xShell_Logs:37]Module:8;$at_modulo;[xShell_Logs:37]DTS:12;$at_dts;[xShell_Logs:37]Event_Description:5;$at_descripcion;[xShell_Logs:37]UserName:2;$at_usuario)
	AT_Initialize (->$at_encabezados)
	AT_Initialize (->$ay_datos)
	AT_AppendItems2TextArray (->$at_encabezados;"Modulo";"Fecha";"Descripción";"Usuario")
	AT_AppendToPointerArray (->$ay_datos;->$at_Modulo;->$at_dts;->$at_descripcion;->$at_usuario)
	$l_progreso:=Progress New 
	Progress SET ICON ($l_progreso;<>p_iconoColegium)
	Progress SET TITLE ($l_progreso;"Preparando exportación del Registro de Actividades…";0;"";True:C214)
	Progress SET TITLE ($l_progreso;"Exportando Registro de Actividades…";0;"";True:C214)
	CREATE FOLDER:C475($t_ruta;*)
	$h_refDoc:=Create document:C266($t_ruta)
	CLOSE DOCUMENT:C267($h_refDoc)
	$l_resultado:=XLS_GeneraArchivo ($t_ruta;"Registro de actividades";"Registro de actividades";->$at_encabezados;->$ay_datos;$l_progreso)
	Progress QUIT ($l_progreso)
Else 
	$l_desde:=1
	$l_hasta:=$l_maxRegistros
	
	$t_carpeta:=Select folder:C670("Seleccione la carpeta en la que desea guardar el registro de actividad…")
	If (OK=1)
		AT_AppendItems2TextArray (->$at_encabezados;"Modulo";"Fecha";"Descripción";"Usuario")
		AT_AppendToPointerArray (->$ay_datos;->$at_Modulo;->$at_dts;->$at_descripcion;->$at_usuario)
		$l_progreso:=Progress New 
		For ($i;1;$l_documentos)
			Progress SET ICON ($l_progreso;<>p_iconoColegium)
			Progress SET TITLE ($l_progreso;"Preparando Registro de actividades…";0;"";True:C214)
			Progress SET MESSAGE ($l_progreso;String:C10($i)+__ (" de ")+String:C10($l_documentos)+__ (" documentos"))
			SELECTION RANGE TO ARRAY:C368($l_desde;$l_hasta;[xShell_Logs:37]Module:8;$at_modulo;[xShell_Logs:37]DTS:12;$at_dts;[xShell_Logs:37]Event_Description:5;$at_descripcion;[xShell_Logs:37]UserName:2;$at_usuario)
			For ($i_descripciones;1;Size of array:C274($at_descripcion))
				$t_texto:=$at_descripcion{$i_descripciones}
				$t_texto:=Replace string:C233($t_texto;"\t";" ")
				$t_texto:=Replace string:C233($t_texto;"\n";"\r")
				$t_texto:=Replace string:C233($t_texto;"\r\r";"\r")
				
				Case of 
					: ($at_descripcion{$i_descripciones}="Ejecucion de código@")
						$at_descripcion{$i_descripciones}:="Ejecucion de código"
						
					: (ST_countlines ($t_texto)>24)
						AT_Text2Array (->$at_texto;$t_texto;"\r")
						AT_RedimArrays (24;->$at_texto)
						APPEND TO ARRAY:C911($at_texto;"…")
						$t_texto:=AT_array2text (->$at_texto;"\r")
						
					: (Length:C16($t_texto)>1024)
						$t_texto:=Substring:C12($t_texto;1;1024)
				End case 
				
				If (Position:C15("<SPAN";$t_texto)>0)
					$t_texto:=ST Get plain text:C1092($t_texto)
				End if 
			End for 
			
			
			$t_ruta:=$t_carpeta+"Actividad - "+Replace string:C233($at_DTS{1};":";"-")+" a "+Replace string:C233($at_dts{Size of array:C274($at_dts)};":";"-")+".xls"
			CREATE FOLDER:C475($t_ruta;*)
			$h_refDoc:=Create document:C266($t_ruta)
			CLOSE DOCUMENT:C267($h_refDoc)
			AT_Initialize (->$at_encabezados)
			AT_Initialize (->$ay_datos)
			AT_AppendItems2TextArray (->$at_encabezados;"Modulo";"Fecha";"Descripción";"Usuario")
			AT_AppendToPointerArray (->$ay_datos;->$at_Modulo;->$at_dts;->$at_descripcion;->$at_usuario)
			Progress SET TITLE ($l_progreso;"Exportando Registro de actividades…";0;"";True:C214)
			Progress SET MESSAGE ($l_progreso;String:C10($i)+__ (" de ")+String:C10($l_documentos)+__ (" documentos"))
			$l_resultado:=XLS_GeneraArchivo ($t_ruta;"Registro de actividades";"Registro de actividades";->$at_encabezados;->$ay_datos;$l_progreso)
			$l_desde:=$l_desde+$l_maxRegistros
			$l_hasta:=$l_hasta+$l_maxRegistros
		End for 
		Progress QUIT ($l_progreso)
	End if 
End if 

USE NAMED SELECTION:C332("$actividad")
CLEAR NAMED SELECTION:C333("$actividad")

If ($l_resultado=1)
	If ($l_documentos=1)
		OPEN URL:C673($t_ruta)
	Else 
		SHOW ON DISK:C922($t_carpeta;*)
	End if 
End if 
  //End if




