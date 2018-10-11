//%attributes = {}
  // Método: VC4D_GetLastModifData
  //
  //
  // por Alberto Bachler Klein
  // creación 17/06/17, 16:54:55
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_DATE:C307($d_fechaModif)
C_TIME:C306($h_horaModif)
C_TEXT:C284($t_dtsModificacion;$t_ruta;$t_rutaVC4D;$t_uuid;$t_uuidMetodo)

ARRAY TEXT:C222($at_autor;0)
ARRAY TEXT:C222($at_codigo;0)
ARRAY TEXT:C222($at_dtsModificacion;0)


If (False:C215)
	C_TEXT:C284(VC4D_GetLastModifData ;$1)
	C_POINTER:C301(VC4D_GetLastModifData ;$2)
	C_POINTER:C301(VC4D_GetLastModifData ;$3)
End if 

$t_ruta:=$1
$t_rutaVC4D:=VC4D_GetDBPath 


  //USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE;
Begin SQL
	SELECT auto_uuid FROM VC4D_Metodos
	WHERE ruta=:$t_ruta
	INTO :$t_uuidMetodo
End SQL

If (UTIL_isOS64bit ($t_uuidMetodo))
	Begin SQL
		USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE;
		SELECT autor, dts_modificacion, codigo FROM VC4D_HistorialCambios
		WHERE uuid_metodo=:$t_uuidMetodo
		INTO :$at_autor, :$at_dtsModificacion, :$at_codigo;
	End SQL
	
	  //Begin SQL
	  //USE DATABASE SQL_INTERNAL;
	  //End SQL
End if 

If (Size of array:C274($at_dtsModificacion)=0)
	METHOD GET MODIFICATION DATE:C1170($t_ruta;$d_fechaModif;$h_horaModif;*)
	$t_dtsModificacion:=String:C10($d_fechaModif;ISO date:K1:8;$h_horaModif)
	APPEND TO ARRAY:C911($at_autor;"desconocido")
	APPEND TO ARRAY:C911($at_dtsModificacion;$t_dtsModificacion)
End if 


SORT ARRAY:C229($at_dtsModificacion;$at_autor;$at_codigo;<)
$0:=$at_autor{1}
Case of 
	: (Count parameters:C259=1)
	: (Count parameters:C259=2)
		$2->:=$at_dtsModificacion{1}
	: (Count parameters:C259=3)
		$2->:=$at_dtsModificacion{1}
		$3->:=$at_codigo{1}
End case 









