

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket 174553
  // Fecha y hora: 25-07-17, 16:13:27
  // ----------------------------------------------------
  // Método: [Personas].Input_ACT.bFamilia
  // Descripción: cuando el usuario esté en más de una familia, se le permitirá seleccionar entre ellas.
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_LONGINT:C283($seleccion)

$vt_Familia:=AT_array2text (->ACTEC_atFamilias)
$seleccion:=Pop up menu:C542($vt_Familia)
If ($seleccion#0)
	ACTEC_atFamilias:=$seleccion
	vsACTEC_FamiliaSeleccionada:=ACTEC_atFamilias{$seleccion}
	vlACTEC_Familias:=ACTEC_alIdsFamilias3{$seleccion}
	ACT_GeneraEstadoDeCuenta ("CargaInterfaz";->[Personas:7];Record number:C243([Personas:7]))
End if 
