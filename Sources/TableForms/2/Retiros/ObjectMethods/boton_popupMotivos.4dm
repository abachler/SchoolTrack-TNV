  // [Alumnos].Retiros.Botón invisible()
  // Por: Alberto Bachler: 13/11/13, 11:05:45
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



$t_menuMotivos:=MNU_CreaMenu_arreglo (-><>aMotivosRetiro)
[Alumnos:2]Motivo_de_retiro:43:=Dynamic pop up menu:C1006($t_menuMotivos)
RELEASE MENU:C978($t_menuMotivos)