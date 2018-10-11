//%attributes = {}
  //dbu_VerificaPromediosActa

C_LONGINT:C283($0)
C_BLOB:C604($blob;$1)
C_BOOLEAN:C305($DisplayDialog;$2)
$0:=1

ARRAY LONGINT:C221($aRecNums;0)
Case of 
	: (Count parameters:C259=2)
		$blob:=$1
		$DisplayDialog:=$2
	: (Count parameters:C259=1)
		$blob:=$1
	Else 
		ARRAY LONGINT:C221($aRecNums;0)
		$DisplayDialog:=True:C214
End case 

If (BLOB size:C605($blob)>0)
	BLOB TO VARIABLE:C533($blob;$aRecNums)
End if 

If (Size of array:C274($ARECNUMS)=0)  //query student and initialize arrays only if the method was called from menus
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=1;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=12)
	ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
	SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
	ARRAY TEXT:C222(aText1;0)  //student Class
	ARRAY TEXT:C222(aText2;0)  //student Names
	ARRAY TEXT:C222(aText3;0)  //promedio SchoolTrack
	ARRAY TEXT:C222(aText4;0)  //promedio acta
	ARRAY TEXT:C222(aText5;0)
End if 

$insertAt:=0

CREATE EMPTY SET:C140([Alumnos:2];"erroresActa")
_O_C_INTEGER:C282($niv_act)
$niv_act:=-999
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando promedios en actas..."))
For ($students;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Alumnos:2];$aRecNums{$students})
	READ ONLY:C145([xxSTR_Niveles:6])
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Alumnos:2]nivel_numero:29)
	If (Not:C34([xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
		$averageSchoolTrack:=Num:C11(Replace string:C233([Alumnos:2]Promedio_General_Oficial:32;<>vs_AppDecimalSeparator;<>tXS_RS_DecimalSeparator))
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incluida_en_Actas:44=True:C214;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & ;[Asignaturas:18]Es_Optativa:70=False:C215;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & ;[Asignaturas:18]Incide_en_promedio:27=True:C214)  // MONO: Agrego la condición para filtrar calificaciones oficiales que utiliza el método AL_CalculaPromediosGenerales
		
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$aNotas;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$aReal;[Asignaturas:18]Asignatura:3;$aAsignatura)
		
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		GOTO RECORD:C242([Alumnos:2];$aRecNums{$students})
		
		$sum:=0
		$div:=0
		For ($notas;1;Size of array:C274($aNotas))
			Case of 
				: ($aNotas{$notas}="ERR")
				: ($aNotas{$notas}=">>>")
				: ($aNotas{$notas}="*")
				: ($aNotas{$notas}="X")
				: ($aNotas{$notas}="P")
				: ($aNotas{$notas}="NE")
				Else 
					$num:=Num:C11(Replace string:C233($aNotas{$notas};<>vs_AppDecimalSeparator;<>tXS_RS_DecimalSeparator))
					If ($num>0)
						$sum:=$sum+$Num
						$div:=$div+1
					End if 
			End case 
		End for 
		If ($niv_act#[xxSTR_Niveles:6]NoNivel:5)
			$niv_act:=[xxSTR_Niveles:6]NoNivel:5
			EVS_ReadStyleData ([xxSTR_Niveles:6]EvStyle_oficial:23)
		End if 
		If (($sum#0) & ($div#0))
			  //$average:=Round($sum/$div;1)
			$average:=Round:C94($sum/$div;iGradesDec)
			If ($average#$averageSchoolTrack)
				$vr_mediaReal:=Round:C94(AT_Mean (->$aReal;1);11)
				  //$average:=EV2_Real_a_Nota ($vr_mediaReal;0)
				  //20141105 ASM. la agregué el tercer parametro al método, porque siempre se estaba aproximando a cero decimal. Esto producía que el promedio ST no fueran igual al calculado.
				$average:=EV2_Real_a_Nota ($vr_mediaReal;0;iGradesDecNO)
				If ($average#$averageSchoolTrack)
					$insertAt:=$insertAt+1
					AT_Insert ($insertAt;1;->aText1;->aText2;->aText3;->aText4;->aText5)
					aText1{$insertAt}:=[Alumnos:2]curso:20
					aText2{$insertAt}:=[Alumnos:2]apellidos_y_nombres:40
					aText3{$insertAt}:=[Alumnos:2]Promedio_General_Oficial:32
					aText4{$insertAt}:=String:C10($average;"0,0")
					aText5{$insertAt}:=[Alumnos:2]Nombre_oficial:48
					ADD TO SET:C119([Alumnos:2];"erroresActa")
				End if 
			End if 
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$students/Size of array:C274($aRecNums))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)



If ($insertAt>0)
	$0:=-1
	USE SET:C118("erroresActa")
	If ($DisplayDialog)  //ask for printing only if the method was called from menus
		$msg:=__ ("Se detectaron inconsistencias entre los promedios generales calculados por SchoolTrack y el promedio que arrojan las asignaturas que figuran en el acta.")+"\r"
		$msg:=$msg+__ ("Las actas con errores no serán impresas.")+"\r\r"
		$msg:=$msg+__ ("Generalmente estos errores se producen por una inconsistencia entre las asignaturas configuradas para ser imprimidas en el acta y su caracter de promediable.")+"\r\r"
		$msg:=$msg+__ ("Para localizar y resolver estos errores utilice, desde Asignaturas, las consultas predefinidas siguientes.")+"\r"
		$msg:=$msg+__ ("- Asignaturas en Actas, NO Promediables y NO Optativas")+"\r"
		$msg:=$msg+__ ("- Asignaturas promediables NO incluidas en actas")
		$r:=CD_Dlog (0;$msg)
	End if 
Else 
	If ($DisplayDialog)
		$r:=CD_Dlog (0;__ ("No se detectó ningún error en los promedios generales de los alumnos\r (los niveles con promedios generales truncados no son verificados)."))
	End if 
End if 

CLEAR SET:C117("erroresActa")

