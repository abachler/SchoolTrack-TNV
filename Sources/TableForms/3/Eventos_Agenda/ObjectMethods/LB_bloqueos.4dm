  // [Cursos].Eventos_Agenda.LB_CurEvtHoraBlock()
  //
  //
  // creado por: Alberto Bachler Klein: 04-08-16, 19:44:14
  // -----------------------------------------------------------
C_LONGINT:C283($l_accion;$l_columna;$l_fila)
C_POINTER:C301($y_bloqueosDesde;$y_bloqueosHasta;$y_bloqueosMotivo)

$y_bloqueosMotivo:=OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_Motivo")
$y_bloqueosDesde:=OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_Desde")
$y_bloqueosHasta:=OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_Hasta")
$y_bloqueoActivo:=OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_DiaBloqueado")  //20170630 ASM 

LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087(Object current:K67:2);$l_columna;$l_fila)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		If ((Contextual click:C713) & ($y_bloqueoActivo->=0))
			Case of 
				: ((<>viSTR_puedeBloquearDiasCalendar=1) | (([Cursos:3]Numero_del_profesor_jefe:2=<>lUSR_RelatedTableUserID) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001))))
					If ($l_fila>0)
						$l_accion:=Pop up menu:C542(__ ("Añadir un intervalo de bloqueo en esta fecha;Eliminar el bloqueo"))
					Else 
						$l_accion:=Pop up menu:C542(__ ("Añadir un intervalo de bloqueo en esta fecha;(Eliminar el bloqueo"))
					End if 
				Else 
					$l_accion:=Pop up menu:C542(__ ("(Añadir un intervalo de bloqueo en esta fecha;(Eliminar el bloqueo"))
			End case 
			
			Case of 
				: ($l_accion=1)
					LISTBOX INSERT ROWS:C913(*;OBJECT Get name:C1087(Object current:K67:2);0)
					EDIT ITEM:C870($y_bloqueosMotivo->;1)
				: ($l_accion=2)
					LISTBOX DELETE ROWS:C914(*;OBJECT Get name:C1087(Object current:K67:2);$l_fila)
			End case 
		End if 
		
	: (Form event:C388=On Data Change:K2:15)
		
		Case of 
			: ($l_columna=1)  //Motivo
				If ($y_bloqueosMotivo->{$l_fila}="")
					$y_bloqueosMotivo->{$l_fila}:=__ ("Motivo")+" "+String:C10($l_fila)
				End if 
				
			: ($l_columna=2)  //Desde
				If (Time:C179(Time string:C180($y_bloqueosDesde->{$l_fila}))>?23:59:59?)
					$y_bloqueosDesde->{$l_fila}:=?23:59:59?+0
				End if 
				If ((Time:C179(Time string:C180($y_bloqueosHasta->{$l_fila}))=?00:00:00?) | ($y_bloqueosHasta->{$l_fila}<$y_bloqueosDesde->{$l_fila}))
					$y_bloqueosHasta->{$l_fila}:=$y_bloqueosDesde->{$l_fila}+1
				End if 
				
			: ($l_columna=3)  //Hasta
				If (Time:C179(Time string:C180($y_bloqueosHasta->{$l_fila}))>?24:00:01?)
					$y_bloqueosHasta->{$l_fila}:=?24:00:00?+0
				End if 
				If ((Time:C179(Time string:C180($y_bloqueosHasta->{$l_fila}))=?00:00:00?) | ($y_bloqueosHasta->{$l_fila}<$y_bloqueosDesde->{$l_fila}))
					$y_bloqueosHasta->{$l_fila}:=$y_bloqueosDesde->{$l_fila}+1
				End if 
				
		End case 
End case 



