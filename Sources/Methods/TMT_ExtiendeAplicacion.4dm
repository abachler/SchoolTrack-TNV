//%attributes = {}
  // TMT_ExtiendeAplicacion()
  // Por: Alberto Bachler: 07/06/13, 10:11:01
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_DATE:C307($2)
C_DATE:C307($3)

C_DATE:C307($d_inicioSesiones;$d_terminoSesiones)
C_LONGINT:C283($l_IdAsignatura;$l_recNumAsignacion)

If (False:C215)
	C_LONGINT:C283(TMT_ExtiendeAplicacion ;$1)
	C_DATE:C307(TMT_ExtiendeAplicacion ;$2)
	C_DATE:C307(TMT_ExtiendeAplicacion ;$3)
End if 

$l_recNumAsignacion:=$1
$d_inicioSesiones:=$2
$d_terminoSesiones:=$3
KRL_GotoRecord (->[TMT_Horario:166];$l_recNumAsignacion;True:C214)
$l_IdAsignatura:=[TMT_Horario:166]ID_Asignatura:5

PERIODOS_LoadData ([TMT_Horario:166]Nivel:10)
If ($d_inicioSesiones=!00-00-00!)
	$d_inicioSesiones:=vdSTR_Periodos_InicioEjercicio
End if 
If ($d_terminoSesiones=!00-00-00!)
	$d_terminoSesiones:=vdSTR_Periodos_FinEjercicio
End if 

[TMT_Horario:166]SesionesDesde:12:=$d_inicioSesiones
[TMT_Horario:166]SesionesHasta:13:=$d_terminoSesiones
SAVE RECORD:C53([TMT_Horario:166])

TMT_CreaSesiones ($l_recNumAsignacion;$d_inicioSesiones;$d_terminoSesiones)
TMT_CuentaHorasClases ($l_IdAsignatura)

