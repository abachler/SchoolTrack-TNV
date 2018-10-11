//%attributes = {}
  // Método: _InfoReglamentariaAlumno
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 26/10/09, 10:41:59
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($fieldName;$1)
C_TEXT:C284($0)

  // Código principal
$fieldName:=$1
$0:=MDATA_RetornaLiteral (->[Alumnos:2]numero:1;$fieldName)





