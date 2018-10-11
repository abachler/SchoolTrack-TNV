//%attributes = {}
  // prClassAbs()
  //
  //
  // creado por: Alberto Bachler Klein: 31-03-16, 15:11:25
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_DATE:C307($d_fechaInicio;$d_fechaTermino)
C_LONGINT:C283($i)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_formulaNombreDocumento;$t_nombreFormulario;$t_opcion)

ARRAY DATE:C224($ad_fechaInasistencia;0)
ARRAY LONGINT:C221($al_recNums;0)


If (False:C215)
	C_TEXT:C284(prClassAbs ;$1)
	C_TEXT:C284(prClassAbs ;$2)
End if 

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_formulaNombreDocumento:=$2
End if 

$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
$t_nombreFormulario:=[xShell_Reports:54]FormName:17
$t_opcion:=[xShell_Reports:54]SpecialParameter:18

  //$d_fechaInicio:=Current date(*)
$d_fechaInicio:=Current date:C33(*)
OK:=1


PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
ARRAY INTEGER:C220(aInt1;0)
If ($t_opcion="diario")
	$d_fechaInicio:=DT_PopCalendar 
	KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
	KRL_RelateSelection (->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]numero:1;"")
	QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=$d_fechaInicio)
	
	If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
		CD_Dlog (0;__ ("No hay inasistencias en esta fecha."))
		ok:=0
	End if 
Else 
	STR_BusquedaEspecial (->[Alumnos_Inasistencias:10])
	$d_fechaInicio:=dDate1
	$d_fechaTermino:=dDate2
End if 
If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
	OK:=1
End if 

If (ok=1)
	If ($d_fechaInicio=!00-00-00!)
		CD_Dlog (0;__ ("Fecha incorrecta."))
	Else 
		If (<>shift)
			ORDER BY:C49([Cursos:3])
		Else 
			ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
		End if 
		
		QR_AjustesImpresion (Letter_Portrait)
		If (ok=1)
			LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_recNums)
			
			
			<>stopExec:=False:C215
			For ($i;1;Size of array:C274($al_recNums))
				KRL_GotoRecord (->[Cursos:3];$al_recNums{$i};False:C215)
				
				RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
				sProf:=[Profesores:4]Apellidos_y_nombres:28
				sCurso:=[Cursos:3]Curso:1
				Case of 
					: ($t_opcion="diario")
						sCount:=String:C10($d_fechaInicio;3)
						sTitle:="Informe Diario de Inasistencia"
						QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
						KRL_RelateSelection (->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]numero:1;"")
						QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=$d_fechaInicio)
						KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
						SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10]Fecha:1;$ad_fechaInasistencia;[Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos_SintesisAnual:210]Inasistencias_Dias:30;aInt1)
						If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
							QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
						End if 
						
						
					Else 
						sCount:=String:C10($d_fechaInicio;1)+" al "+String:C10($d_fechaTermino;1)
						sTitle:="Informe de Inasitencia"
						QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
						KRL_RelateSelection (->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]numero:1)
						Case of 
							: (bAll=1)
							: (bSearch=1)
								QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1>=$d_fechaInicio;*)
								QUERY SELECTION:C341([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1<=$d_fechaTermino;*)
								Case of 
									: (r1=1)
										QUERY SELECTION:C341([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Justificación:2#"")
										scount:=scount+" (justificadas)"
									: (r2=1)
										QUERY SELECTION:C341([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Justificación:2="")
										scount:=scount+" (injustificadas)"
									: (r3=1)
										QUERY SELECTION:C341([Alumnos_Inasistencias:10])
								End case 
						End case 
						KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
						If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
							SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10]Fecha:1;adate1;[Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos_SintesisAnual:210]Inasistencias_Dias:30;aInt1)
							QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
						End if 
				End case 
				
				If (<>stopExec)
					$i:=Size of array:C274($al_recNums)
				End if 
			End for 
		End if 
		
	End if 
End if 



