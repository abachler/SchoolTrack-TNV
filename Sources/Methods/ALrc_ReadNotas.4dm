//%attributes = {}
  // ALrc_ReadNotas()
  // 
  //
  // modificado por: Alberto Bachler Klein: 24-06-16, 17:27:29
  // -----------------------------------------------------------
C_LONGINT:C283($i;$j;$l_idCurso)


AS_InitReport 

vPeriodo:=$1

$recNum:=Record number:C243([Alumnos:2])
ALrc_LoadPercentGrades (vPeriodo;iPrintMode;0;False:C215)
If (r1=1)
	COPY ARRAY:C226(aNtaInternalName;aN0)
Else 
	COPY ARRAY:C226(aNtaAsignatura;aN0)
End if 
GOTO RECORD:C242([Alumnos:2];$recNum)

For ($i;1;Size of array:C274(aN0))
	$el:=Find in array:C230(<>aAsign;aNtaAsignatura{$i})
	If ($el>0)
		aSector{$i}:=String:C10(<>aAsgSectorPosition{$el};"00")+aSector{$i}
	End if 
End for 

sAsignatura:=aHdrs{1}
For ($i;1;12)
	(Get pointer:C304("sp"+String:C10($i)))->:=aHdrs{$i+1}
End for 
spCF:=aHdrs{14}
sAvgP1:=aHdrs{15}
sAvgP2:=aHdrs{16}
sAvgP3:=aHdrs{17}
sAvgP4:=aHdrs{18}
sAvgHdr2:=aHdrs{19}
sAvgHdr3:=aHdrs{20}
sAvgHdr4:=aHdrs{21}
sAvgHdr5:=aHdrs{22}
vi_ColWidth:=20

ARRAY TEXT:C222(aAvgs;0)
ARRAY TEXT:C222(aAvgs;8)

EVS_ReadStyleData ([xxSTR_Niveles:6]EvStyle_interno:33)
READ ONLY:C145([xxSTR_Niveles:6])
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Alumnos:2]nivel_numero:29)
$truncate:=Num:C11([xxSTR_Niveles:6]PromediosGeneralesTruncados:11)


  //Cargo la sintesis anual del curso para leer el promedio del grupo
$l_idCurso:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->[Alumnos:2]curso:20;->[Cursos:3]Numero_del_curso:6)  // MONO TICKET 213203
$key:=String:C10(<>GINSTITUCION)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+[Alumnos_SintesisAnual:210]Curso:7+"."+String:C10(Abs:C99($l_idCurso))  //MONO 184433
QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]LLavePrimaria:6=$key)


If (bAverages=1)
	If (vi_PrintMode>0)
		aAvgs{1}:=_ConvierteEvaluacion ([Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92;[xxSTR_Niveles:6]EvStyle_interno:33)
		aAvgs{2}:=_ConvierteEvaluacion ([Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121;[xxSTR_Niveles:6]EvStyle_interno:33)
		aAvgs{3}:=_ConvierteEvaluacion ([Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150;[xxSTR_Niveles:6]EvStyle_interno:33)
		aAvgs{4}:=_ConvierteEvaluacion ([Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179;[xxSTR_Niveles:6]EvStyle_interno:33)
		aAvgs{5}:=_ConvierteEvaluacion ([Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10;[xxSTR_Niveles:6]EvStyle_interno:33)
		aAvgs{6}:=""
		aAvgs{7}:=_ConvierteEvaluacion ([Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20;[xxSTR_Niveles:6]EvStyle_interno:33)
		aAvgs{8}:=_ConvierteEvaluacion ([Cursos_SintesisAnual:63]PromedioFinal_Real:17;[xxSTR_Niveles:6]EvStyle_interno:33)
	Else 
		aAvgs{1}:=[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96
		aAvgs{2}:=[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125
		aAvgs{3}:=[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154
		aAvgs{4}:=[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183
		aAvgs{5}:=[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14
		aAvgs{6}:=""
		aAvgs{7}:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24
		aAvgs{8}:=[Cursos_SintesisAnual:63]PromedioFinal_Literal:21
	End if 
End if 

If (bGrpArea=1)
	ARRAY TEXT:C222(aSectores;0)
	COPY ARRAY:C226(aSector;aSectores)
	AT_DistinctsArrayValues (->aSectores)
	ARRAY TEXT:C222(aSectorAverages;0)
	ARRAY TEXT:C222(aSectorAverages;Size of array:C274(aSectores))
	$0:=Size of array:C274(aN0)+Size of array:C274(aSectores)+3
Else 
	ARRAY BOOLEAN:C223(aBoolean1;0)
	COPY ARRAY:C226(aElectiva;aBoolean1)
	AT_DistinctsArrayValues (->aBoolean1)
	$0:=Size of array:C274(aN0)+Size of array:C274(aBoolean1)+3
End if 