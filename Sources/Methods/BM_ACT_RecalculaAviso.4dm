//%attributes = {}

  //  // ----------------------------------------------------
  //  // Usuario (SO): Roberto Catalán
  //  // Fecha y hora: 01-08-18, 18:13:17
  //  // ----------------------------------------------------
  //  // Método: BM_ACT_RecalculaAviso
  //  // Descripción
  //  // Método que se ejecuta cuando el registro del AC está siendo utilizado
  //  //
  //  // Parámetros
  //  // ----------------------------------------------------

  //C_LONGINT($l_recNumAC)
  //C_TEXT($t_fecha;$1)
  //C_LONGINT($l_filtra;$l_recalcularSiempre)
  //C_DATE($d_fecha)
  //C_BOOLEAN($b_hecho;$0)

  //ST_Deconcatenate ("";$1;->$l_recNumAC;->$t_fecha;->$l_filtra;->$l_recalcularSiempre)
  //$d_fecha:=DTS_GetDate ($t_fecha)
  //$b_hecho:=ACTac_Recalcular ($l_recNumAC;$d_fecha;($l_filtra=1);($l_recalcularSiempre=1))

  //$0:=$b_hecho