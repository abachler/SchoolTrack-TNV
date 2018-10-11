//%attributes = {}
  // TMT_EliminaSala()
  // Por: Alberto Bachler: 22/05/13, 08:54:50
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_SalaEliminada)
C_LONGINT:C283($l_error;$l_IdSala;$l_opcionUsuario;$l_registrosHorario)
C_TEXT:C284($t_NombreSala;$t_TextoLog)

If (False:C215)
	C_BOOLEAN:C305(TMT_EliminaSala ;$0)
	C_LONGINT:C283(TMT_EliminaSala ;$1)
End if 

$l_IdSala:=$1
KRL_FindAndLoadRecordByIndex (->[TMT_Salas:167]ID_Sala:1;->$l_IdSala;True:C214)
$t_NombreSala:=[TMT_Salas:167]NombreSala:2

QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Sala:6=[TMT_Salas:167]ID_Sala:1)
$l_registrosHorario:=Records in selection:C76([TMT_Horario:166])

IT_Confirmacion_Inicializa 
If ($l_registrosHorario>0)
	$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("28/Encabezado_salasAsignadas"))
	$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("29/btn1_EliminarSalaAsignada"))
	$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("33/btn2_Cancelar"))
	
	$l_error:=IT_Confirmacion_AgregaTagValor ("$t_NombreSala";$t_NombreSala)
	$l_error:=IT_Confirmacion_AgregaTagValor ("$l_registrosHorario";String:C10($l_registrosHorario))
	
	$t_TextoLog:=__ ("Eliminación de sala de clases.")
	$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
	If ($l_opcionUsuario=1)
		ARRAY TEXT:C222($at_Vacio;$l_registrosHorario)
		ARRAY LONGINT:C221($al_zeros;$l_registrosHorario)
		KRL_Array2Selection (->$al_zeros;->[TMT_Horario:166]ID_Sala:6;->$at_Vacio;->[TMT_Horario:166]Sala:8)
		KRL_DeleteRecord (->[TMT_Salas:167])
		KRL_UnloadReadOnly (->[TMT_Salas:167])
		KRL_UnloadReadOnly (->[TMT_Horario:166])
		$b_SalaEliminada:=True:C214
	End if 
Else 
	$b_SalaEliminada:=True:C214
	KRL_DeleteRecord (->[TMT_Salas:167])
	KRL_UnloadReadOnly (->[TMT_Salas:167])
	KRL_UnloadReadOnly (->[TMT_Horario:166])
End if 

If (($b_SalaEliminada) & (KRL_EsEventoEnInterfazUsuario ))
	TMT_CargaSalas 
	TMT_CargaHorario (vs_SelectedClass;vlSTR_Horario_CicloNumero;b_soloBloquesVigentes)  //MONO TICKET 216065
End if 

$0:=$b_SalaEliminada