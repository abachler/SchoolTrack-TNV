//%attributes = {}
  // KRL_RebuildTable()
  //
  //
  // creado por: Alberto Bachler Klein: 24-10-16, 10:29:06
  // -----------------------------------------------------------
C_POINTER:C301($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($b_mostrarError)
C_LONGINT:C283($l_error)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_nombreDocumento;$t_nombreTabla)


If (False:C215)
	C_POINTER:C301(KRL_RebuildTable ;$1)
	C_BOOLEAN:C305(KRL_RebuildTable ;$2)
End if 

$y_tabla:=$1
If (Count parameters:C259=2)
	$b_mostrarError:=$2
End if 

$t_nombreTabla:=Table name:C256($y_tabla)
$t_nombreDocumento:=Temporary folder:C486+"export-"+$t_nombreTabla+".txt"

READ WRITE:C146($y_tabla->)

ALL RECORDS:C47($y_tabla->)
If (Records in selection:C76($y_tabla->)>0)
	$l_error:=IO_ExportRecordsFromOneTable ($y_tabla;$t_nombreDocumento)
	If ($l_error=0)
		READ WRITE:C146($y_tabla->)
		TRUNCATE TABLE:C1051($y_tabla->)
		IO_ImportRecords2OneTable ($y_tabla;$t_nombreDocumento)
		UNLOAD RECORD:C212($y_tabla->)
		LOG_RegisterEvt (__ ("Reconstrucción de la tabla ")+IT_SetTextStyle_Bold (->$t_nombreTabla))
	Else 
		LOG_RegisterEvt (__ ("Un error impidió la reconstrucción de la tabla ")+IT_SetTextStyle_Bold (->$t_nombreTabla)+": "+String:C10($l_error))
		If ($b_mostrarError)
			ModernUI_Notificacion (__ ("Error al reconstruir una tabla");__ ("Un error impidió la reconstrucción de la tabla ")+IT_SetTextStyle_Bold (->$t_nombreTabla)+": "+String:C10($l_error);"OK";"";"";True:C214)
		End if 
	End if 
Else 
	TRUNCATE TABLE:C1051($y_tabla->)  // para eliminar objetos asociados a los datos previamente existentes que pudieran estar dañados
End if 

READ ONLY:C145($y_tabla->)