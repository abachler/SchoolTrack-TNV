//%attributes = {}
  // CU_Firmas_GuardaFirmantes()
  // Por: Alberto Bachler K.: 24-02-14, 10:55:49
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

C_LONGINT:C283($l_filas)
C_POINTER:C301($y_autorizacionProfesores;$y_codigoAsignaturas;$y_nombreAsignaturas;$y_nombreProfesores;$y_rutProfesores;$y_uuidProfesores)
C_OBJECT:C1216($o_firmantes)


If (False:C215)
	C_POINTER:C301(CU_Firmas_GuardaFirmantes ;$1)
	C_POINTER:C301(CU_Firmas_GuardaFirmantes ;$2)
	C_POINTER:C301(CU_Firmas_GuardaFirmantes ;$3)
	C_POINTER:C301(CU_Firmas_GuardaFirmantes ;$4)
	C_POINTER:C301(CU_Firmas_GuardaFirmantes ;$5)
	C_POINTER:C301(CU_Firmas_GuardaFirmantes ;$6)
	C_POINTER:C301(CU_Firmas_GuardaFirmantes ;$7)
End if 

$b_tablaEnLectura:=Read only state:C362([Cursos:3])
KRL_ReloadInReadWriteMode (->[Cursos:3])

$y_nombreAsignaturas:=$1
$y_codigoAsignaturas:=$2
$y_uuidProfesores:=$3
$y_nombreProfesores:=$4
$y_rutProfesores:=$5
$y_autorizacionProfesores:=$6
$y_mostrarNombresApellidos:=$7


OB SET ARRAY:C1227($o_firmantes;"asignaturas";$y_nombreAsignaturas->)
OB SET ARRAY:C1227($o_firmantes;"codigoAsignaturas";$y_codigoAsignaturas->)
OB SET ARRAY:C1227($o_firmantes;"uuidProfesores";$y_uuidProfesores->)
OB SET ARRAY:C1227($o_firmantes;"nombresProfesores";$y_nombreProfesores->)
OB SET ARRAY:C1227($o_firmantes;"rutProfesores";$y_rutProfesores->)
OB SET ARRAY:C1227($o_firmantes;"autorizacionProfesores";$y_autorizacionProfesores->)
OB SET:C1220($o_firmantes;"nombresApellidos";$y_mostrarNombresApellidos->)


OB_ObjectToBlob (->$o_firmantes;->[Cursos:3]xoFirmantesActas_cl:8)
SAVE RECORD:C53([Cursos:3])
KRL_ResetPreviousRWMode (->[Cursos:3];$b_tablaEnLectura)