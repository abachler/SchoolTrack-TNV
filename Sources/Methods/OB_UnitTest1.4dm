//%attributes = {}
  // OB_UnitTest()
  // permite verificar la correcta operación de los métodos para ecribir y leer las propiedades y valores en un objeto / json
  // crea un objeto, asigna valores y propiedades
  // convertirlo a un json válido
  // cob
If (False:C215)
	  // creado por: Alberto Bachler Klein: 23-11-15, 18:52:54
	  //  ---------------------------------------------
End if 


C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_boolean)
C_DATE:C307($d_fechaNacimiento)
C_LONGINT:C283($i;$i_integer;$l_anoRetorno;$l_añoNacimento;$l_añoParis;$l_edad)
C_TIME:C306($h_HoraActual)
C_PICTURE:C286($p_imagen)
C_POINTER:C301($y_apellido)
C_REAL:C285($r_real)
C_TEXT:C284($t_apellido;$t_json;$t_nombre)
C_OBJECT:C1216($ob_objeto;$ob_objetoEnObjeto)

ARRAY BLOB:C1222($ax_blob;0)
ARRAY BOOLEAN:C223($ab_Boolean;0)
ARRAY DATE:C224($ad_fecha;0)
ARRAY INTEGER:C220($ai_integer;0)
ARRAY LONGINT:C221($al_Edad;0)
ARRAY TIME:C1223($ah_hora;0)
ARRAY PICTURE:C279($ap_imagen;0)
ARRAY REAL:C219($ar_real;0)
ARRAY TEXT:C222($at_apellidos;0)
ARRAY TEXT:C222($at_nombres;0)
ARRAY OBJECT:C1221($ao_Objeto;0)
ARRAY OBJECT:C1221($o_Objeto;0)

$t_nombre:="Alberto"  // text
$t_apellido:="Bächler"
$y_apellido:=->$t_apellido  // pointer
$d_fechaNacimiento:=!1954-10-12!  // date
$h_HoraActual:=Current time:C178  // time
$l_edad:=61  //numeric
$r_real:=456.0123456789  // real
$i_integer:=31000  //integer
$b_boolean:=True:C214  // boolean
SET BLOB SIZE:C606($x_blob;100)  // blob
READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"no_picture.gif";$p_imagen)

$r_real:=456.0123456789
$i_integer:=31000
$b_boolean:=True:C214


  // creacion del objeto principal
$ob_objeto:=OB_Create 
OB_SET ($ob_objeto;->$t_nombre;"nombre")
OB_SET ($ob_objeto;->$t_apellido;"apellido")
OB_SET ($ob_objeto;->$d_fechaNacimiento;"fechaNacimiento")
OB_SET ($ob_objeto;->$h_HoraActual;"horaActual")
OB_SET ($ob_objeto;->$l_edad;"edad")
OB_SET ($ob_objeto;->$x_blob;"blob")
OB_SET ($ob_objeto;->$p_imagen;"imagen")
OB_SET ($ob_objeto;->$r_real;"real")
OB_SET ($ob_objeto;->$i_integer;"integer")
OB_SET ($ob_objeto;->$b_boolean;"boolean")

  // creación de un objeto secundario
$ob_objetoEnObjeto:=OB_Create 
$l_año1:=1954
$l_año2:=1974
$l_año3:=1990
OB_SET ($ob_objetoEnObjeto;->$l_año1;"nacimiento")
OB_SET ($ob_objetoEnObjeto;->$l_año2;"aParis")
OB_SET ($ob_objetoEnObjeto;->$l_año3;"retornoChile")
OB_SET ($ob_objeto;->$ob_objetoEnObjeto;"historia")

  // creación y asibgnación de un objeto secundario utilización la notación con puntos
OB_SET ($ob_objeto;->$l_año1;"historia2.nacimiento")
OB_SET ($ob_objeto;->$l_año2;"historia2.aParis")
OB_SET ($ob_objeto;->$l_año3;"historia2.retornoChile")

  // creo y pueblo los arreglos que serán agregados al json
For ($i;1;3)
	APPEND TO ARRAY:C911($at_nombres;$t_nombre)
	APPEND TO ARRAY:C911($at_apellidos;$t_apellido)
	APPEND TO ARRAY:C911($ad_fecha;$d_fechaNacimiento)
	APPEND TO ARRAY:C911($ah_hora;$h_HoraActual)
	APPEND TO ARRAY:C911($ax_blob;$x_blob)
	APPEND TO ARRAY:C911($ap_imagen;$p_imagen)
	APPEND TO ARRAY:C911($al_Edad;$l_edad)
	APPEND TO ARRAY:C911($ai_integer;$i_integer)
	APPEND TO ARRAY:C911($ar_real;$r_real)
	APPEND TO ARRAY:C911($ab_Boolean;$b_boolean)
	APPEND TO ARRAY:C911($ao_Objeto;$ob_objetoEnObjeto)
End for 

  // agrego los arreglos al objeto
OB_SET ($ob_objeto;->$at_nombres;"array-nombre")
OB_SET ($ob_objeto;->$at_apellidos;"array-apellido")
OB_SET ($ob_objeto;->$ad_fecha;"array-fechaNacimiento")
OB_SET ($ob_objeto;->$ah_hora;"array-horaActual")
OB_SET ($ob_objeto;->$al_Edad;"array-edad")
OB_SET ($ob_objeto;->$ax_blob;"array-blob")
OB_SET ($ob_objeto;->$ap_imagen;"array-imagen")
OB_SET ($ob_objeto;->$ai_integer;"array-integer")
OB_SET ($ob_objeto;->$ar_real;"array-real")
OB_SET ($ob_objeto;->$ab_Boolean;"array-boolean")
OB_SET ($ob_objeto;->$ao_Objeto;"array-object")

  // convierto el objeto al json (que es enviado al portapapeles para depuración)
$t_json:=OB_Object2Json ($ob_objeto)
SET TEXT TO PASTEBOARD:C523($t_json)
CLEAR VARIABLE:C89($ob_objeto)  // no es realmente necesario ya 4D lo hace automaticamente (usado para pruebas)

$ob_objeto:=OB_JsonToObject ($t_json)
OB_GET ($ob_objeto;->$t_nombre;"nombre")
OB_GET ($ob_objeto;->$t_apellido;"apellido")
OB_GET ($ob_objeto;->$d_fechaNacimiento;"fechaNacimiento")
OB_GET ($ob_objeto;->$h_HoraActual;"horaActual")
OB_GET ($ob_objeto;->$l_edad;"edad")
OB_GET ($ob_objeto;->$x_blob;"blob")
OB_GET ($ob_objeto;->$p_imagen;"imagen")
OB_GET ($ob_objeto;->$r_real;"real")
OB_GET ($ob_objeto;->$i_integer;"integer")
OB_GET ($ob_objeto;->$b_boolean;"boolean")

OB_GET ($ob_objeto;->$ob_objetoEnObjeto;"historia")
OB_GET ($ob_objetoEnObjeto;->$l_añoNacimento;"nacimiento")
OB_GET ($ob_objetoEnObjeto;->$l_añoParis;"aParis")
OB_GET ($ob_objetoEnObjeto;->$l_anoRetorno;"retornoChile")

OB_GET ($ob_objeto;->$l_añoNacimento;"historia2.nacimiento")
OB_GET ($ob_objeto;->$l_añoParis;"historia2.aParis")
OB_GET ($ob_objeto;->$l_anoRetorno;"historia2.retornoChile")

OB_GET ($ob_objeto;->$at_nombres;"array-nombre")
OB_GET ($ob_objeto;->$at_apellidos;"array-apellido")
OB_GET ($ob_objeto;->$ad_fecha;"array-fechaNacimiento")
OB_GET ($ob_objeto;->$ah_hora;"array-horaActual")
OB_GET ($ob_objeto;->$al_Edad;"array-edad")
OB_GET ($ob_objeto;->$ax_blob;"array-blob")
OB_GET ($ob_objeto;->$ap_imagen;"array-imagen")
OB_GET ($ob_objeto;->$ai_integer;"array-integer")
OB_GET ($ob_objeto;->$ar_real;"array-real")
OB_GET ($ob_objeto;->$ab_Boolean;"array-boolean")
OB_GET ($ob_objeto;->$ao_Objeto;"array-object")









