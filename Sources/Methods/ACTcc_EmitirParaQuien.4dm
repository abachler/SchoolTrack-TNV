//%attributes = {}
  //ACTcc_EmitirParaQuien

C_LONGINT:C283($month;$year;$1;$2)

$month:=$1
$year:=$2

CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];aLong1)
KRL_RelateSelection (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9;"")
CREATE SET:C116([Personas:7];"Apoderados")
KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]No:1;"")
QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=$month;*)
QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Agno:7=$year)
KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;"")
CREATE SET:C116([Personas:7];"ApdosEmitidosMes")
DIFFERENCE:C122("Apoderados";"ApdosEmitidosMes";"ApoderadosEmitir")

$Emitir:=True:C214
USE SET:C118("Apoderados")
SELECTION TO ARRAY:C260([Personas:7]No:1;al_IDApoderados)
KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];aLong1)

$ApdosEmitidos:=Records in set:C195("ApdosEmitidosMes")

If (($ApdosEmitidos>0) & (Not:C34(cb_GenerarAvisoAuto=1)))
	
	cdT_Msg:="Existen "+String:C10($ApdosEmitidos)+" apoderados para los cuales ya han sido emitidos avisos en este período."
	cdT_Msg:=cdT_Msg+"\r"+"¿Qué desea hacer?"
	WDW_Open (500;185;6;-Palette form window:K39:9;"¿Para quién emitir?")
	DIALOG:C40([xxSTR_Constants:1];"ACT_EmitirParaQuien")
	CLOSE WINDOW:C154
	
	Case of 
			
		: (epq1=1)
			
			  //Cancelar la operación
			$Emitir:=False:C215
			
		: (epq2=1)
			
			  //Emitir solo para los no emitidos
			$Emitir:=True:C214
			USE SET:C118("ApoderadosEmitir")
			SELECTION TO ARRAY:C260([Personas:7]No:1;al_IDApoderados)
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];aLong1)
			
			
		: (epq3=1)
			
			  //Emitir para toda la seleccion...
			$Emitir:=True:C214
			USE SET:C118("Apoderados")
			SELECTION TO ARRAY:C260([Personas:7]No:1;al_IDApoderados)
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];aLong1)
			
	End case 
	
Else 
	
	$Emitir:=True:C214
	USE SET:C118("ApoderadosEmitir")
	SELECTION TO ARRAY:C260([Personas:7]No:1;al_IDApoderados)
	KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
	SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];aLong1)
	
End if 

$0:=$Emitir