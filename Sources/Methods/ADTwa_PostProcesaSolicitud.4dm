//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 14-03-17, 10:33:59
  // ----------------------------------------------------
  // Método: ADTwa_PostProcesaSolicitud
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_POINTER:C301($y_ParameterNames;$y_ParameterValues)
C_TEXT:C284($t_json;$t_uuid1;$t_uuid2;$t_archivo;$t_Base64Postulaciones;$t_url)
C_LONGINT:C283($l_error)
C_OBJECT:C1216($ob_Raiz;$ob_validformat;$ob_finalProc)
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_archivoValido)
ARRAY TEXT:C222($at_encabezados;0)


$l_error:=0
$b_archivoValido:=False:C215

READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
$t_uuidColegio:=[Colegio:31]UUID:58
REDUCE SELECTION:C351([Colegio:31];0)

If ((Semaphore:C143("$PostulacionesImportacionAlumno";300)) | (Process number:C372("Importacion de Alumnos Web")#0))
	$l_error:=-5
End if 
$ob_validformat:=OB_Create 
If ($l_error=0)
	$y_ParameterNames:=$1
	$y_ParameterValues:=$2
	
	  //extraigo valores para validar la llave y el archivo
	$t_uuid1:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"param1")
	$t_uuid2:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"param2")
	$t_llave:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"autentificacion")
	$t_archivo:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"archivo")
	$t_url:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"url")
	
	If ($t_llave#XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
		$l_error:=-1
		  //respuesta con error en llave de autenticación
		OB_SET_Boolean ($ob_validformat;False:C215;"esValido")
		OB_SET ($ob_validformat;->$t_uuidColegio;"uuidColegio")
		OB_SET ($ob_validformat;->$l_error;"error")
		OB_SET_Text ($ob_validformat;"Problema de autenticación";"errorTexto")
		$t_json:=OB_Object2Json ($ob_validformat)
	Else 
		
		If ($t_url="")
			$l_error:=-6
			OB_SET_Boolean ($ob_validformat;False:C215;"esValido")
			OB_SET ($ob_validformat;->$t_uuidColegio;"uuidColegio")
			OB_SET ($ob_validformat;->$l_error;"error")
			OB_SET_Text ($ob_validformat;"URL de respuesta vacío.")
			$t_json:=OB_Object2Json ($ob_validformat)
		Else 
			BASE64 DECODE:C896($t_archivo;$x_blob)
			$t_NombreDocumento:=DTS_Get_GMT_TimeStamp +".txt"
			t_RutaArchivo:=Temporary folder:C486+$t_NombreDocumento
			$t_texto:=Convert to text:C1012($x_blob;"UTF-8")
			TEXT TO DOCUMENT:C1237(t_RutaArchivo;$t_texto;"UTF-8")
			
			If (OK=1)
				$t_textoArchivo:=Document to text:C1236(t_RutaArchivo)
				If ($t_textoArchivo#"")
					$l_pos:=Position:C15("[Madre]";$t_textoArchivo)
					$l_pos:=$l_pos+Position:C15("[Padre]";$t_textoArchivo)
					If ($l_pos#0)
						
						$t_uuidProceso:=Generate UUID:C1066
						OB_SET ($ob_validformat;->$t_uuidProceso;"uuidProceso")
						OB_SET_Boolean ($ob_validformat;True:C214;"esValido")
						OB_SET ($ob_validformat;->$t_uuidColegio;"uuidColegio")
						OB_SET ($ob_validformat;->$l_error;"error")
						$t_json:=OB_Object2Json ($ob_validformat)
						
					Else 
						
						$l_error:=-4  //formato de archivo no valido
						OB_SET_Boolean ($ob_validformat;False:C215;"esValido")
						OB_SET ($ob_validformat;->$t_uuidColegio;"uuidColegio")
						OB_SET ($ob_validformat;->$l_error;"error")
						OB_SET_Text ($ob_validformat;"Formato de archivo no valido";"errorTexto")
						$t_json:=OB_Object2Json ($ob_validformat)
					End if 
				Else 
					$l_error:=-3  //Problema de lectura del archivo en el temporal
					OB_SET_Boolean ($ob_validformat;False:C215;"esValido")
					OB_SET ($ob_validformat;->[Colegio:31]Auto_UUID:60;"uuidColegio")
					OB_SET ($ob_validformat;->$l_error;"error")
					OB_SET_Text ($ob_validformat;"Se produjo un problema en la lectura del archivo.";"errorTexto")
					$t_json:=OB_Object2Json ($ob_validformat)
					
				End if 
			Else 
				$l_error:=-2  //mensaje de error en la creación del documento
				OB_SET_Boolean ($ob_validformat;False:C215;"esValido")
				OB_SET ($ob_validformat;->$t_uuidColegio;"uuidColegio")
				OB_SET ($ob_validformat;->$l_error;"error")
				OB_SET_Text ($ob_validformat;"El documento no pudo ser creado.";"errorTexto")
				$t_json:=OB_Object2Json ($ob_validformat)
			End if 
		End if 
	End if 
Else 
	  //respuesta con error en llave de autenticación
	OB_SET_Boolean ($ob_validformat;False:C215;"esValido")
	OB_SET ($ob_validformat;->$t_uuidColegio;"uuidColegio")
	OB_SET ($ob_validformat;->$l_error;"error")
	OB_SET_Text ($ob_validformat;"Ya existe un proceso de importación activo";"errorTexto")
	$t_json:=OB_Object2Json ($ob_validformat)
End if 

$0:=$t_json

If ($l_error=0)
	$l_process:=New process:C317("WIZ_STR_ImportacionAlumnos";Pila_1024K;"Importacion de Alumnos Web";t_RutaArchivo;$t_uuidProceso;$t_url)
End if 
CLEAR SEMAPHORE:C144("$PostulacionesImportacionAlumno")