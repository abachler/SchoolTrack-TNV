//%attributes = {"executedOnServer":true}
  // MÉTODO: CIM_GetDatabaseStats
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 29/06/11, 07:27:35
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // CIM_GetDatabaseStats()
  // ----------------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_estadisticasDetalladas)
C_LONGINT:C283($l_error;$l_IdProcesoProgresoServer;$l_indexCliente;$l_maxSize;$l_minSize;$l_numeroDeRegistros;$l_numeroDeTablas;$l_objectSize;$l_procesoProgresoCliente;$l_tableNum)
C_POINTER:C301($y_DBinfo_avgRecordSize;$y_DBinfo_fragmentation;$y_DBinfo_maxSize;$y_DBinfo_minSize;$y_DBinfo_recordCount;$y_DBinfo_TableIds;$y_DBinfo_TableNames;$y_DBinfo_tableSize;$y_TablePointer)
C_REAL:C285($r_average;$r_totalSize;$r_tasaEjecucion)
C_TEXT:C284($t_mensajeProgreso;$t_NombreCliente;$t_tableName;$t_tableNameVirtual)

C_TEXT:C284($1)
C_LONGINT:C283($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)
C_POINTER:C301($7)
C_POINTER:C301($8)
C_POINTER:C301($9)
C_POINTER:C301($10)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_estadisticasDetalladas)
C_LONGINT:C283($i;$ii;$l_error;$l_IdProcesoProgresoServer;$l_indexCliente;$l_maxSize;$l_milliseconds;$l_minSize;$l_numeroDeRegistros;$l_numeroDeTablas)
C_LONGINT:C283($l_objectSize;$l_procesoProgresoCliente;$l_tableNum)
C_POINTER:C301($y_DBinfo_avgRecordSize;$y_DBinfo_fragmentation;$y_DBinfo_maxSize;$y_DBinfo_minSize;$y_DBinfo_recordCount;$y_DBinfo_TableIds;$y_DBinfo_TableNames;$y_DBinfo_tableSize;$y_TablePointer)
C_REAL:C285($r_average;$r_tasaEjecucion;$r_totalSize)
C_TEXT:C284($t_mensajeProgreso;$t_mensajeProgreso1;$t_mensajeProgreso2;$t_NombreCliente;$t_retornoCarro;$t_tableName;$t_tableNameVirtual)

ARRAY LONGINT:C221($al_DBinfo_recordCount;0)
ARRAY LONGINT:C221($al_DBinfo_TableIds;0)
ARRAY LONGINT:C221($al_metodos;0)
ARRAY REAL:C219($ar_DBinfo_avgRecordSize;0)
ARRAY REAL:C219($ar_DBinfo_fragmentation;0)
ARRAY REAL:C219($ar_DBinfo_maxSize;0)
ARRAY REAL:C219($ar_DBinfo_minSize;0)
ARRAY REAL:C219($ar_DBinfo_tableSize;0)
ARRAY TEXT:C222($at_Clientes;0)
ARRAY TEXT:C222($at_DBinfo_TableNames;0)



If (False:C215)
	C_TEXT:C284(CIM_GetDatabaseStats ;$1)
	C_LONGINT:C283(CIM_GetDatabaseStats ;$2)
	C_POINTER:C301(CIM_GetDatabaseStats ;$3)
	C_POINTER:C301(CIM_GetDatabaseStats ;$4)
	C_POINTER:C301(CIM_GetDatabaseStats ;$5)
	C_POINTER:C301(CIM_GetDatabaseStats ;$6)
	C_POINTER:C301(CIM_GetDatabaseStats ;$7)
	C_POINTER:C301(CIM_GetDatabaseStats ;$8)
	C_POINTER:C301(CIM_GetDatabaseStats ;$9)
	C_POINTER:C301(CIM_GetDatabaseStats ;$10)
End if 




  // CODIGO
$t_retornoCarro:="\r"
$t_NombreCliente:=$1
$l_procesoProgresoCliente:=$2
$y_DBinfo_TableIds:=$3
$y_DBinfo_TableNames:=$4
$y_DBinfo_recordCount:=$5
$y_DBinfo_fragmentation:=$6
If (Count parameters:C259=10)
	$y_DBinfo_tableSize:=$7
	$y_DBinfo_avgRecordSize:=$8
	$y_DBinfo_maxSize:=$9
	$y_DBinfo_minSize:=$10
	$b_estadisticasDetalladas:=True:C214
	$t_mensajeProgreso1:=__ ("Obteniendo estadísticas detalladas sobre la base de datos...")
Else 
	$t_mensajeProgreso1:=__ ("Obteniendo estadísticas básicas sobre la base de datos...")
End if 


$l_IdProcesoProgresoServer:=IT_Progress (1;0;0;$t_mensajeProgreso1)
$l_numeroDeTablas:=Get last table number:C254
For ($i;1;$l_numeroDeTablas)
	If (Is table number valid:C999($i))
		$l_tableNum:=$i
		$t_tableName:=Table name:C256($i)
		$t_tableNameVirtual:=API Get Virtual Table Name ($i)
		If (($t_tableNameVirtual="") | ($t_tableNameVirtual="zz@"))
			$t_tableNameVirtual:=$t_tableName
		End if 
		APPEND TO ARRAY:C911($at_DBinfo_TableNames;$t_tableNameVirtual)
		APPEND TO ARRAY:C911($al_DBinfo_TableIds;$i)
		APPEND TO ARRAY:C911($al_DBinfo_recordCount;Records in table:C83(Table:C252($i)->))
		APPEND TO ARRAY:C911($ar_DBinfo_fragmentation;Get table fragmentation:C1127(Table:C252($i)->))
		
		$l_milliseconds:=Milliseconds:C459
		If ($b_estadisticasDetalladas)
			  // obtengo estadisticas detalladas
			$y_TablePointer:=Table:C252($l_tableNum)
			$r_totalSize:=0
			$l_minSize:=2*1024*1024*1024
			$l_maxSize:=0
			$l_numeroDeRegistros:=Records in table:C83($y_TablePointer->)
			If ($l_numeroDeRegistros>0)
				$t_mensajeProgreso2:=$t_tableNameVirtual
				  //IT_ProgressOnClient ($t_NombreCliente;$l_procesoProgresoCliente;$i/$l_numeroDeTablas;"";0;$t_mensajeProgreso2)
				ALL RECORDS:C47($y_TablePointer->)
				For ($ii;1;$l_numeroDeRegistros)
					$l_error:=API Record To Blob ($l_tableNum;$x_blob)
					$l_objectSize:=BLOB size:C605($x_blob)
					$r_totalSize:=$r_totalSize+BLOB size:C605($x_blob)
					SET BLOB SIZE:C606($x_blob;0)
					Case of 
						: ($l_objectSize<=$l_minSize)
							$l_minSize:=$l_objectSize
							
						: ($l_objectSize>=$l_maxSize)
							$l_maxSize:=$l_objectSize
					End case 
					
					NEXT RECORD:C51($y_TablePointer->)
					
					If ((Milliseconds:C459-$l_milliseconds)>500)
						$t_mensajeProgreso2:=$t_tableNameVirtual+$t_retornoCarro+String:C10($ii)+" de "+String:C10($l_numeroDeRegistros)+" registros"
						$l_IdProcesoProgresoServer:=IT_Progress (0;$l_IdProcesoProgresoServer;$i/$l_numeroDeTablas;"";$ii/$l_numeroDeRegistros;$t_mensajeProgreso2)
						If ($l_procesoProgresoCliente>0)
							IT_ProgressOnClient ($t_NombreCliente;$l_procesoProgresoCliente;$i/$l_numeroDeTablas;$t_mensajeProgreso1;$ii/$l_numeroDeRegistros;$t_mensajeProgreso2)
						End if 
						$l_milliseconds:=Milliseconds:C459
					End if 
				End for 
			Else 
				$l_minSize:=0
				$r_average:=0
				$l_maxSize:=0
				$r_totalSize:=0
			End if 
			$r_average:=Round:C94($r_totalSize/Records in table:C83($y_TablePointer->);2)
			APPEND TO ARRAY:C911($ar_DBinfo_avgRecordSize;$r_average)
			APPEND TO ARRAY:C911($ar_DBinfo_tableSize;$r_totalSize)
			APPEND TO ARRAY:C911($ar_DBinfo_maxSize;$l_maxSize)
			APPEND TO ARRAY:C911($ar_DBinfo_minSize;$l_minSize)
		Else 
			$l_IdProcesoProgresoServer:=IT_Progress (0;$l_IdProcesoProgresoServer;$i/$l_numeroDeTablas)
			If (($l_procesoProgresoCliente>0) & ($t_NombreCliente#""))
				IT_ProgressOnClient ($t_NombreCliente;$l_procesoProgresoCliente;$i/$l_numeroDeTablas)
			End if 
		End if 
	End if 
End for 
$l_IdProcesoProgresoServer:=IT_Progress (-1;$l_IdProcesoProgresoServer)

COPY ARRAY:C226($al_DBinfo_TableIds;$y_DBinfo_TableIds->)
COPY ARRAY:C226($at_DBinfo_TableNames;$y_DBinfo_TableNames->)
COPY ARRAY:C226($al_DBinfo_recordCount;$y_DBinfo_recordCount->)
COPY ARRAY:C226($ar_DBinfo_fragmentation;$y_DBinfo_fragmentation->)
If (Count parameters:C259=10)
	COPY ARRAY:C226($ar_DBinfo_avgRecordSize;$y_DBinfo_avgRecordSize->)
	COPY ARRAY:C226($ar_DBinfo_tableSize;$y_DBinfo_tableSize->)
	COPY ARRAY:C226($ar_DBinfo_maxSize;$y_DBinfo_maxSize->)
	COPY ARRAY:C226($ar_DBinfo_minSize;$y_DBinfo_minSize->)
End if 

