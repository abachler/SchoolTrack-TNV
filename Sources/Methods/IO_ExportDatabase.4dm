//%attributes = {}
  // IO_ExportDatabase()
  // Por: Alberto Bachler K.: 14-10-14, 19:21:13
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_incluirXShell)
C_LONGINT:C283($i;$l_idProgreso;$l_tablas)
C_POINTER:C301($y_tabla)
C_REAL:C285($r_avance)
C_TEXT:C284($t_rutaArchivo;$t_rutaCarpeta)


If (False:C215)
	C_BOOLEAN:C305(IO_ExportDatabase ;$1)
	C_TEXT:C284(IO_ExportDatabase ;$2)
End if 


If (False:C215)
	C_BOOLEAN:C305(IO_ExportDatabase ;$1)
	C_TEXT:C284(IO_ExportDatabase ;$2)
End if 

$t_rutaCarpeta:=""
$b_incluirXShell:=True:C214
Case of 
	: (Count parameters:C259=2)
		$t_rutaCarpeta:=$2
		$b_incluirXShell:=$1
	: (Count parameters:C259=1)
		$b_incluirXShell:=$1
End case 

EM_ErrorManager ("INSTALL")
EM_ErrorManager ("SetMode";"Log")

If ($t_rutaCarpeta="")
	$t_rutaCarpeta:=SYS_SelectFolder ("Seleccione la carpeta para exportar los datos...")
End if 
If ($t_rutaCarpeta#"")
	SYS_CreatePath ($t_rutaCarpeta)
	$l_tablas:=Get last table number:C254
	$l_idProgreso:=Progress New 
	Progress SET TITLE ($l_idProgreso;"Exportando registros...";-1;"";True:C214)
	For ($i;1;$l_tablas)
		If (Is table number valid:C999($i))
			$r_avance:=$i/$l_tablas
			Progress SET PROGRESS ($l_idProgreso;$r_avance;String:C10($i)+__ (" de ")+String:C10($l_Tablas)+__ (" tablas");True:C214)
			$y_tabla:=Table:C252($i)
			$t_rutaArchivo:=$t_rutaCarpeta+"Tabla"+String:C10(Table:C252($y_tabla))+".txt"
			ALL RECORDS:C47($y_tabla->)
			IO_ExportRecordsFromOneTable ($y_tabla;$t_rutaArchivo)
		End if 
	End for 
	Progress QUIT ($l_idProgreso)
End if 

EM_ErrorManager ("Clear")


