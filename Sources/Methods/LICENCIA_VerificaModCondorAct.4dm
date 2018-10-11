//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 09-11-15, 12:01:12
  // ----------------------------------------------------
  // Método: LICENCIA_VerificaModCondorAct
  // Descripción
  // 
  //ASM Método para verficar si algún modulo condor se encuentra activo
  //
  // Parámetros
  // $1 se debe pasar el nombre del módulo condor a consultar.
  // Los módulos que vienen en la licencia son los siguientes (nombre en el json) :
  // Extracurriculares
  // Inhabilidad
  // OrientacionySeguimiento
  // Personas
  // PlanificaFacil
  // Postulaciones
  // Reinscripciones
  // Tareas
  // Se debe pasar como parametro el nombre de alguno de los módulos.
  //
  // ----------------------------------------------------

C_TEXT:C284($1)
C_BOOLEAN:C305($0)

C_BLOB:C604($x_Licencia;$x_llavePublica)
C_BOOLEAN:C305($b_activo)
C_LONGINT:C283($l_HLcrypt)
C_TEXT:C284($t_condor;$t_json;$t_jsonLicencia;$t_Licencia;$t_llavePublica;$t_oys;$t_refjson;$t_refJsonLicencia)
C_OBJECT:C1216($ob;$ob_licencia;$ob_LicenciaCondor;$ob_licencia2)
C_POINTER:C301($y_jsonModCondor)

$t_modulo:=$1  //"Orientacion y Seguimiento"

If (Count parameters:C259=2)
	$y_jsonModCondor:=$2
End if 

ALL RECORDS:C47([xShell_ApplicationData:45])
$t_json:=[xShell_ApplicationData:45]Licencia:23

  // Modificado por: Alexis Bustamante (12-06-2017)
  //TICKET 179869

If (Valida_json ($t_json))
	
	$ob:=OB_Create 
	$ob_licencia:=OB_Create 
	$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
	
	OB_GET ($ob;->$ob_licencia;"licencia")
	OB_GET ($ob_licencia;->$t_Licencia;"datosLicencia")
	
	BASE64 DECODE:C896($t_Licencia;$x_Licencia)
	
	If (BLOB size:C605($x_Licencia)>0)
		
		$t_jsonLicencia:=CRYPT_NewEncryptDecrypt ("decryptNo4d";"public";$t_Licencia;True:C214)
		
		$ob_licencia2:=OB_Create 
		$ob_LicenciaCondor:=OB_Create 
		$ob_Modulo:=OB_Create 
		
		$ob_LicenciaCondor:=JSON Parse:C1218($t_jsonLicencia;Is object:K8:27)
		
		OB_GET ($ob_LicenciaCondor;->$ob_licencia2;"condor")
		OB_GET ($ob_licencia2;->$ob_Modulo;$t_modulo)
		OB_GET ($ob_Modulo;->$b_activo;"activo")
		
		If (Count parameters:C259=2)
			$y_jsonModCondor->:=$ob_licencia2
		End if 
	Else 
		$b_activo:=False:C215
	End if 
Else 
	$b_activo:=False:C215
End if 

$0:=$b_activo