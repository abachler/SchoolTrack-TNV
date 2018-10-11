//%attributes = {}
  // UD_v20161017_ImportaMaterialDoc()
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 17/10/16, 15:17:47
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($i;$l_therm)
C_TEXT:C284($err;$t_descripcion;$t_fecha;$t_fecha_modificacion;$t_id_asignatura;$t_id_documento;$t_id_interno;$t_id_profesor_modificadopor;$t_idProfesor;$t_json)
C_TEXT:C284($t_nombreArchivo;$t_refType)
C_OBJECT:C1216($ob_raiz)

ARRAY OBJECT:C1221($ao_Registros;0)

$l_therm:=IT_UThermometer (1;0;"Interrogando a Schoolnet...")
WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
$err:=SN3_CallWebService ("sn3ws_datos_ST_proceso.consulta")

If ($err="")
	WEB SERVICE GET RESULT:C779($t_json;"resultado";*)
End if 
IT_UThermometer (-2;$l_therm)

If ($t_json#"")
	$ob_raiz:=OB_Create 
	$ob_raiz:=OB_JsonToObject ($t_json)
	OB_GET ($ob_raiz;->$ao_Registros;"OB")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando datos de Material Docente...")
	For ($i;1;Size of array:C274($ao_Registros))
		OB_GET ($ao_Registros{$i};->$t_nombreArchivo;"monbre_archivo")
		OB_GET ($ao_Registros{$i};->$t_fecha;"fecha")
		OB_GET ($ao_Registros{$i};->$t_descripcion;"descripcion")
		OB_GET ($ao_Registros{$i};->$t_fecha_modificacion;"fecha_modificacion")
		OB_GET ($ao_Registros{$i};->$t_idProfesor;"id_profesor")
		OB_GET ($ao_Registros{$i};->$t_id_asignatura;"id_asignatura")
		OB_GET ($ao_Registros{$i};->$t_id_profesor_modificadopor;"id_profesor_modificadopor")
		OB_GET ($ao_Registros{$i};->$t_id_documento;"id_documento")
		OB_GET ($ao_Registros{$i};->$t_refType;"reftype")
		OB_GET ($ao_Registros{$i};->$t_id_interno;"id_interno")
		
		  //verifico si el archivo existe
		QUERY:C277([Asignaturas_Adjuntos:230];[Asignaturas_Adjuntos:230]ID:1=Num:C11($t_id_documento))
		If (Records in selection:C76([Asignaturas_Adjuntos:230])=0)
			  //creo el registro
			CREATE RECORD:C68([Asignaturas_Adjuntos:230])
			[Asignaturas_Adjuntos:230]ID:1:=Num:C11($t_id_documento)
			[Asignaturas_Adjuntos:230]id_asignatura:7:=Num:C11($t_id_asignatura)
			[Asignaturas_Adjuntos:230]nombre_adjunto:10:=$t_nombreArchivo
			[Asignaturas_Adjuntos:230]id_profesor:9:=Num:C11($t_idProfesor)
			[Asignaturas_Adjuntos:230]fecha_adjunto:5:=Date:C102($t_fecha+"T00:00:00")
			[Asignaturas_Adjuntos:230]fecha_ultima_modificacion:6:=Date:C102($t_fecha_modificacion+"T00:00:00")
			[Asignaturas_Adjuntos:230]extension:4:=$t_refType
			[Asignaturas_Adjuntos:230]descripcion:3:=$t_descripcion
			[Asignaturas_Adjuntos:230]id_modificadoPor:8:=Num:C11($t_id_profesor_modificadopor)
			SAVE RECORD:C53([Asignaturas_Adjuntos:230])
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($ao_Registros))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 


