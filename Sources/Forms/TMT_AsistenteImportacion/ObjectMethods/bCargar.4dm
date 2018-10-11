ARRAY TEXT:C222($at_childName;0)
ARRAY OBJECT:C1221($ao_childObj;0)
C_TEXT:C284($doc;$t_sepColArchivo)
C_BLOB:C604($x_file)
C_OBJECT:C1216($o_tempResult)
C_BOOLEAN:C305($b_error)
$doc:=xfGetFileName 

If ($doc#"")
	vt_file:=$doc
	TMT_AsistImport_init 
	Case of 
		: (sepColOpc1=1)  //tab
			$t_sepColArchivo:="\t"
		: (sepColOpc2=1)  //coma
			$t_sepColArchivo:=","
		: (sepColOpc3=1)  //punto y coma
			$t_sepColArchivo:=";"
	End case 
	$b_encabezado:=(OBJECT Get pointer:C1124(Object named:K67:5;"tieneEncabezado")->=1)
	
	$proc:=IT_UThermometer (1;0;"Ejecutando lectura en el servidor")
	DOCUMENT TO BLOB:C525(vt_file;$x_file)
	$o_tempResult:=TMT_AsistImport_GpUntis ($x_file;$t_sepColArchivo;$b_encabezado)  //ejecución en el servidor
	$b_error:=OB Get:C1224($o_tempResult;"error")
	IT_UThermometer (-2;$proc)
	
	If ($b_error)
		ALERT:C41(OB Get:C1224($o_tempResult;"error_detail"))
		
	Else 
		o_horarioOK:=OB Get:C1224($o_tempResult;"OK")
		o_horarioNotFound:=OB Get:C1224($o_tempResult;"NOTFOUND")
		
		$l_nodos:=OB_GetChildNodes (o_horarioOK;->$at_childName;->$ao_childObj)
		COPY ARRAY:C226($at_childName;at_cursos_selector)
		SORT ARRAY:C229(at_cursos_selector;>)
		If (Size of array:C274(at_cursos_selector)>0)
			at_cursos_selector{0}:=at_cursos_selector{1}
			$t_curso:=at_cursos_selector{0}
			TMT_AsistImport_Load ($ao_childObj{1})
			$l_noNivel:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$t_curso;->[Cursos:3]Nivel_Numero:7)
			
			$l_nodos:=OB_GetChildNodes (o_horarioNotFound;->$at_childName;->$ao_childObj)
			$fia:=Find in array:C230($at_childName;String:C10($l_noNivel))
			If ($fia>0)
				TMT_AsistImport_LBNotFound ($ao_childObj{$fia})
				TMT_AsistImport_LNAsigNivel ($l_noNivel)
			Else 
				ARRAY TEXT:C222(at_lbNFCurso;0)
				ARRAY TEXT:C222(at_lbNFLlave;0)
			End if 
			
		End if 
		
	End if 
	
	
	  //LOG DE LOS BLOQUES NO ENCONTRADOS, AHORA LOS TENENDREMOS EN EL OBJETO.
	  //If (Size of array(at_noCargado)>0)
	  //CD_Dlog (0;__ ("Hay registros del archivo que no son consistentes con Schooltrack, no fue posible asociarlos a una asignatura. Por favor seleccione una carpeta para dejar un listado de estos."))
	  //$t_ruta:=xfGetDirName 
	  //If ($t_ruta#"")
	  //ARRAY POINTER($ay_data;0)
	  //APPEND TO ARRAY($ay_data;->at_noCargado)
	  //ARRAY TEXT($at_encabezado;0)
	  //$t_ruta:=$t_ruta+"noleido"+DTS_Get_GMT_TimeStamp +".xls"
	  //XLS_GeneraArchivo ($t_ruta;"noleido";"";->$at_encabezado;->$ay_data)
	  //End if 
	  //End if 
	
End if 

