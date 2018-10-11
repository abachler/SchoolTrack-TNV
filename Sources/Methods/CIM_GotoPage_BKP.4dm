//%attributes = {}
  // CIM_GotoPage_BKP()
  // Por: Alberto Bachler K.: 06-09-14, 17:59:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_documento)
C_DATE:C307($d_fechaProximoRespaldo;$d_fechaUltimoRespaldo)
_O_C_INTEGER:C282($i_respaldos)
C_LONGINT:C283($l_errorNumero;$l_statusRespaldo;$l_ultimo)
C_TIME:C306($h_horaProximoRespaldo;$h_horaUltimoRespaldo)
C_POINTER:C301($y_Compresion;$y_fechaRespaldos;$y_nombreArchivosRespaldo;$y_programacion_at;$y_reintentarEnUnidad;$y_respaldos_modoEliminacion;$y_rutaArchivosRespaldo)
C_TEXT:C284($t_errorDescripcion;$t_fecha;$t_inicio;$t_json;$t_mensaje;$t_nombreArchivo;$t_ProgramadoA;$t_proximo;$t_refJson;$t_refNodoID)
C_TEXT:C284($t_refNodoRespaldos;$t_refRespaldoAnterior;$t_ruta;$t_rutaDiario;$t_rutaLogRespaldos;$t_statusRespaldo;$t_termino;$t_texto;$t_uuidDatabase)

ARRAY LONGINT:C221($al_resultado;0)
ARRAY LONGINT:C221($al_TipoNodos;0)
ARRAY TEXT:C222($at_inicios;0)
ARRAY TEXT:C222($at_nodos;0)
ARRAY TEXT:C222($at_nombreNodos;0)
ARRAY TEXT:C222($at_ProgramadoA;0)
ARRAY TEXT:C222($at_proximos;0)
ARRAY TEXT:C222($at_rutas;0)
ARRAY TEXT:C222($at_rutasDiario;0)
ARRAY TEXT:C222($at_status;0)
ARRAY TEXT:C222($at_terminos;0)



$y_programacion_at:=OBJECT Get pointer:C1124(Object named:K67:5;"menuProgramacionSeleccion")
AT_Initialize ($y_programacion_at)
APPEND TO ARRAY:C911($y_programacion_at->;__ ("Sin respaldo automático"))
APPEND TO ARRAY:C911($y_programacion_at->;__ ("Programación horaria"))
APPEND TO ARRAY:C911($y_programacion_at->;__ ("Programación diaria"))
APPEND TO ARRAY:C911($y_programacion_at->;__ ("Programación semanal"))
$y_programacion_at->:=1


$y_respaldos_modoEliminacion:=OBJECT Get pointer:C1124(Object named:K67:5;"menuRespaldosModoEliminacion")
AT_Initialize ($y_respaldos_modoEliminacion)
APPEND TO ARRAY:C911($y_respaldos_modoEliminacion->;__ ("Después de respaldar"))
APPEND TO ARRAY:C911($y_respaldos_modoEliminacion->;__ ("Antes de respaldar"))
$y_respaldos_modoEliminacion->:=1

$y_reintentarEnUnidad:=OBJECT Get pointer:C1124(Object named:K67:5;"menuUnidadReintentos")
AT_Initialize ($y_reintentarEnUnidad)
APPEND TO ARRAY:C911($y_reintentarEnUnidad->;__ ("Segundos"))
APPEND TO ARRAY:C911($y_reintentarEnUnidad->;__ ("Minutos"))
APPEND TO ARRAY:C911($y_reintentarEnUnidad->;__ ("Horas"))
$y_reintentarEnUnidad->:=2

$y_Compresion:=OBJECT Get pointer:C1124(Object named:K67:5;"menuRespaldosCompresion")
AT_Initialize ($y_Compresion)
APPEND TO ARRAY:C911($y_Compresion->;__ ("Ninguna"))
APPEND TO ARRAY:C911($y_Compresion->;__ ("Rápido"))
APPEND TO ARRAY:C911($y_Compresion->;__ ("Compacto"))
$y_Compresion->:=2


CIM_BKP_LeePreferencias 
CIM_BKP_AnalisisLog 

  //20160120 RCH Opciones Envio respalgo FTP
(OBJECT Get pointer:C1124(Object named:K67:5;"PermiteEnvioAutomatico"))->:=Num:C11(PREF_fGet (0;"PermitirEnvioRespaldosFTP";"1"))
(OBJECT Get pointer:C1124(Object named:K67:5;"EnviarProximoBackup"))->:=Num:C11(PREF_fGet (0;"EnviarProximoBackup";"0"))

(OBJECT Get pointer:C1124(Object named:K67:5;"EnviarBackupS3"))->:=Num:C11(PREF_fGet (0;"AWS_COLEGIO_PERMITE_ENVIO_CLG";"1"))  //20170605 RCH

