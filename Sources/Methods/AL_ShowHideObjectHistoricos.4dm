//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 03-05-17, 16:33:28
  // ----------------------------------------------------
  // Método: AL_ShowHideObjectHistoricos
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



OBJECT SET VISIBLE:C603(*;"notasHistoricas@";True:C214)

If ([Alumnos_Calificaciones:208]P01_Final_Nota:113=-10)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Nota:113;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Puntos:114;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Simbolo:115;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Real:112;False:C215)
End if 
If ([Alumnos_Calificaciones:208]P02_Final_Nota:188=-10)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Nota:188;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Puntos:189;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Simbolo:190;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Real:187;False:C215)
End if 
If ([Alumnos_Calificaciones:208]P03_Final_Nota:263=-10)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Nota:263;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Puntos:264;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Simbolo:265;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Real:262;False:C215)
End if 
If ([Alumnos_Calificaciones:208]P04_Final_Nota:338=-10)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Nota:338;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Puntos:339;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Simbolo:340;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Real:337;False:C215)
End if 
If ([Alumnos_Calificaciones:208]P05_Final_Nota:413=-10)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Nota:413;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Puntos:414;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Simbolo:415;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Real:412;False:C215)
End if 
If ([Alumnos_Calificaciones:208]Anual_Nota:12=-10)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]Anual_Nota:12;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]Anual_Puntos:13;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]Anual_Simbolo:14;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]Anual_Real:11;False:C215)
End if 
If ([Alumnos_Calificaciones:208]ExamenAnual_Nota:17=-10)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]ExamenAnual_Nota:17;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]ExamenAnual_Puntos:18;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]ExamenAnual_Real:16;False:C215)
End if 
If ([Alumnos_Calificaciones:208]ExamenExtra_Nota:22=-10)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]ExamenExtra_Nota:22;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]ExamenExtra_Puntos:23;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]ExamenExtra_Simbolo:24;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]ExamenExtra_Real:21;False:C215)
End if 
If ([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27=-10)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;False:C215)
End if 
If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33=-10)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35;False:C215)
	OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;False:C215)
End if 