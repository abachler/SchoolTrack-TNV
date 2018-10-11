//%attributes = {}
  // IO_ImportRecords2OneTable()
  // Por: Alberto Bachler K.: 23-07-14, 12:55:10
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($i;$l_idProgreso;$l_registros)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_mensaje;$t_nombreTabla;$t_RutaDocumento)



If (False:C215)
	C_POINTER:C301(IO_ImportRecords2OneTable ;$1)
	C_TEXT:C284(IO_ImportRecords2OneTable ;$2)
	C_TEXT:C284(IO_ImportRecords2OneTable ;$3)
End if 

$y_tabla:=$1


$t_RutaDocumento:=""
$t_nombreTabla:=Table name:C256($y_tabla)
If (Count parameters:C259>=2)
	$t_RutaDocumento:=$2
End if 

If (Count parameters:C259=3)
	$t_mensaje:=$3
Else 
	$t_mensaje:="Importando registros en el archivo "+$t_nombreTabla
End if 


SET CHANNEL:C77(10;$t_RutaDocumento)
If (ok=1)
	RECEIVE VARIABLE:C81($t_nombreTabla)
	If ($t_nombreTabla=Table name:C256($y_tabla))
		RECEIVE VARIABLE:C81($l_registros)
		$l_idProgreso:=Progress New 
		Progress SET TITLE ($l_idProgreso;$t_nombreTabla)
		For ($i;1;$l_registros)
			RECEIVE RECORD:C79($y_tabla->)
			SAVE RECORD:C53($y_tabla->)
			If (Dec:C9($i/1000)=0)
				Progress SET PROGRESS ($l_idProgreso;$i/$l_registros;String:C10($i)+" / "+String:C10($l_registros))
			End if 
		End for 
		Progress QUIT ($l_idProgreso)
		KRL_UnloadReadOnly ($y_tabla)
	Else 
		CD_Dlog (0;__ ("Los datos del archivo seleccionado no corresponden al archivo recepcionante"))
	End if 
	SET CHANNEL:C77(11)
End if 

