  // [xxSTR_Constants].STR_CFG_InformesEspeciales.Variable50()
  // Por: Alberto Bachler K.: 28-02-14, 21:04:43
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


REDUCE SELECTION:C351([Cursos:3];0)
WDW_OpenFormWindow (->[xxSTR_Niveles:6];"Certificado";-1;8;__ ("Certificado ")+[xxSTR_Niveles:6]Nivel:1;"")
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=vi_NoNivel)
KRL_ModifyRecord (->[xxSTR_Niveles:6];"Certificado")
CLOSE WINDOW:C154
  //se debe cargar el nivel  nuevamente al volver a la configuracion
  //192571 
ACTAS_LeeConfiguracion ([xxSTR_Niveles:6]NoNivel:5;"";<>gyear)  //ABC
ACTAS_ConfiguraFormActa (True:C214)
  //ACTAS_GuardaConfiguracion ([xxSTR_Niveles]NoNivel)
  //ACTAS_ConfiguraFormActa 
