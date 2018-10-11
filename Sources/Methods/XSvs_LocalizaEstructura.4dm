//%attributes = {}
  // XSvs_LocalizaEstructura()
  // Por: Alberto Bachler: 05/03/13, 09:05:32
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_BLOB:C604($x_Blob)
C_LONGINT:C283($l_OTRefs;$l_referenciaObjeto;$l_tablas;$ms;$i_tablas;$l_ultimocampo;$i)
C_POINTER:C301($y_tabla)

ARRAY INTEGER:C220($ai_numerosCampos;0)
ARRAY TEXT:C222($at_nombresCampos;0)
ARRAY INTEGER:C220($ai_numerosTablas;0)
ARRAY TEXT:C222($at_nombresTablas;0)

$ms:=Milliseconds:C459
$l_procesoID:=IT_UThermometer (1;0;__ ("Localizando estructura virtual..."))

$x_Blob:=XSvs_LeeLocalizacion (<>vtXS_CountryCode;<>vtXS_langage)
BLOB_ExpandBlob_byPointer (->$x_Blob)

$t_metodoAnterior:=OT SetErrorHandler ("OT_errorHandler")
$l_referenciaObjeto:=OT BLOBToObject ($x_Blob)
OT GetArray ($l_referenciaObjeto;"ArregloNumerosTablas";$ai_numerosTablas)
OT GetArray ($l_referenciaObjeto;"ArregloNombresTablas";$at_nombresTablas)

For ($i_numerosTablas;Size of array:C274($ai_numerosTablas);1;-1)
	If (Is table number valid:C999($ai_numerosTablas{$i_numerosTablas}))
		If (Not:C34(USR_checkRights ("L";Table:C252($ai_numerosTablas{$i_numerosTablas}))))
			AT_Delete ($i_numerosTablas;1;->$ai_numerosTablas;->$at_nombresTablas)
		End if 
	Else 
		AT_Delete ($i_numerosTablas;1;->$ai_numerosTablas;->$at_nombresTablas)
	End if 
End for 
SET TABLE TITLES:C601($at_nombresTablas;$ai_numerosTablas;*)

SORT ARRAY:C229($ai_numerosTablas)
For ($i_tablas;1;Size of array:C274($ai_numerosTablas))
	$t_indice:=String:C10($ai_numerosTablas{$i_tablas})
	ARRAY INTEGER:C220($ai_numerosCampos;0)
	ARRAY TEXT:C222($at_nombresCampos;0)
	  // Modificado por: Alexis Bustamante (12/09/2017)
	  //188214 
	  //OT GetArray ($l_referenciaObjeto;"ArregloNumerosCampos"+$t_indice;$ai_numerosCampos)
	  //OT GetArray ($l_referenciaObjeto;"ArregloNombresCampos"+$t_indice;$at_nombresCampos)
	$l_ultimocampo:=Get last field number:C255($ai_numerosTablas{$i_tablas})
	For ($i;1;$l_ultimocampo)
		If (Is field number valid:C1000($ai_numerosTablas{$i_tablas};$i))
			APPEND TO ARRAY:C911($at_nombresCampos;Field name:C257($ai_numerosTablas{$i_tablas};$i))
			APPEND TO ARRAY:C911($ai_numerosCampos;$i)  //es un numero de cmapo que no existe.
		End if 
	End for 
	SET FIELD TITLES:C602(Table:C252($ai_numerosTablas{$i_tablas})->;$at_nombresCampos;$ai_numeroscampos)
End for 
dhVS_SetSpecialTitles 
$l_procesoID:=IT_UThermometer (-2;$l_procesoID)
OT Clear ($l_referenciaObjeto)  //2015/08/13
$ms:=Milliseconds:C459-$ms
