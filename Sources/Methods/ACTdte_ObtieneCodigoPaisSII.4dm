//%attributes = {}
  //ACTdte_ObtieneCodigoPaisSII
  //metodo que busca el codigo de pais a partir de una nacionalidad
  //Si la nacionalidad ya la conocemos, devolvemos el codigo de pais correspondiente
  //Si no conocemos la nacionalidad, permitimos al usuario crear una relacion entre la nacionalidad y un país. Eso lo almacenamos en otra pref

C_TEXT:C284($t_nacionalidad;$1;$t_codigo;$0)
C_TEXT:C284($t_nombrePrefNac;$t_nombrePrefNacColegio;$t_nombrePrefPaises;$t_jsonNac;$t_jsonNacColegio;$t_jsonPaises)
C_TEXT:C284($t_refNac;$t_refPais;$t_refNacCol)
C_LONGINT:C283($l_pos;$l_resp)
C_OBJECT:C1216($ob;$ob2;$ob3)

ARRAY TEXT:C222($atACT_paisesNac;0)
ARRAY TEXT:C222($atACT_Nacionalidad;0)

ARRAY TEXT:C222($atACT_paises;0)
ARRAY TEXT:C222($atACT_paisesCod;0)

$t_nacionalidad:=$1
$t_nacionalidad:=ST_CleanString ($t_nacionalidad)
If ($t_nacionalidad#"")
	ACTdte_SetTablasNacionalidad ("NombrePrefTablaNacionalidades";->$t_nombrePrefNac)
	ACTdte_SetTablasNacionalidad ("NombrePrefTablaNacionalidadesColegio";->$t_nombrePrefNacColegio)
	ACTdte_SetTablasNacionalidad ("NombrePrefTablaPaises";->$t_nombrePrefPaises)
	
	$t_jsonNac:=PREF_fGet (0;$t_nombrePrefNac)
	$t_jsonNacColegio:=PREF_fGet (0;$t_nombrePrefNacColegio)  //esta tabla es opcional. No siempre podría existir
	$t_jsonPaises:=PREF_fGet (0;$t_nombrePrefPaises)
	
	If (($t_jsonNac="") | ($t_jsonPaises="") | ($t_jsonNac="0") | ($t_jsonPaises="0") | ($t_jsonNac="false") | ($t_jsonPaises="false"))  //si no existen las preferencias por defecto, se cargan tablas
		ACTdte_SetTablasNacionalidad 
		$t_jsonNac:=PREF_fGet (0;$t_nombrePrefNac)
		$t_jsonPaises:=PREF_fGet (0;$t_nombrePrefPaises)
	End if 
	
	$ob:=JSON Parse:C1218($t_jsonNac)
	$ob2:=JSON Parse:C1218($t_jsonPaises)
	
	If ((OB Is defined:C1231($ob)) & (OB Is defined:C1231($ob2)))
		
		OB GET ARRAY:C1229($ob;"tablanac_pais";$atACT_paisesNac)
		OB GET ARRAY:C1229($ob;"tablanac_nacionalidad";$atACT_Nacionalidad)
		
		OB GET ARRAY:C1229($ob2;"tablacodigospaises";$atACT_paises)
		OB GET ARRAY:C1229($ob2;"tablacodigos";$atACT_paisesCod)
		
		$l_pos:=Find in array:C230($atACT_Nacionalidad;$t_nacionalidad)
		If ($l_pos>0)
			$t_pais:=$atACT_paisesNac{$l_pos}
			$l_pos:=Find in array:C230($atACT_paises;$t_pais)
			If ($l_pos>0)
				$t_codigo:=$atACT_paisesCod{$l_pos}
			Else 
				CD_Dlog (0;__ ("País ")+ST_Qte ($t_pais)+__ (" no encontrado en tabla países."))
			End if 
		Else 
			
			  //Se verifica en tabla de institución. Si el valor ya existía, se retorna. De lo contrario se muestra un mensaje para agregar el pais a la nacionalidad
			C_BOOLEAN:C305($b_mostrarCuadroSeleccion)
			ARRAY TEXT:C222($atACT_paisesNacCol;0)
			ARRAY TEXT:C222($atACT_NacionalidadCol;0)
			
			If ($t_jsonNacColegio#"")
				$ob3:=JSON Parse:C1218($t_jsonNacColegio)
				
				OB GET ARRAY:C1229($ob3;"tablanac_pais";$atACT_paisesNacCol)
				OB GET ARRAY:C1229($ob3;"tablanac_nacionalidad";$atACT_NacionalidadCol)
				
				$l_pos:=Find in array:C230($atACT_NacionalidadCol;$t_nacionalidad)
				If ($l_pos>0)
					$t_pais:=$atACT_paisesNacCol{$l_pos}
					$l_pos:=Find in array:C230($atACT_paises;$t_pais)
					If ($l_pos>0)
						$t_codigo:=$atACT_paisesCod{$l_pos}
					Else 
						CD_Dlog (0;__ ("País ")+ST_Qte ($t_pais)+__ (" no encontrado en tabla países."))
					End if 
				Else 
					$b_mostrarCuadroSeleccion:=True:C214
				End if 
			Else 
				$b_mostrarCuadroSeleccion:=True:C214
			End if 
			
			If ($b_mostrarCuadroSeleccion)
				ARRAY TEXT:C222(atACT_Paises;0)
				$l_resp:=CD_Dlog (0;__ ("No existe país asociado a la nacionalidad ")+ST_Qte ($t_nacionalidad)+__ (". Para poder continuar deberá seleccionar el país asociado.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
				If ($l_resp=1)
					COPY ARRAY:C226($atACT_paises;atACT_Paises)  //la lista de paises debe ser la lista que tenemos en el json por defecto ya que solo esos código conocemos.
					ARRAY POINTER:C280(<>aChoicePtrs;0)
					APPEND TO ARRAY:C911(<>aChoicePtrs;->atACT_Paises)
					TBL_ShowChoiceList (0;"Seleccione un País...")
					If (choiceIdx>0)
						APPEND TO ARRAY:C911($atACT_paisesNacCol;atACT_Paises{choiceIdx})
						APPEND TO ARRAY:C911($atACT_NacionalidadCol;$t_nacionalidad)
						ACTdte_SetTablasNacionalidad ("GuardaTablaNacionalidadColegio";->$atACT_paisesNacCol;->$atACT_NacionalidadCol)
						  //se obtiene codigo para ser devuelto
						$t_codigo:=ACTdte_ObtieneCodigoPaisSII ($t_nacionalidad)
					End if 
				End if 
				AT_Initialize (->atACT_Paises)
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("Las tablas de países y nacionalidades no pudieron ser cargadas."))
	End if 
Else 
	CD_Dlog (0;__ ("El receptor del documento no tiene RUT ni Nacionalidad ingresada. Si el receptor es de nacionalidad Chilena ingresar RUT, de lo contrario, ingresar el número de documento como pasaporte y seleccionar una nacionalidad en la ficha."))
End if 
$0:=$t_codigo