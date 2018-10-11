//%attributes = {}
  // XSnota_ObtieneUltimaNota()
  // Por: Alberto Bachler K.: 11-03-15, 17:56:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1;$0)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_POINTER:C301($y_fecha;$y_hora)
C_TEXT:C284($t_fechaHora;$t_llave;$t_nota)

C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_POINTER:C301($y_fecha;$y_hora;$y_usuario)
C_TEXT:C284($t_fechaHora;$t_llave;$t_nota)



If (False:C215)
	C_TEXT:C284(XSnota_ObtieneUltimaNota ;$0)
	C_TEXT:C284(XSnota_ObtieneUltimaNota ;$1)
	C_POINTER:C301(XSnota_ObtieneUltimaNota ;$2)
	C_POINTER:C301(XSnota_ObtieneUltimaNota ;$3)
End if 


$t_llave:=$1

Case of 
	: (Count parameters:C259=4)
		$y_fecha:=$2
		$y_hora:=$3
		$y_usuario:=$4
	: (Count parameters:C259=3)
		$y_fecha:=$2
		$y_hora:=$3
	: (Count parameters:C259=2)
		$y_fecha:=$2
End case 

READ ONLY:C145([xShell_RecordNotes:283])
QUERY:C277([xShell_RecordNotes:283];[xShell_RecordNotes:283]Llave:4=$t_llave)
ORDER BY:C49([xShell_RecordNotes:283];[xShell_RecordNotes:283]DTS:6;<)
REDUCE SELECTION:C351([xShell_RecordNotes:283];1)
If (Records in selection:C76([xShell_RecordNotes:283])=1)
	Case of 
		: (Not:C34(Is nil pointer:C315($y_hora)))
			$t_fechaHora:=DT_FechaISO_a_FechaHora ([xShell_RecordNotes:283]DTS:6;$y_fecha;$y_hora)
		: (Not:C34(Is nil pointer:C315($y_fecha)))
			$t_fechaHora:=DT_FechaISO_a_FechaHora ([xShell_RecordNotes:283]DTS:6;$y_fecha)
	End case 
	
	$t_nota:=[xShell_RecordNotes:283]Anotacion:8
	$0:=$t_nota
End if 

UNLOAD RECORD:C212([xShell_RecordNotes:283])