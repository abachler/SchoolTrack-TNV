//%attributes = {}
  //SN3_SetControlVariable

C_BOOLEAN:C305(<>inSN3)
  //<>inSN3:=((Num(PREF_fGet (0;"upgraded2SN3";"0"))=1) & (DL_IsModuleLicensed (1;SchoolNet)))

<>inSN3:=LICENCIA_esModuloAutorizado (1;SchoolNet)