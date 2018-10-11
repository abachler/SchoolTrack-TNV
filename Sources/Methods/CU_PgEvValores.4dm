//%attributes = {}
  //CU_PgEvValores

C_LONGINT:C283($i)
C_BOOLEAN:C305(CUv_mEvVal)
CUv_mEvVal:=False:C215
EV2_InitArrays 
atSTR_Periodos_Nombre:=$1
Case of 
	: (atSTR_Periodos_Nombre=1)
		$rubOfst:=1
	: (atSTR_Periodos_Nombre=2)
		$rubOfst:=7
	: (atSTR_Periodos_Nombre=3)
		$rubOfst:=13
	: (atSTR_Periodos_Nombre=4)
		$rubOfst:=20
	: (atSTR_Periodos_Nombre=5)
		$rubOfst:=28
End case 
ARRAY POINTER:C280(aNtaFldPtr;6)
ARRAY POINTER:C280(aNtaArrPtr;6)
For ($i;1;6)
	aNtaArrPtr{$i}:=Get pointer:C304("aNta"+String:C10($i))
	aNtaFldPtr{$i}:=Field:C253(23;$i+$rubOfst)
End for 
MESSAGES OFF:C175
QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
If (Not:C34(Macintosh option down:C545 | Windows Alt down:C563))
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
End if 
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIds)
For ($i;1;Size of array:C274($aIds))
	$recNum:=Find in field:C653([Alumnos_EvaluacionValorica:23]Alumno_Numero:1;$aIds{$i})
	If ($recNum<0)
		CREATE RECORD:C68([Alumnos_EvaluacionValorica:23])
		[Alumnos_EvaluacionValorica:23]Alumno_Numero:1:=$aIds{$i}
		SAVE RECORD:C53([Alumnos_EvaluacionValorica:23])
		UNLOAD RECORD:C212([Alumnos_EvaluacionValorica:23])
	End if 
End for 

QRY_QueryWithArray (->[Alumnos_EvaluacionValorica:23]Alumno_Numero:1;->$aIds)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([Alumnos_EvaluacionValorica:23];[Alumnos:2]apellidos_y_nombres:40;>)
COPY NAMED SELECTION:C331([Alumnos_EvaluacionValorica:23];"SEL Ntas")
MESSAGES ON:C181
SELECTION TO ARRAY:C260(aNtaFldPtr{1}->;aNtaArrPtr{1}->;aNtaFldPtr{2}->;aNtaArrPtr{2}->;aNtaFldPtr{3}->;aNtaArrPtr{3}->;aNtaFldPtr{4}->;aNtaArrPtr{4}->;aNtaFldPtr{5}->;aNtaArrPtr{5}->;aNtaFldPtr{6}->;aNtaArrPtr{6}->;[Alumnos:2]apellidos_y_nombres:40;aNtaStdNme;[Alumnos:2]curso:20;aNtaCurso)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

xALSet_CU_AreaEvaluacion 
OBJECT SET ENTERABLE:C238(<>sEvalExpl1;False:C215)
OBJECT SET ENTERABLE:C238(<>sEvalExpl;False:C215)
FORM GOTO PAGE:C247(3)
IT_SetButtonState ((USR_checkRights ("M";->[Alumnos_EvaluacionValorica:23])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2);->bBWR_SaveRecord)
MNU_SetMenuItemState ((USR_checkRights ("M";->[Alumnos_EvaluacionValorica:23])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2);1;5)

  //se reestablecen los atributos "cliqueables" o "ingresables" que pueden haber sido modificados en el método del formulario (XX_OnRecordLoad)
BWR_EnableSpecificObjects (->atSTR_Periodos_Nombre)