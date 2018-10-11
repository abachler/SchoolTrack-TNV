//%attributes = {"executedOnServer":true}
  //  TMT_AsistImport_GpUntis
  //MONO:

READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Profesores:4])
READ ONLY:C145([Alumnos_Calificaciones:208])
READ ONLY:C145([Alumnos:2])

C_TIME:C306($ref)
C_BLOB:C604($1;$x_file)
C_TEXT:C284($t_ruta;$t_curso;$text;$delimiter;$t_nivel;$t_separador;$2)
C_LONGINT:C283($i;$l_idTermometro;$l_recnum_asig;$l_IDprofe;$fia)
C_BOOLEAN:C305($b_encabezado;$3)
  //C_POINTER($y_oFound;$3;$y_oNotFound;$4)
C_OBJECT:C1216($o_horario;$o_obj;$o_dias;$o_dia;$o_horas;$0;$o_result)

ARRAY TEXT:C222($at_key;0)
ARRAY TEXT:C222($at_nombrePropiedades;0)
ARRAY OBJECT:C1221($ao_objetos;0)
ARRAY TEXT:C222($at_cursosAsig;0)

$o_horario:=OB_Create 
$o_sinAsignaturas:=OB_Create 
$o_result:=OB_Create 

$x_file:=$1
$t_separador:=$2
$b_encabezado:=$3
  //cambios para ejecución en el servidor
$t_ruta:=SYS_GetServer_4DFolder (Database folder:K5:14)+DTS_Get_GMT_TimeStamp +"_imp_horario_temp.txt"
BLOB TO DOCUMENT:C526($t_ruta;$x_file)

If (OK=1)
	
	If (SYS_IsWindows )
		USE CHARACTER SET:C205("windows-1252";1)
	Else 
		USE CHARACTER SET:C205("MacRoman";1)
	End if 
	
	$delimiter:=ACTabc_DetectDelimiter ($t_ruta)
	$ref:=Open document:C264($t_ruta;"";Read mode:K24:5)
	If ($b_encabezado)
		RECEIVE PACKET:C104($ref;$text;$delimiter)  //saltamos encabezados 
	End if 
	RECEIVE PACKET:C104($ref;$text;$delimiter)  //tomamos la primera linea 
	
	$l_idTermometro:=IT_Progress (1;0;0;"Leyendo Archivo ...")
	
	While ($text#"")
		
		$l_idTermometro:=IT_Progress (0;$l_idTermometro;Get document position:C481($ref)/Get document size:C479($t_ruta);"Leyendo archivo")
		
		$t_codigo:=Replace string:C233(ST_GetWord ($text;1;$t_separador);"\"";"";*)
		$t_curso:=Replace string:C233(ST_GetWord ($text;2;$t_separador);"\"";"";*)
		$t_prof:=Replace string:C233(ST_GetWord ($text;3;$t_separador);"\"";"";*)
		$t_asig:=Replace string:C233(ST_GetWord ($text;4;$t_separador);"\"";"";*)
		$t_sala:=Replace string:C233(ST_GetWord ($text;5;$t_separador);"\"";"";*)
		$l_dia:=Num:C11(ST_GetWord ($text;6;$t_separador))
		$l_hora:=Num:C11(ST_GetWord ($text;7;$t_separador))
		$t_nodoAsig:=$t_codigo+"_"+$t_asig+"_"+$t_prof+"_"+$t_curso
		
		$l_recnum_asig:=-1
		  //BUSCAR LA ASIGNATURA CON EL BLOQUE
		$t_codinterno:=ST_GetCleanString ($t_codigo+$t_curso+$t_asig+$t_sala)
		  //$l_recnum_asig:=Find in field([Asignaturas]Codigo_interno;$t_codinterno)
		QUERY BY ATTRIBUTE:C1331([Asignaturas:18];[Asignaturas:18]Opciones:57;"impHorarioCode";=;$t_codinterno)
		If (Records in selection:C76([Asignaturas:18])>0)
			$l_recnum_asig:=Record number:C243([Asignaturas:18])
		End if 
		If ($l_recnum_asig=-1)  //20170302 RCH
			$t_codinterno:=ST_GetCleanString ($t_codigo+$t_curso+$t_asig)
			QUERY BY ATTRIBUTE:C1331([Asignaturas:18];[Asignaturas:18]Opciones:57;"impHorarioCode";=;$t_codinterno)
			If (Records in selection:C76([Asignaturas:18])>0)
				$l_recnum_asig:=Record number:C243([Asignaturas:18])
			End if 
			  //$l_recnum_asig:=Find in field([Asignaturas]Codigo_interno;$t_codinterno)
		End if 
		
		If ($l_recnum_asig=-1)
			$t_codinterno:=ST_GetCleanString ($t_codigo+$t_asig+$t_sala)
			QUERY BY ATTRIBUTE:C1331([Asignaturas:18];[Asignaturas:18]Opciones:57;"impHorarioCode";=;$t_codinterno)
			If (Records in selection:C76([Asignaturas:18])>0)
				$l_recnum_asig:=Record number:C243([Asignaturas:18])
			End if 
			  //$l_recnum_asig:=Find in field([Asignaturas]Codigo_interno;$t_codinterno)
		End if 
		
		If ($l_recnum_asig=-1)  //20170302 RCH
			$t_codinterno:=ST_GetCleanString ($t_codigo+$t_asig)
			QUERY BY ATTRIBUTE:C1331([Asignaturas:18];[Asignaturas:18]Opciones:57;"impHorarioCode";=;$t_codinterno)
			If (Records in selection:C76([Asignaturas:18])>0)
				$l_recnum_asig:=Record number:C243([Asignaturas:18])
			End if 
			  //$l_recnum_asig:=Find in field([Asignaturas]Codigo_interno;$t_codinterno)
		End if 
		
		If ($l_recnum_asig=-1)
			
			If (Position:C15("-";$t_curso)=0)
				$t_curso:=Insert string:C231($t_curso;"-";Length:C16($t_curso))
			End if 
			
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$t_curso;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Abreviación:26=$t_asig)
			
			If (Records in selection:C76([Asignaturas:18])=1)
				$l_recnum_asig:=Record number:C243([Asignaturas:18])
			End if 
			
		End if 
		
		  //SI ENCONTRAMOS LA ASIGNATURAS AGREGAMOS AL OBJETO DE HORARIO
		If ($l_recnum_asig>=0)
			
			GOTO RECORD:C242([Asignaturas:18];$l_recnum_asig)
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
			AT_DistinctsFieldValues (->[Alumnos:2]curso:20;->$at_cursosAsig)
			
			For ($i_cursos;1;Size of array:C274($at_cursosAsig))
				
				$o_bloque:=OB_Create 
				OB SET:C1220($o_bloque;"curso";$at_cursosAsig{$i_cursos})
				OB SET:C1220($o_bloque;"dia";$l_dia)
				OB SET:C1220($o_bloque;"hora";$l_hora)
				OB SET:C1220($o_bloque;"asigFound";True:C214)
				OB SET:C1220($o_bloque;"asignatura";String:C10([Asignaturas:18]Numero:1))
				OB SET:C1220($o_bloque;"profesor";$t_prof)
				
				TMT_AsistImportAddBlock2Obj (->$o_horario;$o_bloque)
				
			End for 
			
		Else 
			
			  //SI NO ENCONTRAMOS LA ASIGNATURA CORRESPONDIENTE AL BLOQUE, LO AGREGAMOS AL OBJETO DE NO ENCONTRADO
			  //NIVEL
			If (Position:C15("-";$t_curso)=0)
				$t_curso:=Insert string:C231($t_curso;"-";Length:C16($t_curso))
			End if 
			$t_nivel:=String:C10(KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$t_curso;->[Cursos:3]Nivel_Numero:7))
			
			$o_bloque:=OB_Create 
			OB SET:C1220($o_bloque;"curso";$t_curso)
			OB SET:C1220($o_bloque;"nivel";$t_nivel)
			OB SET:C1220($o_bloque;"dia";$l_dia)
			OB SET:C1220($o_bloque;"hora";$l_hora)
			OB SET:C1220($o_bloque;"asigFound";False:C215)
			OB SET:C1220($o_bloque;"asignatura";$t_nodoAsig)
			OB SET:C1220($o_bloque;"profesor";$t_prof)
			
			TMT_AsistImportAddBlock2Obj (->$o_sinAsignaturas;$o_bloque)
			
		End if 
		
		RECEIVE PACKET:C104($ref;$text;$delimiter)
		
	End while 
	
	USE CHARACTER SET:C205(*;1)
	CLOSE DOCUMENT:C267($ref)
	DELETE DOCUMENT:C159($t_ruta)
	  //$t_son:=OB_Object2Json ($o_sinAsignaturas)
	  //SET TEXT TO PASTEBOARD($t_son)
	  //$y_oFound->:=$o_horario
	  //$y_oNotFound->:=$o_sinAsignaturas
	
	OB SET:C1220($o_result;"OK";$o_horario)
	OB SET:C1220($o_result;"NOTFOUND";$o_sinAsignaturas)
	OB SET:C1220($o_result;"error";False:C215)
	
	$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
	
Else 
	OB SET:C1220($o_result;"error";True:C214)
	OB SET:C1220($o_result;"error_detail";"EL archivo de importación no pudo ser escrito en el servidor "+$t_ruta)
	
End if 

$0:=$o_result
