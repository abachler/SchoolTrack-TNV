//%attributes = {}
  // AL_EliminaLicencia()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 06/01/13, 10:29:02
  // ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_AusenciasDiariasBloquedas;$l_ausenciasSesionesBloqueadas;$l_recNumLicencia;$l_registroEliminado)

ARRAY TEXT:C222($at_Observaciones;0)
ARRAY TEXT:C222($at_Nul;0)
ARRAY LONGINT:C221($al_Nul;0)

If (False:C215)
	C_LONGINT:C283(AL_EliminaLicencia ;$0)
	C_LONGINT:C283(AL_EliminaLicencia ;$1)
End if 

  // CODIGO
$l_recNumLicencia:=$1
KRL_GotoRecord (->[Alumnos_Licencias:73];$l_recNumLicencia;True:C214)
If (OK=1)
	If (([Alumnos_Licencias:73]Tipo_licencia:4=<>aLicencias{1}) | ([Alumnos_Licencias:73]Tipo_licencia:4=<>aLicencias{2}))
		
		START TRANSACTION:C239
		CREATE EMPTY SET:C140([Alumnos_Inasistencias:10];"lockedSet")
		
		  // eliminación de referencias a las licencias en los registros de inasistencia
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Licencia:5=[Alumnos_Licencias:73]ID:6)
		If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
			SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10]Observaciones:3;$at_Observaciones)
			ARRAY LONGINT:C221($al_Nul;Size of array:C274($at_Observaciones))
			ARRAY TEXT:C222($at_Nul;Size of array:C274($at_Observaciones))
			For ($i;1;Size of array:C274($at_Observaciones))
				$at_Observaciones{$i}:=Replace string:C233($at_Observaciones{$i};[Alumnos_Licencias:73]Observaciones:5;"")
			End for 
			READ WRITE:C146([Alumnos_Inasistencias:10])
			ARRAY TO SELECTION:C261($al_Nul;[Alumnos_Inasistencias:10]Licencia:5;$at_Observaciones;[Alumnos_Inasistencias:10]Observaciones:3;$at_Nul;[Alumnos_Inasistencias:10]Justificación:2)
			$l_AusenciasDiariasBloquedas:=Records in set:C195("lockedSet")
			KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
		End if 
		
		  // eliminación de las referencias a las licencia en los registros de inasistencia a clases
		QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Licencia:9=[Alumnos_Licencias:73]ID:6)
		If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
			SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]Observaciones:5;$at_Observaciones)
			ARRAY LONGINT:C221($al_Nul;Size of array:C274($at_Observaciones))
			ARRAY TEXT:C222($at_Nul;Size of array:C274($at_Observaciones))
			For ($i;1;Size of array:C274($at_Observaciones))
				$at_Observaciones{$i}:=Replace string:C233($at_Observaciones{$i};[Asignaturas_Inasistencias:125]Observaciones:5;"")
			End for 
			READ WRITE:C146([Alumnos_Inasistencias:10])
			ARRAY TO SELECTION:C261($al_Nul;[Asignaturas_Inasistencias:125]ID_Licencia:9;$at_Observaciones;[Asignaturas_Inasistencias:125]Observaciones:5;$at_Nul;[Asignaturas_Inasistencias:125]Justificacion:3)
			$l_ausenciasSesionesBloqueadas:=Records in set:C195("lockedSet")
			KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
		End if 
		
		  // si algun registro de inasistencia diaria o de inasistencia a sesiones no pudo ser eliminado se cancela la transacción y
		  // el registro de licencia no es eliminado
		If (($l_AusenciasDiariasBloquedas+$l_ausenciasSesionesBloqueadas)=0)
			DELETE RECORD:C58([Alumnos_Licencias:73])
			VALIDATE TRANSACTION:C240
			$l_registroEliminado:=1
		Else 
			CANCEL TRANSACTION:C241
			CD_Dlog (0;__ ("No es posible eliminar el registro de Licencia en este momento.\r\rNo fue posible acceder en escritura a algunos registros de inasistiencias diarias o inasistencias a clases."))
		End if 
	Else 
		DELETE RECORD:C58([Alumnos_Licencias:73])
		$l_registroEliminado:=1
	End if 
Else 
	CD_Dlog (0;__ ("No es posible eliminar el registro de Licencia en este momento.\r\rImposible de acceder en escritura al registro."))
End if 
READ ONLY:C145([Alumnos_Licencias:73])

$0:=$l_registroEliminado