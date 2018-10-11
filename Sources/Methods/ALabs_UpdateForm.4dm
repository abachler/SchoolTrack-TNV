//%attributes = {}
  // ALabs_UpdateForm()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 04/01/13, 11:12:20
  // ---------------------------------------------
C_BOOLEAN:C305($b_sesionImpartida)
_O_C_INTEGER:C282($i;$i_alumnos;$i_ausentes;$i_filas;$i_horas)
C_LONGINT:C283($l_abajo;$l_anchoColumna1;$l_anchoColumnas;$l_anchoDisponible;$l_arriba;$l_columna;$l_columnasHoras;$l_columnasOcultas;$l_derecha;$l_elemento)
C_LONGINT:C283($l_expansionColumna1;$l_idSesion;$l_indiceSesion;$l_izquierda;$l_numeroDeFilas;$l_posicionInasistente;$l_primeraHora;$l_ultimaHora)
C_POINTER:C301($y_ColumnaHora)

ARRAY INTEGER:C220($ai_horas;0)
ARRAY INTEGER:C220($al2D_CoordenadasCeldas;2;0)
ARRAY INTEGER:C220($ai_HoraInasistencia;0)
ARRAY INTEGER:C220($al_horasEnHorario;0)
ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY LONGINT:C221($al_IdSesiones;0)
ARRAY TEXT:C222($aJustificacion;0)


xALSet_STR_InasistenciaSesiones 
For ($i;1;Size of array:C274(aiSTR_Horario_HoraNo))
	If (alSTR_Horario_RefTipoHora{$i}=1)
		APPEND TO ARRAY:C911($al_horasEnHorario;aiSTR_Horario_HoraNo{$i})
	End if 
End for 
$l_horasValidas:=Size of array:C274($al_horasEnHorario)


AL_SetSort (xALP_Subsectores;7;2)
ARRAY INTEGER:C220($al2D_CoordenadasCeldas;2;0)
For ($i;1;Size of array:C274(atSTK_Subsectores))
	If (aImpartida{$i})
		AL_SetCellColor (xALP_Subsectores;1;$i;3;$i;$al2D_CoordenadasCeldas;"";16;"";0)
	Else 
		AL_SetCellColor (xALP_Subsectores;1;$i;3;$i;$al2D_CoordenadasCeldas;"";15;"";0)
	End if 
	If (ab_InasistenciaTomada{$i})
		AL_SetRowStyle (xALP_Subsectores;$i;Bold:K14:2)
	Else 
		AL_SetRowStyle (xALP_Subsectores;$i;Plain:K14:1)
	End if 
End for 
AL_UpdateArrays (xALP_Subsectores;-2)

  //AL_SetSort (xALP_Inasistencias;1)
ALP_SetAlternateLigneColor (xALP_Inasistencias;Size of array:C274(alSTK_StudentIDs))
AL_UpdateArrays (xALP_Inasistencias;-2)


COPY ARRAY:C226(alSTK_SesionID;aLong1)
QRY_QueryWithArray (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->aLong1)
SET FIELD RELATION:C919([Asignaturas_Inasistencias:125]ID_Sesión:1;Automatic:K51:4;Structure configuration:K51:2)
SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Sesión:1;$al_IdSesiones;[Asignaturas_Inasistencias:125]ID_Alumno:2;$al_IdAlumnos;[Asignaturas_Inasistencias:125]Justificacion:3;$aJustificacion;[Asignaturas_RegistroSesiones:168]Hora:4;$ai_HoraInasistencia)
SET FIELD RELATION:C919([Asignaturas_Inasistencias:125]ID_Sesión:1;Structure configuration:K51:2;Structure configuration:K51:2)
SORT ARRAY:C229($al_IdAlumnos;$al_IdSesiones;$aJustificacion;$ai_HoraInasistencia;>)

$l_numeroDeFilas:=Size of array:C274(alSTK_StudentIDs)
$l_primeraHora:=1
For ($i_horas;1;Size of array:C274($al_horasEnHorario))
	$l_columna:=$i_horas+1
	
	$y_ColumnaHora:=Get pointer:C304("alSTK_Hora"+String:C10($i_horas))
	For ($i_filas;1;$l_numeroDeFilas)
		$l_idSesion:=$y_ColumnaHora->{$i_filas}
		If ($l_idSesion#0)
			$l_indiceSesion:=Find in array:C230(alSTK_SesionID;Abs:C99($l_IdSesion))
			$b_sesionImpartida:=aImpartida{$l_indiceSesion}
		End if 
		Case of 
			: ($l_idSesion=0)
				AL_SetCellColor (xALP_Inasistencias;$l_columna;$i_filas;$l_columna;$i_filas;$al2D_CoordenadasCeldas;"";1;"";1)
			: (Not:C34($b_sesionImpartida))
				AL_SetCellColor (xALP_Inasistencias;$l_columna;$i_filas;$l_columna;$i_filas;$al2D_CoordenadasCeldas;"";13;"";13)
			: ($l_idSesion<0)
				AL_SetCellColor (xALP_Inasistencias;$l_columna;$i_filas;$l_columna;$i_filas;$al2D_CoordenadasCeldas;"";3;"";3)
			: ($l_idSesion>0)
				AL_SetCellColor (xALP_Inasistencias;$l_columna;$i_filas;$l_columna;$i_filas;$al2D_CoordenadasCeldas;"";11*16+2;"";11*16+2)
		End case 
	End for 
End for 





For ($i_alumnos;1;Size of array:C274(alSTK_StudentIDs))
	$l_columnasHoras:=aiSTK_Hora{Size of array:C274(aiSTK_Hora)}+1
	If ((adSTK_FechaIngreso{$i_Alumnos}>dFrom) | ((adSTK_FechaRetiro{$i_Alumnos}<=dFrom) & (adSTK_FechaRetiro{$i_Alumnos}>!00-00-00!)))
		AL_SetCellColor (xALP_Inasistencias;2;$i_alumnos;$l_columnasHoras;$i_alumnos;$al2D_CoordenadasCeldas;"";1;"";1)
	End if 
End for 

For ($i_ausentes;1;Size of array:C274($al_IdAlumnos))
	$l_posicionInasistente:=Find in array:C230(alSTK_StudentIDs;$al_IdAlumnos{$i_ausentes})
	If ($l_posicionInasistente>0)
		$l_columnaHora:=Find in array:C230($al_horasEnHorario;$ai_HoraInasistencia{$i_ausentes})
		If ($l_columnaHora#-1)
			$y_ColumnaHora:=Get pointer:C304("alSTK_Hora"+String:C10($l_columnaHora))
			$y_ColumnaHora->{$l_posicionInasistente}:=-Abs:C99($y_ColumnaHora->{$l_posicionInasistente})
			$l_columna:=$l_columnaHora+1
			If ($aJustificacion{$i_ausentes}#"")
				AL_SetCellColor (xALP_Inasistencias;$l_columna;$l_posicionInasistente;$l_columna;$l_posicionInasistente;$al2D_CoordenadasCeldas;"";3;"";3)
			Else 
				AL_SetCellColor (xALP_Inasistencias;$l_columna;$l_posicionInasistente;$l_columna;$l_posicionInasistente;$al2D_CoordenadasCeldas;"";4;"";4)
			End if 
		End if 
	End if 
End for 



For ($i;2;18)
	AL_SetFormat (xALP_Inasistencias;$i;"          ";0;0;0;0)
End for 



vl_anchoColumna1:=0
$l_anchoColumna1:=220
ARRAY TEXT:C222($at_arreglosEnColumnas;0)
AL_GetArrayNames (xALP_Inasistencias;$at_arreglosEnColumnas;0)
$l_columnasHora:=Size of array:C274($at_arreglosEnColumnas)-1
OBJECT GET COORDINATES:C663(xALP_Inasistencias;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
$l_anchoDisponible:=($l_derecha-$l_izquierda+1)-16-$l_anchoColumna1
$l_anchoColumnas:=Trunc:C95($l_anchoDisponible/$l_columnasHora;0)
$l_expansionColumna1:=$l_anchoDisponible-($l_anchoColumnas*$l_columnasHora)
AL_SetWidths (xALP_Inasistencias;1;1;$l_anchoColumna1+$l_expansionColumna1)
For ($i_horas;1;$l_columnasHora)
	$l_columna:=$i_horas+1
	AL_SetWidths (xALP_Inasistencias;$l_columna;1;$l_anchoColumnas)
End for 
AL_SetColOpts (xALP_Inasistencias;1;1;1;3;0)

AL_UpdateArrays (xALP_Inasistencias;-2)



$l_elemento:=Find in array:C230(<>aCursos;vs_SelectedClass)
If ($l_elemento>0)
	<>aCursos:=$l_elemento
End if 

GOTO OBJECT:C206(xALP_Inasistencias)

  //End if 