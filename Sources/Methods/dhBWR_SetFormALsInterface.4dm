//%attributes = {}
  //dhBWR_SetFormALsInterface

  //Case of 
  //: (Table(yBWR_CurrentTable)=Table(->[Alumnos]))
  //ALP_SetInterfaces (xALP_UFields;xALP_ConductaAlumnos;xALP_Notas;xALP_PsyEvents;xALP_PsyObs;xALP_Interview;xALP_ComentariosPJefe;xALP_ObsAsg;xALP_Familia;xALP_Hermano;xALP_FamUFields;xALP_Enfermedades;xALP_alergias;xALP_Hospitalizaciones;xALP_vacunas;xALP_ControlesMedicos;xALP_Aparatos;xALP_ConsultasEnfermeria;xALP_EventosPostEgreso)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[Familia]))
  //ALP_SetInterfaces (xALP_FamUFields;xALP_EventosFamiliares;xALP_Hermano;xALP_Familia)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[Cursos]))
  //ALP_SetInterfaces (xALP_StdList;xALP_Asignaturas;xALP_Delegados;xALP_Notas;xALP_EvaluacionPersonal;xALP_Promo;xALP_Firmas)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[Profesores]))
  //ALP_SetInterfaces (xALP_pfUF;xALP_PFAsig;xALP_AsgLst;xALP_Students;xALP_Tutoria1;vxALP_Tutoria2;xALP_Tutoria3)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[Asignaturas]))
  //ALP_SetInterfaces (xALP_StdList;xALP_ASNotas;xALP_ASObs;xALP_SkillsStudentList;xALP_Destrezas;xALP_Planes;xALP_Sesions;xALP_AsistenciaSesiones;xALP_Ejes;xALP_Evaluaciones)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[Actividades]))
  //ALP_SetInterfaces (xALP_StdList;xALP_ActividadesExtra)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[Personas]))
  //ALP_SetInterface (xAL_ppUF)
  //If (vsBWR_CurrentModule="AccountTrack")
  //ALP_SetInterfaces (xALP_Alumnos;xALP_Transacciones;xALP_Documentos;ALP_CargosXPagar;xALP_Pagos;xALP_DesglosePago;xALP_DocsenCartera;xALP_DocsDepositados)
  //End if 
  //
  //: (Table(yBWR_CurrentTable)=Table(->[ACT_CuentasCorrientes]))
  //ALP_SetInterfaces (xAL_ccUF;xALP_Familia;xALP_Hermano;xALP_Transacciones;xALP_Documentos;ALP_CargosXPagar;xALP_Pagos;xALP_DesglosePago;xALP_Observaciones)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[ACT_Avisos_de_Cobranza]))
  //ALP_SetInterface (xALP_CargosXPagar)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[ACT_Pagos]))
  //ALP_SetInterface (xALP_DesglosePago)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[ACT_Boletas]))
  //ALP_SetInterfaces (ALP_CargosBoleta;xALP_DocsInvolved;xALP_AlumnosBol)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[ACT_Documentos_en_Cartera]))
  //ALP_SetInterface (xALP_DesglosePago)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[ACT_Documentos_de_Pago]))
  //ALP_SetInterface (xALP_DesglosePago)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[BBL_Items]))
  //ALP_SetInterfaces (xALP_Sbjcts;xALP_Copy;xALP_Prestamos;xALP_SubRec)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[BBL_Lectores]))
  //ALP_SetInterfaces (xALP_Prestamos;xALP_transacciones)
  //
  //: (Table(yBWR_CurrentTable)=Table(->[BBL_Subscripciones]))
  //ALP_SetInterface (xALP_SerialPub)
  //End case 