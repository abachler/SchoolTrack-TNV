//%attributes = {}
  // CIM_RespaldaIndex()
  // Por: Alberto Bachler K.: 08-04-15, 15:38:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_LONGINT:C283($i;$l_campo;$l_elemento;$l_idProgreso;$l_tabla;$l_tipoIndex)
C_POINTER:C301($y_Campo;$y_IdCampo;$y_IdTabla;$y_listBox;$y_nombreIndex;$y_Tabla;$y_tipoCampo;$y_TipoIndex;$y_tipoIndexNum;$y_uuidIndex)
C_TEXT:C284($t_json;$t_nombreCampo;$t_nombreIndex;$t_rutaRespaldo;$t_uuidIndex;$t_varianteTipo)
C_OBJECT:C1216($ob_indexInfo;$ob_raiz)

ARRAY LONGINT:C221($al_Campo;0)
ARRAY LONGINT:C221($al_elementosEncontrados;0)
ARRAY LONGINT:C221($al_tabla;0)
ARRAY TEXT:C222($at_uuidIndexCompuestos;0)

$y_IdTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"ID_Tabla")
$y_IdCampo:=OBJECT Get pointer:C1124(Object named:K67:5;"Id_campo")
$y_Tabla:=OBJECT Get pointer:C1124(Object named:K67:5;"Tabla")
$y_Campo:=OBJECT Get pointer:C1124(Object named:K67:5;"campo")
$y_TipoIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoIndex")
$y_nombreIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreIndex")
$y_tipoCampo:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoCampo")
$y_tipoIndexNum:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoIndex_L")
$y_uuidIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"ID_indice")
$y_listBox:=OBJECT Get pointer:C1124(Object named:K67:5;"listboxIndexes")



$l_idProgreso:=Progress New 
Progress SET TITLE ($l_idProgreso;__ ("Guardando esquema de indexación");-1;"";True:C214)

$y_TipoIndex->{0}:="composite"
AT_MultiArraySearch (False:C215;->$al_elementosEncontrados;$y_TipoIndex)
For ($i;1;Size of array:C274($al_elementosEncontrados))
	$t_uuidIndex:=$y_uuidIndex->{$al_elementosEncontrados{$i}}
	If (Find in array:C230($at_uuidIndexCompuestos;$t_uuidIndex)=-1)
		APPEND TO ARRAY:C911($at_uuidIndexCompuestos;$t_uuidIndex)
	End if 
End for 

$ob_raiz:=OB_Create 
For ($i;1;Size of array:C274($at_uuidIndexCompuestos))
	$t_uuidIndex:=$at_uuidIndexCompuestos{$i}
	$l_tipoIndex:=1
	$l_elemento:=Find in array:C230($y_uuidIndex->;$t_uuidIndex)
	$t_nombreIndex:=$y_nombreIndex->{$l_elemento}
	$t_varianteTipo:="Composite"
	$t_nombreCampo:=""
	$l_elemento:=Find in array:C230($y_uuidIndex->;$t_uuidIndex)
	
	AT_Initialize (->$al_tabla;->$al_Campo)
	Repeat 
		APPEND TO ARRAY:C911($al_tabla;$y_IdTabla->{$l_elemento})
		APPEND TO ARRAY:C911($al_Campo;$y_IdCampo->{$l_elemento})
		$l_elemento:=$l_elemento+1
		$l_elemento:=Find in array:C230($y_uuidIndex->;$t_uuidIndex;$l_elemento)
	Until ($l_elemento=-1)
	$ob_indexInfo:=OB_Create 
	OB_SET ($ob_indexInfo;->$t_uuidIndex;"uuid")
	OB_SET ($ob_indexInfo;->$l_tipoIndex;"tipo")
	OB_SET ($ob_indexInfo;->$t_varianteTipo;"varianteTipo")
	OB_SET ($ob_indexInfo;->$t_nombreIndex;"nombreIndex")
	OB_SET ($ob_indexInfo;->$t_nombreCampo;"nombreCampo")
	OB_SET ($ob_indexInfo;->$al_tabla;"tabla")
	OB_SET ($ob_indexInfo;->$al_Campo;"campo")
	
	OB_SET ($ob_raiz;->$ob_indexInfo;"index "+$t_uuidIndex)
End for 


For ($i;1;Size of array:C274($y_uuidIndex->))
	$t_uuidIndex:=$y_uuidIndex->{$i}
	$t_nombreIndex:=$y_nombreIndex->{$i}
	$t_nombreCampo:=$y_Tabla->{$i}
	$l_tabla:=$y_IdTabla->{$i}
	$l_campo:=$y_IdCampo->{$i}
	$l_tipoIndex:=$y_tipoIndexNum->{$i}
	$t_varianteTipo:=$y_TipoIndex->{$i}
	
	If ($t_varianteTipo#"Composite")
		AT_Initialize (->$al_tabla;->$al_Campo)
		APPEND TO ARRAY:C911($al_tabla;$y_IdTabla->{$i})
		APPEND TO ARRAY:C911($al_Campo;$y_IdCampo->{$i})
		
		$ob_indexInfo:=OB_Create 
		OB_SET ($ob_indexInfo;->$t_uuidIndex;"uuid")
		OB_SET ($ob_indexInfo;->$l_tipoIndex;"tipo")
		OB_SET ($ob_indexInfo;->$t_varianteTipo;"varianteTipo")
		OB_SET ($ob_indexInfo;->$t_nombreIndex;"nombreIndex")
		OB_SET ($ob_indexInfo;->$t_nombreCampo;"nombreCampo")
		OB_SET ($ob_indexInfo;->$al_tabla;"tabla")
		OB_SET ($ob_indexInfo;->$al_Campo;"campo")
		
		OB_SET ($ob_raiz;->$ob_indexInfo;"index "+$t_uuidIndex)
	End if 
	
End for 


$t_json:=OB_Object2Json ($ob_raiz;True:C214)
If (Application type:C494#4D Remote mode:K5:5)
	$t_rutaRespaldo:=Get 4D folder:C485(Database folder:K5:14)+"indexacionSchooltrack.json"
	TEXT TO DOCUMENT:C1237($t_rutaRespaldo;$t_json;"UTF-8")
Else 
	$t_rutaRespaldo:=Temporary folder:C486+"indexacionSchooltrack.json"
	TEXT TO DOCUMENT:C1237($t_rutaRespaldo;$t_json;"UTF-8")
	DOCUMENT TO BLOB:C525($t_rutaRespaldo;$x_blob)
	KRL_SendFileToServer ("indexacionSchooltrack.json";$x_blob)
End if 

Progress QUIT ($l_idProgreso)