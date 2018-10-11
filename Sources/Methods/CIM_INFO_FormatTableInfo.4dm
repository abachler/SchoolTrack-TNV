//%attributes = {}
  // CIM_INFO_FormatTableInfo()
  // Por: Alberto Bachler K.: 03-11-14, 17:08:10
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_IdProcesoProgresoCliente;$l_infoDetallada;$l_maxSize;$l_minSize;$l_tableNum)
C_POINTER:C301($y_fragmentacion;$y_maximoRegistro;$y_mediaRegistro;$y_minimoRegistro;$y_nombreTablas;$y_numeroRegistros;$y_numeroTablas;$y_TablePointer;$y_tamañoTabla)
C_REAL:C285($r_totalSize;$r_value)

If (False:C215)
	C_LONGINT:C283(CIM_INFO_FormatTableInfo ;$1)
End if 
OBJECT SET VISIBLE:C603(*;"resultadoVerificacion";False:C215)


$l_infoDetallada:=$1

$y_numeroTablas:=OBJECT Get pointer:C1124(Object named:K67:5;"infoBD_numeroTablas")
$y_nombreTablas:=OBJECT Get pointer:C1124(Object named:K67:5;"infoBD_nombreTablas")
$y_numeroRegistros:=OBJECT Get pointer:C1124(Object named:K67:5;"infoBD_numeroRegistros")
$y_fragmentacion:=OBJECT Get pointer:C1124(Object named:K67:5;"infoBD_fragmentacion")
$y_tamañoTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"infoBD_tamañoTabla")
$y_mediaRegistro:=OBJECT Get pointer:C1124(Object named:K67:5;"infoBD_mediaRegistro")
$y_minimoRegistro:=OBJECT Get pointer:C1124(Object named:K67:5;"infoBD_minimoRegistro")
$y_maximoRegistro:=OBJECT Get pointer:C1124(Object named:K67:5;"infoBD_maximoRegistro")


Case of 
	: ($l_infoDetallada<=0)
		  // para obtener estadísticas básicas (numero de registros y fragmentación)
		If (Size of array:C274($y_numeroTablas->)=0)
			If (Application type:C494=4D Remote mode:K5:5)
				$l_IdProcesoProgresoCliente:=IT_Progress (1;0;0;"Obteniendo estadísticas básicas sobre la base de datos...")
			End if 
			CIM_GetDatabaseStats (<>registeredName;$l_IdProcesoProgresoCliente;$y_numeroTablas;$y_nombreTablas;$y_numeroRegistros;$y_fragmentacion)
			AT_RedimArrays (Size of array:C274($y_numeroTablas->);$y_tamañoTabla;$y_mediaRegistro;$y_minimoRegistro;$y_maximoRegistro)
			If (Application type:C494=4D Remote mode:K5:5)
				IT_Progress (-1;$l_IdProcesoProgresoCliente)
			End if 
		End if 
		
	: ($l_infoDetallada>=1)
		  // para obtener estadísticas detalladas (numero de registros y fragmentación, tamaño de la tabla, tamaño promedio, mínimo y máximo de registros)
		If (AT_GetSumArray ($y_tamañoTabla)=0)
			If (Application type:C494=4D Remote mode:K5:5)
				$l_IdProcesoProgresoCliente:=IT_Progress (1;0;0;"Obteniendo estadísticas básicas sobre la base de datos...")
			End if 
			CIM_GetDatabaseStats (<>registeredName;$l_IdProcesoProgresoCliente;$y_numeroTablas;$y_nombreTablas;$y_numeroRegistros;$y_fragmentacion;$y_tamañoTabla;$y_mediaRegistro;$y_minimoRegistro;$y_maximoRegistro)
			If (Application type:C494=4D Remote mode:K5:5)
				IT_Progress (-1;$l_IdProcesoProgresoCliente)
			End if 
		End if 
End case 

OBJECT SET VISIBLE:C603(*;"infoBD_fragmentacion";False:C215)
OBJECT SET VISIBLE:C603(*;"infoBD_tamañoTabla";False:C215)
OBJECT SET VISIBLE:C603(*;"infoBD_mediaRegistro";False:C215)
OBJECT SET VISIBLE:C603(*;"infoBD_minimoRegistro";False:C215)
OBJECT SET VISIBLE:C603(*;"infoBD_maximoRegistro";False:C215)
Case of 
	: ($l_infoDetallada=0)  //fragmentación
		OBJECT SET VISIBLE:C603(*;"infoBD_fragmentacion";True:C214)
		LISTBOX SORT COLUMNS:C916(*;"lb_infoBD";4;<)
		
	: ($l_infoDetallada=1)  //tamaño de la tabla
		OBJECT SET VISIBLE:C603(*;"infoBD_tamañoTabla";True:C214)
		LISTBOX SORT COLUMNS:C916(*;"lb_infoBD";5;<)
	: ($l_infoDetallada=2)  //tamaño promedio de registros
		OBJECT SET VISIBLE:C603(*;"infoBD_mediaRegistro";True:C214)
		LISTBOX SORT COLUMNS:C916(*;"lb_infoBD";6;<)
		
	: ($l_infoDetallada=3)  //tamaño mínimo de registro
		OBJECT SET VISIBLE:C603(*;"infoBD_minimoRegistro";True:C214)
		LISTBOX SORT COLUMNS:C916(*;"lb_infoBD";7;>)
		
	: ($l_infoDetallada=4)  //tamaño máximo de registro
		OBJECT SET VISIBLE:C603(*;"infoBD_maximoRegistro";True:C214)
		LISTBOX SORT COLUMNS:C916(*;"lb_infoBD";8;<)
End case 


ARRAY LONGINT:C221(al_DBINfo_Colors;0)
ARRAY LONGINT:C221(al_DBINfo_Colors;Size of array:C274($y_nombreTablas->))
For ($i;1;Size of array:C274($y_nombreTablas->))
	$l_tableNum:=$y_numeroTablas->{$i}
	If (($y_fragmentacion->{$i}>80) & ($y_numeroRegistros->{$i}>100))
		al_DBINfo_Colors{$i}:=0x00FF0000
	Else 
		al_DBINfo_Colors{$i}:=0x0000
	End if 
End for 

