//%attributes = {}
  //ACTdic_CreaRegistro
C_LONGINT:C283($l_id)
C_LONGINT:C283($1;$2;$4)
C_BOOLEAN:C305($3)
C_TEXT:C284($5)
C_REAL:C285($r_pct;$6;$r_dcto)
C_LONGINT:C283($l_cta;$l_orden;$l_idAl)
C_BOOLEAN:C305($b_inactivo)
C_TEXT:C284($t_periodo;$t_llave;$t_nomDcto;$t_alumno)
C_LONGINT:C283($l_recNum;$0)

$l_cta:=$1
$r_dcto:=$2
$b_inactivo:=$3
$l_orden:=$4
$t_periodo:=$5
$r_pct:=$6

$t_periodo:=Choose:C955($t_periodo="";<>gNombreAgnoEscolar;$t_periodo)

$t_llave:=ST_Concatenate (".";->$b_inactivo;->$t_periodo;->$r_dcto;->$l_cta)
$l_recNum:=Find in field:C653([ACT_DctosIndividuales_Cuentas:228]Llave:11;$t_llave)
If ($l_recNum=-1)
	CREATE RECORD:C68([ACT_DctosIndividuales_Cuentas:228])
	
	$l_id:=SQ_SeqNumber (->[ACT_DctosIndividuales_Cuentas:228]ID:1)
	While (Find in field:C653([ACT_DctosIndividuales_Cuentas:228]ID:1;$l_id)#-1)
		$l_id:=SQ_SeqNumber (->[ACT_DctosIndividuales_Cuentas:228]ID:1)
	End while 
	[ACT_DctosIndividuales_Cuentas:228]ID:1:=$l_id
	
	[ACT_DctosIndividuales_Cuentas:228]ID_CuentaCorriente:6:=$l_cta
	[ACT_DctosIndividuales_Cuentas:228]ID_Descuento:5:=$r_dcto
	[ACT_DctosIndividuales_Cuentas:228]Inactivo:10:=$b_inactivo
	[ACT_DctosIndividuales_Cuentas:228]Orden:8:=$l_orden
	[ACT_DctosIndividuales_Cuentas:228]Periodo:9:=$t_periodo
	[ACT_DctosIndividuales_Cuentas:228]Porcentaje:7:=$r_pct
	
	ACTcc_OpcionesDctos ("RegistraLog")
	
	SAVE RECORD:C53([ACT_DctosIndividuales_Cuentas:228])
	
	  //agrego el valor a la cuenta para los informes
	  //166170 JVP
	  // MOD Ticket Nº 210644 PA 20180626
	  //[ACT_CuentasCorrientes]Descuento:=$r_pct
	ACTcc_OpcionesDctos ("ActualizaDctoCtaCte";->$r_dcto;->$r_pct)
	SAVE RECORD:C53([ACT_CuentasCorrientes:175])
	
	
	KRL_UnloadReadOnly (->[ACT_DctosIndividuales_Cuentas:228])
Else 
	GOTO RECORD:C242([ACT_DctosIndividuales_Cuentas:228];$l_recNum)
	$l_id:=[ACT_DctosIndividuales_Cuentas:228]ID:1
End if 

$0:=$l_id
