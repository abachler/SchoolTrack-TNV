//%attributes = {}
  // PREF_PreferenciasUsuario_SET(propiedad:T ; valor:Y {; IdUsuario:L})
  // asigna el *valor* de la *propiedad*  en el archivo de preferencias del usuario
  //
  // creado por: Alberto Bachler Klein: 01-04-16, 11:37:32
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)

C_LONGINT:C283($l_idUsuario)
C_POINTER:C301($y_Valor)
C_TEXT:C284($t_carpetaImpresionesPdf;$t_propiedad;$t_rutaCarpetaPrefUsuario;$t_rutaPrefUsuario)
C_OBJECT:C1216($ob_preferencias)


If (False:C215)
	C_TEXT:C284(PREF_PreferenciasUsuario_SET ;$1)
	C_POINTER:C301(PREF_PreferenciasUsuario_SET ;$2)
	C_LONGINT:C283(PREF_PreferenciasUsuario_SET ;$3)
End if 

$t_propiedad:=$1
$y_Valor:=$2
$l_idUsuario:=USR_GetUserID 

If (Count parameters:C259=3)
	$l_idUsuario:=$3
End if 

$t_rutaCarpetaPrefUsuario:=System folder:C487(User preferences_user:K41:4)+"Schooltrack 12"+Folder separator:K24:12
If (Test path name:C476($t_rutaCarpetaPrefUsuario)#Is a folder:K24:2)
	SYS_CreateFolder ($t_rutaCarpetaPrefUsuario)
End if 
$t_rutaPrefUsuario:=$t_rutaCarpetaPrefUsuario+"userprefs {"+String:C10($l_idUsuario)+"}.json"


  // si el documento de preferencias usuario no existe o corresponde a otro usuario logeado lo creo y asigno los valores por defecto
If (Test path name:C476($t_rutaPrefUsuario)#Is a document:K24:1)
	  // asigno los valores por omisión
	$t_carpetaImpresionesPdf:=System folder:C487(Documents folder:K41:18)+"Impresiones SchoolTrack 12"
	SYS_CreateFolder ($t_carpetaImpresionesPdf)
	
	$ob_preferencias:=OB_Create 
	OB_SET ($ob_preferencias;->$l_idUsuario;UserPrefs_UserId)
	OB_SET ($ob_preferencias;->$t_carpetaImpresionesPdf;UserPrefs_PDFpath)
Else 
	OB_JsonDocumentToObject ($t_rutaPrefUsuario;->$ob_preferencias)
End if 

OB_SET ($ob_preferencias;$y_valor;$t_propiedad)
OB_ObjectToJsonDocument ($ob_preferencias;$t_rutaPrefUsuario)




