//%attributes = {}
C_TEXT:C284($vtACT_Carrera;$vt_periodo;$vt_mensaje)
C_DATE:C307($vd_fecha)
C_LONGINT:C283($vl_idPagare;$vl_idApoderado;$vlACT_IdCtaCte;$0;$vl_idTercero)
C_POINTER:C301($vy_pointer1)
C_REAL:C285($vr_montoPagare)

$vy_pointer1:=$1
$vtACT_Carrera:=$2
$vd_fecha:=$3
$vt_periodo:=$4
$vl_idApoderado:=$5
$vlACT_IdCtaCte:=$6
$vl_idTercero:=$7

  //$vr_montoPagare:=ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMPago";$vy_pointer1;->[ACT_Cargos]Saldo;Current date(*))
  //If ($vr_montoPagare>0)
READ WRITE:C146([ACT_Pagares:184])
CREATE RECORD:C68([ACT_Pagares:184])
[ACT_Pagares:184]Carrera:7:=$vtACT_Carrera
[ACT_Pagares:184]Fecha_Generacion:9:=$vd_fecha
$vl_idPagare:=SQ_SeqNumber (->[ACT_Pagares:184]ID:12)
[ACT_Pagares:184]ID:12:=$vl_idPagare
  //[ACT_Pagares]ID_Estado:=-103
ACTcfg_OpcionesPagares ("AsignaEstadoPorDefecto")
[ACT_Pagares:184]Numero_Pagare:11:=Num:C11(ACTcfg_OpcionesGeneracionP ("ObtieneNumero"))
[ACT_Pagares:184]Periodo:5:=$vt_periodo
[ACT_Pagares:184]ID_Apdo:17:=$vl_idApoderado
[ACT_Pagares:184]ID_Cta:18:=$vlACT_IdCtaCte
[ACT_Pagares:184]ID_Tercero:22:=$vl_idTercero
[ACT_Pagares:184]ID_Alumno:23:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Pagares:184]ID_Cta:18;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
  //SAVE RECORD([ACT_Pagares])
ACTpagares_fSave 
$vt_mensaje:="Generación de Pagaré."
ACTcfg_OpcionesPagares ("Log";->$vt_mensaje)
KRL_UnloadReadOnly (->[ACT_Pagares:184])

ACTcfg_OpcionesGeneracionP ("AsignaIDPagareAAC1";->$vl_idPagare;$vy_pointer1)

ACTcfg_OpcionesGeneracionP ("CalculaMontoPagare";->$vl_idPagare)

  //Else 
  //LOG_RegisterEvt ("Pagaré no generado debido a que el saldo de los avisos seleccionados no es superior a 0")
  //End if 
$0:=$vl_idPagare