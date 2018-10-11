//%attributes = {}
  //ACTitems_DuplicaCargo

C_REAL:C285($r_idCargo;$1;$0)
C_REAL:C285($r_resp)
C_LONGINT:C283($l_indice)

$r_idCargo:=$1

KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]Periodo_id_item_original:43;->$r_idCargo)
If (Records in selection:C76([xxACT_Items:179])>0)
	$r_resp:=CD_Dlog (0;__ ("Ya existe un ítem de cargo creado a partir del ítem seleccionado (ítem de cargo id: ")+String:C10([xxACT_Items:179]ID:1)+")."+"\r\r"+__ ("¿Desea continuar con la creación de un nuevo ítem de cargo asociado al ítem id ")+String:C10($r_idCargo)+"?";"";__ ("Si");__ ("No"))
Else 
	$r_resp:=1
End if 
KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$r_idCargo)

If ($r_resp=1)
	DUPLICATE RECORD:C225([xxACT_Items:179])
	[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1)
	[xxACT_Items:179]Auto_UUID:44:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
	  // Modificado por: Saúl Ponce (06-04-2018) Ticket Nº 203335, Se reemplazaban todos los número. Si en la glosa habpia número de cuotas también se aumentaban
	  //For ($l_indice;19;10;-1)  // no se puede mas de 19 porque sino se reemplazara el año
	  //[xxACT_Items]Glosa:=Replace string([xxACT_Items]Glosa;String($l_indice);String($l_indice+1))
	  //[xxACT_Items]Glosa_de_Impresión:=Replace string([xxACT_Items]Glosa_de_Impresión;String($l_indice);String($l_indice+1))
	  //[xxACT_Items]Periodo:=Replace string([xxACT_Items]Periodo;String($l_indice);String($l_indice+1))
	  //End for 
	For ($l_indice;2100;2000;-1)
		[xxACT_Items:179]Glosa:2:=Replace string:C233([xxACT_Items:179]Glosa:2;String:C10($l_indice);String:C10($l_indice+1))
		[xxACT_Items:179]Glosa_de_Impresión:20:=Replace string:C233([xxACT_Items:179]Glosa_de_Impresión:20;String:C10($l_indice);String:C10($l_indice+1))
		[xxACT_Items:179]Periodo:42:=Replace string:C233([xxACT_Items:179]Periodo:42;String:C10($l_indice);String:C10($l_indice+1))
	End for 
	[xxACT_Items:179]Periodo_id_item_original:43:=$r_idCargo
	[xxACT_Items:179]Codigo_interno:48:=""  //20180918 RCH
	SAVE RECORD:C53([xxACT_Items:179])
	$0:=[xxACT_Items:179]ID:1
Else 
	$0:=$r_idCargo
End if 