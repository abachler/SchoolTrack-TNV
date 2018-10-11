//%attributes = {}
  // MÉTODO: CU_InitArrays
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 20/12/11, 18:11:54
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Inicializa variables procesos utilizadas en diferentes instancias en la ficha del curso
  //
  // PARÁMETROS
  // CU_InitArrays()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
ARRAY TEXT:C222(<>aStdWhNme;0)
ARRAY INTEGER:C220(<>aStdNo;0)
ARRAY LONGINT:C221(<>aStdId;0)

ARRAY TEXT:C222(aSubjectName;0)
ARRAY TEXT:C222(aSubjectTeacher;0)
ARRAY TEXT:C222(at_OrdenAsignaturas;0)

ARRAY LONGINT:C221(al_CUIdDelegado;0)
ARRAY TEXT:C222(at_CUWorkPhoneDelegado;0)
ARRAY TEXT:C222(at_CUeMailDelegado;0)
ARRAY TEXT:C222(at_CUNameDelegado;0)
ARRAY TEXT:C222(at_CUDelegaciónDelegado;0)
ARRAY TEXT:C222(at_CUHomePhoneDelegado;0)

ARRAY INTEGER:C220(alActas_ColumnNumber;0)
ARRAY TEXT:C222(aAsg;0)
ARRAY TEXT:C222(aPrfNam;0)
ARRAY TEXT:C222(aPrfAut;0)
ARRAY TEXT:C222(aAsg2;0)
ARRAY TEXT:C222(aPrfNam2;0)
ARRAY TEXT:C222(aPrfAut2;0)

ARRAY TEXT:C222(at_CuApoderados;0)
ARRAY LONGINT:C221(al_CURecNumApoderados;0)

ARRAY REAL:C219(aPctAsist;0)
ARRAY INTEGER:C220(aStdNoLista;0)
ARRAY INTEGER:C220(aInasist;0)
ARRAY INTEGER:C220(aAtrasos;0)
ARRAY INTEGER:C220(aAtrasosInter;0)
ARRAY INTEGER:C220(aAntN;0)
ARRAY INTEGER:C220(aAntP;0)
ARRAY INTEGER:C220(aCastigos;0)
ARRAY INTEGER:C220(aSusp;0)
ARRAY INTEGER:C220(aAntNeutras;0)

ARRAY DATE:C224(ad_FechaEvCurso;0)  //RCH 53871
ARRAY TEXT:C222(at_CategoriaEvCurso;0)
ARRAY TEXT:C222(at_TemaEvCurso;0)

COPY ARRAY:C226(<>atSTR_ModosEvaluacion;aEvMode)