//%attributes = {}
  //AS_UpdateStyleSettings


$newStyle:=$1
If (Count parameters:C259=2)
	$forceUpdate:=$2
Else 
	$forceUpdate:=False:C215
End if 

$wasInReadOnly:=False:C215
If (Read only state:C362([Asignaturas:18]))
	READ WRITE:C146([Asignaturas:18])
	LOAD RECORD:C52([Asignaturas:18])
	$wasInReadOnly:=True:C214
End if 

EVS_ReadStyleData ($newStyle)
[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=$newStyle
[Asignaturas:18]Ingresa_Esfuerzo:40:=(cb_EvaluaEsfuerzo=1)
[Asignaturas:18]Pondera_Esfuerzo:61:=(AT_GetSumArray (->aFactorEsfuerzo)>0)
OBJECT SET VISIBLE:C603([Asignaturas:18]Ingresa_Esfuerzo:40;(cb_EvaluaEsfuerzo=1))
OBJECT SET VISIBLE:C603([Asignaturas:18]Pondera_Esfuerzo:61;(cb_EvaluaEsfuerzo=1))
OBJECT SET ENTERABLE:C238([Asignaturas:18]Pondera_Esfuerzo:61;(AT_GetSumArray (->aFactorEsfuerzo)>0))

If ($forceUpdate)
	Case of 
		: (iResults=1)
			r1:=1
			r2:=0
			r3:=0
			[Asignaturas:18]Resultado_no_calculado:47:=False:C215
		: (iResults=2)
			r1:=0
			r2:=1
			r3:=0
			[Asignaturas:18]Resultado_no_calculado:47:=False:C215
		: (iResults=3)
			[Asignaturas:18]Incide_en_promedio:27:=False:C215
			[Asignaturas:18]Resultado_no_calculado:47:=True:C214
	End case 
End if 

AS_fSave 

If ($wasInReadOnly)
	KRL_ReloadAsReadOnly (->[Asignaturas:18])
End if 

