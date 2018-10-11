//%attributes = {}
  // VC4D_LoadChanges()
  //
  //
  // creado por: Alberto Bachler Klein: 14-02-16, 17:13:09
  // -----------------------------------------------------------
C_BLOB:C604($x_parametros;$x_repuesta)
C_BOOLEAN:C305($b_codigoDistinto;$b_esconderIguales)
C_DATE:C307($d_fecha)
C_LONGINT:C283($i_loops;$l_elemento;$l_error;$l_errorCode;$l_metodosDB;$l_metodosEnServidor;$l_metodosFormulario;$l_metodosProyecto;$l_opcion;$l_progreso)
C_LONGINT:C283($l_resultado;$l_size;$l_tipoMetodo;$l_triggers)
C_TIME:C306($h_hora)
C_POINTER:C301($y_arreglo;$y_autor;$y_dtsModificationServer;$y_integrable;$y_metodo;$y_modificacion;$y_ruta;$y_statusServer;$y_tabla;$y_tipo_T)
C_POINTER:C301($y_uuidMetodo)
C_TEXT:C284($t_currentOnErrMethod;$t_dtsDesde;$t_dtsHasta;$t_dtsLocal;$t_dtsServer;$t_error;$t_errorWS;$t_nombreObjeto;$t_nombreObjetoFormulario;$t_nombreTabla)
C_TEXT:C284($t_NS;$t_password;$t_path;$t_text;$t_url;$t_userName;$t_WSN)
C_OBJECT:C1216($ob_data;$ob_parametros;$ob_respuesta)

ARRAY LONGINT:C221($al_tipoObjeto;0)
ARRAY POINTER:C280($ay_jerarquia;0)
ARRAY TEXT:C222($at_dtsEnServidor;0)
ARRAY TEXT:C222($at_nombreObjeto;0)
ARRAY TEXT:C222($at_nombreObjetoFormulario;0)
ARRAY TEXT:C222($at_nombreTabla;0)
ARRAY TEXT:C222($at_rutasMetodosEnServidor;0)


ARRAY LONGINT:C221(al_RowControl;0)


$y_tipo_T:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoMetodo")
$y_ruta:=OBJECT Get pointer:C1124(Object named:K67:5;"ruta")
$y_metodo:=OBJECT Get pointer:C1124(Object named:K67:5;"metodo")
$y_autor:=OBJECT Get pointer:C1124(Object named:K67:5;"creador")
$y_modificacion:=OBJECT Get pointer:C1124(Object named:K67:5;"dts_modificacion")
$y_uuidMetodo:=OBJECT Get pointer:C1124(Object named:K67:5;"uuid_metodo")
$y_statusServer:=OBJECT Get pointer:C1124(Object named:K67:5;"statusServer")
$y_dtsModificationServer:=OBJECT Get pointer:C1124(Object named:K67:5;"modificacionServer")
$y_integrable:=OBJECT Get pointer:C1124(Object named:K67:5;"integrable")


AT_Initialize (->$al_tipoObjeto;->$at_nombreObjeto;->$at_nombreObjetoFormulario)
AT_Initialize ($y_tipo_T;$y_ruta;$y_metodo;$y_autor;$y_modificacion;->$at_nombreTabla;$y_uuidMetodo;$y_statusServer;$y_dtsModificationServer)


$l_opcion:=$1
$l_opcion:=15

Case of 
	: ($l_opcion=1)  // todo
		$t_dtsDesde:=""
		
	: ($l_opcion=3)  // ultima hora
		$h_hora:=Current time:C178(*)-(60*60)
		$t_dtsDesde:=String:C10(Current date:C33(*);ISO date:K1:8;$h_hora)
		
	: ($l_opcion=4)  // ultimas 3 horas
		$h_hora:=Current time:C178(*)-(60*60*3)
		$t_dtsDesde:=String:C10(Current date:C33(*);ISO date:K1:8;$h_hora)
		
	: ($l_opcion=6)  // hoy
		$t_dtsDesde:=String:C10(Current date:C33(*);ISO date:K1:8;?00:00:00?)
		
	: ($l_opcion=7)  // desde ayer
		$t_dtsDesde:=String:C10(Current date:C33(*)-1;ISO date:K1:8;?00:00:00?)
		
	: ($l_opcion=8)  // desde antes de ayer
		$t_dtsDesde:=String:C10(Current date:C33(*)-2;ISO date:K1:8;?00:00:00?)
		
	: ($l_opcion=9)  // ultimos 3 días
		$t_dtsDesde:=String:C10(Current date:C33(*)-3;ISO date:K1:8;?00:00:00?)
		
	: ($l_opcion=10)  // ultima semana
		$t_dtsDesde:=String:C10(Current date:C33(*)-6;ISO date:K1:8;?00:00:00?)
		
	: ($l_opcion=11)  // ultimas dos semanas
		$t_dtsDesde:=String:C10(Current date:C33(*)-13;ISO date:K1:8;?00:00:00?)
		
	: ($l_opcion=12)  // ultimo més
		$t_dtsDesde:=String:C10(Add to date:C393(Current date:C33(*);0;-1;0);ISO date:K1:8;?00:00:00?)
		
	: ($l_opcion=14)  //
		  //OBJECT SET VISIBLE(*;"fechas@";True)
		  //OBJECT SET VISIBLE(*;"fechas_@_hasta";False)
		$d_fecha:=(OBJECT Get pointer:C1124(Object named:K67:5;"fechas_fecha_desde"))->
		$h_Hora:=(OBJECT Get pointer:C1124(Object named:K67:5;"fechas_hora_desde"))->
		$t_dtsDesde:=String:C10($d_fecha;ISO date:K1:8;$h_hora)
		
	: ($l_opcion=15)  //
		  //OBJECT SET VISIBLE(*;"fechas@";True)
		  //OBJECT SET VISIBLE(*;"fechas_@_hasta";True)
		$d_fecha:=(OBJECT Get pointer:C1124(Object named:K67:5;"fechas_fecha_desde"))->
		$h_Hora:=(OBJECT Get pointer:C1124(Object named:K67:5;"fechas_hora_desde"))->
		$t_dtsDesde:=String:C10($d_fecha;ISO date:K1:8;$h_hora)
		$d_fecha:=(OBJECT Get pointer:C1124(Object named:K67:5;"fechas_fecha_hasta"))->
		$h_Hora:=(OBJECT Get pointer:C1124(Object named:K67:5;"fechas_hora_hasta"))->
		$t_dtsHasta:=String:C10($d_fecha;ISO date:K1:8;$h_hora)
End case 






$l_progreso:=Progress New 
Progress SET WINDOW VISIBLE (True:C214;60;120;True:C214)
Progress SET TITLE ($l_progreso;"VC4D";-1;"Leyendo el historial de cambios…")
Progress SET PROGRESS ($l_progreso;-1)

OB SET:C1220($ob_parametros;"dtsDesde";$t_dtsDesde;"dtsHasta";$t_dtsHasta)
$ob_data:=VC4D_GetData ("VC4D_HistorialCambios";$ob_parametros)
OB GET ARRAY:C1229($ob_data;"tipo_objeto";$al_tipoObjeto)
OB GET ARRAY:C1229($ob_data;"ruta";$y_ruta->)
OB GET ARRAY:C1229($ob_data;"autor";$y_autor->)
OB GET ARRAY:C1229($ob_data;"dts_modificacion";$y_modificacion->)
OB GET ARRAY:C1229($ob_data;"nombre_tabla";$at_nombreTabla)
OB GET ARRAY:C1229($ob_data;"nombre_objeto";$at_nombreObjeto)
OB GET ARRAY:C1229($ob_data;"nombre_objeto_formulario";$at_nombreObjetoFormulario)
OB GET ARRAY:C1229($ob_data;"uuid_metodo";$y_uuidMetodo->)

ARRAY TEXT:C222($y_statusServer->;Size of array:C274($y_ruta->))
ARRAY TEXT:C222($y_dtsModificationServer->;Size of array:C274($y_ruta->))
ARRAY BOOLEAN:C223($y_integrable->;Size of array:C274($y_ruta->))

Progress SET TITLE ($l_progreso;"VC4D";-1;"Leyendo en el servidor…")
Progress SET PROGRESS ($l_progreso;-1)
$t_userName:=(OBJECT Get pointer:C1124(Object named:K67:5;"userName"))->
$t_password:=(OBJECT Get pointer:C1124(Object named:K67:5;"password"))->
$t_url:=(OBJECT Get pointer:C1124(Object named:K67:5;"URL"))->
$t_WSN:=(OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName"))->
$t_NS:=(OBJECT Get pointer:C1124(Object named:K67:5;"nameSpace"))->

COPY ARRAY:C226($y_ruta->;$at_rutasMetodosEnServidor)
AT_DistinctsArrayValues (->$at_rutasMetodosEnServidor)
$ob_parametros:=OB_Create 
OB_SET ($ob_parametros;->$t_userName;"user")
OB_SET ($ob_parametros;->$t_password;"passw")
OB_SET ($ob_parametros;->$at_rutasMetodosEnServidor;"paths")
$l_resultado:=OB_ObjectToBlob (->$ob_parametros;->$x_parametros)
WEB SERVICE SET PARAMETER:C777("data";$x_parametros)
$t_errorWS:=VC4D_CallWebService ("VC4Dws_GetMethodsInfo";$t_url;$t_WSN;$t_NS)

If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($x_repuesta;"output";*)  //20180514 RCH Ticket 206788
	OB_BlobToObject (->$x_repuesta;->$ob_respuesta)
	OB_GET ($ob_respuesta;->$t_error;"errorText")
	OB_GET ($ob_respuesta;->$l_error;"errorCode")
	OB_GET ($ob_respuesta;->$at_rutasMetodosEnServidor;"paths")
	OB_GET ($ob_respuesta;->$at_dtsEnServidor;"dts")
End if 
$l_metodosEnServidor:=Size of array:C274($at_dtsEnServidor)

$t_currentOnErrMethod:=Method called on error:C704
ON ERR CALL:C155("VC4D_OnError")


$l_metodosDB:=0
$l_metodosFormulario:=0
$l_metodosProyecto:=0
$l_triggers:=0
$l_size:=Size of array:C274($al_tipoObjeto)
$i_loops:=0
ARRAY TEXT:C222($y_tipo_T->;$l_size)
ARRAY TEXT:C222($y_metodo->;$l_size)
Progress SET PROGRESS ($l_progreso;0)
For ($i;Size of array:C274($al_tipoObjeto);1;-1)
	Progress SET PROGRESS ($l_progreso;$i_loops/$l_size)
	$i_loops:=$i_loops+1
	error:=0
	If ($y_ruta->{$i}="@VC4D/loadVC4Ddata")
		
	End if 
	METHOD RESOLVE PATH:C1165($y_ruta->{$i};$l_tipoMetodo;$y_tabla;$t_nombreObjeto;$t_nombreObjetoFormulario;*)
	METHOD GET MODIFICATION DATE:C1170($y_ruta->{$i};$d_fecha;$h_hora;*)
	If (Not:C34(Is nil pointer:C315($y_Tabla)))
		$t_nombreTabla:=Table name:C256($y_tabla)
	Else 
		$t_nombreTabla:=""
	End if 
	$l_errorCode:=error
	
	
	If ($l_errorCode=0)
		  //$y_modificacion->{$i}:=String($d_fecha;ISO date;$h_hora)
		Case of 
			: ($l_tipoMetodo=Path project method:K72:1)
				$y_tipo_T->{$i}:="Método proyecto"
				$y_metodo->{$i}:=$t_nombreObjeto
				  //$l_metodosProyecto:=$l_metodosProyecto+1
			: ($l_tipoMetodo=Path database method:K72:2)
				$y_tipo_T->{$i}:="Método de base de datos"
				$y_metodo->{$i}:=$t_nombreObjeto
				  //$l_metodosDB:=$l_metodosDB+1
			: ($l_tipoMetodo=Path trigger:K72:4)
				$y_tipo_T->{$i}:="Trigger"
				$y_metodo->{$i}:="["+$t_nombreTabla+"]"
				$l_triggers:=$l_triggers+1
			: ($l_tipoMetodo=Path project form:K72:3)
				$y_tipo_T->{$i}:="Formulario Proyecto"
				$y_metodo->{$i}:=$t_nombreObjeto+"."+Choose:C955($t_nombreObjetoFormulario="";"formMethod";$t_nombreObjetoFormulario)
				  //$l_metodosFormulario:=$l_metodosFormulario+1
			: ($l_tipoMetodo=Path table form:K72:5)
				$y_tipo_T->{$i}:="Formulario tabla"
				$y_metodo->{$i}:="["+$t_nombreTabla+"]."+$t_nombreObjeto+"."+Choose:C955($t_nombreObjetoFormulario="";"formMethod";$t_nombreObjetoFormulario)
				  //$l_metodosFormulario:=$l_metodosFormulario+1
		End case 
		$y_modificacion->{$i}:=Replace string:C233($y_modificacion->{$i};"T";", ")
		
	Else 
		Case of 
			: ($l_errorCode=-9776)
				$t_error:="Unable to create method: "+$t_path
			: ($l_errorCode=-9775)
				$t_error:="Unable to write method code"+$t_path
			: ($l_errorCode=-9774)
				$t_error:="Unable to read method code: "+$t_path
			: ($l_errorCode=-9768)
				$t_error:="Invalid object path: "+$t_path
			: ($l_errorCode=-9767)
				$t_error:="Cannot update methods. One or more resources are locked"
			: ($l_errorCode=-9766)
				$t_error:="The method is currently being edited"
			Else 
				$t_error:="Unknown error"
		End case 
		DELETE FROM ARRAY:C228($al_tipoObjeto;$i)
		DELETE FROM ARRAY:C228($y_tipo_T->;$i)
		DELETE FROM ARRAY:C228($y_ruta->;$i)
		DELETE FROM ARRAY:C228($y_metodo->;$i)
		DELETE FROM ARRAY:C228($y_autor->;$i)
		DELETE FROM ARRAY:C228($y_modificacion->;$i)
		DELETE FROM ARRAY:C228($y_uuidMetodo->;$i)
		DELETE FROM ARRAY:C228($y_statusServer->;$i)
		DELETE FROM ARRAY:C228($y_dtsModificationServer->;$i)
		DELETE FROM ARRAY:C228($y_integrable->;$i)
	End if 
End for 
ON ERR CALL:C155($t_currentOnErrMethod)
AT_MultiLevelSort (">><";$y_tipo_T;$y_metodo;$y_modificacion;$y_ruta;$y_autor;$y_uuidMetodo;$y_statusServer;$y_dtsModificationServer;$y_integrable)


$b_esconderIguales:=((OBJECT Get pointer:C1124(Object named:K67:5;"mostrarIguales"))->=0)

Progress SET TITLE ($l_progreso;"VC4D";1;"Analizando cambios en el código")
ARRAY LONGINT:C221(al_RowControl;Size of array:C274($y_ruta->))
ARRAY BOOLEAN:C223($y_integrable->;Size of array:C274($y_ruta->))
For ($i;Size of array:C274($y_ruta->);1;-1)
	METHOD RESOLVE PATH:C1165($y_ruta->{$i};$l_tipoMetodo;$y_tabla;$t_nombreObjeto;$t_nombreObjetoFormulario;*)
	Progress SET PROGRESS ($l_progreso;$i/Size of array:C274($y_ruta->);$y_metodo->{$i};True:C214)
	$t_dtsLocal:=$y_modificacion->{$i}
	$l_elemento:=Find in array:C230($at_rutasMetodosEnServidor;$y_Ruta->{$i})
	If (($l_elemento>0) & ($l_metodosEnServidor>0))
		$t_dtsServer:=Replace string:C233($at_dtsEnServidor{$l_elemento};"T";", ")
	Else 
		$t_dtsServer:=""
	End if 
	$y_dtsModificationServer->{$i}:=$t_dtsServer
	
	
	$b_codigoDistinto:=VC4D_ComparaCodigo ($y_Ruta->{$i})
	Case of 
		: (($t_dtsServer="0000-00-00@") | ($t_dtsServer=""))
			$y_dtsModificationServer->{$i}:=""
			
			$y_statusServer->{$i}:=IT_SetTextColor_Name (->$t_text;"Blue")
			If (($l_tipoMetodo=Path table form:K72:5) | ($l_tipoMetodo=Path project form:K72:3))
				$y_integrable->{$i}:=False:C215
				$t_text:="Nuevo objeto: Copiar fomulario u objeto y luego integrar código"
				$y_statusServer->{$i}:=IT_SetTextColor_Name (->$t_text;"Red")
			Else 
				$t_text:="Nuevo"
				$y_integrable->{$i}:=True:C214
				$y_statusServer->{$i}:=IT_SetTextColor_Name (->$t_text;"Blue")
			End if 
			
			
		: (Not:C34($b_codigoDistinto))
			If (($l_tipoMetodo=Path table form:K72:5) | ($l_tipoMetodo=Path project form:K72:3))
				$y_integrable->{$i}:=True:C214
				$t_text:="Iguales: integrar si el fomulario fue copiado al servidor"
			Else 
				$t_text:="Iguales"
				If ($b_esconderIguales)
					al_RowControl{$i}:=lk row is hidden:K53:31
				End if 
			End if 
			$y_statusServer->{$i}:=IT_SetTextColor_Name (->$t_text;"Black")
			
		: ($t_dtsServer<$y_modificacion->{$i})
			$t_text:="Local"
			$y_statusServer->{$i}:=IT_SetTextColor_Name (->$t_text;"Green")
			$y_dtsModificationServer->{$i}:=IT_SetTextColor_Name (->$t_dtsServer;"Green")
			$y_integrable->{$i}:=True:C214
			
		Else 
			$t_text:="Remoto"
			$y_statusServer->{$i}:=IT_SetTextColor_Name (->$t_text;"Red")
			$y_dtsModificationServer->{$i}:=IT_SetTextColor_Name (->$t_dtsServer;"Red")
			$y_integrable->{$i}:=False:C215
	End case 
	
	If (Not:C34(al_RowControl{$i} ?? 0))
		Case of 
			: ($l_tipoMetodo=Path project method:K72:1)
				$l_metodosProyecto:=$l_metodosProyecto+1
			: ($l_tipoMetodo=Path database method:K72:2)
				$l_metodosDB:=$l_metodosDB+1
			: ($l_tipoMetodo=Path trigger:K72:4)
				$l_triggers:=$l_triggers+1
			: ($l_tipoMetodo=Path project form:K72:3)
				$l_metodosFormulario:=$l_metodosFormulario+1
			: ($l_tipoMetodo=Path table form:K72:5)
				$l_metodosFormulario:=$l_metodosFormulario+1
		End case 
	End if 
	
	
End for 
Progress QUIT ($l_progreso)


APPEND TO ARRAY:C911($ay_jerarquia;$y_tipo_T)
LISTBOX SET HIERARCHY:C1098(*;"lb_vc4d";True:C214;$ay_jerarquia)


OBJECT SET TITLE:C194(*;"metodosProyecto";String:C10($l_metodosProyecto)+" Métodos proyecto")
OBJECT SET TITLE:C194(*;"metodosDB";String:C10($l_metodosDB)+" Métodos de base de datos")
OBJECT SET TITLE:C194(*;"metodosFormulario";String:C10($l_metodosformulario)+" Métodos objetos formularios")
OBJECT SET TITLE:C194(*;"triggers";String:C10($l_triggers)+" triggers")


  //LISTBOX SET ARRAY(*;"lb_vc4d";Listbox control array;->al_RowControl)
$y_arreglo:=LISTBOX Get array:C1278(*;"lb_vc4d";lk control array:K53:30)







