//%attributes = {}
  // MPA_AnulaEvaluacionAdquirida
  // Por: Alberto Bachler K.: 18-03-15, 17:47:26
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------

C_LONGINT:C283($i;$l_desdePeriodo;$l_hastaPeriodo;$l_recNumAprendizaje)

$l_recNumAprendizaje:=$1
$l_desdePeriodo:=$2
$l_hastaPeriodo:=$3

KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recNumAprendizaje;True:C214)

For ($i;$l_desdePeriodo;$l_hastaPeriodo)
	If ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? $i)
		Case of 
			: ($i=1)  //MONO 26-07-2018 No estaba el caso del periodo 1
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12:=-10
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=-10
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NivelLogroEnunciado:16:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NivelLogroID:15:=0
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- $i
			: ($i=2)
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=-10
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=-10
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NivelLogroEnunciado:28:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NivelLogroID:27:=0
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- $i
			: ($i=3)
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_fechaRegistro:97:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36:=-10
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=-10
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_NivelLogroEnunciado:40:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_NivelLogroID:39:=0
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- $i
			: ($i=4)
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_fechaRegistro:98:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48:=-10
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47:=-10
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_NivelLogroEnunciado:52:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_NivelLogroID:51:=0
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- $i
			: ($i=5)
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_fechaRegistro:99:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65:=-10
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64:=-10
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_NivelLogroEnunciado:69:=""
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_NivelLogroID:68:=0
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- $i
		End case 
	End if 
End for 


If ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 0)
	[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100:=!00-00-00!
	[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=""
	[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=""
	[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=-10
	[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=-10
	[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84:=""
	[Alumnos_EvaluacionAprendizajes:203]Final_NivelLogroEnunciado:102:=""
	[Alumnos_EvaluacionAprendizajes:203]Final_NivelLogroID:103:=0
	[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 0
End if 
[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=!00-00-00!

SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])

For ($i;$l_desdePeriodo;$l_hastaPeriodo)
	MPA_Calculos (Record number:C243([Alumnos_EvaluacionAprendizajes:203]);$i)
End for 



If (KRL_IsWebProcess )
	KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
End if 

