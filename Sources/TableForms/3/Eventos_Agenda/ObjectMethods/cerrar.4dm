  // [Cursos].Eventos_Agenda.Botón2()
  //
  //
  // creado por: Alberto Bachler Klein: 05-08-16, 10:41:30
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_pos)
C_POINTER:C301($y_bloqueosDesde;$y_bloqueosHasta;$y_bloqueosMotivo)

ARRAY DATE:C224($ad_fechasBloqueadas;0)
ARRAY DATE:C224($ad_HorasBloqueadasFechas;0)
ARRAY LONGINT:C221($al_HoraDesde;0)
ARRAY LONGINT:C221($al_HoraHasta;0)
ARRAY LONGINT:C221($DA_Return;0)
ARRAY TEXT:C222($at_fechasBloqueadasMotivo;0)
ARRAY TEXT:C222($at_HorasBloqueadasMotivo;0)

$y_bloqueosMotivo:=OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_Motivo")
$y_bloqueosDesde:=OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_Desde")
$y_bloqueosHasta:=OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_Hasta")

BLOB_Blob2Vars (->[Cursos:3]xCalendario_DiasBloq:48;0;->$ad_fechasBloqueadas;->$at_fechasBloqueadasMotivo;->$ad_HorasBloqueadasFechas;->$at_HorasBloqueadasMotivo;->$al_HoraDesde;->$al_HoraHasta)

$ad_HorasBloqueadasFechas{0}:=vd_fechaBloqueoDia
AT_SearchArray (->$ad_HorasBloqueadasFechas;"=";->$DA_Return)
SORT ARRAY:C229($DA_Return;<)
For ($i;1;Size of array:C274($DA_Return))
	AT_Delete ($DA_Return{$i};1;->$ad_HorasBloqueadasFechas;->$at_HorasBloqueadasMotivo;->$al_HoraDesde;->$al_HoraHasta)
End for 

$l_pos:=Find in array:C230($ad_fechasBloqueadas;vd_fechaBloqueoDia)

If ((OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_DiaBloqueado"))->=1)
	If ($l_pos=-1)
		APPEND TO ARRAY:C911($ad_fechasBloqueadas;vd_fechaBloqueoDia)
		APPEND TO ARRAY:C911($at_fechasBloqueadasMotivo;(OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_MotivoDia"))->)
	Else 
		$at_fechasBloqueadasMotivo{$l_pos}:=(OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_MotivoDia"))->
	End if 
	
Else 
	
	If ($l_pos>0)
		AT_Delete ($l_pos;1;->$ad_fechasBloqueadas;->$at_fechasBloqueadasMotivo)
	End if 
	
	For ($i;1;Size of array:C274($y_bloqueosMotivo->))
		APPEND TO ARRAY:C911($ad_HorasBloqueadasFechas;vd_fechaBloqueoDia)
		APPEND TO ARRAY:C911($at_HorasBloqueadasMotivo;$y_bloqueosMotivo->{$i})
		APPEND TO ARRAY:C911($al_HoraDesde;$y_bloqueosDesde->{$i})
		APPEND TO ARRAY:C911($al_HoraHasta;$y_bloqueosHasta->{$i})
	End for 
	
End if 

BLOB_Variables2Blob (->[Cursos:3]xCalendario_DiasBloq:48;0;->$ad_fechasBloqueadas;->$at_fechasBloqueadasMotivo;->$ad_HorasBloqueadasFechas;->$at_HorasBloqueadasMotivo;->$al_HoraDesde;->$al_HoraHasta)
SAVE RECORD:C53([Cursos:3])

KRL_ReloadAsReadOnly (->[Cursos:3])
CANCEL:C270