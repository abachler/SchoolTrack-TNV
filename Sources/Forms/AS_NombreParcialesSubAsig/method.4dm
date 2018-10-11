If (Form event:C388=On Load:K2:1)
	
	ARRAY TEXT:C222($at_parciales;0)
	C_POINTER:C301($y_parciales;$y_nombre;$y_titulo1;$y_titulo2;$y_descripcion)
	C_LONGINT:C283($i)
	
	  //$y_descripcion:=(OBJECT Get pointer(Object named;"t_funcionalidad"))//me queda en nill
	$y_parciales:=(OBJECT Get pointer:C1124(Object named:K67:5;"parciales"))
	$y_nombre:=(OBJECT Get pointer:C1124(Object named:K67:5;"nombres"))
	$y_titulo1:=(OBJECT Get pointer:C1124(Object named:K67:5;"t_lb1"))
	$y_titulo2:=(OBJECT Get pointer:C1124(Object named:K67:5;"t_lb2"))
	
	OBJECT SET TITLE:C194($y_titulo1->;__ ("Nombre de las parciales"))
	OBJECT SET TITLE:C194($y_titulo2->;__ ("Personalizar nombres"))
	OBJECT SET TITLE:C194(*;"t_funcionalidad";__ ("Personalice los nombres de las parciales de las subasignaturas, que se encuentran relacionadas con las asignaturas listadas en el explorador, de forma masiva."))
	  //$y_descripcion->:=__ ("Personalice los nombres de las parciales de las subasignaturas, que se encuentran relacionadas con las asignaturas listadas en el explorador, de forma masiva.")
	
	For ($i;1;12)
		APPEND TO ARRAY:C911($at_parciales;__ ("Parcial ")+String:C10($i))
	End for 
	
	COPY ARRAY:C226($at_parciales;$y_parciales->)
	COPY ARRAY:C226($at_parciales;$y_nombre->)
	
	LISTBOX SET PROPERTY:C1440(*;"parciales";lk sortable:K53:45;0)
	LISTBOX SET PROPERTY:C1440(*;"nombres";lk sortable:K53:45;0)
	LISTBOX SET PROPERTY:C1440(*;"nombres";lk single click edit:K53:70;1)
	OBJECT SET ENABLED:C1123(*;"parciales";False:C215)
	
End if 