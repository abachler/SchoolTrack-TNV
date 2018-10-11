  // [BBL_Items].Busqueda.registro()
  // Por: Alberto Bachler K.: 06-01-15, 12:44:33
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_Clasificacion;$y_Codigo;$y_Expresion;$y_Registro)

$y_Registro:=OBJECT Get pointer:C1124(Object named:K67:5;"registro")
$y_Codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"codigo")
$y_Clasificacion:=OBJECT Get pointer:C1124(Object named:K67:5;"clasificacion")
$y_Expresion:=OBJECT Get pointer:C1124(Object named:K67:5;"expresionBusqueda")

Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		OBJECT SET VISIBLE:C603(*;"modoComparacion@";False:C215)
		OBJECT SET TITLE:C194(*;"tipoBusqueda";__ ("Busqueda por número de registro"))
		
	: (Form event:C388=On After Keystroke:K2:26)
		$y_codigo->:=""
		$y_Expresion->:=""
		$y_Clasificacion->:=""
		OBJECT SET TITLE:C194(*;"tipoBusqueda";__ ("Busqueda por número de registro"))
		If (Get edited text:C655#"")
			DESCRIBE QUERY EXECUTION:C1044(True:C214)
			QUERY:C277([BBL_Items:61];[BBL_Registros:66]No_Registro:25;=;Get edited text:C655)
			$t_path:=Get last query path:C1045(Description in text format:K19:5)
			$t_path:=ST_GetWord ($t_path;2;"--> ")
			$t_registros:=ST_GetWord ($t_path;2)
			$t_ms:=ST_GetWord ($t_path;6)
			DESCRIBE QUERY EXECUTION:C1044(False:C215)
			OBJECT SET TITLE:C194(*;"resultadoBusqueda";$t_registros+" "+__ ("items")+__ (" en ")+$t_ms+__ (" ms"))
			OBJECT SET TITLE:C194(*;"tipoBusqueda";__ ("Busqueda por número de registro"))
		Else 
			REDUCE SELECTION:C351([BBL_Items:61];0)
			OBJECT SET TITLE:C194(*;"tipoBusqueda";"")
			OBJECT SET TITLE:C194(*;"resultadoBusqueda";"")
		End if 
		
End case 
BBL_BusquedaRapida ("ajustesBarraEstado")
OBJECT SET TITLE:C194(*;"modoComparacion";"")
OBJECT SET VISIBLE:C603(*;"modoComparacion";False:C215)
REDRAW WINDOW:C456