//%attributes = {}
  // Método: EV2_Calcula_PTC
  //
  //
  // creado por Alberto Bachler Klein
  // el 28/02/18, 10:01:38
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_promedioModificado)
C_LONGINT:C283($i_calificaciones;$i_periodos;$l_calificaciones;$l_recNumCalificaciones)
C_REAL:C285($r_nota;$r_puntos;$r_real;$r_sumaNotas;$r_sumaPuntos;$r_sumaReales)


If (False:C215)
	C_BOOLEAN:C305(EV2_Calcula_PTC ;$0)
End if 

For ($i_periodos;1;viSTR_Periodos_NumeroPeriodos)
	For ($i_calificaciones;1;12)
		KRL_GetFieldValueByFieldName ("[Alumnos_Calificaciones]P"+String:C10($i_periodos;"00")+"_Eval"+String:C10($i_calificaciones;"00")+"_Real";->$r_real)
		If ($r_real>=vrNTA_MinimoEscalaReferencia)
			KRL_GetFieldValueByFieldName ("[Alumnos_Calificaciones]P"+String:C10($i_periodos;"00")+"_Eval"+String:C10($i_calificaciones;"00")+"_Nota";->$r_nota)
			KRL_GetFieldValueByFieldName ("[Alumnos_Calificaciones]P"+String:C10($i_periodos;"00")+"_Eval"+String:C10($i_calificaciones;"00")+"_Puntos";->$r_puntos)
			$l_calificaciones:=$l_calificaciones+1
			$r_sumaReales:=$r_sumaReales+$r_real
			$r_sumaNotas:=$r_sumaNotas+$r_nota
			$r_sumaPuntos:=$r_sumaPuntos+$r_puntos
		End if 
	End for 
End for 


If ($l_calificaciones>0)
	  // por ahora truncamos
	[Alumnos_Calificaciones:208]PTC_Real:535:=Trunc:C95($r_sumaReales/$l_calificaciones;11)
	[Alumnos_Calificaciones:208]PTC_Nota:536:=Trunc:C95($r_sumaNotas/$l_calificaciones;iGradesDecPF)
	[Alumnos_Calificaciones:208]PTC_Puntos:537:=Trunc:C95($r_sumaPuntos/$l_calificaciones;iPointsDecPF)
	
	If (False:C215)
		  //si se debe aproximar o truncar según la configuración activar este código de acuerdo a la preferencia 
		If (vi_gTrFAvg=1)
			[Alumnos_Calificaciones:208]PTC_Real:535:=Trunc:C95($r_sumaReales/$l_calificaciones;11)
			[Alumnos_Calificaciones:208]PTC_Nota:536:=Trunc:C95($r_sumaNotas/$l_calificaciones;iGradesDecPF)
			[Alumnos_Calificaciones:208]PTC_Puntos:537:=Trunc:C95($r_sumaPuntos/$l_calificaciones;iPointsDecPF)
		Else 
			[Alumnos_Calificaciones:208]PTC_Real:535:=Round:C94($r_sumaReales/$l_calificaciones;11)
			[Alumnos_Calificaciones:208]PTC_Nota:536:=Round:C94($r_sumaNotas/$l_calificaciones;iGradesDecPF)
			[Alumnos_Calificaciones:208]PTC_Puntos:537:=Round:C94($r_sumaPuntos/$l_calificaciones;iPointsDecPF)
		End if 
	End if 
	
	
	
	Case of 
		: (iEvaluationMode=Notas)
			  //[Alumnos_Calificaciones]PTC_Literal:=String([Alumnos_Calificaciones]PTC_Nota)
			[Alumnos_Calificaciones:208]PTC_Literal:539:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]PTC_Real:535;iEvaluationMode;iGradesDec)  //20180424 ASM Ticket 205331
			[Alumnos_Calificaciones:208]PTC_Simbolos:538:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]PTC_Real:535)
			
		: (iEvaluationMode=Puntos)
			[Alumnos_Calificaciones:208]PTC_Literal:539:=String:C10([Alumnos_Calificaciones:208]PTC_Puntos:537)
			[Alumnos_Calificaciones:208]PTC_Simbolos:538:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]PTC_Real:535)
			
		: (iEvaluationMode=Simbolos)
			[Alumnos_Calificaciones:208]PTC_Simbolos:538:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]PTC_Real:535)
			[Alumnos_Calificaciones:208]PTC_Literal:539:=[Alumnos_Calificaciones:208]PTC_Simbolos:538
			
		: (iEvaluationMode=Porcentaje)
			If (vi_gTrFAvg=1)
				[Alumnos_Calificaciones:208]PTC_Literal:539:=String:C10(Trunc:C95([Alumnos_Calificaciones:208]PTC_Real:535;1))
			Else 
				[Alumnos_Calificaciones:208]PTC_Literal:539:=String:C10(Round:C94([Alumnos_Calificaciones:208]PTC_Real:535;1))
			End if 
			[Alumnos_Calificaciones:208]PTC_Simbolos:538:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]PTC_Real:535)
	End case 
	
	
Else 
	[Alumnos_Calificaciones:208]PTC_Real:535:=-10
	[Alumnos_Calificaciones:208]PTC_Nota:536:=-10
	[Alumnos_Calificaciones:208]PTC_Puntos:537:=-10
	[Alumnos_Calificaciones:208]PTC_Literal:539:=""
	[Alumnos_Calificaciones:208]PTC_Simbolos:538:=""
End if 


$b_promedioModificado:=([Alumnos_Calificaciones:208]PTC_Real:535#Old:C35([Alumnos_Calificaciones:208]PTC_Real:535))\
 | ([Alumnos_Calificaciones:208]PTC_Nota:536#Old:C35([Alumnos_Calificaciones:208]PTC_Nota:536))\
 | ([Alumnos_Calificaciones:208]PTC_Puntos:537#Old:C35([Alumnos_Calificaciones:208]PTC_Puntos:537))\
 | ([Alumnos_Calificaciones:208]PTC_Simbolos:538#Old:C35([Alumnos_Calificaciones:208]PTC_Simbolos:538))\
 | ([Alumnos_Calificaciones:208]PTC_Literal:539#Old:C35([Alumnos_Calificaciones:208]PTC_Literal:539))

$0:=$b_promedioModificado


