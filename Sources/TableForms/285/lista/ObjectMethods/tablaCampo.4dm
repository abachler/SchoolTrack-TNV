  // [yST_Diccionario].lista.tablaCampo()
  // Por: Alberto Bachler K.: 16-01-15, 19:44:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_indexado;$b_invisible;$b_unico)
_O_C_INTEGER:C282($i_campos;$i_tablas)
C_LONGINT:C283($l_largoAlpha;$l_tipoCampo)
C_POINTER:C301($y_tipo)


If ((Is table number valid:C999([sync_diccionario:285]st_tabla:8)) & (Is field number valid:C1000([sync_diccionario:285]st_tabla:8;[sync_diccionario:285]st_campo:9)))
	(OBJECT Get pointer:C1124(Object named:K67:5;"tablacampo"))->:="["+Table name:C256([sync_diccionario:285]st_tabla:8)+"]"+Field name:C257([sync_diccionario:285]st_tabla:8;[sync_diccionario:285]st_campo:9)
	$y_tipo:=OBJECT Get pointer:C1124(Object named:K67:5;"tipo")
	GET FIELD PROPERTIES:C258([sync_diccionario:285]st_tabla:8;[sync_diccionario:285]st_campo:9;$l_tipoCampo;$l_largoAlpha;$b_indexado;$b_unico;$b_invisible)
	Case of 
		: (([sync_diccionario:285]st_tipo4D:10=Is alpha field:K8:1) & ($l_largoAlpha=0))
			$y_tipo->:="UUID"
		: ([sync_diccionario:285]st_tipo4D:10=Is alpha field:K8:1)
			$y_tipo->:="Alpha "+String:C10($l_largoAlpha)
		: ([sync_diccionario:285]st_tipo4D:10=Is text:K8:3)
			$y_tipo->:="Text"
		: ([sync_diccionario:285]st_tipo4D:10=Is real:K8:4)
			$y_tipo->:="Real"
		: ([sync_diccionario:285]st_tipo4D:10=Is longint:K8:6)
			$y_tipo->:="Longint"
		: ([sync_diccionario:285]st_tipo4D:10=Is integer 64 bits:K8:25)
			$y_tipo->:="Int64"
		: ([sync_diccionario:285]st_tipo4D:10=Is integer:K8:5)
			$y_tipo->:="Integer"
		: ([sync_diccionario:285]st_tipo4D:10=Is date:K8:7)
			$y_tipo->:="Date"
		: ([sync_diccionario:285]st_tipo4D:10=Is time:K8:8)
			$y_tipo->:="Time"
		: ([sync_diccionario:285]st_tipo4D:10=Is boolean:K8:9)
			$y_tipo->:="Boolean"
		: ([sync_diccionario:285]st_tipo4D:10=Is picture:K8:10)
			$y_tipo->:="Picture"
		: ([sync_diccionario:285]st_tipo4D:10=Is subtable:K8:11)
			$y_tipo->:="Subtable"
		: ([sync_diccionario:285]st_tipo4D:10=Is BLOB:K8:12)
			$y_tipo->:="Blob"
	End case 
	
	If ([sync_diccionario:285]sincronizable:12)
		OBJECT SET FONT STYLE:C166(*;"tablacampo";Bold:K14:2)
	Else 
		OBJECT SET FONT STYLE:C166(*;"tablacampo";Plain:K14:1)
	End if 
	OBJECT SET COLOR:C271(*;"tablacampo";-Black:K11:16)
Else 
	OBJECT SET FONT STYLE:C166(*;"tablacampo";Plain:K14:1)
	OBJECT SET COLOR:C271(*;"tablacampo";-Red:K11:4)
End if 