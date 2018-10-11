//%attributes = {}
  //SERwa_Ejecuta

C_BOOLEAN:C305($b_ejecutado;$0)
C_TEXT:C284($1;$t_llaveRec;$t_llaveCalc)
C_TEXT:C284($2;$t_dts)
C_BLOB:C604($3;$xBlob)
C_POINTER:C301($4)
C_TEXT:C284(vt_json)  //Se usa en un tipo de script
C_OBJECT:C1216($ob_logScripts;$ob_exec)
C_TEXT:C284($t_nombrePref;$t_dtsOB)

$t_llaveRec:=$1
$t_dts:=$2
$xBlob:=$3
vt_json:=""

EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")

$t_llaveCalc:=WSscript_GeneraLlave ($t_dts;$xBlob)
$t_script:=Convert to text:C1012($xBlob;"UTF-8")

  //Para log
  //Se genera log por dia
$t_dtsOB:=DTS_MakeFromDateTime 
$t_nombrePref:="XS_HESR_"+Substring:C12($t_dtsOB;1;8)  //Historial ejecucion scripts remotos
$ob_logScripts:=PREF_fGetObject (0;$t_nombrePref;$ob_logScripts)
OB SET:C1220($ob_exec;"llave";$t_llaveRec)
OB SET:C1220($ob_exec;"dts";$t_dts)
OB SET:C1220($ob_exec;"script";$t_script)
OB SET:C1220($ob_exec;"vt_json";vt_json)  //vacia hasta este punto
OB SET:C1220($ob_logScripts;$t_dtsOB;$ob_exec)
PREF_SetObject (0;$t_nombrePref;$ob_logScripts)
FLUSH CACHE:C297

If ($t_llaveCalc=$t_llaveRec)
	$4->:=EXE_Execute ($t_script)
	$b_ejecutado:=True:C214
Else 
	$b_ejecutado:=False:C215
	$4->:="Acceso denegado a la API de servicios de SchoolTrack."
End if 

  //Para guardar la respuesta en el log
OB SET:C1220($ob_exec;"vt_json";vt_json)
OB SET:C1220($ob_exec;"error";$4->)
OB SET:C1220($ob_exec;"ejecutado";$b_ejecutado)
OB SET:C1220($ob_logScripts;$t_dtsOB;$ob_exec)
PREF_SetObject (0;$t_nombrePref;$ob_logScripts)

EM_ErrorManager ("Clear")

$0:=$b_ejecutado