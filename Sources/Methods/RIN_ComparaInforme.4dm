//%attributes = {}
  // RIN_ComparaInforme()
  // Por: Alberto Bachler K.: 13-08-14, 18:37:42
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_BLOB:C604($x_Pdf)
C_BOOLEAN:C305($b_ejecutarAntesCadaRegistro;$b_ejecutarDespuesCadaRegistro;$b_noRequiereSeleccion;$b_unaTareaPorRegistro)
C_LONGINT:C283($l_campoDestinoRelacion;$l_campoOrigenRelacion;$l_error;$l_error;$l_tablaRelacionada;$l_tablaSuperReport;$l_versionEstructura_Principal;$l_versionEstructura_Revision)
C_POINTER:C301($y_JsonComparacion;$y_rutaPdf)
C_TEXT:C284($t_codigoLenguaje;$t_codigoPais;$t_comentarios;$t_consultaEnInformeB64;$t_consultaEnRepositorioB64;$t_Description;$t_ejemploEnRepositorioB64;$t_error;$t_errorWS;$t_modeloEnInformeB64)
C_TEXT:C284($t_modeloEnRepositorioB64;$t_nodoError;$t_refNodoInfo;$t_nombre;$t_nombreFormulario;$t_nuevoEjemploB64;$t_parametroEspecial;$t_refjSon;$t_refNodoError;$t_refNodoInfo)
C_TEXT:C284($t_scriptAntesImpresion;$t_scriptDespuesImpresion;$t_tags;$t_uuid;$t_uuidInstitucion;$t_version;$t_versionEstructura;$t_versionMaxima;$t_versionMinima;$t_jsonComparacion)

If (False:C215)
	C_TEXT:C284(RIN_ComparaInforme ;$0)
	C_TEXT:C284(RIN_ComparaInforme ;$1)
End if 

$y_JsonComparacion:=OBJECT Get pointer:C1124(Object named:K67:5;"jsonComparacion")
If (Not:C34(Is nil pointer:C315($y_JsonComparacion)))
	$t_jsonComparacion:=$y_JsonComparacion->
End if 

If ($t_jsonComparacion="")
	$t_uuid:=$1
	
	$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
	$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
	$t_version:=String:C10($l_versionEstructura_Principal;"00")+"."+String:C10($l_versionEstructura_Revision;"00")
	
	WEB SERVICE SET PARAMETER:C777("uuid";$t_uuid)
	WEB SERVICE SET PARAMETER:C777("version";$t_version)
	
	$t_errorWS:=WS_CallIntranetWebService ("RINws_ComparaInforme";True:C214)
	
	If ($t_errorWS="")
		WEB SERVICE GET RESULT:C779($t_jsonComparacion;"json";*)  //20180514 RCH Ticket 206788
		
		If (Not:C34(Is nil pointer:C315($y_JsonComparacion)))
			$y_JsonComparacion->:=$t_jsonComparacion
		End if 
		
		
		C_OBJECT:C1216($ob;$ob_info;$ob_error)
		$ob:=OB_Create 
		$ob_info:=OB_Create 
		$ob_error:=OB_Create 
		
		$ob:=JSON Parse:C1218($t_jsonComparacion;Is object:K8:27)
		OB_GET ($ob;->$ob_info;"info")
		OB_GET ($ob;->$ob_error;"error")
		OB_GET ($ob_error;->$t_error;"textoError")
		OB_GET ($ob_error;->$l_error;"codigoError")
		
		Case of 
			: ($l_error=-1)  // referencia (recNum) inválido
				ModernUI_Notificacion (__ ("Comparacion con  informe en repositorio");__ ("No es posible comparar el informe con la version almacenada en el repositorio a causa de un error:")+"r\r"+$t_error)
				
			: ($l_error=-2)  // no fue posible acceder al informe
				$t_comentarios:=__ ("Primer envío al repositorio de informes")
				
			: ($l_error=-3)  // no fue posible acceder al informe
				ModernUI_Notificacion (__ ("Comparacion con  informe en repositorio");__ ("No es posible comparar el informe con la version almacenada en el repositorio a causa de un error:")+"r\r"+$t_error)
				
			: ($l_error=-6)  // versión incomptible
				$t_comentarios:=__ ("Actualización de compatibilidad del informe a partir de la versión ")+[xShell_Reports:54]version_minimo:23
				$l_error:=0
				
			: ($l_error=-4)  // informe removido
				ModernUI_Notificacion (__ ("Comparacion con  informe en repositorio");__ ("No es posible comparar el informe con la version almacenada en el repositorio a causa de un error:")+"r\r"+$t_error)
				
			: ($l_error=-5)  // blob inexistente
				$l_error:=0
				
		End case 
	Else 
		ModernUI_Notificacion (__ ("Información del informe");__ ("No fue posible establecer la comunicación con el repositorio de informes:\r")+$t_error)
	End if 
Else 
	$l_error:=0
End if 

If ($t_jsonComparacion#"")
	C_OBJECT:C1216($ob;$ob_info;$ob_error)
	$ob:=OB_Create 
	$ob_info:=OB_Create 
	$ob_error:=OB_Create 
	
	$ob:=JSON Parse:C1218($t_jsonComparacion;Is object:K8:27)
	
	OB_GET ($ob;->$ob_info;"info")
	OB_GET ($ob;->$ob_error;"error")
	
	OB_GET ($ob_error;->$t_error;"textoError")
	OB_GET ($ob_error;->$l_error;"codigoError")
	
	OB_GET ($ob_info;->$t_nombre;"nombre")
	OB_GET ($ob_info;->$t_uuidInstitucion;"uuidInstitucion")
	OB_GET ($ob_info;->$t_Description;"descripcion")
	OB_GET ($ob_info;->$t_tags;"tags")
	OB_GET ($ob_info;->$t_codigoPais;"codigoPais")
	OB_GET ($ob_info;->$t_codigoLenguaje;"codigoLenguaje")
	OB_GET ($ob_info;->$t_ejemploEnRepositorioB64;"ejemploPDF")
	OB_GET ($ob_info;->$t_modeloEnRepositorioB64;"data")
	OB_GET ($ob_info;->$t_versionMinima;"versionMinima")
	OB_GET ($ob_info;->$t_versionMaxima;"versionMaxima")
	
	OB_GET ($ob_info;->$t_scriptAntesImpresion;"scriptAntesImpresion")
	OB_GET ($ob_info;->$t_scriptDespuesImpresion;"scriptDespuesImpresion")
	OB_GET ($ob_info;->$b_ejecutarAntesCadaRegistro;"ejecutarAntesCadaRegistro")
	OB_GET ($ob_info;->$b_ejecutarDespuesCadaRegistro;"ejecutarDespuesCadaRegistro")
	OB_GET ($ob_info;->$b_unaTareaPorRegistro;"unaTareaPorRegistro")
	OB_GET ($ob_info;->$b_noRequiereSeleccion;"noRequiereSeleccion")
	OB_GET ($ob_info;->$l_tablaSuperReport;"tablaSuperReport")
	OB_GET ($ob_info;->$l_tablaRelacionada;"tablaRelacionada")
	OB_GET ($ob_info;->$l_campoOrigenRelacion;"campoOrigenRelacion")
	OB_GET ($ob_info;->$l_campoDestinoRelacion;"campoDestinoRelacion")
	OB_GET ($ob_info;->$t_nombreFormulario;"nombreFormulario")
	OB_GET ($ob_info;->$t_parametroEspecial;"parametroEspecial")
	OB_GET ($ob_info;->$t_consultaEnRepositorioB64;"consultaAsociada")
	
	
	  // COMPARACIONES
	Case of 
		: ($l_error=-2)
			$t_comentarios:=__ ("Primer envío al repositorio de informes")
		: ($l_error=-6)  // versión incomptible
			$t_comentarios:=__ ("Actualización de compatibilidad del informe a partir de la versión ")+[xShell_Reports:54]version_minimo:23
			
		Else 
			  // nombre del informe
			If ($t_nombre#[xShell_Reports:54]ReportName:26)
				$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación del nombre del informe")
			End if 
			
			  // institucion
			Case of 
				: ((Util_isValidUUID ($t_uuidInstitucion)) & (Util_isValidUUID ([xShell_Reports:54]UUID_institucion:33)) & ($t_uuidInstitucion#[xShell_Reports:54]UUID_institucion:33))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación de la restricción de uso a una institución")+" ("+OBJECT Get title:C1068(*;"institucion")+")"
					
				: ((Util_isValidUUID ($t_uuidInstitucion)) & (Not:C34(Util_isValidUUID ([xShell_Reports:54]UUID_institucion:33))))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Baja de la restricción de uso a una institución")
					
				: ((Not:C34(Util_isValidUUID ($t_uuidInstitucion)) & (Util_isValidUUID ([xShell_Reports:54]UUID_institucion:33))))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Alta de la restricción de uso a una institución")+" ("+OBJECT Get title:C1068(*;"institucion")+")"
					
				: (($t_uuidInstitucion#[xShell_Reports:54]UUID_institucion:33) & (Util_isValidUUID ([xShell_Reports:54]UUID_institucion:33)))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Alta de la restricción de uso a una institución")+" ("+OBJECT Get title:C1068(*;"institucion")+")"
			End case 
			
			  //descripcion
			If ($t_Description#[xShell_Reports:54]Descripción:16)
				$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación de la descripción del informe.")
			End if 
			
			  // palabras claves
			If (($t_tags#[xShell_Reports:54]Tags:43) & ([xShell_Reports:54]Tags:43#""))
				$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación de las palabras claves del informe.")
			End if 
			
			  //pais
			Case of 
				: (($t_codigoPais#"") & ([xShell_Reports:54]CountryCode:1=""))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Baja de la restricción de uso por país"+" ("+$t_codigoPais+")")
				: (($t_codigoPais="") & ([xShell_Reports:54]CountryCode:1#""))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Alta de la restricción de uso por país")+" ("+[xShell_Reports:54]CountryCode:1+")"
				: ($t_codigoPais#[xShell_Reports:54]CountryCode:1)
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Cambio de la restricción de uso por país")+" ("+[xShell_Reports:54]CountryCode:1+")"
			End case 
			
			  // lenguaje
			Case of 
				: (($t_codigoLenguaje#"") & ([xShell_Reports:54]LangageCode:10=""))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Baja de la restricción de uso por idioma"+" ("+$t_codigoLenguaje+")")
				: (($t_codigoLenguaje="") & ([xShell_Reports:54]LangageCode:10#""))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Alta de la restricción de uso por idioma")+" ("+[xShell_Reports:54]LangageCode:10+")"
				: ($t_codigoLenguaje#[xShell_Reports:54]LangageCode:10)
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Cambio de la restricción de uso por idioma")+" ("+[xShell_Reports:54]LangageCode:10+")"
			End case 
			
			
			BASE64 ENCODE:C895([xShell_Reports:54]xReportData_:29;$t_modeloEnInformeB64)
			Case of 
				: (Length:C16($t_modeloEnInformeB64)#Length:C16($t_modeloEnRepositorioB64))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación en el diseño del informe")
				Else 
					If ($t_modeloEnInformeB64#$t_modeloEnRepositorioB64)
						$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación en el diseño del informe")
					End if 
			End case 
			
			$y_rutaPdf:=OBJECT Get pointer:C1124(Object named:K67:5;"rutaPdf")
			If (Not:C34(Is nil pointer:C315($y_rutaPdf)))
				If ($y_rutaPdf->#"")
					DOCUMENT TO BLOB:C525($y_rutaPdf->;$x_Pdf)
					BASE64 ENCODE:C895($x_Pdf;$t_nuevoEjemploB64)
					
					Case of 
						: (($t_nuevoEjemploB64#"") & ($t_ejemploEnRepositorioB64=""))
							$t_comentarios:=$t_comentarios+"\r•  "+__ ("Nuevo ejemplo del informe")
						Else 
							If ($t_nuevoEjemploB64#$t_ejemploEnRepositorioB64)
								$t_comentarios:=$t_comentarios+"\r•  "+__ ("Actualización del ejemplo de informe")
							End if 
					End case 
				End if 
			End if 
			
			If ([xShell_Reports:54]version_minimo:23#$t_versionMinima)
				$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación de la versión mínima de la aplicación compatible")+" ("+[xShell_Reports:54]version_minimo:23+__ (" en lugar de ")+$t_versionMinima+")"
			End if 
			
			If ([xShell_Reports:54]version_maximo:24#$t_versionMáxima)
				$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación de la versión máxima de la aplicación compatible")+" ("+[xShell_Reports:54]version_maximo:24+__ (" en lugar de ")+$t_versionMaxima+")"
			End if 
			
			  // script antes de imprimir
			Case of 
				: (($t_scriptAntesImpresion#"") & ([xShell_Reports:54]ExecuteBeforePrinting:4=""))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Adición de script ejecutable antes de la impresión")
				: (($t_scriptAntesImpresion="") & ([xShell_Reports:54]ExecuteBeforePrinting:4#""))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Eliminación de script ejecutable antes de la impresión")
				: (Length:C16($t_scriptAntesImpresion)#Length:C16([xShell_Reports:54]ExecuteBeforePrinting:4))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación de script ejecutable antes de la impresión")
				Else 
					If (($t_scriptAntesImpresion#[xShell_Reports:54]ExecuteBeforePrinting:4))
						$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación de script ejecutable antes de la impresión")
					End if 
			End case 
			
			  // script después de imprimir
			Case of 
				: (($t_scriptDespuesImpresion#"") & ([xShell_Reports:54]ExecuteAfterPrinting:30=""))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Adición de script ejecutable después de la impresión")
				: (($t_scriptDespuesImpresion="") & ([xShell_Reports:54]ExecuteAfterPrinting:30#""))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Eliminación de script ejecutable después de la impresión")
				: (Length:C16($t_scriptDespuesImpresion)#Length:C16([xShell_Reports:54]ExecuteAfterPrinting:30))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación de script ejecutable después de la impresión")
				Else 
					If (($t_scriptDespuesImpresion#[xShell_Reports:54]ExecuteAfterPrinting:30))
						$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación de script ejecutable después de la impresión")
					End if 
			End case 
			
			  // ejecución antes de vada registro
			Case of 
				: ($b_ejecutarAntesCadaRegistro & Not:C34([xShell_Reports:54]ExecuteBeforeEachDocument:31))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Alta de la ejecución antes de cada registro")
				: (Not:C34($b_ejecutarAntesCadaRegistro) & [xShell_Reports:54]ExecuteBeforeEachDocument:31)
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Baja de la ejecución antes de cada registro")
			End case 
			
			  // ejecución después de cada registro
			Case of 
				: ($b_ejecutarDespuesCadaRegistro & Not:C34([xShell_Reports:54]ExecuteAfterEachRecord:32))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Alta de la ejecución después de cada registro")
				: (Not:C34($b_ejecutarDespuesCadaRegistro) & [xShell_Reports:54]ExecuteAfterEachRecord:32)
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Baja de la ejecución depués de cada registro")
			End case 
			
			  // una tarea por registro
			Case of 
				: ($b_unaTareaPorRegistro & Not:C34([xShell_Reports:54]isOneRecordReport:11))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Alta de la propiedad Una tarea por registro")
				: (Not:C34($b_unaTareaPorRegistro) & [xShell_Reports:54]ExecuteAfterEachRecord:32)
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Baja de la propiedad Una tarea por registro")
			End case 
			
			  // no requiere selección
			Case of 
				: ($b_noRequiereSeleccion & Not:C34([xShell_Reports:54]NoRequiereSeleccion:40))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Baja de la propiedad No requiere selección")
				: (Not:C34($b_noRequiereSeleccion) & [xShell_Reports:54]NoRequiereSeleccion:40)
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Alta de la propiedad No requiere selección")
			End case 
			
			  // cambios en la relación entre tabla principal y tabla de origen de datos
			If ($l_tablaSuperReport#[xShell_Reports:54]SR_MainTable:42)
				$t_comentarios:=$t_comentarios+"\r•  "+__ ("Cambio de la tabla de origen de datos utilizada en impresiones SuperReport")
			End if 
			If ($l_tablaRelacionada#[xShell_Reports:54]RelatedTable:14)
				$t_comentarios:=$t_comentarios+"\r•  "+__ ("Cambio de la tabla principal de origen de datos a imprimir")
			End if 
			If (($l_campoOrigenRelacion#[xShell_Reports:54]SourceField:13) | ($l_campoDestinoRelacion#[xShell_Reports:54]RelatedField:15))
				$t_comentarios:=$t_comentarios+"\r•  "+__ ("Cambio de la relación entre la tabla principal y la tabla de origen de datos")
			End if 
			
			BASE64 ENCODE:C895([xShell_Reports:54]AssociatedQuery:21;$t_consultaEnInformeB64)
			Case of 
				: (Length:C16($t_consultaEnInformeB64)#Length:C16($t_consultaEnRepositorioB64))
					$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación de la consulta asociada al informe")
				Else 
					If ($t_consultaEnInformeB64#$t_consultaEnRepositorioB64)
						$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación de la consulta asociada al informe")
					End if 
			End case 
			
			  // formulario nativo
			If ($t_nombreFormulario#[xShell_Reports:54]FormName:17)
				$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación del formulario nativo de impresión")
			End if 
			
			If ($t_parametroEspecial#[xShell_Reports:54]SpecialParameter:18)
				$t_comentarios:=$t_comentarios+"\r•  "+__ ("Modificación de parametros especiales para impresión de formulario")
			End if 
	End case 
	
	$t_comentarios:=ST_ClearExtraCR ($t_comentarios)
	
	
	$0:=$t_comentarios
	  //OBJECT SET ENABLED(*;"enviarInforme@";($t_comentarios#"") & (ST Get plain text([xShell_Reports]Descripción)#""))//ABC
	
End if 

