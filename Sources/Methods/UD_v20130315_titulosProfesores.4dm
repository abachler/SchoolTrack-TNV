//%attributes = {}
  // UD_v20130315_titulosProfesores()
  // Por: Alberto Bachler: 15/03/13, 11:41:29
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_totalTitulos)
C_TEXT:C284($t_asunto;$t_body;$t_descripcion;$t_destinatario;$t_mensaje;$t_uuid)

ARRAY LONGINT:C221($al_IdsAddedByConverter;0)

QUERY:C277([Profesores_Titulos:216];[Profesores_Titulos:216]id_added_by_converter:4#0)
If (Records in selection:C76([Profesores_Titulos:216])>0)
	$l_totalTitulos:=Records in selection:C76([Profesores_Titulos:216])
	AT_DistinctsFieldValues (->[Profesores_Titulos:216]id_added_by_converter:4;->$al_IdsAddedByConverter)
	$t_descripcion:="Se perdieron "+String:C10($l_totalTitulos)+" títulos académicos secundarios asignados a "+String:C10(Size of array:C274($al_IdsAddedByConverter))+" profesores."
	$t_descripcion:=$t_descripcion+"\rLos titulos académicos principales no sufrieron ningún daño y continúan asignados en la ficha de los profesores."
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";"Problemas con los títulos académicos secundarios de los profesores";$t_descripcion)
	$t_mensaje:="Lamentablemente no hay otra forma de recuperar los títulos académicos que exportarlos desde algún respaldo anterior e importarlos en esta base de datos."
	$t_mensaje:=$t_mensaje+"\rEsta operación sólo puede ser realizada por el departamento técnico de Colegium."
	$t_mensaje:=$t_mensaje+"\rSi usted prefiere o si el número de títulos perdidos no es significativo puede volver a registrar los títulos en los registros de profesores."
	$t_mensaje:=$t_mensaje+"\r\rLamentamos los inconvenientes causados por este problema y quedamos a su disposición para ayudarle a recuperar esta información si usted lo estima necesario."
	$t_mensaje:=$t_mensaje+"\r\r\r\rDepartamento Técnico de Colegium."
	NTC_Mensaje_Texto ($t_uuid;$t_mensaje)
	
	$t_asunto:="Perdida de titulos académicos de profesores."
	$t_body:="En el colegio "+<>gCustom+" se perdieron "+String:C10($l_totalTitulos)+" títulos académicos en "+String:C10(Size of array:C274($al_IdsAddedByConverter))+" registros de profesores."
	$t_body:=$t_body+"\r\rEl colegio fue informado con el siguiente mensaje en el centro de notificaciones:"
	$t_body:=$t_body+"\rEVENTO: Problemas con los títulos académicos secundarios de los profesores"
	$t_body:=$t_body+"\rDESCRIPCION: "+$t_descripcion
	$t_body:=$t_body+"\rDETALLE: "+$t_mensaje
	$t_destinatario:="qa@colegium.com"
	Mail_EnviaNotificacion ($t_asunto;$t_body;$t_destinatario)
End if 

