//%attributes = {}
  // AS_GestionPestañas()
  // Por: Alberto Bachler: 28/02/13, 11:31:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_activa;$b_usuarioAutorizado)
C_LONGINT:C283($i;$l_alumnos;$l_competencias;$l_IdPestaña;$l_modoRegistroAsistencia;$l_pagina_a_activar;$l_sesiones)
C_TEXT:C284($t_nombrePestaña)


$l_pagina_a_activar:=$1
$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)

$b_usuarioAutorizado:=((<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | ((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (USR_checkRights ("M";->[Asignaturas:18])))
SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;1;(USR_checkRights ("M";->[Asignaturas:18]));1;0)  // propiedades
SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;2;(USR_checkRights ("M";->[Asignaturas:18]));1;0)  // objetivos - mono 143166
SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;3;(USR_checkRights ("L";->[Alumnos_Calificaciones:208]) | ($b_usuarioAutorizado));1;0)  //evaluacion
SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;4;(USR_checkRights ("L";->[Alumnos_Calificaciones:208]) | ($b_usuarioAutorizado));1;0)  // observaciones
SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;6;(USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169]) | ($b_usuarioAutorizado));1;0)  // planes de clases
SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;7;(USR_checkRights ("L";->[Asignaturas_RegistroSesiones:168]) | ($b_usuarioAutorizado));1;0)  // sesiones
SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;8;(USR_checkRights ("M";->[Asignaturas:18]) | ($b_usuarioAutorizado));1;0)  // calendario
SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;9;((USR_checkRights ("L";->[Alumnos_Calificaciones:208]) | ($b_usuarioAutorizado)) & (($l_modoRegistroAsistencia=2) | ($l_modoRegistroAsistencia=4)));1;0)  // asistencia
SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;10;(USR_checkRights ("L";->[Alumnos_Calificaciones:208]) | ($b_usuarioAutorizado));1;0)  // aprendizajes

If ([Asignaturas:18]EVAPR_IdMatriz:91=0)
	$l_competencias:=0
Else 
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_competencias)
	SET QUERY LIMIT:C395(1)
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[Asignaturas:18]EVAPR_IdMatriz:91;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=3)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	SET QUERY LIMIT:C395(0)
End if 

$l_alumnos:=[Asignaturas:18]Numero_de_alumnos:49
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_sesiones)
SET QUERY LIMIT:C395(1)
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)

Case of 
	: ($l_alumnos=0)
		SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;10;False:C215;0;0)  // aprendizajes
		SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;3;False:C215;0;0)  // evaluaciones
		SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;4;False:C215;0;0)  // observaciones
		SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;9;False:C215;0;0)  // asistencia a clases
	: ($l_competencias=0)
		SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;10;False:C215;0;0)  // aprendizajes
End case 

If ($l_sesiones=0)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_asignaturas;7;False:C215;0;0)  // sesiones
End if 

GET LIST ITEM PROPERTIES:C631(hlTab_STR_asignaturas;$l_pagina_a_activar;$b_activa)

If (Not:C34($b_activa))
	$l_pagina_a_activar:=0
	For ($i;1;Count list items:C380(hlTab_STR_asignaturas))
		GET LIST ITEM:C378(hlTab_STR_asignaturas;$i;$l_IdPestaña;$t_nombrePestaña)
		GET LIST ITEM PROPERTIES:C631(hlTab_STR_asignaturas;$l_IdPestaña;$b_activa)
		If ($b_activa)
			$l_pagina_a_activar:=$l_IdPestaña
			$i:=Count list items:C380(hlTab_STR_asignaturas)
		End if 
	End for 
End if 

$0:=$l_pagina_a_activar

