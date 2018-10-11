//%attributes = {"executedOnServer":true}
  // XSvs_ActualizaTabla()
  // Por: Alberto Bachler: 07/03/13, 11:56:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_campoInvisible;$b_indexado;$b_muchos_a_uno;$b_tablaEsInvisible;$b_unico;$b_uno_a_muchos)
C_LONGINT:C283($l_campoRelacion_1aN;$l_campoRelacionado;$l_largoCampo;$l_numeroCampo;$l_numeroCampoDiscriminante;$l_numeroTabla;$l_tablaRelacion_1aN;$l_tablaRelacionada;$l_tipoCampo)
C_TEXT:C284($t_llaveTablaPrincipal;$t_llaveTablaRelacionada)

If (False:C215)
	C_LONGINT:C283(XSvs_ActualizaTabla ;$1)
End if 

$l_numeroTabla:=$1


