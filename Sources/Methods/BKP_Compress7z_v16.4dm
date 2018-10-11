//%attributes = {"executedOnServer":true}
  // Método: BKP_Compress7z
  // comprime el último respaldo y elimina los respaldos *comprimidos* previos
  //
  // creado por Alberto Bachler Klein
  // el 15/03/18, 15:28:22
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

C_BOOLEAN:C305($0)
C_BOOLEAN:C305($b_locked;$b_visible)
C_DATE:C307($d_creacion;$d_modificacion)
C_LONGINT:C283($i;$l_maximoRespaldos;$l_progress;$l_respaldos_a_eliminar)
C_TIME:C306($h_creacion;$h_modificacion)
C_TEXT:C284($t_carpeta_a_Comprimir;$t_destination4BK;$t_destination4BL;$t_destinoCompresion;$t_dts;$t_error;$t_rutaCarpetaRespaldos;$t_rutaRespaldoComprimido;$t_rutaRespaldos;$t_rutaUltimoBK)
C_TEXT:C284($t_rutaUltimoBL;$t_rutaUltimoRespaldo;$t_source4BL;$t_XMLrefPrefsRespaldo)

ARRAY TEXT:C222($at_documentos;0)
ARRAY TEXT:C222($at_documentos4BK;0)
ARRAY TEXT:C222($at_documentos4BL;0)
ARRAY TEXT:C222($at_documentos7z;0)
ARRAY TEXT:C222($at_dts4BK;0)
ARRAY TEXT:C222($at_dts4BL;0)
ARRAY TEXT:C222($at_dts7z;0)

BKP_LeeItemPlanBackup ("BKP_rutaCarpetaRespaldos";->$t_rutaCarpetaRespaldos)
BKP_LeeItemPlanBackup ("BKP_Respaldos_aConservar";->$l_maximoRespaldos)
$t_rutaUltimoRespaldo:=BKP_UltimoRespaldoDisponible 

DOCUMENT LIST:C474($t_rutaCarpetaRespaldos;$at_documentos;Ignore invisible:K24:16+Absolute path:K24:14)
For ($i;Size of array:C274($at_documentos);1;-1)
	GET DOCUMENT PROPERTIES:C477($at_documentos{$i};$b_locked;$b_visible;$d_creacion;$h_creacion;$d_modificacion;$h_modificacion)
	$t_dts:=String:C10($d_modificacion;ISO date GMT:K1:10;$h_modificacion)
	Case of 
		: ($at_documentos{$i}="@.7z")
			APPEND TO ARRAY:C911($at_documentos7z;$at_documentos{$i})
			APPEND TO ARRAY:C911($at_dts7z;$t_dts)
			
		: ($at_documentos{$i}="@.4BK")
			APPEND TO ARRAY:C911($at_documentos4BK;$at_documentos{$i})
			APPEND TO ARRAY:C911($at_dts4BK;$t_dts)
			
		: ($at_documentos{$i}="@.4BL")
			APPEND TO ARRAY:C911($at_documentos4BL;$at_documentos{$i})
			APPEND TO ARRAY:C911($at_dts4BL;$t_dts)
	End case 
	
End for 


  // eliminos los .4BK anteriores al último
SORT ARRAY:C229($at_dts4BK;$at_documentos4BK;>)
For ($i;1;Size of array:C274($at_documentos4BK)-1)
	DELETE DOCUMENT:C159($at_documentos4BK{$i})
End for 

  // eliminos los .4BL anteriores al último
SORT ARRAY:C229($at_dts4BL;$at_documentos4BL;>)
For ($i;1;Size of array:C274($at_documentos4BL)-1)
	DELETE DOCUMENT:C159($at_documentos4BL{$i})
End for 



  // creo la carpeta para la compresión de archivos
$t_carpeta_a_Comprimir:=Replace string:C233($t_rutaUltimoRespaldo;".4BK";"")+Folder separator:K24:12
$t_destinoCompresion:=$t_rutaUltimoRespaldo+".7z"
CREATE FOLDER:C475($t_carpeta_a_Comprimir;*)

If (Size of array:C274($at_dts4BK)>0)
	SORT ARRAY:C229($at_dts4BK;$at_documentos4BK;<)
	$t_rutaUltimoBK:=$at_documentos4BK{1}
	$t_destination4BK:=$t_carpeta_a_Comprimir+SYS_Path2FileName ($t_rutaUltimoBK)
	If (Test path name:C476($t_rutaUltimoBK)=Is a document:K24:1)
		  // muevo el ultimo respaldo
		MOVE DOCUMENT:C540($t_rutaUltimoBK;$t_destination4BK)
	End if 
End if 

  // si el respaldo del journal  correspondiente al respaldo anterior existe
  // lo muevo a una carpeta temporal junto con el respaldo de la base de datos
  // y comprimo ambos archivos
If (Size of array:C274($at_dts4BL)>0)
	SORT ARRAY:C229($at_dts4BL;$at_documentos4BL;<)
	$t_source4BL:=$at_documentos4BL{1}
	$t_destination4BL:=$t_carpeta_a_Comprimir+SYS_Path2FileName ($t_source4BL)
	If (Test path name:C476($t_source4BL)=Is a document:K24:1)
		  // muevo el journal previo al respaldo anterior
		MOVE DOCUMENT:C540($t_source4BL;$t_destination4BL)
	End if 
End if 



DOCUMENT LIST:C474($t_carpeta_a_Comprimir;$at_documentos)
If (Size of array:C274($at_documentos)>0)
	  // comprimo ambos archivos
	$l_progress:=IT_UThermometer (1;0;__ ("Comprimiendo el último respaldo…");-1)
	$0:=z7_Archive ($t_carpeta_a_Comprimir;$t_destinoCompresion;"";->$t_error)
	$l_progress:=IT_UThermometer (-2;$l_progress)
	
	  // devuelvo los archivos a la carpeta de respaldos original
	If (Test path name:C476($t_destination4BK)=Is a document:K24:1)
		MOVE DOCUMENT:C540($t_destination4BK;$t_rutaUltimoRespaldo)
	End if 
	
	If (Test path name:C476($t_destination4BL)=Is a document:K24:1)
		MOVE DOCUMENT:C540($t_destination4BL;$t_source4BL)
	End if 
	
	DELETE FOLDER:C693($t_carpeta_a_Comprimir;Delete only if empty:K24:23)
	
End if 


  //Elimino los respaldos que exedan el máximo de respaldos a conservar
DOCUMENT LIST:C474($t_rutaCarpetaRespaldos;$at_documentos;Ignore invisible:K24:16+Absolute path:K24:14)


AT_Initialize (->$at_documentos7z;->$at_dts7z)
For ($i;Size of array:C274($at_documentos);1;-1)
	GET DOCUMENT PROPERTIES:C477($at_documentos{$i};$b_locked;$b_visible;$d_creacion;$h_creacion;$d_modificacion;$h_modificacion)
	$t_dts:=String:C10($d_modificacion;ISO date GMT:K1:10;$h_modificacion)
	If ($at_documentos{$i}="@.7z")
		APPEND TO ARRAY:C911($at_documentos7z;$at_documentos{$i})
		APPEND TO ARRAY:C911($at_dts7z;$t_dts)
	End if 
End for 

SORT ARRAY:C229($at_dts7z;$at_documentos7z;>)
If (Size of array:C274($at_documentos7z)>$l_maximoRespaldos)
	$l_respaldos_a_eliminar:=Size of array:C274($at_documentos7z)-$l_maximoRespaldos
	For ($i;1;$l_respaldos_a_eliminar)
		DELETE DOCUMENT:C159($at_documentos7z{$i})
	End for 
End if 






