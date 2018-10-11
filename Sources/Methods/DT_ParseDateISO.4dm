//%attributes = {}
  // DT_ParseDateISO()
  // 
  //
  // creado por: Alberto Bachler Klein: 19-08-16, 19:47:11
  // codigo original de Miyako
  // -----------------------------------------------------------

C_TEXT:C284($1;$t_fecha)
C_POINTER:C301($2;$3)
C_BOOLEAN:C305($0)

ASSERT:C1129(Count parameters:C259=3)
ASSERT:C1129(Not:C34(Is nil pointer:C315($2)))
ASSERT:C1129(Not:C34(Is nil pointer:C315($3)))
ASSERT:C1129(Type:C295($2->)=Is date:K8:7)
ASSERT:C1129(Type:C295($3->)=Is time:K8:8)

$t_fecha:=$1

ARRAY LONGINT:C221($al_posicion;0)
ARRAY LONGINT:C221($l_largo;0)

If (Match regex:C1019("(\\d{4})-(\\d{2})-(\\d{2})T(\\d{2}:\\d{2}:\\d{2})(?i:z)";$t_fecha;1;$al_posicion;$l_largo))
	
	C_DATE:C307($d_fecha)
	C_TIME:C306($h_hora)
	
	XML DECODE:C1091($t_fecha;$d_fecha)
	XML DECODE:C1091($t_fecha;$h_hora)
	
	$2->:=$d_fecha
	$3->:=$h_hora
	
	$0:=True:C214
	
End if 