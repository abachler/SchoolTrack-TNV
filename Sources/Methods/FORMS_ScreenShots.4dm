//%attributes = {}
  // FORMS_ScreenShots()
  // 
  //
  // creado por: Alberto Bachler Klein: 09-09-16, 11:42:05
  // -----------------------------------------------------------

C_LONGINT:C283($i;$i_form;$i_pagina;$l_ms;$l_numeroDeTablas;$l_numeroTabla;$l_paginas)
C_PICTURE:C286($p_imagen)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_nombreForm;$t_nombreTabla;$t_ruta)
C_OBJECT:C1216($ob_formulario;$ob_formularios;$ob_raiz)

ARRAY TEXT:C222($at_Forms;0)
ARRAY OBJECT:C1221($ao_formularios;0)

$l_ms:=Milliseconds:C459
$ob_raiz:=OB_Create 
FORM GET NAMES:C1167($at_Forms)
For ($i_form;1;Size of array:C274($at_Forms))
	$t_nombreForm:=$at_Forms{$i_form}
	FORM LOAD:C1103($t_nombreForm)
	$l_paginas:=FORMS_CountPages ($t_nombreForm)
	For ($i_pagina;1;$l_paginas)
		FORM SCREENSHOT:C940($t_nombreForm;$p_imagen;$i_pagina)
		$ob_formulario:=OB_Create 
		OB_SET_Text ($ob_formulario;"Proyecto";"tipoFormulario")
		OB_SET_Text ($ob_formulario;"none";"tabla")
		OB_SET_Text ($ob_formulario;$t_nombreForm;"nombreForm")
		OB_SET ($ob_formulario;->$i_pagina;"pagina")
		OB_SET ($ob_formulario;->$p_imagen;"imagen")
		APPEND TO ARRAY:C911($ao_formularios;$ob_formulario)
	End for 
End for 

$l_numeroDeTablas:=Get last table number:C254
  //$l_ProgressProcID:=IT_Progress (1;0;0;"Buscando referencias a imagenes en formulario de tablas…")
For ($i;1;$l_numeroDeTablas)
	If (Is table number valid:C999($i))
		$l_numeroTabla:=$i
		$y_tabla:=Table:C252($i)
		$t_nombreTabla:=Table name:C256($i)
		FORM GET NAMES:C1167(Table:C252($i)->;$at_Forms)
		For ($i_form;1;Size of array:C274($at_Forms))
			$t_nombreForm:=$at_Forms{$i_form}
			FORM LOAD:C1103($y_tabla->;$t_nombreForm)
			$l_paginas:=FORMS_CountPages ($t_nombreForm;$y_tabla)
			For ($i_pagina;1;$l_paginas)
				FORM SCREENSHOT:C940($y_tabla->;$t_nombreForm;$p_imagen;$i_pagina)
				$ob_formulario:=OB_Create 
				OB_SET_Text ($ob_formulario;"Proyecto";"tipoFormulario")
				OB_SET_Text ($ob_formulario;$t_nombreTabla;"tabla")
				OB_SET_Text ($ob_formulario;$t_nombreForm;"nombreForm")
				OB_SET ($ob_formulario;->$i_pagina;"pagina")
				OB_SET ($ob_formulario;->$p_imagen;"imagen")
				APPEND TO ARRAY:C911($ao_formularios;$ob_formulario)
			End for 
		End for 
	End if 
End for 

OB_SET ($ob_raiz;->$ao_formularios;"formularios")

$t_ruta:=Get 4D folder:C485(Database folder:K5:14)+"formularios.json"
OB_ObjectToJsonDocument ($ob_raiz;$t_ruta;True:C214)

$l_ms:=Milliseconds:C459-$l_ms

CLEAR VARIABLE:C89($ao_formularios)
CLEAR VARIABLE:C89($ob_raiz)
CLEAR VARIABLE:C89($ob_formulario)

