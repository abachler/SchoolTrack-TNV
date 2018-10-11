//%attributes = {}
  // ASrs_CargaArreglos()
  // Por: Alberto Bachler: 20/05/13, 16:12:49
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($1)

C_BOOLEAN:C305($b_mostrarSesionesAñosAnteriores)
C_DATE:C307($d_fechaSesion)
C_LONGINT:C283($i;$l_IdProfesor;$l_numeroHoras;$l_recNumConInformacion;$l_tamañoArreglos)

ARRAY BOOLEAN:C223($ab_TieneInformacion;0)
ARRAY DATE:C224($ad_FechaSesiones;0)
ARRAY LONGINT:C221($al_IdProfesores;0)
ARRAY LONGINT:C221($al_recNumSesiones;0)
ARRAY TEXT:C222($at_profAs;0)
If (False:C215)
	C_BOOLEAN:C305(ASrs_CargaArreglos ;$1)
End if 

If (Count parameters:C259=1)
	$b_mostrarSesionesAñosAnteriores:=$1
End if 

If ($b_mostrarSesionesAñosAnteriores)
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<vdSTR_Periodos_InicioEjercicio)
	vb_SesionesAñosAnteriores:=True:C214
Else 
	vb_SesionesAñosAnteriores:=False:C215
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=vdSTR_Periodos_InicioEjercicio;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=vdSTR_Periodos_FinEjercicio)
End if 
QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Impartida:5=True:C214)

CREATE SET:C116([Asignaturas_RegistroSesiones:168];"Sesiones")
ORDER BY:C49([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;>;[Asignaturas_RegistroSesiones:168]hasData:8;>;[Asignaturas_RegistroSesiones:168]Hora:4;>)
SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168];$al_recNumSesiones;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;$ad_FechaSesiones;[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10;$al_IdProfesores;[Asignaturas_RegistroSesiones:168]hasData:8;$ab_TieneInformacion)


ARRAY DATE:C224(adSTK_SesionFecha;0)
ARRAY INTEGER:C220(aiSTK_SesionHoras;0)
ARRAY LONGINT:C221(alSTK_SesionRecNum;0)
ARRAY TEXT:C222(atSTK_SesionProf;0)
ARRAY TEXT:C222(atSTK_SesionFecha;0)

$d_fechaSesion:=!00-00-00!
$l_IdProfesor:=0
$l_numeroHoras:=0
$l_tamañoArreglos:=0
$l_recNumConInformacion:=-1
ARRAY LONGINT:C221(al_estilosListasSesiones;0)
  //ARRAY LONGINT(al_estilosListasSesiones;Size of array($ad_FechaSesiones))
For ($i;1;Size of array:C274($ad_FechaSesiones))
	If (($d_fechaSesion=$ad_FechaSesiones{$i}) & ($l_IdProfesor=$al_IdProfesores{$i}))
		$l_numeroHoras:=$l_numeroHoras+1
		aiSTK_SesionHoras{$l_tamañoArreglos}:=$l_numeroHoras
		If ($ab_TieneInformacion{$i})
			alSTK_SesionRecNum{$l_tamañoArreglos}:=$al_recNumSesiones{$i}
			  //al_estilosListasSesiones{$i}:=Bold
		End if 
	Else 
		$l_recNumConInformacion:=-1
		$l_numeroHoras:=1
		$l_tamañoArreglos:=$l_tamañoArreglos+1
		$l_IdProfesor:=$al_IdProfesores{$i}
		$t_profesor:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$l_IdProfesor;->[Profesores:4]Nombre_comun:21)
		If ($l_IdProfesor=0)
			$l_IdProfesor:=[Asignaturas:18]profesor_numero:4
			$t_profesor:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$l_IdProfesor;->[Profesores:4]Nombre_comun:21)
		End if 
		AT_Insert ($l_tamañoArreglos;1;->adSTK_SesionFecha;->atSTK_SesionFecha;->aiSTK_SesionHoras;->alSTK_SesionRecNum;->atSTK_SesionProf)
		adSTK_SesionFecha{$l_tamañoArreglos}:=$ad_FechaSesiones{$i}
		atSTK_SesionFecha{$l_tamañoArreglos}:=DT_Fecha_a_Texto ($ad_FechaSesiones{$i};"Abreviado")
		aiSTK_SesionHoras{$l_tamañoArreglos}:=$l_numeroHoras
		alSTK_SesionRecNum{$l_tamañoArreglos}:=$al_recNumSesiones{$i}
		atSTK_SesionProf{$l_tamañoArreglos}:=$t_profesor
		If ($ab_TieneInformacion{$i})
			$l_recNumConInformacion:=$al_recNumSesiones{$i}
			alSTK_SesionRecNum{$l_tamañoArreglos}:=$al_recNumSesiones{$i}
			  //al_estilosListasSesiones{$i}:=Bold
		End if 
	End if 
	$d_fechaSesion:=$ad_FechaSesiones{$i}
	$l_IdProfesor:=$al_IdProfesores{$i}
End for 

  //20160607 ASM Ticket 156742
ARRAY LONGINT:C221(al_estilosListasSesiones;Size of array:C274(alSTK_SesionRecNum))
For ($i;1;Size of array:C274(alSTK_SesionRecNum))
	KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];alSTK_SesionRecNum{$i};False:C215)
	If ([Asignaturas_RegistroSesiones:168]hasData:8)
		al_estilosListasSesiones{$i}:=Bold:K14:2
	End if 
	
End for 


LISTBOX SORT COLUMNS:C916(lb_sesiones;1;<)
