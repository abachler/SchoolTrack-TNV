//%attributes = {}
  // SR_VerificaCodigo
  //20110318 RCH Se crea metodo para unificar codigo...

C_TEXT:C284($1;$0;$vt_codigo)

$vt_codigo:=$1

$vt_codigo:=Replace string:C233($vt_codigo;"<>cr";"\r\n")  //20170415 RCH Se estaba reemplazando el texto por un salto de línea. 20170418 RCH Se corrige r por n
$vt_codigo:=Replace string:C233($vt_codigo;"\r\nlf";"\r\n")  //20171206 RCH

$vt_codigo:=Replace string:C233($vt_codigo;Char:C90(10);"\r\n")

  //If (Application version>="0800")
$vt_codigo:=Replace string:C233($vt_codigo;"Automatic Relations";"Set Automatic Relations")
$vt_codigo:=Replace string:C233($vt_codigo;"SET SET";"SET")
  //End if 

  //If (Application version>="1210")
$vt_codigo:=Replace string:C233($vt_codigo;"DELETE ELEMENT";"DELETE FROM ARRAY")
$vt_codigo:=Replace string:C233($vt_codigo;"INSERT ELEMENT";"INSERT IN ARRAY")

  //20110308 RCH Necesario para que se generen correctamente archivos de texto en ACT hechos en informes...
$t_crlf:="\r\n"
$vt_codigo:=Replace string:C233($vt_codigo;"<>cr";$t_crlf)  //para que en v11 sea reconocido el salto de linea se ejecuta esta linea
$vt_codigo:=Replace string:C233($vt_codigo;"<>crlflf";$t_crlf)  //20110620 RCH Por si pasa 2 veces por aca...


$vt_codigo:=Replace string:C233($vt_codigo;"<>crlf";$t_crlf)  //20171129  JVP falta cambiar esa variable


  //20170426 JVP Es necesario realizar la conversion en v12 debido a que tb ya no funciona en v12
$vt_codigo:=Replace string:C233($vt_codigo;"<>tb";ST_Qte ("\\t"))

  ///20170706 JVP se agrega validacion del siguiente signo debido a que existen informes que lo tienen como comentario
  //y eso ocaciona que se corte el codigo  de PROCESS 4D TAGS
$vt_codigo:=Replace string:C233($vt_codigo;"-->";"")

  //20170707 JVP se cambia validacion de ok:=0, debido a que Procces 4d tags cambia el estado de esta variable
  //por lo cual genera un formulario que no correspode
$vt_codigo:=Replace string:C233($vt_codigo;"ok:=0";"vt_ErrorEjecucionScript:="+ST_Qte ("No ejecutar"))

  //20110314 PSV Necesario para que v11 encuentre la ruta del archivo de texto a generar segun tipo de aplicacion.
$vt_codigo:=Replace string:C233($vt_codigo;"4D Client";"4D Remote Mode")
$vt_codigo:=Replace string:C233($vt_codigo;"4D Runtime Volume License";"4D Volume Desktop")

  //20110318 RCH
$vt_codigo:=Replace string:C233($vt_codigo;"Find index key";"Find in field")

  //20110328 RCH
$vt_codigo:=Replace string:C233($vt_codigo;"SET TEXT TO CLIPBOARD";"SET TEXT TO PASTEBOARD")

  //20130314 RCH
$vt_codigo:=Replace string:C233($vt_codigo;"Ascii";"Character code")

  //20150205 RCH
$vt_codigo:=Replace string:C233($vt_codigo;"SET WEB SERVICE PARAMETER";"WEB SERVICE SET PARAMETER")
  //20150309 SPO
  //$vt_codigo:=Replace string($vt_codigo;"GET WEB SERVICE RESULT";"WEB SERVICE GET PARAMETER")
$vt_codigo:=Replace string:C233($vt_codigo;"GET WEB SERVICE RESULT";"WEB SERVICE GET RESULT")

  //20160805 DL-RC
$vt_codigo:=Replace string:C233($vt_codigo;"_o_C_INTEGER";"C_LONGINT")

  //20180413 RCH
$vt_codigo:=Replace string:C233($vt_codigo;"DL_IsModuleLicensed";"LICENCIA_esModuloAutorizado")

  //End if 
  //agrego validacion v15 JVP 20161007
  //If (Application version>="1500")
  //$vt_codigo:=Replace string($vt_codigo;"_o_C_INTEGER";"C_LONGINT")
  //$vt_codigo:=Replace string($vt_codigo;"C_INTEGER";"C_LONGINT")
  //End if 

  //20161214 ASM
EXE_ReplaceString ("arreglos";"ARRAY STRING";"ARRAY TEXT";->$vt_codigo)

  //20170707 RCH Para solucionar problemas con variable Logo. Se declara en el mismo script
  //20170725 RCH Se agrega otro método usado en algunos reportes
C_LONGINT:C283($l_pos;$l_indice;$l_posArreglo;$i)
C_TEXT:C284($t_nombreVar;$t_declaracion)
ARRAY TEXT:C222($at_metodos;0)
APPEND TO ARRAY:C911($at_metodos;"_LogoInstitucion")
APPEND TO ARRAY:C911($at_metodos;"SR_GetOrganisationLogo")
For ($l_indice;1;Size of array:C274($at_metodos))
	$l_pos:=Position:C15($at_metodos{$l_indice};$vt_codigo)
	If ($l_pos>0)
		ARRAY TEXT:C222($at_codigo;0)
		AT_Text2Array (->$at_codigo;$vt_codigo;"\r")
		For ($i;1;Size of array:C274($at_codigo))
			$l_pos:=Position:C15($at_metodos{$l_indice};$at_codigo{$i})
			If ($l_pos>0)
				$t_nombreVar:=Substring:C12($at_codigo{$i};1;Position:C15(":=";$at_codigo{$i})-1)
				$l_posArreglo:=$i
				$i:=Size of array:C274($at_codigo)
			End if 
		End for 
		If ($l_posArreglo>0)
			AT_Insert ($l_posArreglo;1;->$at_codigo)
			$at_codigo{$l_posArreglo}:="C_PICTURE("+$t_nombreVar+")"
			$vt_codigo:=AT_array2text (->$at_codigo;"\r")
		End if 
	End if 
End for 

$0:=$vt_codigo