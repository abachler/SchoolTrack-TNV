//%attributes = {"executedOnServer":true}
  // MÉTODO: CIM_VerifyDataFile
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 29/06/11, 05:22:59
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // CIM_VerifyDataFile()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_POINTER:C301($y_ArregloErrores;$3)
C_TEXT:C284(vt_client;$1)  // nombre del cliente si el proceso de verificación fue iniciado desde un cliente, utilizado por el método de callback
C_LONGINT:C283(vl_ClientProgressProcessID;$2)  // id del proceso cliente en el que se muestra el mensaje de progreso, utilizado por el método de callback


  // CODIGO PRINCIPAL
ARRAY TEXT:C222(at_DataFileError;0)  // para almacenar los errores detectados

vt_client:=""
vl_ClientProgressProcessID:=0
Case of 
	: (Count parameters:C259=3)
		  //si el método es llamdo desde otro método con parametros con el nombre del cliente y ID del mensaje de progreso
		vt_client:=$1
		vl_ClientProgressProcessID:=$2
		$y_arregloErrores:=$3
		
	: (Count parameters:C259=2)
		  //si el método es llamdo desde otro método con parametros con el nombre del cliente y ID del mensaje de progreso
		vt_client:=$1
		vl_ClientProgressProcessID:=$2
		
		
	: ((Application type:C494=4D Server:K5:6) | (Application type:C494=4D Local mode:K5:1))
		  // si el método es ejecutado directamente en 4D server o 4D local
		  // no se usa el mensaje de progreso en el cliente
		vt_client:=""
		vl_ClientProgressProcessID:=0
		
		
	: (Application type:C494=4D Remote mode:K5:5)
		  // si la aplicación es un cliente pero no se recibieron parametros mostrar el mensaje
		vt_client:=""
		vl_ClientProgressProcessID:=0
End case 


  // iniciamos el mensaje de proceso en el servidor o en 4D monousuario 
  // la variable vl_ServerProgressProcessID contiene el ID del proceso en el servidor o en 4D monousuario
vl_ServerProgressProcessID:=IT_Progress (1;0;0;__ ("Verificando base de datos..."))
OK:=0
VERIFY CURRENT DATA FILE:C1008(Verify all:K57:1;0;"CIM_VerifyDataFile_Callback")
$0:=OK

If (Size of array:C274(at_DataFileError)>0)
	$0:=0
Else 
	$0:=1
End if 

If (Not:C34(Is nil pointer:C315($y_arregloErrores)))
	COPY ARRAY:C226(at_DataFileError;$y_arregloErrores->)
End if 


