//%attributes = {}
  // PREF_LeePreferenciasUsuario(propiedad:T ; valor:Y {; IdUsuario:L})
  // retorna en el puntero <valor> el valor de la propiedad <propiedad>
  //
  // creado por: Alberto Bachler Klein: 01-04-16, 08:40:15
  // -----------------------------------------------------------
  // Modificado por: Patricio Aliaga (16-06-2018)
  //  Se agrega cuarto parametro de tipo texto, que permite pasar el valor "Preview", para agregar una carpeta con este nombre 
  // a la ruta de impresion de retorno
C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)

C_LONGINT:C283($l_idUsuario;$l_idUsuarioEnPrefs)
C_POINTER:C301($y_retorno)
C_TEXT:C284($t_carpetaImpresionesPdf;$t_propiedad;$t_rutaCarpetaPrefUsuario;$t_rutaPrefUsuario;$t_destino)
C_OBJECT:C1216($ob_preferencias)


If (False:C215)
	C_OBJECT:C1216(PREF_PreferenciasUsuario_GET ;$0)
	C_TEXT:C284(PREF_PreferenciasUsuario_GET ;$1)
	C_POINTER:C301(PREF_PreferenciasUsuario_GET ;$2)
	C_LONGINT:C283(PREF_PreferenciasUsuario_GET ;$3)
End if 

$l_idUsuario:=USR_GetUserID 

Case of 
	: (Count parameters:C259=2)
		$t_propiedad:=$1
		$y_retorno:=$2
	: (Count parameters:C259=3)
		$t_propiedad:=$1
		$y_retorno:=$2
		$l_idUsuario:=$3
End case 

$t_rutaCarpetaPrefUsuario:=System folder:C487(User preferences_user:K41:4)+"Schooltrack 12"+Folder separator:K24:12
If (Test path name:C476($t_rutaCarpetaPrefUsuario)#Is a folder:K24:2)
	SYS_CreateFolder ($t_rutaCarpetaPrefUsuario)
End if 
$t_rutaPrefUsuario:=$t_rutaCarpetaPrefUsuario+"userprefs {"+String:C10($l_idUsuario)+"}.json"

  // si el documento de preferencias usuario no existe o corresponde a otro usuario logeado lo creo y asigno los valores por defecto
If (Test path name:C476($t_rutaPrefUsuario)#Is a document:K24:1)
	  // asigno los valores por omisión
	$t_carpetaImpresionesPdf:=System folder:C487(Documents folder:K41:18)+"Impresiones SchoolTrack 12"+Folder separator:K24:12
	SYS_CreateFolder ($t_carpetaImpresionesPdf)
	
	$ob_preferencias:=OB_Create 
	OB_SET ($ob_preferencias;->$l_idUsuario;UserPrefs_UserId)
	OB_SET ($ob_preferencias;->$t_carpetaImpresionesPdf;UserPrefs_PDFpath)
	OB_ObjectToJsonDocument ($ob_preferencias;$t_rutaPrefUsuario)
End if 

OB_JsonDocumentToObject ($t_rutaPrefUsuario;->$ob_preferencias)
If (Not:C34(Is nil pointer:C315($y_retorno)))
	OB_GET ($ob_preferencias;$y_retorno;$t_propiedad)
End if 



$0:=$ob_preferencias


