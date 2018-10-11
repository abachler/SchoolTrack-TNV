//%attributes = {"shared":true,"executedOnServer":true}
  // VC4D_SetCommited()
  // 
  //
  // creado por: Alberto Bachler Klein: 15-02-16, 08:27:41
  // -----------------------------------------------------------
C_TEXT:C284($t_uuidMetodo;$t_rutaVC4D)


$t_uuidMetodo:=$1

$t_rutaVC4D:=VC4D_GetDBPath 

Begin SQL
	USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE;
	UPDATE VC4D_HistorialCambios
	SET commited=True Where uuid_metodo=:$t_uuidMetodo and commited=False;
End SQL

Begin SQL
	USE DATABASE SQL_INTERNAL;
End SQL



