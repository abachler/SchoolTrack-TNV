//%attributes = {}
  //SRal_LeePromediosGenerales


$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gyear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;False:C215)

vs_PromedioG_Periodo1:=[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96
If ([Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92<rPctMinimum)
	vs_TextColorG_Periodo1:="Red"
Else 
	vs_TextColorG_Periodo1:="Blue"
End if 

vs_PromedioG_Periodo2:=[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125
If ([Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121<rPctMinimum)
	vs_TextColorG_Periodo2:="Red"
Else 
	vs_TextColorG_Periodo2:="Blue"
End if 

vs_PromedioG_Periodo3:=[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154
If ([Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150<rPctMinimum)
	vs_TextColorG_Periodo3:="Red"
Else 
	vs_TextColorG_Periodo3:="Blue"
End if 

vs_PromedioG_Periodo4:=[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183
If ([Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179<rPctMinimum)
	vs_TextColorG_Periodo4:="Red"
Else 
	vs_TextColorG_Periodo4:="Blue"
End if 

vs_PromedioG_Periodo5:=[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212
If ([Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208<rPctMinimum)
	vs_TextColorG_Periodo5:="Red"
Else 
	vs_TextColorG_Periodo5:="Blue"
End if 


vs_PromedioG_Final:=[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14
If ([Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10<rPctMinimum)
	vs_TextColorG_Final:="Red"
Else 
	vs_TextColorG_Final:="Blue"
End if 

vs_NotaFinalG:=[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14
If ([Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10<rPctMinimum)
	vs_TextColorFinalG:="Red"
Else 
	vs_TextColorFinalG:="Blue"
End if 

vs_NotaFinalOficialG:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
If ([Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25<rPctMinimum)
	vs_TextColorFinalOficialG:="Red"
Else 
	vs_TextColorFinalOficialG:="Blue"
End if 

vr_SumaEM:=[Alumnos:2]Chile_SumaNotasEMedia:74
vr_DivisorEM:=[Alumnos:2]Chile_TotalAsignaturasEMedia:75
vr_PromedioEMedia:=[Alumnos:2]Chile_PromedioEMedia:73
vi_PuntajeEM:=[Alumnos:2]Chile_PuntajePromedioEM:92
