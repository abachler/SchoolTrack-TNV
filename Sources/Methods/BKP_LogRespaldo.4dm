//%attributes = {}
  // BKP_LogRespaldo()
  // Por: Alberto Bachler K.: 01-11-14, 14:23:20
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_bloqueado;$b_invisible)
C_DATE:C307($d_creacion;$d_fechaProximoRespaldo;$d_fechaUltimoRespaldo;$d_modificacion)
C_LONGINT:C283($i;$i_respaldos;$l_nodos;$l_statusNumero;$l_statusRespaldo)
C_TIME:C306($h_creacion;$h_horaProximoRespaldo;$h_horaUltimoRespaldo;$h_modificacion)
C_TEXT:C284($t_fechaHoraRespaldo;$t_fechaHoraRespaldoAnterior;$t_json;$t_nombreBD;$t_nombreInstitucion;$t_programacion;$t_ProgramadoA;$t_proximo;$t_proximoRespaldo;$t_rolBD)
C_TEXT:C284($t_ruta;$t_rutaDiario;$t_rutaLogRespaldos;$t_rutaUltimoDiario;$t_rutaUltimoRespaldo;$t_statusRespaldo;$t_statusTexto;$t_uuidDatabase;$t_XMLrefPrefsRespaldo)
C_OBJECT:C1216($ob_infoRespaldo;$ob_nodoIdentificacion;$ob_nodoRespaldos;$ob_raiz)

ARRAY LONGINT:C221($al_resultado;0)
ARRAY TEXT:C222($at_fechaHoraRespaldos;0)
ARRAY TEXT:C222($at_nombreNodosRespaldo;0)
ARRAY TEXT:C222($at_ProgramadoA;0)
ARRAY TEXT:C222($at_proximos;0)
ARRAY TEXT:C222($at_rutas;0)
ARRAY TEXT:C222($at_rutasDiario;0)
ARRAY TEXT:C222($at_status;0)
ARRAY OBJECT:C1221($ao_nodosRespaldo;0)

  // obtengo información del último respaldo efectuado
GET BACKUP INFORMATION:C888(Last backup date:K54:1;$d_fechaUltimoRespaldo;$h_horaUltimoRespaldo)
GET BACKUP INFORMATION:C888(Next backup date:K54:3;$d_fechaProximoRespaldo;$h_horaProximoRespaldo)
GET BACKUP INFORMATION:C888(Last backup status:K54:2;$l_statusRespaldo;$t_statusRespaldo)

$t_XMLrefPrefsRespaldo:=BKP_ParseXML 
$t_rutaUltimoRespaldo:=DOM_GetValue ($t_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/LastBackupPath/Item1")
$t_rutaUltimoDiario:=DOM_GetValue ($t_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/LastBackupLogPath/Item1")
$t_fechaHoraRespaldo:=String:C10($d_fechaUltimoRespaldo;ISO date:K1:8;$h_horaUltimoRespaldo)
$t_proximoRespaldo:=String:C10($d_fechaProximoRespaldo;ISO date:K1:8;$h_horaProximoRespaldo)
DOM CLOSE XML:C722($t_XMLrefPrefsRespaldo)

READ ONLY:C145([xShell_ApplicationData:45])
ALL RECORDS:C47([xShell_ApplicationData:45])
FIRST RECORD:C50([xShell_ApplicationData:45])
$t_uuidDatabase:=[xShell_ApplicationData:45]UUID_database:13
$t_rolBD:=[xShell_ApplicationData:45]ID_Organizacion:17
$t_nombreInstitucion:=[xShell_ApplicationData:45]Denominacion_Fantasia:28
$t_nombreBD:=SYS_GetServerProperty (XS_DataFileName)


SYS_CreaCarpetaServidor (Get 4D folder:C485(Logs folder:K5:19)+"Backup")
$t_rutaLogRespaldos:=Get 4D folder:C485(Logs folder:K5:19)+"Backup"+Folder separator:K24:12+"Backup "+$t_uuidDatabase+".json"
If (Test path name:C476($t_rutaLogRespaldos)=Is a document:K24:1)
	$t_json:=Document to text:C1236($t_rutaLogRespaldos;"UTF-8")
	$ob_raiz:=OB_JsonToObject ($t_json)
	OB_SET ($ob_raiz;->$t_uuidDatabase;"identificacion.uuidBaseDatos")
	OB_SET ($ob_raiz;->$t_rolBD;"identificacion.idInstitucion")
	OB_SET ($ob_raiz;->$t_nombreInstitucion;"identificacion.nombreInstitucion")
	
Else 
	$h_docRef:=Create document:C266($t_rutaLogRespaldos)
	CLOSE DOCUMENT:C267($h_docRef)
	$ob_raiz:=OB_Create 
	$ob_nodoIdentificacion:=OB_Create 
	$ob_nodoRespaldos:=OB_Create 
	OB_SET ($ob_raiz;->$ob_nodoIdentificacion;"identificacion")
	OB_SET ($ob_raiz;->$ob_nodoRespaldos;"respaldos")
	OB_SET ($ob_raiz;->$t_uuidDatabase;"identificacion.uuidBaseDatos")
	OB_SET ($ob_raiz;->$t_rolBD;"identificacion.idInstitucion")
	OB_SET ($ob_raiz;->$t_nombreInstitucion;"identificacion.nombreInstitucion")
End if 


  // Modificado por: Alexis Bustamante (01-08-2017)
  //TICKET 184843 
OB_GET ($ob_raiz;->$ob_nodoRespaldos;"respaldos")

  //leeo la información de respaldos anteriores
$l_nodos:=OB_GetChildNodes ($ob_nodoRespaldos;->$at_nombreNodosRespaldo;->$ao_nodosRespaldo)
$l_nodos:=Size of array:C274($at_nombreNodosRespaldo)
$l_nodos:=Choose:C955($l_nodos<100;$l_nodos;99)  // tomo en consideración solo los últimos 99 nodos (conservamos solo la información de los ultimos 100)
If ($l_nodos>0)
	For ($i;1;Size of array:C274($ao_nodosRespaldo))
		OB_GET ($ao_nodosRespaldo{$i};->$l_statusNumero;"codigoErrorRespaldo")
		OB_GET ($ao_nodosRespaldo{$i};->$t_statusTexto;"descripcionErrorRespaldo")
		OB_GET ($ao_nodosRespaldo{$i};->$t_ruta;"rutaRespaldo")
		OB_GET ($ao_nodosRespaldo{$i};->$t_ProgramadoA;"programadoA")
		OB_GET ($ao_nodosRespaldo{$i};->$t_fechaHoraRespaldoAnterior;"fechahoraRespaldo")
		OB_GET ($ao_nodosRespaldo{$i};->$t_proximo;"respaldoProximo")
		APPEND TO ARRAY:C911($al_resultado;$l_statusNumero)
		APPEND TO ARRAY:C911($at_status;$t_statusTexto)
		APPEND TO ARRAY:C911($at_rutas;$t_ruta)
		APPEND TO ARRAY:C911($at_rutasDiario;$t_rutaDiario)
		APPEND TO ARRAY:C911($at_ProgramadoA;$t_ProgramadoA)
		APPEND TO ARRAY:C911($at_fechaHoraRespaldos;$t_fechaHoraRespaldoAnterior)
		APPEND TO ARRAY:C911($at_proximos;$t_proximo)
	End for 
End if 
OB_Remove ($ob_raiz;"respaldos")  // elimino el nodo para reconstruirlo más abajo


If (Test path name:C476($t_rutaUltimoRespaldo)=Is a document:K24:1)
	GET DOCUMENT PROPERTIES:C477($t_rutaUltimoRespaldo;$b_bloqueado;$b_invisible;$d_creacion;$h_creacion;$d_modificacion;$h_modificacion)
	If (Test path name:C476($t_rutaUltimoDiario)#Is a document:K24:1)
		$t_rutaUltimoDiario:=""
	End if 
End if 

If ($l_statusRespaldo=0)
	$t_statusRespaldo:=""
End if 
If (Size of array:C274($at_proximos)>0)
	$t_programadoA:=$at_proximos{1}
End if 
  // creo un nodo para el último respaldo
$ob_infoRespaldo:=OB_Create 
OB_SET ($ob_infoRespaldo;->$l_statusRespaldo;"codigoErrorRespaldo")
OB_SET ($ob_infoRespaldo;->$t_statusRespaldo;"descripcionErrorRespaldo")
OB_SET ($ob_infoRespaldo;->$t_rutaUltimoRespaldo;"rutaRespaldo")
OB_SET ($ob_infoRespaldo;->$t_programadoA;"programadoA")
OB_SET ($ob_infoRespaldo;->$t_fechaHoraRespaldo;"fechahoraRespaldo")
OB_SET ($ob_infoRespaldo;->$t_proximoRespaldo;"respaldoProximo")

  // recreo el nodo respaldos, agrego el último y agrego el nodo a la raiz
$ob_nodoRespaldos:=OB_Create 
OB_SET ($ob_nodoRespaldos;->$ob_infoRespaldo;$t_fechaHoraRespaldo)


  // agrego la información de respaldos anteriores al nodo respaldos
For ($i_respaldos;1;Size of array:C274($at_rutas))
	If ($i_respaldos>1)
		$t_programacion:=$at_ProgramadoA{$i_respaldos}
	Else 
		$t_programacion:=""
	End if 
	$l_statusNumero:=$al_resultado{$i_respaldos}
	$t_statusTexto:=$at_status{$i_respaldos}
	$t_ruta:=$at_rutas{$i_respaldos}
	$t_fechaHoraRespaldo:=$at_fechaHoraRespaldos{$i_respaldos}
	$t_proximo:=$at_proximos{$i_respaldos}
	$t_programacion:=$at_ProgramadoA{$i_respaldos}
	If ($l_statusNumero=0)
		$t_statusTexto:=""
	End if 
	
	  //creo un nodo con la información del respaldo anterior
	$ob_infoRespaldo:=OB_Create 
	OB_SET ($ob_infoRespaldo;->$l_statusNumero;"codigoErrorRespaldo")
	OB_SET ($ob_infoRespaldo;->$t_statusTexto;"descripcionErrorRespaldo")
	OB_SET ($ob_infoRespaldo;->$t_ruta;"rutaRespaldo")
	OB_SET ($ob_infoRespaldo;->$t_programacion;"programadoA")
	OB_SET ($ob_infoRespaldo;->$t_fechaHoraRespaldo;"fechahoraRespaldo")
	OB_SET ($ob_infoRespaldo;->$t_proximo;"respaldoProximo")
	
	  // lo agrego al nodo respaldos
	OB_SET ($ob_nodoRespaldos;->$ob_infoRespaldo;$t_fechaHoraRespaldo)
End for 

OB_SET ($ob_raiz;->$ob_nodoRespaldos;"respaldos")
$t_json:=OB_Object2Json ($ob_raiz;True:C214)

TEXT TO DOCUMENT:C1237($t_rutaLogRespaldos;$t_json;"UTF-8")




