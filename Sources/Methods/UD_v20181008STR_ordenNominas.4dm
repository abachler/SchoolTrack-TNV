//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Patricio Aliaga
  // Fecha y hora: 08-10-18, 12:35:07
  // ----------------------------------------------------
  // Método: UD_v20181008STR_ordenNominas
  // Descripción
  // Metodo se encarga de tomar la configuracion previa de los ordenes de nominas y dejarlos en la nueva preferencia de tipo objeto
  //
  // Parámetros
  // ----------------------------------------------------


ALL RECORDS:C47([xxSTR_Constants:1])
C_OBJECT:C1216($o_pref;$o_configuracionGeneral)
OB SET:C1220($o_configuracionGeneral;"NdeOrden";([xxSTR_Constants:1]OrdenNtas:26=1))
OB SET:C1220($o_configuracionGeneral;"CursoNombres";([xxSTR_Constants:1]OrdenNtas:26=0))
OB SET:C1220($o_configuracionGeneral;"Nombres";([xxSTR_Constants:1]OrdenNtas:26=2))
OB SET:C1220($o_configuracionGeneral;"UsaGenero";(Num:C11(PREF_fGet (0;"◊viSTR_AgruparPorSexo";"0"))=1))
OB SET:C1220($o_configuracionGeneral;"Genero";False:C215)  // Falso Femenino True Masculino por defecto Femenino
OB SET:C1220($o_pref;"0";$o_configuracionGeneral)
PREF_SetObject (0;"STR_ordenNominas";$o_pref)