//%attributes = {}
  //SYS_DateTime2Secs

  // ==================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 28/05/03, 11:26:29
  // -------------------------------------------------------------------------------
  // Metodo: SYS_DateTime2Secs
  // Descripcion Convierte Fecha y hora a segundos sobre la base de la fecha de referencia 
  // (01/01/1904 a 00:00)
  // 
  //Syntaxis: sy
  // Parametros
  //$1=Fecha; $2=hora; $3=longint (solo par compatibilidad con ITK)
  // ===================================================================



  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_DATE:C307($date;$1)
C_TIME:C306($time;$2)
C_REAL:C285($secs;$0)

  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
$date:=$1
$time:=$2

  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
$dateOffset:=$date-!1904-01-01!
$secsOffset:=$dateOffset*86400
$secsTime:=$time*1
$secs:=$secsOffset+$secsTime
$0:=$secs

  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
  // -------------------------------------------------------------------------------