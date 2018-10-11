//%attributes = {}
  // Método: ACTcfg_OpcionesArchivoBancario
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 24-02-10, 11:56:33
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($vt_accion;$1;$vt_retorno;$0)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1;$ptr2)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

  // Código principal
Case of 
	: ($vt_accion="RetornaNombreBanco")
		READ ONLY:C145([xxACT_Bancos:129])
		QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Codigo:2=ST_GetWord ($ptr1->;2;".");*)
		QUERY:C277([xxACT_Bancos:129]; & ;[xxACT_Bancos:129]Pais:3=ST_GetWord ($ptr1->;1;"."))
		If (Records in selection:C76([xxACT_Bancos:129])=1)
			$vt_retorno:=[xxACT_Bancos:129]Nombre:1
		End if 
		
	: ($vt_accion="DeclaraArreglosFrom")
		ARRAY LONGINT:C221(alACT_ABArchivoID;0)
		ARRAY TEXT:C222(atACT_ABArchivoNombre;0)
		ARRAY BOOLEAN:C223(abACT_ABArchivoImpExp;0)
		ARRAY TEXT:C222(atACT_ABArchivoTipo;0)
		ARRAY TEXT:C222(atACT_ABArchivoBanco;0)
		
End case 

$0:=$vt_retorno