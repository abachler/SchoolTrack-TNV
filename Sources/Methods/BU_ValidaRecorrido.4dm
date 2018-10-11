//%attributes = {}
  //BU_ValidaRecorrido

C_LONGINT:C283($recs)
C_LONGINT:C283($id)
C_LONGINT:C283($IdRuta)
C_TEXT:C284($vt_SelJornada)
C_LONGINT:C283($vl_selNumDia)
C_TIME:C306($vd_SElHora)
$id:=[BU_Rutas_Recorridos:33]ID_Recorrido:1
$IdRuta:=[BU_Rutas_Recorridos:33]ID_Ruta:2
$vt_SelJornada:=[BU_Rutas_Recorridos:33]Jornada:4
$vl_selNumDia:=[BU_Rutas_Recorridos:33]Dia_Semana_Num:12
$vd_SElHora:=[BU_Rutas_Recorridos:33]Hora:5

SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
SET QUERY LIMIT:C395(1)
QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;$IdRuta;*)
QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Jornada:4;=;$vt_SelJornada;*)
QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Dia_Semana_Num:12;=;$vl_selNumDia;*)
QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Hora:5;=;$vd_SElHora;*)
QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]ID_Recorrido:1#$id)
SET QUERY LIMIT:C395(0)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($recs=1)
	$0:=1
Else 
	If ((vt_SelJornada#$vt_SelJornada) | (vl_selNumDia#$vl_selNumDia) | (vd_SElHora#$vd_SElHora))
		READ ONLY:C145([BU_Viajes:109])
		QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Numero_Recorrido:4;=;$id)
		$recviajes:=Records in selection:C76([BU_Viajes:109])
		If ($recviajes>0)
			$0:=2
		Else 
			$0:=0
		End if 
	Else 
		$0:=0
	End if 
End if 



