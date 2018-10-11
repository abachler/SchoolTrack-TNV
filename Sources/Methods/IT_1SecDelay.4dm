//%attributes = {}
  //IT_1SecDelay

  //En $1 entregamos la cantidad de tiempo de delay en segundos

C_REAL:C285($1)
$ticks:=$1*60
$inicio:=Tickcount:C458
While (Tickcount:C458-$inicio<$ticks)
	IDLE:C311
	IDLE:C311
	IDLE:C311
End while 