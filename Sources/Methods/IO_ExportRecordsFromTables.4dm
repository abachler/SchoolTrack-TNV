//%attributes = {}
  // IO_ExportRecordsFromTables()
  // Por: Alberto Bachler K.: 23-07-14, 13:03:06
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($b_usarSeleccionActual)
C_LONGINT:C283($i;$j;$l_numeroTabla;$l_registros;$l_tablas_a_exportar)
C_POINTER:C301($y_arregloTablas;$y_tabla)
C_TEXT:C284($t_nombreTabla;$t_rutaDocumento)


If (False:C215)
	C_POINTER:C301(IO_ExportRecordsFromTables ;$1)
	C_TEXT:C284(IO_ExportRecordsFromTables ;$2)
	C_BOOLEAN:C305(IO_ExportRecordsFromTables ;$3)
End if 

$y_arregloTablas:=$1


Case of 
	: (Count parameters:C259=3)
		$b_usarSeleccionActual:=$3
		$t_rutaDocumento:=$2
	: (Count parameters:C259=2)
		$t_rutaDocumento:=$2
End case 


  //MAIN CODE
SET CHANNEL:C77(12;$t_rutaDocumento)
If (ok=1)
	$l_tablas_a_exportar:=Size of array:C274($y_arregloTablas->)
	SEND VARIABLE:C80($l_tablas_a_exportar)
	For ($j;1;$l_tablas_a_exportar)
		$y_tabla:=$y_arregloTablas->{$j}
		If (Not:C34($b_usarSeleccionActual))
			ALL RECORDS:C47($y_tabla->)
		End if 
		FIRST RECORD:C50($y_tabla->)
		If (ok=1)
			$l_registros:=Records in selection:C76($y_tabla->)
			$t_nombreTabla:=Table name:C256($y_tabla)
			$l_numeroTabla:=Table:C252($y_tabla)
			SEND VARIABLE:C80($l_numeroTabla)
			SEND VARIABLE:C80($t_nombreTabla)
			SEND VARIABLE:C80($l_registros)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Exportando registros del archivo ")+$t_nombreTabla)
			For ($i;1;$l_registros)
				SEND RECORD:C78($y_tabla->)
				NEXT RECORD:C51($y_tabla->)
				If (Dec:C9($i/50)=0)
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$l_registros)
				End if 
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
	End for 
	SET CHANNEL:C77(11)
End if 

