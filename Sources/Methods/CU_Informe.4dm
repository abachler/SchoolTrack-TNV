//%attributes = {}
  //CU_Informe
  // Modificado por: Saul Ponce (20/06/2016) Ticket N° 151460
  // Los arrays con nombres de los alumnos no se cargaban correctamente
  // Modificado por: Patricio Aliaga (30/05/2016) Ticket N° 182255 
  // Se agrega variable para mostrar % minimo de asistencia para aprobar y filtro para excluir las asignaturas sin profesor asignado

C_LONGINT:C283(vi_StyleType)
ARRAY TEXT:C222(aAbsNames;0)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)

$recNumCurso:=Record number:C243([Cursos:3])
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Preparando la impresión del informe de ")+[Cursos:3]Curso:1+__ ("..."))
  //Asistencia  
USE SET:C118("class")
  //KRL_RelateSelection (->[Alumnos_SintesisAnual];->[Alumnos]Número;"")
KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=<>gYear)
CREATE SET:C116([Alumnos_SintesisAnual:210];"Conducta")
$r_minimoAsistencia_PCT:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]Minimo_asistencia:24)
If ($r_minimoAsistencia_PCT>0)
	minasispct:="Alumnos con asistencia inferior al mínimo autorizado ("+String:C10($r_minimoAsistencia_PCT)+"%): "
Else 
	minasispct:="Alumnos con asistencia inferior al mínimo autorizado (0%): "
End if 

QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33<$r_minimoAsistencia_PCT)
  //SELECTION TO ARRAY([Alumnos_SintesisAnual]Inasistencias_Dias;aInt1;[Alumnos]Apellidos_y_Nombres;aAbsNames;[Alumnos_SintesisAnual]Inasistencias_Horas;$aHorasAusencia;[Alumnos_SintesisAnual]HorasEfectivas;$ahorasReales)
SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]ID_Alumno:4;$id_alumnos;[Alumnos_SintesisAnual:210]Inasistencias_Dias:30;aInt1;[Alumnos_SintesisAnual:210]Inasistencias_Horas:31;$aHorasAusencia;[Alumnos_SintesisAnual:210]HorasEfectivas:32;$ahorasReales)

$z:=1
While ($z<=Size of array:C274($id_alumnos))
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$id_alumnos{$z})
	APPEND TO ARRAY:C911(aAbsNames;[Alumnos:2]apellidos_y_nombres:40)
	$z:=$z+1
End while 


iInasist:=Size of array:C274(aInt1)
ARRAY REAL:C219(aReel1;Size of array:C274(aInt1))
ARRAY REAL:C219(aReel2;Size of array:C274(aInt1))
ARRAY TEXT:C222(aEmptyText;Size of array:C274(aInt1))
PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]AttendanceMode:3)

Case of 
	: (($modoRegistroAsistencia=1) | ($modoRegistroAsistencia=3))
		For ($i;1;Size of array:C274(aAbsNames))
			If (aInt1{$i}>0)
				aReel1{$i}:=Round:C94(viSTR_Calendario_DiasAHoy-aInt1{$i}/viSTR_Calendario_DiasAHoy*100;1)
				aReel2{$i}:=Round:C94(viSTR_Periodos_DiasAgno-aInt1{$i}/viSTR_Periodos_DiasAgno*100;1)
			Else 
				aReel1{$i}:=100
				aReel2{$i}:=100
			End if 
		End for 
	: (($modoRegistroAsistencia=2) | ($modoRegistroAsistencia=4))
		For ($i;1;Size of array:C274(aAbsNames))
			If ($aHorasAusencia{$i}>0)
				aInt1{$i}:=$aHorasReales{$i}
				aReel2{$i}:=Round:C94($aHorasReales{$i}-$aHorasAusencia{$i}/$aHorasReales{$i}*100;1)
				aReel1{$i}:=$aHorasAusencia{$i}
			Else 
				aInt1{$i}:=$aHorasReales{$i}
				aReel2{$i}:=100
				aReel1{$i}:=0
			End if 
		End for 
End case 
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;15)
  //end asistencia

  //Conducta
ARRAY TEXT:C222(aDD;0)
ARRAY INTEGER:C220(aDD1;0)  //anotaciones positivas
ARRAY INTEGER:C220(aDD2;0)  //anotaciones negativas
ARRAY INTEGER:C220(aDD3;0)  //castigos
ARRAY INTEGER:C220(aDD4;0)  //suspensiones
ARRAY TEXT:C222(aDD5;0)  //Condicionalidad
ARRAY TEXT:C222(aPD;0)
ARRAY INTEGER:C220(aPD1;0)  //anotaciones positivas
ARRAY INTEGER:C220(aPD2;0)  //anotaciones negativas
ARRAY INTEGER:C220(aPD3;0)  //castigos
ARRAY INTEGER:C220(aPD4;0)  //suspensiones
ARRAY TEXT:C222(aPD5;0)  //Condicionalidad
USE SET:C118("Conducta")
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
  //SELECTION TO ARRAY([Alumnos_SintesisAnual]Anotaciones_Positivas;$pos;[Alumnos_SintesisAnual]Anotaciones_Negativas;$neg;[Alumnos_SintesisAnual]Castigos;$det;[Alumnos_SintesisAnual]Suspensiones;$susp;[Alumnos_SintesisAnual]Condicionalidad_Hasta;$cond;[Alumnos]Apellidos_y_Nombres;$Name)
SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]Anotaciones_Positivas:34;$pos;[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36;$neg;[Alumnos_SintesisAnual:210]Castigos:43;$det;[Alumnos_SintesisAnual:210]Suspensiones:44;$susp;[Alumnos_SintesisAnual:210]Condicionalidad_Hasta:58;$cond;[Alumnos_SintesisAnual:210]ID_Alumno:4;$id_alumnos)
ARRAY TEXT:C222($Name;0)
$z:=1
While ($z<=Size of array:C274($id_alumnos))
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$id_alumnos{$z})
	APPEND TO ARRAY:C911($Name;[Alumnos:2]apellidos_y_nombres:40)
	$z:=$z+1
End while 


For ($i;1;Size of array:C274($pos))
	If (($neg{$i}>=iNegAnot) | ($det{$i}>=iDet) | ($susp{$i}>=iSusp) | ($Cond{$i}#!00-00-00!))
		AT_Insert (1;1;->aPD;->aPD1;->aPD2;->aPD3;->aPD4;->aPD5)
		aPD{1}:=$Name{$i}
		aPD1{1}:=$pos{$i}
		aPD2{1}:=$neg{$i}
		aPD3{1}:=$det{$i}
		aPD4{1}:=$susp{$i}
		If ($cond{$i}#!00-00-00!)
			aPD5{1}:="Hasta el: "+String:C10($cond{$i};dt_GetNullDateString )
		End if 
	End if 
End for 

For ($i;1;Size of array:C274($pos))
	If ($pos{$i}>=iPosAnot)
		If (bNoPbl=1) & (Find in array:C230(aPD;$Name{$i})>0)
		Else 
			AT_Insert (1;1;->aDD;->aDD1;->aDD2;->aDD3;->aDD4;->aDD5)
			aDD{1}:=$Name{$i}
			aDD1{1}:=$pos{$i}
			aDD2{1}:=$neg{$i}
			aDD3{1}:=$det{$i}
			aDD4{1}:=$susp{$i}
			If ($cond{$i}#!00-00-00!)
				aPD5{1}:="Hasta el: "+String:C10($cond{$i};dt_GetNullDateString )
			End if 
		End if 
	End if 
End for 
  //Conducta
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;30)

  //DISPERSION
USE SET:C118("class")
EV2_Calificaciones_SeleccionAL   //seleccionamos los registros de notas del curso
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)

Case of 
	: (r0_Todas=1)
		
	: (r1_EnPromedioInterno=1)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]IncideEnPromedioInterno:64=True:C214)
		
	: (r2_EnPromedioOficial=1)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incide_en_promedio:27=True:C214)
		
	: (r3_madres=1)
		
		  // Modificado por: Alexis Bustamante (12/09/2016)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Consolidacion_Madre_Id:7=0)
		
End case 

If (vl_sinprofesor=1)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]profesor_nombre:13#"")
End if 


SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
CREATE SET:C116([Alumnos_Calificaciones:208];"notas")

  //verifico que los nombres de asignaturas en los registros de calificaciones sean los correctos
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$aRecNums;"")
$m:=Milliseconds:C459
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Alumnos_Calificaciones:208];$aRecNums{$i})
	RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
	If (([Alumnos_Calificaciones:208]NombreOficialAsignatura:7#[Asignaturas:18]Asignatura:3) | ([Alumnos_Calificaciones:208]NombreInternoAsignatura:8#[Asignaturas:18]denominacion_interna:16))
		KRL_ReloadInReadWriteMode (->[Alumnos_Calificaciones:208])
		[Alumnos_Calificaciones:208]NombreOficialAsignatura:7:=[Asignaturas:18]Asignatura:3
		[Alumnos_Calificaciones:208]NombreInternoAsignatura:8:=[Asignaturas:18]denominacion_interna:16
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
	End if 
End for 
$m:=Milliseconds:C459-$m

GOTO RECORD:C242([Cursos:3];$recNumCurso)
USE SET:C118("Notas")
DISTINCT VALUES:C339([Alumnos_Calificaciones:208]NombreOficialAsignatura:7;aAsig)


$s:=Size of array:C274(aAsig)
ARRAY TEXT:C222(aDisp1;$s)
ARRAY TEXT:C222(aDisp2;$s)
ARRAY TEXT:C222(aDisp3;$s)
ARRAY TEXT:C222(aDisp4;$s)
ARRAY TEXT:C222(aDisp5;$s)
ARRAY TEXT:C222(aDisp6;$s)
ARRAY TEXT:C222(aDisp7;$s)
ARRAY TEXT:C222(aDisp8;$s)
ARRAY TEXT:C222(aPend;$s)
ARRAY TEXT:C222(aExim;$s)
ARRAY TEXT:C222(aNoEval;$s)
ARRAY INTEGER:C220(aTotal;$s)



$estiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]EvStyle_oficial:23)
EVS_ReadStyleData ($estiloEvaluacionOficial)

For ($i;1;$s)
	USE SET:C118("notas")
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NombreOficialAsignatura:7=aAsig{$i})
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$aNota;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$aEvStyleID)
	
	$s2:=Size of array:C274($aNota)
	$d1:=0
	$d2:=0
	$d3:=0
	$d4:=0
	$d5:=0
	$d6:=0
	$d7:=0
	$d8:=0
	$p:=0
	$x:=0
	$noEval:=0
	For ($j;1;$s2)
		Case of 
			: ($aNota{$j}=-2)
				$p:=$p+1
			: ($aNOta{$j}=-3)
				$x:=$x+1
			: ($aNota{$j}=-10)
				$noEval:=$noEval+1
			Else 
				$n:=$aNota{$j}
				Case of 
					: (($n<=arCU_DispersionTo{1}) & (arCU_DispersionTo{1}#0))
						$d1:=$d1+1
					: (($n<=arCU_DispersionTo{2}) & (arCU_DispersionTo{2}#0))
						$d2:=$d2+1
					: (($n<=arCU_DispersionTo{3}) & (arCU_DispersionTo{3}#0))
						$d3:=$d3+1
					: (($n<=arCU_DispersionTo{4}) & (arCU_DispersionTo{4}#0))
						$d4:=$d4+1
					: (($n<=arCU_DispersionTo{5}) & (arCU_DispersionTo{5}#0))
						$d5:=$d5+1
					: (($n<=arCU_DispersionTo{6}) & (arCU_DispersionTo{6}#0))
						$d6:=$d6+1
					: (($n<=arCU_DispersionTo{7}) & (arCU_DispersionTo{7}#0))
						$d7:=$d7+1
					: (($n<=arCU_DispersionTo{8}) & (arCU_DispersionTo{8}#0))
						$d8:=$d8+1
				End case 
		End case 
	End for 
	aDisp1{$i}:=String:C10($d1)
	aDisp2{$i}:=String:C10($d2)
	aDisp3{$i}:=String:C10($d3)
	aDisp4{$i}:=String:C10($d4)
	aDisp5{$i}:=String:C10($d5)
	aDisp6{$i}:=String:C10($d6)
	aDisp7{$i}:=String:C10($d7)
	aDisp8{$i}:=String:C10($d8)
	aPend{$i}:=String:C10($p)
	aExim{$i}:=String:C10($x)
	aNoEval{$i}:=String:C10($noEval)
	aTotal{$i}:=$s2
End for 
  //*********************************************************
  //*********************************************************

$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;60)
  //end dispersion

  //rendimiento
  //*********************************************************
  // INICIO SECCION A REVISAR TENIENDO EN CUENTA EL CAMBIO DE FORMATO DE NOTAS
  //*********************************************************
ARRAY TEXT:C222(aDest;0)
ARRAY TEXT:C222(aAvg;0)
ARRAY REAL:C219(aAvgNota;0)
ARRAY TEXT:C222(aInsuf;0)
ARRAY TEXT:C222(aAsgInsuf;0)
ARRAY TEXT:C222(aAvgInsuf;0)
ARRAY TEXT:C222(aPendStd;0)
ARRAY TEXT:C222(aPendAsg;0)

Case of 
	: (vi_StyleType=1)
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
		$evStyleID:=[xxSTR_Niveles:6]EvStyle_oficial:23
		EVS_ReadStyleData ($evStyleID)
	: (vi_StyleType=2)
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
		$evStyleID:=[xxSTR_Niveles:6]EvStyle_interno:33
		EVS_ReadStyleData ($evStyleID)
End case 

USE SET:C118("class")
For ($i;1;Records in selection:C76([Alumnos:2]))
	USE SET:C118("class")
	GOTO SELECTED RECORD:C245([Alumnos:2];$i)
	
	
	
	
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	Case of 
		: (r0_Todas=1)
			
		: (r1_EnPromedioInterno=1)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]IncideEnPromedioInterno:64=True:C214)
			
		: (r2_EnPromedioOficial=1)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incide_en_promedio:27=True:C214)
		: (r3_madres=1)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Consolidacion_Madre_Id:7=0)
			  // Modificado por: Alexis Bustamante (12/09/2016)
			
	End case 
	
	If (vl_sinprofesor=1)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]profesor_nombre:13#"")
	End if 
	
	
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aRealNtaF;[Asignaturas:18]Incide_en_promedio:27;aInAvg;[Asignaturas:18]Asignatura:3;$asig;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$aEvStyleID)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	
	USE SET:C118("class")
	GOTO SELECTED RECORD:C245([Alumnos:2];$i)
	
	$avg:=0
	$avgLiteral:=""
	$avgnota:=0
	$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
	AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25;->$avg)
	AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29;->$avgLiteral)
	AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26;->$avgnota)
	
	If ($avg>0)
		Case of 
			: ($avg>=rAvgSupPercent)
				$dontInclude:=False:C215
				For ($evals;1;Size of array:C274(aRealNtaF))
					If ((aRealNtaF{$evals}<rAvgMinAsignaturaPercent) & (aRealNtaF{$evals}>=vrNTA_MinimoEscalaReferencia))
						$dontInclude:=True:C214
						$evals:=Size of array:C274(aRealNtaF)+1
					End if 
				End for 
				If (Not:C34($dontInclude))
					AT_Insert (1;1;->aDest;->aAvg;->aAvgNota)
					aDest{1}:=[Alumnos:2]apellidos_y_nombres:40
					aAvg{1}:=$avgLiteral
					aAvgNota{1}:=$avgnota
				End if 
			: (($avg<rAvginfPercent) & ($avg#-10))
				AT_Insert (1;1;->aInsuf;->aAvgInsuf;->aAsgInsuf)
				aInsuf{1}:=[Alumnos:2]apellidos_y_nombres:40
				aAvgInsuf{1}:=$avgLiteral
		End case 
	End if 
	
	
	For ($j;1;Size of array:C274(aRealNtaF))
		  //If (aRealNtaF{$j}>-10)
		  //$Grade:=NTA_PercentValue2StringValue (aRealNtaF{$j};iPrintActa)
		$Grade:=EV2_Real_a_Literal (aRealNtaF{$j};iPrintActa;iGradesDecNO)  //  20121022 ASM. para visualizar correctamente el promedio oficial del alumno.
		Case of 
			: ((aRealNtaF{$j}=-2) | (aRealNtaF{$j}=-10))
				$n:=Find in array:C230(aPendStd;[Alumnos:2]apellidos_y_nombres:40)
				If ($n<0)
					AT_Insert (1;1;->aPendStd;->aPendAsg)
					aPendStd{1}:=[Alumnos:2]apellidos_y_nombres:40
					$n:=1
				End if 
				aPendAsg{$n}:=aPendAsg{$n}+("; "*Num:C11(aPendAsg{$n}#""))+$asig{$j}
			: ((aRealNtaF{$j}=-3) | (aRealNtaF{$j}=-1))
				  //nothing          
			Else 
				If (aRealNtaF{$j}<rAvgMinPercent)
					$n:=Find in array:C230(aInsuf;[Alumnos:2]apellidos_y_nombres:40)
					If ($n<0)
						$n:=1
						AT_Insert (1;1;->aInsuf;->aAvgInsuf;->aAsgInsuf)
						aInsuf{1}:=[Alumnos:2]apellidos_y_nombres:40
						If (Find in array:C230(aRealNtaF;-2)>0)
							aAvgInsuf{1}:="P"
						Else 
							aAvgInsuf{1}:=$avgLiteral
						End if 
					End if 
					aAsgInsuf{$n}:=aAsgInsuf{$n}+("\r"*Num:C11(aAsgInsuf{$n}#""))+$asig{$j}+" : "+$grade
				End if 
		End case 
		  //Else 
		  //
		  //End if 
	End for 
End for 
  //*********************************************************
  //FIN SECCION A REVISAR TENIENDO 
  //*********************************************************
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
  //end rendimiento• 

RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)

