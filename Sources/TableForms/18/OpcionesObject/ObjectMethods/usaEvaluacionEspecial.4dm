  //Mono Ticket 172577 Evaluacion Especial
C_OBJECT:C1216($o_Opciones)
C_BOOLEAN:C305($b_opcEvaEsp)
$b_opcEvaEsp:=(Self:C308->=1)
$o_Opciones:=[Asignaturas:18]Opciones:57
OB_SET ($o_Opciones;->$b_opcEvaEsp;"usaEvaluacionesEspeciales")
[Asignaturas:18]Opciones:57:=$o_Opciones

If ($b_opcEvaEsp)
	C_LONGINT:C283($i;$l_recNumEvalEspecial;$l_idTermometro)
	C_TEXT:C284($llaveAsig)
	ARRAY LONGINT:C221($al_rn;0)
	$llaveAsig:=String:C10(<>gInstitucion)+"."+String:C10(<>gyear)+"."+String:C10(Abs:C99([Asignaturas:18]Numero:1))
	$l_idTermometro:=IT_Progress (1;0;0;"Verificando Evaluaciones Especiales")
	AS_creaRegistrosAluEvaEspecial ($llaveAsig)
	$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
End if 