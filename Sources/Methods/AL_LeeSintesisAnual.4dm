//%attributes = {}
  // Método: AL_LeeSintesisAnual (llave:T ; campo:Y ; valor:Y {;recargarRegistro:B})
  //
  //
  // por Alberto Bachler Klein
  // creación 18/05/17, 16:33:44
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_BOOLEAN:C305($4)

C_BOOLEAN:C305($b_recargarRegisto)
C_LONGINT:C283($l_año;$l_idAlumno;$l_institucion;$l_nivel;$l_recNum)
C_POINTER:C301($y_campo;$y_valor)
C_TEXT:C284($t_llave)


If (False:C215)
	C_TEXT:C284(AL_LeeSintesisAnual ;$1)
	C_POINTER:C301(AL_LeeSintesisAnual ;$2)
	C_POINTER:C301(AL_LeeSintesisAnual ;$3)
	C_BOOLEAN:C305(AL_LeeSintesisAnual ;$4)
End if 

$t_llave:=$1
$y_campo:=$2
$y_valor:=$3
$b_recargarRegisto:=False:C215

If (Count parameters:C259=4)
	$b_recargarRegisto:=$4
End if 

$l_institucion:=Num:C11(ST_GetWord ($t_llave;1;"."))
$l_año:=Num:C11(ST_GetWord ($t_llave;2;"."))
$l_nivel:=Num:C11(ST_GetWord ($t_llave;3;"."))
$l_idAlumno:=Num:C11(ST_GetWord ($t_llave;4;"."))

$l_año:=Choose:C955($l_año=0;<>gYear;$l_año)
$l_Nivel:=Choose:C955($l_Nivel=0;[Alumnos:2]nivel_numero:29;$l_Nivel)


  //CUERPO
If ($b_recargarRegisto)
	UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
End if 

If (($l_nivel>Nivel_AdmisionDirecta) & ($l_nivel<Nivel_Egresados))
	$l_recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llave;False:C215)
	If ($l_recNum<0)
		AL_CreaRegistrosSintesis ($l_idAlumno;$l_año;$l_nivel;$l_institucion)
	End if 
	
	$y_valor->:=$y_campo->
End if 
