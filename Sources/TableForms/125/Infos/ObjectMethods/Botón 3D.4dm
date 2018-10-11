  // [Asignaturas_Inasistencias].Infos.Botón 3D()
  // Por: Alberto Bachler K.: 19-03-14, 12:04:54
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_SeleccionActual:=Find in array:C230(<>aJustAbs;[Asignaturas_Inasistencias:125]Justificacion:3)
$l_seleccionUsuario:=IT_DynamicPopupMenu_Array (-><>aJustAbs;->[Asignaturas_Inasistencias:125]Justificacion:3;OBJECT Get name:C1087(Object current:K67:2))
If ($l_seleccionUsuario>0)
	[Asignaturas_Inasistencias:125]Justificacion:3:=<>aJustAbs{$l_seleccionUsuario}
End if 




