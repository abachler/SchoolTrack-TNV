//%attributes = {}
  // CU_Firmas_LeeFirmantes()
  // Por: Alberto Bachler K.: 23-02-14, 06:47:10
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)
C_POINTER:C301($7)

C_LONGINT:C283($l_filas)
C_POINTER:C301($y_autorizacionProfesores;$y_codigoAsignaturas;$y_nombreAsignaturas;$y_nombreProfesores;$y_rutProfesores;$y_uuidProfesores;$y_mostrarNombresApellidos)
C_OBJECT:C1216($o_firmantes)


If (False:C215)
	C_POINTER:C301(CU_Firmas_LeeFirmantes ;$1)
	C_POINTER:C301(CU_Firmas_LeeFirmantes ;$2)
	C_POINTER:C301(CU_Firmas_LeeFirmantes ;$3)
	C_POINTER:C301(CU_Firmas_LeeFirmantes ;$4)
	C_POINTER:C301(CU_Firmas_LeeFirmantes ;$5)
	C_POINTER:C301(CU_Firmas_LeeFirmantes ;$6)
	C_POINTER:C301(CU_Firmas_LeeFirmantes ;$6)
	C_POINTER:C301(CU_Firmas_LeeFirmantes ;$7)
End if 


$y_nombreAsignaturas:=$1
$y_codigoAsignaturas:=$2
$y_uuidProfesores:=$3
$y_nombreProfesores:=$4
$y_rutProfesores:=$5
$y_autorizacionProfesores:=$6
If (Count parameters:C259=7)
	$y_mostrarNombresApellidos:=$7
End if 

OB_BlobToObject (->[Cursos:3]xoFirmantesActas_cl:8;->$o_firmantes)

OB GET ARRAY:C1229($o_firmantes;"asignaturas";$y_nombreAsignaturas->)
OB GET ARRAY:C1229($o_firmantes;"codigoAsignaturas";$y_codigoAsignaturas->)
OB GET ARRAY:C1229($o_firmantes;"uuidProfesores";$y_uuidProfesores->)
OB GET ARRAY:C1229($o_firmantes;"nombresProfesores";$y_nombreProfesores->)
OB GET ARRAY:C1229($o_firmantes;"rutProfesores";$y_rutProfesores->)
OB GET ARRAY:C1229($o_firmantes;"autorizacionProfesores";$y_autorizacionProfesores->)
If (Not:C34(Is nil pointer:C315($y_mostrarNombresApellidos)))
	$y_mostrarNombresApellidos->:=OB Get:C1224($o_firmantes;"nombresApellidos";Is longint:K8:6)
End if 

$l_filas:=Size of array:C274($y_nombreAsignaturas->)
AT_RedimArrays ($l_filas;$y_nombreAsignaturas;$y_codigoAsignaturas;$y_uuidProfesores;$y_nombreProfesores;$y_rutProfesores;$y_autorizacionProfesores)

