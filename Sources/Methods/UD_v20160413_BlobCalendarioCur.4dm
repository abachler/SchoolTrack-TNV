//%attributes = {}
  //157386
  //UD_v20160413_BlobCalendarioCur
READ ONLY:C145([Cursos:3])
ALL RECORDS:C47([Cursos:3])
C_LONGINT:C283($i;$l_idTermometro)
ARRAY LONGINT:C221($rn_curso;0)
LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$rn_curso;"")

  //fechas bloqueadas
ARRAY DATE:C224($ad_fechasBloqueadas;0)
ARRAY TEXT:C222($at_fechasBloqueadasMotivo;0)
  //horas bloqueadas
ARRAY DATE:C224($ad_HorasBloqueadasFechas;0)
ARRAY TEXT:C222($at_HorasBloqueadasMotivo;0)
ARRAY LONGINT:C221($al_HoraDesde;0)
ARRAY LONGINT:C221($al_HoraHasta;0)

$l_idTermometro:=IT_Progress (1;0;0;"Configuración de bloqueo de calendario por curso...")
For ($i;1;Size of array:C274($rn_curso))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($rn_curso))
	READ WRITE:C146([Cursos:3])
	GOTO RECORD:C242([Cursos:3];$rn_curso{$i})
	BLOB_Blob2Vars (->[Cursos:3]xCalendario_DiasBloq:48;0;->$ad_fechasBloqueadas)
	AT_DistinctsArrayValues (->$ad_fechasBloqueadas)
	ARRAY TEXT:C222($at_fechasBloqueadasMotivo;Size of array:C274($ad_fechasBloqueadas))
	
	BLOB_Variables2Blob (->[Cursos:3]xCalendario_DiasBloq:48;0;->$ad_fechasBloqueadas;->$at_fechasBloqueadasMotivo;->$ad_HorasBloqueadasFechas;->$at_HorasBloqueadasMotivo;->$al_HoraDesde;->$al_HoraHasta)
	SAVE RECORD:C53([Cursos:3])
	KRL_UnloadReadOnly (->[Cursos:3])
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)