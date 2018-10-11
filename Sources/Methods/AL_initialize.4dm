//%attributes = {}
  //AL_initialize

C_LONGINT:C283(vl_LastHealthItemSelected)

  //notas
EV2_InitArrays 

  //family relations
ARRAY TEXT:C222(aRelName;0)
ARRAY TEXT:C222(aTelDom;0)
ARRAY TEXT:C222(aTelOf;0)
ARRAY LONGINT:C221(aPersID;0)
ARRAY TEXT:C222(aParentesco;0)
ARRAY TEXT:C222(aApoderado;0)

  //brothers
ARRAY TEXT:C222(aBthrName;0)
ARRAY TEXT:C222(aBthrCurso;0)
ARRAY LONGINT:C221(aBthrID;0)

  //observaciones y entrevistas
ARRAY DATE:C224(aIWDate;0)
ARRAY TEXT:C222(alWEvento;0)
ARRAY TEXT:C222(aIWMotivo;0)
ARRAY LONGINT:C221(aIWId;0)
ARRAY TEXT:C222(aPJObs;0)
ARRAY TEXT:C222(aObsP1;0)
ARRAY TEXT:C222(aObsP2;0)
ARRAY TEXT:C222(aObsP3;0)
ARRAY TEXT:C222(aObsP4;0)
ARRAY TEXT:C222(aObsP5;0)
ARRAY TEXT:C222(aObsF;0)
ARRAY TEXT:C222(aAsignatura;0)

ARRAY DATE:C224(ad_FechaEvCurso;0)  //eventos curso
ARRAY TEXT:C222(at_CategoriaEvCurso;0)
ARRAY TEXT:C222(at_TemaEvCurso;0)

  //orientación
ARRAY DATE:C224(aDatePsy;0)
ARRAY TEXT:C222(aPsy;0)
ARRAY LONGINT:C221(aPsyNo;0)
ARRAY TEXT:C222(aTest;0)
ARRAY DATE:C224(aDateTest;0)
ARRAY TEXT:C222(aKeyWds;0)

  //salud
ARRAY TEXT:C222(aProblema;0)
ARRAY TEXT:C222(aPblObs;0)
ARRAY DATE:C224(aDateCE;0)
ARRAY TEXT:C222(aMotCons;0)
ARRAY LONGINT:C221(aCENo;0)
ARRAY LONGINT:C221(aCEHora;0)

  //datos personales (page 1)
ARRAY TEXT:C222(aUFItmName;0)
ARRAY TEXT:C222(aUFItmVal;0)


  // connexions
ARRAY TEXT:C222(at_Connexions;0)


  //Notas historicas
ARRAY TEXT:C222(aHAsig;0)
ARRAY TEXT:C222(aHNota1;0)
ARRAY TEXT:C222(aHNota2;0)
ARRAY TEXT:C222(aHNota3;0)
ARRAY TEXT:C222(aHNota4;0)
ARRAY TEXT:C222(aHPF;0)
ARRAY TEXT:C222(aHEx;0)
ARRAY TEXT:C222(aHNF;0)
ARRAY INTEGER:C220(aHorder;0)
ARRAY LONGINT:C221(aHID;0)

  //salud
ARRAY TEXT:C222(aEnfermedad;0)
ARRAY TEXT:C222(aHospDiagnostico;0)
ARRAY DATE:C224(aHospFecha;0)
ARRAY DATE:C224(aHospHasta;0)
ARRAY TEXT:C222(aAlergiaTipo;0)
ARRAY TEXT:C222(aAlergeno;0)
ARRAY DATE:C224(aCMedico_Fecha;0)
ARRAY TEXT:C222(aCMedico_Curso;0)
ARRAY TEXT:C222(aCMedico_Edad;0)
ARRAY INTEGER:C220(aCMedico_Talla;0)
ARRAY REAL:C219(aCMedico_Peso;0)
ARRAY TEXT:C222(aCMedico_IMC;0)
ARRAY TEXT:C222(aVacuna_Edad;0)
ARRAY TEXT:C222(aVacuna_Enfermedad;0)
ARRAY BOOLEAN:C223(aVacuna_SiNo;0)
ARRAY LONGINT:C221(aVacuna_meses;0)
ARRAY LONGINT:C221(aAparatos_Year;0)
ARRAY TEXT:C222(aAparatos_Curso;0)
ARRAY TEXT:C222(aAparatos_Aparato;0)
ARRAY LONGINT:C221(aAparatos_NoNivel;0)

  //DEstrezas
ARRAY LONGINT:C221(al_ALEvObjIDSubsector;0)
ARRAY TEXT:C222(at_ALEvObjSubsector;0)

_O_ARRAY STRING:C218(80;aStdBthrNm;0)
_O_ARRAY STRING:C218(10;aStdBthrCl;0)
ARRAY LONGINT:C221(aStdBthrID;0)


COPY ARRAY:C226(<>atSTR_ModosEvaluacion;aEvMode)


AL_InitCdtaArr 
AL_CdtaBehaviourFilter ("initListCdta")
AL_CdtaBehaviourFilter ("initArrays")

ARRAY TEXT:C222(aNombresMedicos;0)
ARRAY TEXT:C222(aEspMedicos;0)
ARRAY TEXT:C222(aTelMedicos;0)
ARRAY TEXT:C222(aEMailMedicos;0)
ARRAY LONGINT:C221(aIDMedico;0)
ARRAY BOOLEAN:C223(aModMedico;0)

vtNombreMedico:=""
vtEspecialidadMedico:=""
vtFonosMedico:=""
vteMailMedico:=""
vlIDMedico:=-1