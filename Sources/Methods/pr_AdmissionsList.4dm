//%attributes = {}
  //pr_AdmissionsList



If (Count parameters:C259=2)
	$t_destinoImpresion:=$1
	$t_formulaNombreDocumento:=$2
End if 

$y_tabla:=->[xShell_Reports:54]


ARRAY LONGINT:C221($aExamsID;0)
ARRAY TEXT:C222($at_conexiones;0)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ADT_Candidatos:49])
READ ONLY:C145([xShell_Reports:54])
vt_headerText:=""



Case of 
	: (vt_PLConfigMessage="Para_examenes")
		$t_nombreFormulario:="PLP_USLetterPortrait"
		QR_AjustesImpresion (Letter_Portrait)
		If (ok=1)
			vt_ReportSubTitle:=""
			vd_currentdate:=Current date:C33(*)
			
			KRL_RelateSelection (->[ADT_Examenes:122]ID:1;->[ADT_Candidatos:49]ID_Exam:29;"")
			If (Records in selection:C76([ADT_Examenes:122])>0)
				If (<>shift)
					ORDER BY:C49([ADT_Examenes:122])
				Else 
					ORDER BY:C49([ADT_Examenes:122];[ADT_Examenes:122]Date_Exam:2;>;[ADT_Examenes:122]Group:6;>;[ADT_Examenes:122]Section:7;>)
				End if 
				ORDER BY:C49([ADT_Examenes:122];[ADT_Examenes:122]Date_Exam:2;>;[ADT_Examenes:122]Group:6;>;[ADT_Examenes:122]Section:7;>)
				SELECTION TO ARRAY:C260([ADT_Examenes:122]ID:1;$aExamsID)
				
				For ($k;1;Size of array:C274($aExamsID))
					QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]ID:1=$aExamsID{$K})
					vt_headerText:="Fecha de examen: "+DT_Date2SpanishString ([ADT_Examenes:122]Date_Exam:2)+"\r"+"Hora del examen: "+String:C10([ADT_Examenes:122]Time_Exam:3;2)+"\r"+[ADT_Examenes:122]Group:6+"-"+[ADT_Examenes:122]Section:7
					QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]ID_Exam:29=$aExamsID{$K})
					
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					SELECTION TO ARRAY:C260([ADT_Candidatos:49]Observaciones_examen:14;aText4;[Alumnos:2];$recNums;[Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos:2]Fecha_de_nacimiento:7;aDate1;[ADT_Candidatos:49]Mellizo_de_otro_postulante:40;aBoolean1)
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					ARRAY TEXT:C222(aText2;Size of array:C274(aText1))
					ARRAY TEXT:C222(aText3;Size of array:C274(aText1))
					For ($i;1;Size of array:C274(aText1))
						GOTO RECORD:C242([Alumnos:2];$recNums{$i})
						QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72)
						SELECTION TO ARRAY:C260([Alumnos_Conexiones:212]Conexion:1;$at_conexiones)
						$connexions:=AT_array2text (->$at_conexiones;"\r")
						aText1{$i}:=aText1{$i}+ST_Boolean2Str (aBoolean1{$i};" *";"")
						aText3{$i}:=ST_ClearExtraCR ($connexions)
						aText2{$i}:=DT_ReturnAge (aDate1{$i})
					End for 
					QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
					
				End for 
			End if 
		End if 
		
	: (vt_PLConfigMessage="por_grupo/@")
		$t_nombreFormulario:="PLP_USLetterPaysage"
		QR_AjustesImpresion (Letter_Paysage)
		If (ok=1)
			ARRAY TEXT:C222(atPST_GroupName;0)
			ARRAY DATE:C224(adPST_FromDate;0)
			ARRAY DATE:C224(adPST_ToDate;0)
			ARRAY INTEGER:C220(aiPST_GroupID;0)
			ARRAY INTEGER:C220(aiPST_Candidates;0)
			ARRAY LONGINT:C221(aiPST_ExamTime;0)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			READ ONLY:C145([XShell_FatObjects:86])
			QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="Postulaciones_Examenes")
			If (Records in selection:C76([XShell_FatObjects:86])=1)
				$size:=BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->iPst_groups;->ipst_Sections;->iPst_maxCandidates;->iPST_DistributeBySex;->atPST_GroupName;->adPST_FromDate;->adPST_ToDate;->aiPST_GroupID;->aiPST_Candidates;->aiPST_ExamTime)
			End if 
			ARRAY TEXT:C222($aSex;3)
			$aSex{1}:="FMujeres"
			$aSex{2}:="MHombres"
			$aSex{3}:=""
			vt_ReportSubTitle:=""
			vd_currentdate:=Current date:C33(*)
			
			ARRAY TEXT:C222($aGroups;0)
			DISTINCT VALUES:C339([ADT_Candidatos:49]Grupo:21;$aGroups)
			
			For ($k;1;Size of array:C274($aGroups))
				$el:=Find in array:C230(atPST_GroupName;$aGroups{$k})
				If ($el>0)
					vt_headerText:=atPST_GroupName{$el}+": "+String:C10(adPST_FromDate{$el};7)+" al "+String:C10(adPST_ToDate{$el};7)
				Else 
				End if 
				For ($sex;1;Size of array:C274($aSex))
					Case of 
						: (vt_PLConfigMessage="por_grupo/puntaje")
							vt_ReportSubTitle:=Substring:C12($aSex{$sex};2)+" (por puntaje)"
						: (vt_PLConfigMessage="por_grupo/alpha")
							vt_ReportSubTitle:=Substring:C12($aSex{$sex};2)+" (por orden alfabético)"
					End case 
					
					QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Grupo:21=$aGroups{$k})
					QUERY SELECTION:C341([ADT_Candidatos:49];[Alumnos:2]Sexo:49=(Substring:C12($aSex{$sex};1;1)))
					$sum:=0
					$div:=0
					If (Records in selection:C76([ADT_Candidatos:49])>0)
						SELECTION TO ARRAY:C260([ADT_Candidatos:49]Puntaje_examen:15;aReal1;[ADT_Candidatos:49]Observaciones_examen:14;aText4;[Alumnos:2];$recNums;[Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos:2]Fecha_de_nacimiento:7;aDate1;[ADT_Candidatos:49]Calificación_entrevista:13;aText5;[ADT_Candidatos:49]Observaciones_inscripción:10;aText6;[ADT_Candidatos:49]Recomendación:9;aText7;[ADT_Candidatos:49]Situación_final:16;aText8;[ADT_Candidatos:49]Mellizo_de_otro_postulante:40;aBoolean1)
						ARRAY TEXT:C222(aText2;Size of array:C274(aText1))
						ARRAY TEXT:C222(aText3;Size of array:C274(aText1))
						For ($i;1;Size of array:C274(aText1))
							GOTO RECORD:C242([Alumnos:2];$recNums{$i})
							QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72)
							SELECTION TO ARRAY:C260([Alumnos_Conexiones:212]Conexion:1;$at_conexiones)
							$connexions:=AT_array2text (->$at_conexiones;"\r")
							
							aText1{$i}:=aText1{$i}+ST_Boolean2Str (aBoolean1{$i};" *";"")
							aText3{$i}:=ST_ClearExtraCR ($connexions)
							aText2{$i}:=DT_ReturnAge (aDate1{$i})
							$sum:=$sum+aReal1{$i}
							$div:=$div+Num:C11(aReal1{$i}>0)
						End for 
						vt_average:=String:C10($sum/$div;<>vsPST_ExamEvalFormat)
						QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
						
						If (OK=0)
							$sex:=4
							$k:=Size of array:C274($aGroups)+1
						End if 
					End if 
				End for 
			End for 
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		End if 
		
		
	: (vt_PLConfigMessage="Nomina/Sexo@")
		$t_nombreFormulario:="PLP_USLetterPaysage"
		QR_AjustesImpresion (Letter_Paysage)
		If (ok=1)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			ARRAY TEXT:C222($aSex;3)
			$aSex{1}:="FMujeres"
			$aSex{2}:="MHombres"
			$aSex{3}:=""
			  //vt_ReportTitle:=◊qrReportTitle
			vt_ReportSubTitle:=""
			vd_currentdate:=Current date:C33(*)
			
			For ($sex;1;Size of array:C274($aSex))
				Case of 
					: (vt_PLConfigMessage="nomina/sexo/puntaje")
						vt_ReportSubTitle:=Substring:C12($aSex{$sex};2)+" (por puntaje)"
					: (vt_PLConfigMessage="nomina/sexo/alpha")
						vt_ReportSubTitle:=Substring:C12($aSex{$sex};2)+" (por orden alfabético)"
				End case 
				
				
				QUERY SELECTION:C341([ADT_Candidatos:49];[Alumnos:2]Sexo:49=(Substring:C12($aSex{$sex};1;1)))
				$sum:=0
				$div:=0
				If (Records in selection:C76([ADT_Candidatos:49])>0)
					SELECTION TO ARRAY:C260([ADT_Candidatos:49]Puntaje_examen:15;aReal1;[ADT_Candidatos:49]Observaciones_examen:14;aText4;[Alumnos:2];$recNums;[Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos:2]Fecha_de_nacimiento:7;aDate1;[ADT_Candidatos:49]Calificación_entrevista:13;aText5;[ADT_Candidatos:49]Observaciones_inscripción:10;aText6;[ADT_Candidatos:49]Recomendación:9;aText7;[ADT_Candidatos:49]Situación_final:16;aText8;[ADT_Candidatos:49]Mellizo_de_otro_postulante:40;aBoolean1)
					ARRAY TEXT:C222(aText2;Size of array:C274(aText1))
					ARRAY TEXT:C222(aText3;Size of array:C274(aText1))
					For ($i;1;Size of array:C274(aText1))
						GOTO RECORD:C242([Alumnos:2];$recNums{$i})
						QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72)
						SELECTION TO ARRAY:C260([Alumnos_Conexiones:212]Conexion:1;$at_conexiones)
						$connexions:=AT_array2text (->$at_conexiones;"\r")
						
						aText1{$i}:=aText1{$i}+ST_Boolean2Str (aBoolean1{$i};" *";"")
						aText3{$i}:=ST_ClearExtraCR ($connexions)
						aText2{$i}:=DT_ReturnAge (aDate1{$i})
						$sum:=$sum+aReal1{$i}
						$div:=$div+Num:C11(aReal1{$i}>0)
					End for 
					vt_average:=String:C10($sum/$div;<>vsPST_ExamEvalFormat)
					QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
					
					If (OK=0)
						$sex:=4
					End if 
				End if 
			End for 
			
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		End if 
		
		
	: (vt_PLConfigMessage="Nomina/@")
		$t_nombreFormulario:="PLP_USLetterPaysage"
		QR_AjustesImpresion (Letter_Paysage)
		If (ok=1)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			vt_ReportSubTitle:=""
			vd_currentdate:=Current date:C33(*)
			$sum:=0
			$div:=0
			If (Records in selection:C76([ADT_Candidatos:49])>0)
				SELECTION TO ARRAY:C260([ADT_Candidatos:49]Puntaje_examen:15;aReal1;[ADT_Candidatos:49]Observaciones_examen:14;aText4;[Alumnos:2];$recNums;[Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos:2]Fecha_de_nacimiento:7;aDate1;[ADT_Candidatos:49]Calificación_entrevista:13;aText5;[ADT_Candidatos:49]Observaciones_inscripción:10;aText6;[ADT_Candidatos:49]Recomendación:9;aText7;[ADT_Candidatos:49]Situación_final:16;aText8;[ADT_Candidatos:49]Mellizo_de_otro_postulante:40;aBoolean1)
				ARRAY TEXT:C222(aText2;Size of array:C274(aText1))
				ARRAY TEXT:C222(aText3;Size of array:C274(aText1))
				For ($i;1;Size of array:C274(aText1))
					GOTO RECORD:C242([Alumnos:2];$recNums{$i})
					QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72)
					SELECTION TO ARRAY:C260([Alumnos_Conexiones:212]Conexion:1;$at_conexiones)
					$connexions:=AT_array2text (->$at_conexiones;"\r")
					
					aText1{$i}:=aText1{$i}+ST_Boolean2Str (aBoolean1{$i};" *";"")
					aText3{$i}:=ST_ClearExtraCR ($connexions)
					aText2{$i}:=DT_ReturnAge (aDate1{$i})
					$sum:=$sum+aReal1{$i}
					$div:=$div+Num:C11(aReal1{$i}>0)
				End for 
				vt_average:=String:C10($sum/$div;<>vsPST_ExamEvalFormat)
				QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
				
			End if 
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		End if 
		
		
	: (vt_PLConfigMessage="Cuadro_examen")
		$t_nombreFormulario:="PLP_USLetterPortrait"
		QR_AjustesImpresion (Letter_Portrait)
		If (ok=1)
			vt_ReportSubTitle:=""
			vd_currentdate:=Current date:C33(*)
			ALL RECORDS:C47([ADT_Examenes:122])
			If (Records in selection:C76([ADT_Examenes:122])>0)
				SELECTION TO ARRAY:C260([ADT_Examenes:122]ID:1;$aIDExam;[ADT_Examenes:122]Date_Exam:2;aDate1;[ADT_Examenes:122]Time_Exam:3;aLong1;[ADT_Examenes:122]Group:6;aText1;[ADT_Examenes:122]Section:7;aText2;[ADT_Examenes:122]Girls:9;aInt1;[ADT_Examenes:122]Boys:10;aInt2;[ADT_Examenes:122]Total:11;aInt3)
				QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
			Else 
				CD_Dlog (0;__ ("No hay examenes agendados"))
			End if 
		End if 
End case 