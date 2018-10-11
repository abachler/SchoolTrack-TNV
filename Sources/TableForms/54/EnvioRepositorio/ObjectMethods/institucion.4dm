  // [xShell_Reports].EnvioRepositorio.institucion()
  // Por: Alberto Bachler K.: 13-08-14, 11:30:33
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_elemento;$l_itemSeleccionado)
C_TEXT:C284($t_ColegioActual;$t_json;$t_refJson)

ARRAY TEXT:C222($at_nombreColegio;0)
ARRAY TEXT:C222($at_uuidColegio;0)

$t_json:=OBJECT Get pointer:C1124(Object named:K67:5;"jsonColegios")->

C_OBJECT:C1216($ob)
$ob:=JSON Parse:C1218($t_json;Is object:K8:27)

OB_GET ($ob;->$at_nombreColegio;"nombreColegios")
OB_GET ($ob;->$at_uuidColegio;"uuidColegios")
  // Modificado por: Alexis Bustamante (10-06-2017)
  //TICKET 179869
  //$t_refJson:=JSON Parse text ($t_json)
  //JSON_ExtraeValor ($t_refJson;"nombreColegios";->$at_nombreColegio)
  //JSON_ExtraeValor ($t_refJson;"uuidColegios";->$at_uuidColegio)
  //JSON CLOSE ($t_refJson)

$i_reemplazoParentesis:=Find in array:C230($at_nombreColegio;"(@")
While ($i_reemplazoParentesis>0)
	$at_nombreColegio{$i_reemplazoParentesis}:=Replace string:C233($at_nombreColegio{$i_reemplazoParentesis};"(";"[")
	$at_nombreColegio{$i_reemplazoParentesis}:=Replace string:C233($at_nombreColegio{$i_reemplazoParentesis};")";"]")
	$i_reemplazoParentesis:=Find in array:C230($at_nombreColegio;"(@";$i_reemplazoParentesis)
End while 
SORT ARRAY:C229($at_nombreColegio;$at_uuidColegio;>)

INSERT IN ARRAY:C227($at_nombreColegio;1;2)
$at_nombreColegio{1}:="Todas"
$at_nombreColegio{2}:="(-"
INSERT IN ARRAY:C227($at_uuidColegio;1;2)
$at_uuidColegio{1}:=""
$at_uuidColegio{2}:=""

$l_elemento:=Find in array:C230($at_uuidColegio;<>GUUID)
If ($l_elemento>0)
	$t_ColegioActual:=$at_nombreColegio{$l_elemento}
End if 
$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_nombreColegio;->$t_ColegioActual)

If ($l_itemSeleccionado>0)
	Case of 
		: ($l_itemSeleccionado=1)
			(OBJECT Get pointer:C1124(Object named:K67:5;"uuidColegio"))->:=""
			OBJECT SET TITLE:C194(*;"institucion";__ ("Todas"))
			IT_PropiedadesBotonPopup ("institucion";__ ("Todas");400)
		: ($l_itemSeleccionado<=Size of array:C274($at_nombreColegio))
			(OBJECT Get pointer:C1124(Object named:K67:5;"uuidColegio"))->:=$at_uuidColegio{$l_itemSeleccionado}
			[xShell_Reports:54]UUID_institucion:33:=$at_uuidColegio{$l_itemSeleccionado}
			IT_PropiedadesBotonPopup ("institucion";$at_nombreColegio{$l_itemSeleccionado};400)
	End case 
End if 
