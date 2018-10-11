//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Patricio Aliaga
  // Fecha y hora: 05-09-18, 17:00:29
  // ----------------------------------------------------
  // Método: Upload_CALLBACK1
  // Descripción
  //  Callback
  //
  // Parámetros
  // ----------------------------------------------------


C_LONGINT:C283($1;$2;$3;$4;$5;$l_total)
$l_total:=$1
$count:=$5
l_progress:=IT_Progress (0;l_progress;$count/$l_total;t_mensaje+"\n"+String:C10(Round:C94((($count/1024)/1024);2))+__ (" MB transferidos")+" de "+String:C10(Round:C94((($l_total/1024)/1024);2))+__ (" MB"))