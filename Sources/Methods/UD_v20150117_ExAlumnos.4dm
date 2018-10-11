//%attributes = {}
  // UD_v20150117_ExAlumnos()
  // Por: Alberto Bachler K.: 17-01-15, 16:33:22
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
ARRAY BOOLEAN:C223($ab_EsExAlumno;0)

MESSAGES ON:C181

READ WRITE:C146([Alumnos:2])
ALL RECORDS:C47([Alumnos:2])
ARRAY BOOLEAN:C223($ab_EsExAlumno;Records in selection:C76([Alumnos:2]))
KRL_Array2Selection (->$ab_EsExAlumno;->[Alumnos:2]Es_ExAlumno:90)
KRL_UnloadReadOnly (->[Alumnos:2])

MESSAGES OFF:C175