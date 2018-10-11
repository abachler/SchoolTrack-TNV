//%attributes = {}
  //SN3_RetreiveUserList
C_TEXT:C284($text2Search)
ARRAY TEXT:C222(SN3_ConsultaUsuarios;0)

$text2Search:=$1

SN3_InitConsultaUsuarios 

WEB SERVICE SET PARAMETER:C777("textoconsulta";$text2Search)
WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
$vl_pID:=IT_UThermometer (1;0;__ ("Interrogando SchoolNet...");-1)
$err:=SN3_CallWebService ("sn3ws_consulta_proceso.consulta")
IT_UThermometer (-2;$vl_pID)

If ($err="")
	WEB SERVICE GET RESULT:C779(SN3_ConsultaUsuarios;"return";*)
	$process:=True:C214
	Case of 
		: (Size of array:C274(SN3_ConsultaUsuarios)=0)
			If ($text2Search="")
				$process:=False:C215
				CD_Dlog (0;__ ("No hay usuarios registrados en la base de datos de SchoolNet."))
			Else 
				$process:=False:C215
				CD_Dlog (0;__ ("No hay usuarios que correspondan a la expresión ingresada."))
			End if 
		: (Size of array:C274(SN3_ConsultaUsuarios)=1)
			If (SN3_ConsultaUsuarios{1}="ERROR")
				$process:=False:C215
				CD_Dlog (0;__ ("Se ha producido un error al realizar la búsqueda de usuarios. Por favor intente de nuevo más tarde."))
			End if 
	End case 
	If ($process)
		$thermo:=False:C215
		If (Size of array:C274(SN3_ConsultaUsuarios)>25)
			$thermo:=True:C214
			$p:=IT_UThermometer (1;0;__ ("Procesando respuesta...");-1)
		End if 
		AT_RedimArrays (Size of array:C274(SN3_ConsultaUsuarios);->SN3_AyNUsuarios;->SN3_TipoUsuario;->SN3_TipoCodeUsuario;->SN3_LoginUsuarios;->SN3_PasswordUsuarios;->SN3_CodeUsuarios;->SN3_InactivoUsuarios;->SN3_ColorsUsuarios;->SN3_ModificadoWebUsuarios;->SN3_StylesUsuarios;->SN3_BacksUsuarios;->SN3_CursosUsuarios;->SN3_eMailsUsuarios;->SN3_ultimo_ingreso)
		For ($i;1;Size of array:C274(SN3_ConsultaUsuarios))
			$elem:=SN3_ConsultaUsuarios{$i}
			$tipo:=ST_GetWord ($elem;1;Char:C90(10))
			$nombres:=ST_GetWord ($elem;2;Char:C90(10))
			$login:=ST_GetWord ($elem;3;Char:C90(10))
			$pass:=ST_GetWord ($elem;4;Char:C90(10))
			$code:=ST_GetWord ($elem;5;Char:C90(10))
			$inactivo:=ST_GetWord ($elem;6;Char:C90(10))
			$modificadoWeb:=ST_GetWord ($elem;7;Char:C90(10))
			$curso:=ST_GetWord ($elem;8;Char:C90(10))
			$email:=ST_GetWord ($elem;9;Char:C90(10))
			SN3_ultimo_ingreso{$i}:=ST_GetWord ($elem;10;Char:C90(10))  //mono 02/07/13 ultimo acceso
			SN3_TipoCodeUsuario{$i}:=$tipo
			SN3_AyNUsuarios{$i}:=$nombres
			SN3_LoginUsuarios{$i}:=$login
			SN3_PasswordUsuarios{$i}:=$pass
			SN3_CodeUsuarios{$i}:=$code
			SN3_InactivoUsuarios{$i}:=Num:C11($inactivo)
			SN3_ModificadoWebUsuarios{$i}:=Num:C11($modificadoWeb)
			SN3_CursosUsuarios{$i}:=$curso
			SN3_eMailsUsuarios{$i}:=$email
			If (SN3_InactivoUsuarios{$i}=1)
				SN3_ColorsUsuarios{$i}:=0x007F7F7F
			Else 
				  //SN3_ColorsUsuarios{$i}:=0x0000
				SN3_ColorsUsuarios{$i}:=-255
			End if 
			If (SN3_ModificadoWebUsuarios{$i}=1)
				SN3_StylesUsuarios{$i}:=Italic:K14:3
			End if 
			Case of 
				: (SN3_TipoCodeUsuario{$i}="2")
					SN3_TipoUsuario{$i}:="Alumno"
				: (SN3_TipoCodeUsuario{$i}="1")
					SN3_TipoUsuario{$i}:="Familiar"
			End case 
			SN3_BacksUsuarios{$i}:=0x00FFFFFF
		End for 
		SORT ARRAY:C229(SN3_AyNUsuarios;SN3_TipoUsuario;SN3_TipoCodeUsuario;SN3_LoginUsuarios;SN3_PasswordUsuarios;SN3_CodeUsuarios;SN3_InactivoUsuarios;SN3_ColorsUsuarios;SN3_ModificadoWebUsuarios;SN3_StylesUsuarios;SN3_BacksUsuarios;SN3_CursosUsuarios;SN3_eMailsUsuarios;SN3_ultimo_ingreso;>)
		COPY ARRAY:C226(SN3_TipoUsuario;SN3_TipoUsuarioCpy)
		COPY ARRAY:C226(SN3_TipoCodeUsuario;SN3_TipoCodeUsuarioCpy)
		COPY ARRAY:C226(SN3_AyNUsuarios;SN3_AyNUsuariosCpy)
		COPY ARRAY:C226(SN3_LoginUsuarios;SN3_LoginUsuariosCpy)
		COPY ARRAY:C226(SN3_PasswordUsuarios;SN3_PasswordUsuariosCpy)
		COPY ARRAY:C226(SN3_CodeUsuarios;SN3_CodeUsuariosCpy)
		COPY ARRAY:C226(SN3_InactivoUsuarios;SN3_InactivoUsuariosCpy)
		COPY ARRAY:C226(SN3_ColorsUsuarios;SN3_ColorsUsuariosCpy)
		COPY ARRAY:C226(SN3_ModificadoWebUsuarios;SN3_ModificadoWebUsuariosCpy)
		COPY ARRAY:C226(SN3_StylesUsuarios;SN3_StylesUsuariosCpy)
		COPY ARRAY:C226(SN3_BacksUsuarios;SN3_BacksUsuariosCpy)
		COPY ARRAY:C226(SN3_CursosUsuarios;SN3_CursosUsuariosCpy)
		COPY ARRAY:C226(SN3_eMailsUsuarios;SN3_eMailsUsuariosCpy)
		COPY ARRAY:C226(SN3_ultimo_ingreso;SN3_ultimo_ingresoCpy)  //mono 02/07/13 ultimo acceso
		
		If ($thermo)
			IT_UThermometer (-2;$p)
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
End if 
If (Size of array:C274(SN3_AyNUsuarios)>0)
	SN3_ListMessage:="Mostrando "+String:C10(Size of array:C274(SN3_AyNUsuarios))+" de "+String:C10(Size of array:C274(SN3_AyNUsuarios))+" recibidos."
	_O_ENABLE BUTTON:C192(*;"opcionesLista@")
Else 
	SN3_InitConsultaUsuarios 
End if 
LISTBOX SELECT ROW:C912(lb_usuarios;0;lk remove from selection:K53:3)