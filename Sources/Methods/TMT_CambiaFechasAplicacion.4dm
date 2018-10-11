//%attributes = {}
  // TMT_CambiaFechasAplicacion()
  // Por: Alberto Bachler: 09/06/13, 18:05:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_DATE:C307($2)
C_DATE:C307($3)

C_BOOLEAN:C305($b_accesoEnEscritura)
C_DATE:C307($d_InicioSesiones;$d_TerminoSesiones)
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($i)
C_POINTER:C301($y_recNumAsignaciones_al)

If (False:C215)
	C_LONGINT:C283(TMT_CambiaFechasAplicacion ;$0)
	C_POINTER:C301(TMT_CambiaFechasAplicacion ;$1)
	C_DATE:C307(TMT_CambiaFechasAplicacion ;$2)
	C_DATE:C307(TMT_CambiaFechasAplicacion ;$3)
End if 

$y_recNumAsignaciones_al:=$1

$d_InicioSesiones:=$2
$d_TerminoSesiones:=$3

$b_accesoEnEscritura:=True:C214
For ($i_registros;1;Size of array:C274($y_recNumAsignaciones_al->))
	READ WRITE:C146([TMT_Horario:166])
	$b_accesoEnEscritura:=KRL_GotoRecord (->[TMT_Horario:166];$y_recNumAsignaciones_al->{$i_registros};True:C214)
	If ($b_accesoEnEscritura)
		If ($d_InicioSesiones>[TMT_Horario:166]SesionesDesde:12)
			[TMT_Horario:166]SesionesDesde:12:=$d_InicioSesiones
		End if 
		If ($d_TerminoSesiones<[TMT_Horario:166]SesionesHasta:13)
			[TMT_Horario:166]SesionesHasta:13:=$d_TerminoSesiones
		End if 
		SAVE RECORD:C53([TMT_Horario:166])
	Else 
		$i:=Size of array:C274($y_recNumAsignaciones_al->)
	End if 
End for 
KRL_UnloadReadOnly (->[TMT_Horario:166])
$0:=Num:C11($b_accesoEnEscritura)

