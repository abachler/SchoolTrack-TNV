//%attributes = {}
  // ASrs_ValidaPermisos()
  // Por: Alberto Bachler: 02/07/13, 13:15:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_usuarioAutorizado;$b_profFirmanteAutorizado)
C_LONGINT:C283($l_IdSesion)
C_TEXT:C284($t_tipoPermiso)

If (False:C215)
	C_BOOLEAN:C305(ASrs_ValidaPermisos ;$0)
	C_LONGINT:C283(ASrs_ValidaPermisos ;$1)
	C_TEXT:C284(ASrs_ValidaPermisos ;$2)
End if 

$b_inasistenciaRegistrada:=($1<0)
$l_IdSesion:=Abs:C99($1)
$t_tipoPermiso:=$2


  //20171124 ASM  Ticket 192243 
  //cargo la asignatura para verificar si es profesor firmante
KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;False:C215)
QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)

If ([Asignaturas:18]profesor_firmante_numero:33=<>lUSR_RelatedTableUserID)
	  //leo la preferencia de profesor firmante 
	$l_firmanteProf:=Num:C11(PREF_fGet (0;"FirmantesAutorizados"))
	$b_profFirmanteAutorizado:=($l_firmanteProf=1)
Else 
	$b_profFirmanteAutorizado:=False:C215
End if 

Case of 
	: ($t_tipoPermiso="A")
		KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;False:C215)
		$b_usuarioAutorizado:=USR_checkRights ("A";->[Asignaturas_Inasistencias:125])
		$b_usuarioAutorizado:=$b_usuarioAutorizado | ([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=<>lUSR_RelatedTableUserID)
		$b_usuarioAutorizado:=$b_usuarioAutorizado | $b_profFirmanteAutorizado
		
	: ($t_tipoPermiso="M")
		If ($b_inasistenciaRegistrada)
			KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;False:C215)
			$b_usuarioAutorizado:=USR_checkRights ("M";->[Asignaturas_Inasistencias:125])
			$b_usuarioAutorizado:=$b_usuarioAutorizado | (([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=<>lUSR_RelatedTableUserID) & (<>viSTR_NoModificarNotas=0))
			$b_usuarioAutorizado:=$b_usuarioAutorizado | (($b_profFirmanteAutorizado) & (<>viSTR_NoModificarNotas=0))  //MONO 205116
		Else 
			KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;False:C215)
			$b_usuarioAutorizado:=USR_checkRights ("M";->[Asignaturas_Inasistencias:125])
			$b_usuarioAutorizado:=$b_usuarioAutorizado | ([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=<>lUSR_RelatedTableUserID)
			$b_usuarioAutorizado:=$b_usuarioAutorizado | $b_profFirmanteAutorizado
		End if 
	: ($t_tipoPermiso="D")
		KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;False:C215)
		$b_usuarioAutorizado:=USR_checkRights ("D";->[Asignaturas_Inasistencias:125])
		$b_usuarioAutorizado:=$b_usuarioAutorizado | (([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=<>lUSR_RelatedTableUserID) & (<>viSTR_NoModificarNotas=0))
		$b_usuarioAutorizado:=$b_usuarioAutorizado | (($b_profFirmanteAutorizado) & (<>viSTR_NoModificarNotas=0))  //MONO 205116
End case 

$0:=$b_usuarioAutorizado

