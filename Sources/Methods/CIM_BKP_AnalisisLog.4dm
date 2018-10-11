//%attributes = {}
  // CIM_BKP_AnalisisLog()
  // Por: Alberto Bachler K.: 02-11-14, 09:54:22
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_documento)
C_LONGINT:C283($i_nodos;$i_respaldos;$l_errorNumero;$l_nodos)
C_POINTER:C301($y_fechaRespaldos;$y_nombreArchivosRespaldo;$y_rutaArchivosRespaldo)
C_TEXT:C284($t_errorDescripcion;$t_fecha;$t_inicio;$t_json;$t_mensaje;$t_nombreArchivo;$t_ProgramadoA;$t_proximo;$t_ruta;$t_rutaLogRespaldos)
C_TEXT:C284($t_texto;$t_uuidDatabase)
C_OBJECT:C1216($ob_nodoRespaldos;$ob_raiz)

ARRAY LONGINT:C221($al_resultado;0)
ARRAY TEXT:C222($at_inicios;0)
ARRAY TEXT:C222($at_nombrePropiedades;0)
ARRAY TEXT:C222($at_ProgramadoA;0)
ARRAY TEXT:C222($at_proximos;0)
ARRAY TEXT:C222($at_rutas;0)
ARRAY TEXT:C222($at_status;0)
ARRAY OBJECT:C1221($ao_objetos;0)

READ ONLY:C145([xShell_ApplicationData:45])
ALL RECORDS:C47([xShell_ApplicationData:45])
FIRST RECORD:C50([xShell_ApplicationData:45])
$t_uuidDatabase:=[xShell_ApplicationData:45]UUID_database:13
Case of 
	: (Application type:C494=4D Remote mode:K5:5)
		$t_rutaLogRespaldos:=SYS_GetServer_4DFolder (Logs folder:K5:19)+"Backup"+SYS_FolderDelimiterOnServer +"Backup "+$t_uuidDatabase+".json"
		If (SYS_TestPathName_Server ($t_rutaLogRespaldos)=Is a document:K24:1)
			$x_documento:=KRL_GetFileFromServer ($t_rutaLogRespaldos;True:C214)
			$t_json:=Convert to text:C1012($x_documento;"UTF-8")
		End if 
		
	: ((Application type:C494=4D Volume desktop:K5:2) | (Application type:C494=4D Local mode:K5:1))
		$t_rutaLogRespaldos:=Get 4D folder:C485(Logs folder:K5:19)+"Backup"+Folder separator:K24:12+"Backup "+$t_uuidDatabase+".json"
		If (Test path name:C476($t_rutaLogRespaldos)=Is a document:K24:1)
			$t_json:=Document to text:C1236($t_rutaLogRespaldos;"UTF-8")
		End if 
End case 


If ($t_json#"")
	$ob_raiz:=OB_JsonToObject ($t_json)
	OB_GET ($ob_raiz;->$ob_nodoRespaldos;"respaldos")
	$l_nodos:=OB_GetChildNodes ($ob_nodoRespaldos;->$at_nombrePropiedades;->$ao_objetos)
	For ($i_nodos;1;Size of array:C274($at_nombrePropiedades))
		OB_GET ($ao_objetos{$i_nodos};->$l_errorNumero;"codigoErrorRespaldo")
		OB_GET ($ao_objetos{$i_nodos};->$t_errorDescripcion;"descripcionErrorRespaldo")
		OB_GET ($ao_objetos{$i_nodos};->$t_ruta;"rutaRespaldo")
		OB_GET ($ao_objetos{$i_nodos};->$t_ProgramadoA;"programadoA")
		OB_GET ($ao_objetos{$i_nodos};->$t_inicio;"fechahoraRespaldo")
		OB_GET ($ao_objetos{$i_nodos};->$t_proximo;"respaldoProximo")
		If (Find in array:C230($at_rutas;$t_ruta)=-1)
			APPEND TO ARRAY:C911($al_resultado;$l_errorNumero)
			APPEND TO ARRAY:C911($at_status;$t_errorDescripcion)
			APPEND TO ARRAY:C911($at_rutas;$t_ruta)
			APPEND TO ARRAY:C911($at_ProgramadoA;$t_ProgramadoA)
			APPEND TO ARRAY:C911($at_inicios;$t_inicio)
			APPEND TO ARRAY:C911($at_proximos;$t_proximo)
		End if 
	End for 
	SORT ARRAY:C229($at_inicios;$at_rutas;<)
	
	
	$y_fechaRespaldos:=OBJECT Get pointer:C1124(Object named:K67:5;"fechaRespaldo")
	$y_nombreArchivosRespaldo:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreArchivoRespaldo")
	$y_rutaArchivosRespaldo:=OBJECT Get pointer:C1124(Object named:K67:5;"rutaArchivoRespaldo")
	AT_Initialize ($y_fechaRespaldos;$y_nombreArchivosRespaldo;$y_rutaArchivosRespaldo)
	For ($i_respaldos;1;Size of array:C274($al_resultado))
		$t_fecha:=DT_FechaISO_a_FechaHora ($at_inicios{$i_respaldos})
		$l_errorNumero:=$al_resultado{$i_respaldos}
		If ($l_errorNumero=0)
			$t_ruta4BK:=$at_rutas{$i_respaldos}
			$t_ruta7z:=Replace string:C233($t_ruta4BK;".4BK";".7z")
			$t_ruta7z:=$t_ruta4BK+".7z"
			$t_nombreArchivo4BK:=SYS_Path2FileName ($at_rutas{$i_respaldos})
			$t_nombreArchivo7z:=Replace string:C233($t_nombreArchivo4BK;".4BK";".7z")
			$t_nombreArchivo7z:=$t_nombreArchivo4BK+".7z"
			If (SYS_TestPathName_Server ($t_ruta4BK)=Is a document:K24:1)
				APPEND TO ARRAY:C911($y_nombreArchivosRespaldo->;$t_nombreArchivo4BK)
				APPEND TO ARRAY:C911($y_rutaArchivosRespaldo->;$t_ruta4BK)
				APPEND TO ARRAY:C911($y_fechaRespaldos->;$t_fecha)
			End if 
			If (SYS_TestPathName_Server ($t_ruta7z)=Is a document:K24:1)
				APPEND TO ARRAY:C911($y_nombreArchivosRespaldo->;$t_nombreArchivo7z)
				APPEND TO ARRAY:C911($y_rutaArchivosRespaldo->;$t_ruta7z)
				APPEND TO ARRAY:C911($y_fechaRespaldos->;$t_fecha)
			End if 
		End if 
	End for 
End if 


$t_texto:=BKP_InfoUltimoRespaldo 
OBJECT SET TITLE:C194(*;"infoRespaldo";$t_texto)