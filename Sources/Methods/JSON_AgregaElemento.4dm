//%attributes = {}
  // JSON_AgregaElemento()
  // Por: Alberto Bachler K.: 11-08-14, 15:35:45
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_TEXT:C284($3)

C_BLOB:C604($x_Blob)
C_LONGINT:C283($l_campo;$l_hora;$l_tabla;$l_tipoContenedor;$l_tipoNodo;$l_tipoReceptor)
C_POINTER:C301($y_contenedor)
C_TEXT:C284($t_codificacion;$t_fecha;$t_nodoJson;$t_nodoJsonJson;$t_nombreElemento)

ARRAY TEXT:C222($at_fechas;0)



If (False:C215)
	C_TEXT:C284(JSON_AgregaElemento ;$1)
	C_POINTER:C301(JSON_AgregaElemento ;$2)
	C_TEXT:C284(JSON_AgregaElemento ;$3)
End if 

$t_nodoJson:=$1
$y_contenedor:=$2

If (Count parameters:C259=3)
	$t_nombreElemento:=$3
Else 
	RESOLVE POINTER:C394($y_contenedor;$t_nombreElemento;$l_tabla;$l_campo)
	Case of 
		: (($l_tabla=0) & ($t_nombreElemento=""))
			
		: ($l_Tabla>0)
			If ((Is table number valid:C999($l_tabla)) & (Is field number valid:C1000($l_tabla;$l_campo)))
				$t_nombreElemento:=Table name:C256($l_tabla)+"."+Field name:C257($l_tabla;$l_campo)
			End if 
			
		Else 
			
	End case 
End if 

If (Asserted:C1132($t_nombreElemento#"";"El identificador del elemento JSON es inválido o nulo"))
	
	$l_tipoContenedor:=Type:C295($y_contenedor->)
	
	Case of 
		: ($l_tipoContenedor=Is subtable:K8:11)
			$t_refNodo:=JSON Append text ($t_nodoJson;$t_nombreElemento;"Subtabla no soportada")
			
		: ($l_tipoContenedor=Is picture:K8:10)
			PICTURE TO BLOB:C692($y_contenedor->;$x_Blob;".jpg")
			BASE64 ENCODE:C895($x_blob;$t_codificacion)
			$t_refNodo:=JSON Append text ($t_nodoJson;$t_nombreElemento;$t_codificacion)
			
		: ($l_tipoContenedor=Is BLOB:K8:12)
			BASE64 ENCODE:C895($y_contenedor->;$t_codificacion)
			$t_refNodo:=JSON Append text ($t_nodoJson;$t_nombreElemento;$t_codificacion)
			
		: ($l_tipoContenedor=Is date:K8:7)
			$t_fecha:=DTS_MakeFromDateTime ($y_contenedor->;?00:00:00?)
			$t_refNodo:=JSON Append text ($t_nodoJson;$t_nombreElemento;$t_fecha)
			
		: ($l_tipoContenedor=Is time:K8:8)
			$l_hora:=$y_contenedor->
			$t_refNodo:=JSON Append long ($t_nodoJson;$t_nombreElemento;$l_hora)
			
		: ($l_tipoContenedor=Is text:K8:3)
			$t_refNodo:=JSON Append text ($t_nodoJson;$t_nombreElemento;$y_contenedor->)
			
		: ($l_tipoContenedor=Is alpha field:K8:1)
			$t_refNodo:=JSON Append text ($t_nodoJson;$t_nombreElemento;$y_contenedor->)
			
		: (($l_tipoContenedor=Is longint:K8:6) | ($l_tipoContenedor=Is integer:K8:5) | ($l_tipoContenedor=Is integer 64 bits:K8:25))
			$t_refNodo:=JSON Append long ($t_nodoJson;$t_nombreElemento;$y_contenedor->)
			
		: ($l_tipoContenedor=Is real:K8:4)
			$t_refNodo:=JSON Append real ($t_nodoJson;$t_nombreElemento;$y_contenedor->)
			
		: ($l_tipoContenedor=Is boolean:K8:9)
			$t_refNodo:=JSON Append bool ($t_nodoJson;$t_nombreElemento;Num:C11($y_contenedor->))
			
		: ($l_tipoContenedor=Text array:K8:16)
			$t_refNodo:=JSON Append text array ($t_nodoJson;$t_nombreElemento;$y_contenedor->)
			
		: ($l_tipoContenedor=String array:K8:15)
			$t_refNodo:=JSON Append text array ($t_nodoJson;$t_nombreElemento;$y_contenedor->)
			
		: ($l_tipoContenedor=Boolean array:K8:21)
			$t_refNodo:=JSON Append bool array ($t_nodoJson;$t_nombreElemento;$y_contenedor->)
			
		: ($l_tipoContenedor=LongInt array:K8:19)
			$t_refNodo:=JSON Append long array ($t_nodoJson;$t_nombreElemento;$y_contenedor->)
			
		: ($l_tipoContenedor=Integer array:K8:18)
			$t_refNodo:=JSON Append long array ($t_nodoJson;$t_nombreElemento;$y_contenedor->)
			
		: ($l_tipoContenedor=Real array:K8:17)
			$t_refNodo:=JSON Append real array ($t_nodoJson;$t_nombreElemento;$y_contenedor->)
			
		: ($l_tipoContenedor=Date array:K8:20)
			AT_CopyArrayElements ($y_contenedor;->$at_fechas)
			$t_refNodo:=JSON Append text array ($t_nodoJson;$t_nombreElemento;$at_Fechas)
			
	End case 
End if 

JSON CLOSE ($t_refNodo)
CLEAR VARIABLE:C89($t_refNodo)
