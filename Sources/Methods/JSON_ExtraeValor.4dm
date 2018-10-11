//%attributes = {}
  // JSON_ExtraeValor(refNodo:&T, nombreElemento:&T, objeto:&Y)
  // Por: Alberto Bachler K.: 02-08-14, 12:07:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_POINTER:C301($3)
C_LONGINT:C283($4)

C_BLOB:C604($x_blob)
C_LONGINT:C283($l_convertir;$l_tipoNodo;$l_tipoReceptor)
C_TIME:C306($h_hora)
C_PICTURE:C286($p_imagen)
C_POINTER:C301($y_receptor)
C_TEXT:C284($t_codificacion;$t_fecha;$t_nodo;$t_nombre;$t_refNodo)

ARRAY LONGINT:C221($al_tipos;0)
ARRAY TEXT:C222($at_nodos;0)
ARRAY TEXT:C222($at_nombres;0)
ARRAY TEXT:C222($at_valores;0)


If (False:C215)
	C_TEXT:C284(JSON_ExtraeValor ;$1)
	C_TEXT:C284(JSON_ExtraeValor ;$2)
	C_POINTER:C301(JSON_ExtraeValor ;$3)
	C_LONGINT:C283(JSON_ExtraeValor ;$4)
End if 

$t_refNodo:=$1
$t_nombre:=$2
$y_receptor:=$3

$l_tipoReceptor:=Type:C295($y_receptor->)

$t_nodo:=JSON Get child by name ($t_refNodo;$t_nombre;JSON_CASE_INSENSITIVE)
$l_tipoNodo:=JSON Get type ($t_nodo)
Case of 
	: (($l_tipoNodo=JSON_STRING) & ($l_tipoReceptor=Is picture:K8:10))
		$t_codificacion:=JSON Get text ($t_nodo)
		BASE64 DECODE:C896($t_codificacion;$x_blob)
		BLOB TO PICTURE:C682($x_blob;$p_imagen)
		$y_receptor->:=$p_imagen
		
	: (($l_tipoNodo=JSON_STRING) & ($l_tipoReceptor=Is BLOB:K8:12))
		$t_codificacion:=JSON Get text ($t_nodo)
		BASE64 DECODE:C896($t_codificacion;$x_blob)
		$y_receptor->:=$x_blob
		
	: (($l_tipoNodo=JSON_STRING) & ($l_tipoReceptor=Is date:K8:7))
		$t_fecha:=JSON Get text ($t_nodo)
		$y_receptor->:=DTS_GetDate ($t_fecha)
		
	: (($l_tipoNodo=JSON_NUMBER) & ($l_tipoReceptor=Is time:K8:8))
		$y_receptor->:=JSON Get long ($t_nodo)
		$h_hora:=$y_receptor->
		
	: (($l_tipoNodo=JSON_STRING) & ($l_tipoReceptor=Is text:K8:3))
		$y_receptor->:=JSON Get text ($t_nodo)
		
	: (($l_tipoNodo=JSON_STRING) & ($l_tipoReceptor=Is alpha field:K8:1))
		$y_receptor->:=JSON Get text ($t_nodo)
		
	: (($l_tipoNodo=JSON_NUMBER) & (($l_tipoReceptor=Is longint:K8:6) | ($l_tipoReceptor=Is integer:K8:5) | ($l_tipoReceptor=Is integer 64 bits:K8:25)))
		$y_receptor->:=JSON Get long ($t_nodo)
		
	: (($l_tipoNodo=JSON_NUMBER) & ($l_tipoReceptor=Is real:K8:4))
		$y_receptor->:=JSON Get long ($t_nodo)
		
	: ($l_tipoNodo=JSON_BOOL)
		$y_receptor->:=(JSON Get bool ($t_nodo)=1)
		
	: ($l_tipoNodo=JSON_ARRAY)
		Case of 
			: ($l_tipoReceptor=Text array:K8:16)
				JSON GET TEXT ARRAY ($t_nodo;$y_receptor->)
				
			: ($l_tipoReceptor=String array:K8:15)
				JSON GET TEXT ARRAY ($t_nodo;$y_receptor->)
				
			: ($l_tipoReceptor=Boolean array:K8:21)
				JSON GET BOOL ARRAY ($t_nodo;$y_receptor->)
				
			: ($l_tipoReceptor=LongInt array:K8:19)
				JSON GET LONG ARRAY ($t_nodo;$y_receptor->)
				
			: ($l_tipoReceptor=Integer array:K8:18)
				JSON GET LONG ARRAY ($t_nodo;$y_receptor->)
				
			: ($l_tipoReceptor=Real array:K8:17)
				JSON GET REAL ARRAY ($t_nodo;$y_receptor->)
				
			: ($l_tipoReceptor=Date array:K8:20)
				JSON GET TEXT ARRAY ($t_nodo;$at_valores)
				AT_CopyArrayElements (->$at_valores;$y_receptor)
				
		End case 
		
		  //20160414 RCH Se agrega caso. Si dentro de un json viene un nodo de otro json, se devuelve en texto
	: (($l_tipoNodo=JSON_NODE) & ($l_tipoReceptor=Is text:K8:3))
		$y_receptor->:=JSON Export to text ($t_nodo;JSON_WITHOUT_WHITE_SPACE)
		
End case 


