//%attributes = {}
ARRAY TEXT:C222($at_archivos_vel_todos;0)
ARRAY TEXT:C222($at_archivos_vel_existentes;0)
ARRAY LONGINT:C221($DA_Return;0)

C_TEXT:C284($delimiter;$text;$vt_carpeta)
C_LONGINT:C283($i;$x;$fia;$n)
C_TIME:C306($ref)

If (SYS_IsWindows )
	USE CHARACTER SET:C205("windows-1252";1)
	USE CHARACTER SET:C205("windows-1252";0)
Else 
	USE CHARACTER SET:C205("MacRoman";1)
	USE CHARACTER SET:C205("MacRoman";0)
End if 

$vt_carpeta:=xfGetDirName ("Carpeta donde están los archivos de VEL")

If ($vt_carpeta#"")
	
	APPEND TO ARRAY:C911($at_archivos_vel_todos;"fisico")  //Aqui vienen los registros físicos de cada copia de los libros, revistas etc.
	APPEND TO ARRAY:C911($at_archivos_vel_todos;"diccion")  //titulos tipos de recursos de bibloteca, editoriales, autor
	APPEND TO ARRAY:C911($at_archivos_vel_todos;"libro")  //dewey, cutter, año de edición
	
	  //APPEND TO ARRAY($at_archivos_vel_todos;"dicuni.xls")  `todavía no se si agregar esto por que veop mucha info repetida de los demas archivos
	  //APPEND TO ARRAY($at_archivos_vel_todos;"movusu.xls")`al parecer esto es un registro de actividades pero no encuentro los prestamos
	  //APPEND TO ARRAY($at_archivos_vel_todos;"tmpdevueltos.xls")  `según el nombre del archivo es un archivo de devolución de prestamos pero no veo como está relacionado con los usuarios que pidieron los libros
	
	C_TEXT:C284($vt_enc)
	
	ARRAY TEXT:C222($at_plantilla;0)  //arreglo que formará la plantilla final
	ARRAY TEXT:C222($at_linea_plantilla;0)  //arreglo para trabajar de manera independiente cada linea de la plantilla final
	ARRAY TEXT:C222($at_linea_documento;0)  //arreglo para recibir cada linea de los documentos VEL
	ARRAY TEXT:C222($at_ISBN;0)  //es el dato en común que está en la mayoria de los archivos de VEL
	ARRAY TEXT:C222($at_numreg;0)  //este dato lo saco del archivo físico, encontré que está repetido pero al parecer es debido a que en el archivo se encuentran las copias de baja.
	
	$vt_enc:="Barcode"+"\t"+"N° Registro"+"\t"+"Titulo Principal"+"\t"+"Nº Copia"+"\t"+"Nivel Registro"+"\t"+"Clasificación Dewey"
	$vt_enc:=$vt_enc+"\t"+"Titulos Secundarios"+"\t"+"Autor principal"+"\t"+"Autores Secundario"+"\t"+"Nº de volúmenes"+"\t"+"Editor"+"\t"+"Lugar Edicion"
	$vt_enc:=$vt_enc+"\t"+"Año Edicion"+"\t"+"Materias"+"\t"+"Descripcion"+"\t"+"Notas "+"\t"+"Resumen"+"\t"+"Idioma"+"\t"+"ISBN"+"\t"+"ISSN"
	$vt_enc:=$vt_enc+"\t"+"Serie"+"\t"+"Frecuencia de Publicación"+"\t"+"Nº de Volumen"+"\t"+"Nº  en Serie o Colección"+"\t"+"Fecha Publicacion"
	$vt_enc:=$vt_enc+"\t"+"Cutter"+"\t"+"Tipo Material"+"\t"+"LCCN"+"\t"+"Lugar Físico"+"\t"+"Número de Edición"+"\t"+"Copia. Comentario"+"\t"+"Copia. Costo"
	$vt_enc:=$vt_enc+"\t"+"Copia. Fecha de Adquisicion"+"\t"+"Copia. Proveedor"+"\t"+"Copia. Valor de Remplazo"+"\t"+"Copia Volumen"+"\t"+"Nuevo Barcode"
	
	APPEND TO ARRAY:C911($at_plantilla;$vt_enc)
	APPEND TO ARRAY:C911($at_ISBN;"Lista de ISBN")
	
	DOCUMENT LIST:C474($vt_carpeta;$at_archivos_vel_existentes)
	
	For ($i;1;Size of array:C274($at_archivos_vel_todos))
		
		ARRAY LONGINT:C221($DA_Return_files;0)
		$at_archivos_vel_existentes{0}:=$at_archivos_vel_todos{$i}
		AT_SearchArray (->$at_archivos_vel_existentes;">>";->$DA_Return_files)
		
		For ($o;1;Size of array:C274($DA_Return_files))
			
			$vt_ruta_archivo:=$vt_carpeta+$at_archivos_vel_existentes{$DA_Return_files{$o}}
			$delimiter:=ACTabc_DetectDelimiter ($vt_ruta_archivo)
			$ref:=Open document:C264($vt_ruta_archivo;"";Read mode:K24:5)
			
			If ($o=1)
				RECEIVE PACKET:C104($ref;$text;$delimiter)  // todos tienen encabezado, si un archivo es el segundo de un mismo tipo como por ejemplo diccion el segundo archivo no tiene encabezado
			End if 
			
			Case of 
				: ($i=1)  //fisico
					
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Leyendo archivo "+$at_archivos_vel_existentes{$DA_Return_files{$o}}+"...")
					RECEIVE PACKET:C104($ref;$text;$delimiter)
					
					While ($text#"")
						
						ARRAY TEXT:C222($at_linea_documento;0)
						AT_Text2Array (->$at_linea_documento;$text;"\t")
						
						If (Find in array:C230($at_numreg;ST_GetCleanString ($at_linea_documento{2}))=-1)
							
							APPEND TO ARRAY:C911($at_numreg;ST_GetCleanString ($at_linea_documento{2}))
							APPEND TO ARRAY:C911($at_ISBN;ST_GetCleanString ($at_linea_documento{1}))
							
							ARRAY TEXT:C222($at_linea_plantilla;0)
							ARRAY TEXT:C222($at_linea_plantilla;37)
							
							$at_linea_plantilla{2}:=ST_GetCleanString ($at_linea_documento{2})
							$at_linea_plantilla{4}:=ST_GetCleanString ($at_linea_documento{20})
							$at_linea_plantilla{19}:=ST_GetCleanString ($at_linea_documento{1})
							$at_linea_plantilla{33}:=ST_GetCleanString ($at_linea_documento{4})
							
							APPEND TO ARRAY:C911($at_plantilla;AT_array2text (->$at_linea_plantilla;"\t")+""+"\t")
							
						End if 
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Get document position:C481($ref)/Get document size:C479($vt_ruta_archivo))
						RECEIVE PACKET:C104($ref;$text;$delimiter)
					End while 
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					CLOSE DOCUMENT:C267($ref)
					
				: ($i=2)  //diccion
					
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Leyendo archivo "+$at_archivos_vel_existentes{$DA_Return_files{$o}}+"...")
					C_TEXT:C284($isbn)
					C_LONGINT:C283($texto_blanco)
					$texto_blanco:=0
					$isbn:=""
					ARRAY TEXT:C222($at_ref;0)  //para saber si es titulo, autor, editor, materia, coleccion
					ARRAY TEXT:C222($at_ref_value;0)
					RECEIVE PACKET:C104($ref;$text;$delimiter)
					
					While ($texto_blanco<2)
						
						ARRAY TEXT:C222($at_linea_documento;0)
						AT_Text2Array (->$at_linea_documento;$text;"\t")
						
						If ($text="")
							$texto_blanco:=$texto_blanco+1
						End if 
						
						If (Size of array:C274($at_linea_documento)>1)
							
							If ($isbn#$at_linea_documento{2})
								
								If (Size of array:C274($at_ref)>0)  //cargamos la info para el libro anterior antes de limpiar todo y comenzar a con el libro nuevo(ISBN)
									
									$at_ISBN{0}:=$isbn
									ARRAY LONGINT:C221($DA_Return;0)
									AT_SearchArray (->$at_ISBN;"=";->$DA_Return)
									
									For ($n;1;Size of array:C274($DA_Return))
										
										ARRAY TEXT:C222($at_linea_plantilla;0)
										AT_Text2Array (->$at_linea_plantilla;$at_plantilla{$DA_Return{$n}};"\t")
										
										For ($x;1;Size of array:C274($at_ref))
											
											Case of 
												: ($at_ref{$x}="AUT")
													$pos:=8
												: ($at_ref{$x}="EDI")
													$pos:=11
												: ($at_ref{$x}="TIT")
													$pos:=3
												: ($at_ref{$x}="COL")
													$pos:=21
												: ($at_ref{$x}="MAT")
													$pos:=14
											End case 
											
											$at_linea_plantilla{$pos}:=$at_ref_value{$x}
										End for 
										
										$at_plantilla{$DA_Return{$n}}:=AT_array2text (->$at_linea_plantilla;"\t")+""+"\t"
									End for 
									
								End if 
								
								ARRAY TEXT:C222($at_ref;0)  //para saber si es titulo, autor, editor, materia, coleccion
								ARRAY TEXT:C222($at_ref_value;0)
								
								$isbn:=$at_linea_documento{2}
								
								APPEND TO ARRAY:C911($at_ref;$at_linea_documento{3})
								APPEND TO ARRAY:C911($at_ref_value;$at_linea_documento{1})
								
							Else 
								
								If (Find in array:C230($at_ref;$at_linea_documento{3})=-1)
									APPEND TO ARRAY:C911($at_ref;$at_linea_documento{3})
									APPEND TO ARRAY:C911($at_ref_value;$at_linea_documento{1})
								End if 
								
							End if 
						Else 
							  //para el final del archivo
							$at_ISBN{0}:=$isbn
							ARRAY LONGINT:C221($DA_Return;0)
							AT_SearchArray (->$at_ISBN;"=";->$DA_Return)
							
							For ($n;1;Size of array:C274($DA_Return))
								
								ARRAY TEXT:C222($at_linea_plantilla;0)
								AT_Text2Array (->$at_linea_plantilla;$at_plantilla{$DA_Return{$n}};"\t")
								
								For ($x;1;Size of array:C274($at_ref))
									Case of 
										: ($at_ref{$x}="AUT")
											$pos:=8
										: ($at_ref{$x}="EDI")
											$pos:=11
										: ($at_ref{$x}="TIT")
											$pos:=3
										: ($at_ref{$x}="COL")
											$pos:=21
										: ($at_ref{$x}="MAT")
											$pos:=14
									End case 
									$at_linea_plantilla{$pos}:=$at_ref_value{$x}
								End for 
								
								$at_plantilla{$DA_Return{$n}}:=AT_array2text (->$at_linea_plantilla;"\t")+""+"\t"
							End for 
							
						End if 
						
						RECEIVE PACKET:C104($ref;$text;$delimiter)
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Get document position:C481($ref)/Get document size:C479($vt_ruta_archivo);"Leyendo archivo "+$at_archivos_vel_existentes{$DA_Return_files{$o}}+"...ISBN "+String:C10($isbn))
						
					End while 
					
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					CLOSE DOCUMENT:C267($ref)
					
				: ($i=3)  //libros
					
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Leyendo archivo "+$at_archivos_vel_existentes{$DA_Return_files{$o}}+"...")
					
					RECEIVE PACKET:C104($ref;$text;$delimiter)
					While ($text#"")
						ARRAY TEXT:C222($at_linea_documento;0)
						AT_Text2Array (->$at_linea_documento;$text;"\t")
						
						ARRAY LONGINT:C221($DA_Return;0)
						$at_ISBN{0}:=$at_linea_documento{4}
						AT_SearchArray (->$at_ISBN;"=";->$DA_Return)
						
						For ($n;1;Size of array:C274($DA_Return))
							
							ARRAY TEXT:C222($at_linea_plantilla;0)
							AT_Text2Array (->$at_linea_plantilla;$at_plantilla{$DA_Return{$n}};"\t")
							
							$at_linea_plantilla{6}:=ST_GetCleanString ($at_linea_documento{13})  //clasificación dewey
							$at_linea_plantilla{13}:=ST_GetCleanString ($at_linea_documento{8})  //año de edición
							$at_linea_plantilla{15}:=ST_GetCleanString ($at_linea_documento{37})  //Descripción
							$at_linea_plantilla{16}:=ST_GetCleanString ($at_linea_documento{21})+" "+ST_GetCleanString ($at_linea_documento{25})  //Notas
							$at_linea_plantilla{23}:=ST_GetCleanString ($at_linea_documento{15})  //n° de volumen
							$at_linea_plantilla{26}:=ST_GetCleanString ($at_linea_documento{14})  //cutter
							$at_linea_plantilla{27}:=ST_GetCleanString ($at_linea_documento{2})  //tipo de material
							$at_linea_plantilla{1}:=$at_linea_plantilla{27}+$at_linea_plantilla{2}  //barcode
							
							$at_plantilla{$DA_Return{$n}}:=AT_array2text (->$at_linea_plantilla;"\t")+""+"\t"  //pasa la info a la linea donde está el ISBN
							
						End for 
						
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Get document position:C481($ref)/Get document size:C479($vt_ruta_archivo))
						RECEIVE PACKET:C104($ref;$text;$delimiter)
					End while 
					
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					CLOSE DOCUMENT:C267($ref)
					
			End case 
			
		End for 
		
	End for 
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Creando archivo de exportación formato MT...")
	$ref:=Create document:C266($vt_carpeta+"TempletaImportación Registros_ MT.txt")
	For ($i;1;Size of array:C274($at_plantilla))
		IO_SendPacket ($ref;$at_plantilla{$i}+"\r")
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($at_plantilla))
	End for 
	CLOSE DOCUMENT:C267($ref)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
End if 

USE CHARACTER SET:C205(*;0)
USE CHARACTER SET:C205(*;1)