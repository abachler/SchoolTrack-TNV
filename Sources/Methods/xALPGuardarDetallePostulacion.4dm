//%attributes = {}
  //xALPGuardarDetallePostulacion

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)
C_TEXT:C284($rolColegio)
ARRAY TEXT:C222($camposPostulantes;0)
READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
$rolColegio:=<>vtXS_CountryCode+"."+[Colegio:31]Rol Base Datos:9

AT_Initialize (-><>idCampoModificado;-><>valorCampoModificado;-><>atSiIngresado)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	
	AL_GetCurrCell (xALP_DetallePostulacion;$col;$row)
	
	C_TEXT:C284($IdCampo;$valorDato;$tagCampo)
	$IdCampo:=""
	$valorDato:=""
	$tagCampo:=""
	
	AL_GetCellValue (xALP_DetallePostulacion;$row;3;$IdCampo)
	AL_GetCellValue (xALP_DetallePostulacion;$row;2;$valorDato)
	AL_GetCellValue (xALP_DetallePostulacion;$row;4;$tagCampo)
	AL_GetCellValue (xALP_DetallePostulacion;$row;5;$sillenado)
	
	
	  //buscar el rut del alumno del cual estoy postulando los datos
	
	
	$indice:=Find in array:C230(atTagCampo;"rut")
	
	If ($indice#-1)
		<>rutAlumno:=atValorCampo{$indice}
	End if 
	
	  //validar primero para el caso de que sea rut, numerico, mail, o sexo, que el cambio sea válido
	C_TEXT:C284($mailValidado)
	READ ONLY:C145([xxADT_MetaDataDefinition:79])
	QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]TagADN:19=$tagCampo)
	
	Case of 
		: ([xxADT_MetaDataDefinition:79]Es Email:12=True:C214)
			
			$mailValidado:=SMTP_VerifyEmailAddress ($valorDato;False:C215)
			If ($mailValidado="")
				atValorCampo{$row}:=atValorCampo{0}
			Else 
				APPEND TO ARRAY:C911(<>idCampoModificado;Num:C11($idCampo))
				APPEND TO ARRAY:C911(<>valorCampoModificado;$valorDato)
				APPEND TO ARRAY:C911(<>atSiIngresado;$sillenado)
			End if 
			  //AL_GotoCell (xALP_DetallePostulacion;4;$row)
		: ([xxADT_MetaDataDefinition:79]Es RUT:11=True:C214)
			
			$valorDato:=Replace string:C233($valorDato;".";"")
			$valorDato:=Replace string:C233($valorDato;"-";"")
			
			$rut:=CTRY_CL_VerifRUT ($valorDato;False:C215)
			If ($rut="")
				CD_Dlog (1;__ ("Rut Incorrecto"))
				atValorCampo{$row}:=atValorCampo{0}
			Else 
				  // MOD Ticket N° 209157 Patricio Aliaga 20180608
				$valorDato:=SR_FormatoRUT2 ($valorDato)
				atValorCampo{$row}:=$valorDato
				APPEND TO ARRAY:C911(<>idCampoModificado;Num:C11($idCampo))
				APPEND TO ARRAY:C911(<>valorCampoModificado;$valorDato)
				APPEND TO ARRAY:C911(<>atSiIngresado;$sillenado)
			End if 
		: ([xxADT_MetaDataDefinition:79]Es Numerico:17=True:C214)
			
			If (ST_IsInteger (->$valorDato)=False:C215)
				  //si no es numérico se vuelve al número anterior
				CD_Dlog (1;__ ("Campo debe ser de tipo numérico"))
				atValorCampo{$row}:=atValorCampo{0}
			Else 
				
				APPEND TO ARRAY:C911(<>idCampoModificado;Num:C11($idCampo))
				APPEND TO ARRAY:C911(<>valorCampoModificado;$valorDato)
				APPEND TO ARRAY:C911(<>atSiIngresado;$sillenado)
				atValorCampo{$row}:=$valorDato
			End if 
		: ([xxADT_MetaDataDefinition:79]Es Fecha:18=True:C214)
			$valorDato2:=DT_StrDateIsOK ($valorDato;False:C215)
			
			If ($valorDato2#"00-00-00")
				  //fecha válida
				APPEND TO ARRAY:C911(<>idCampoModificado;Num:C11($idCampo))
				APPEND TO ARRAY:C911(<>valorCampoModificado;$valorDato)
				APPEND TO ARRAY:C911(<>atSiIngresado;$sillenado)
				
			Else 
				CD_Dlog (1;__ ("Fecha no válida"))
				atValorCampo{$row}:=atValorCampo{0}
			End if 
		: ($tagCampo="hijo_sexo")
			If (($valorDato="F") | ($valorDato="M"))
				APPEND TO ARRAY:C911(<>idCampoModificado;Num:C11($idCampo))
				APPEND TO ARRAY:C911(<>valorCampoModificado;Uppercase:C13($valorDato))
				APPEND TO ARRAY:C911(<>atSiIngresado;$sillenado)
			Else 
				  //inválido
				CD_Dlog (1;__ ("Sexo ingresado es inválido, debe ingresar F o M"))
				atValorCampo{$row}:=atValorCampo{0}
			End if 
		: ($tagCampo="apod_sexo")
			If (($valorDato="F") | ($valorDato="M"))
				APPEND TO ARRAY:C911(<>idCampoModificado;Num:C11($idCampo))
				APPEND TO ARRAY:C911(<>valorCampoModificado;Uppercase:C13($valorDato))
				APPEND TO ARRAY:C911(<>atSiIngresado;$sillenado)
			Else 
				  //inválido
				CD_Dlog (1;__ ("Sexo ingresado es inválido, debe ingresar F o M"))
				atValorCampo{$row}:=atValorCampo{0}
			End if 
		Else 
			  //para los campos de texto
			APPEND TO ARRAY:C911(<>idCampoModificado;Num:C11($idCampo))
			APPEND TO ARRAY:C911(<>valorCampoModificado;$valorDato)
			APPEND TO ARRAY:C911(<>atSiIngresado;$sillenado)
	End case 
	
	AT_DistinctsArrayValues (-><>idCampoModificado)
	AT_DistinctsArrayValues (-><>valorCampoModificado)
	AT_DistinctsArrayValues (-><>atSiIngresado)
	
	If (Size of array:C274(<>idCampoModificado)=1)
		$rolColegio:=<>vtXS_CountryCode+"."+[Colegio:31]Rol Base Datos:9
		
		WEB SERVICE SET PARAMETER:C777("idCampos";<>idCampoModificado)
		WEB SERVICE SET PARAMETER:C777("valorCampo";<>valorCampoModificado)
		WEB SERVICE SET PARAMETER:C777("siLlenados";<>atSiIngresado)
		<>rutAlumno:=Replace string:C233(<>rutAlumno;".";"")
		<>rutAlumno:=Replace string:C233(<>rutAlumno;"-";"")
		WEB SERVICE SET PARAMETER:C777("rutPostulante";<>rutAlumno)
		WEB SERVICE SET PARAMETER:C777("rolColegio";$rolColegio)
		
		WEB SERVICE CALL:C778("http://www.admissionnet.cl/ADN_CamposEnBD.php";"http://www.admissionnet.cl/ADN_CamposEnBD.php";"actualizarCampos";"http://www.admissionnet.cl/admnet/ADN_CamposEnBD.php?wsdl")
	End if 
	
	
	
	
	  //AT_Initialize (-><>datosPostulantes)
	  //ADN_DatosPostulanteDesdeServido ($rolColegio;1;-><>datosPostulantes)
	  //  `la tercera columna corresponde al id de campo llenado en el servidor de ADN, sólo sería actualizar dicho dato.
	  //AT_Initialize (->atRutPostulantes;->abRecibirPostulaciones;->atNombrePostulante;->atEstadoPostulacion;->atFechaPostulacion;->atFecha;->atHoraPostulacion;->atFechaNacimiento;->atIDFormularioPostulacion)
	  //ADN_AlmacenarDatosEnArreglos (-><>datosPostulantes;->atRutPostulantes;->atEstadoPostulacion;->atNombrePostulante;->atFecha;->atHoraPostulacion;->atFechaPostulacion;->atFechaNacimiento;->atIDFormularioPostulacion;"Todas")
	  //AL_UpdateArrays (xALP_nuevasPostulaciones;-2)
	<>rutAlumno:=Replace string:C233(<>rutAlumno;".";"")
	<>rutAlumno:=Replace string:C233(<>rutAlumno;"-";"")
	
	WEB SERVICE SET PARAMETER:C777("rutPostulante";<>rutAlumno)
	WEB SERVICE SET PARAMETER:C777("rolColegio";$rolColegio)
	WEB SERVICE SET PARAMETER:C777("idFormulario";idFormulario)
	
	
	WEB SERVICE CALL:C778("http://www.admissionnet.cl/ADN_ExtraerDatosSNT.php";"http://www.admissionnet.cl/ADN_ExtraerDatosSNT.php";"camposLlenadosPostulante";"http://www.admissionnet.cl/ADN_ExtraerDatosSNT.php?wsdl")
	WEB SERVICE GET RESULT:C779($camposPostulantes;"camposPostulante";*)
	
	AT_Initialize (->atNombreCampo;->atValorCampo;->aiIdCampo;->atTagCampo;->atSiLlenado)
	
	  //campos que estan ingresados por el postulante
	For ($i;1;Size of array:C274($camposPostulantes))
		APPEND TO ARRAY:C911(atNombreCampo;$camposPostulantes{$i})
		APPEND TO ARRAY:C911(atValorCampo;$camposPostulantes{$i+1})
		APPEND TO ARRAY:C911(aiIdCampo;$camposPostulantes{$i+2})
		APPEND TO ARRAY:C911(atTagCampo;$camposPostulantes{$i+3})
		APPEND TO ARRAY:C911(atSiLlenado;$camposPostulantes{$i+4})
		$i:=$i+4
	End for 
	AL_UpdateArrays (xALP_DetallePostulacion;-2)
End if 