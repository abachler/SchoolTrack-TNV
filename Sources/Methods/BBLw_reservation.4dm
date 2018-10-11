//%attributes = {"publishedWeb":true}
  //BBLw_reservation

If (False:C215)
	  //Method: BBLw_reservation
	  //Written by  Alberto Bachler on 10/7/98
	  //Module: 
	  //Purpose: 
	  //Syntax:  BBLw_reservation()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>ST_v4517:=False:C215
End if 


  //MAIN CODE
READ ONLY:C145([BBL_Items:61])
vt_msg:=_O_Mac to ISO:C519(__ ("Para reservar el item debes ingresar tu apellido paterno y tu número de lector. Cuando hayas completado estos datos pulsa el botón Enviar"))
$id:=$1
PERIODOS_Init 
PERIODOS_LoadData (0;-2)
QUERY:C277([BBL_Items:61];[BBL_Items:61]Numero:1=$id)
QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1=[BBL_Items:61]Regla:20)
vt_reservationDate:=String:C10(DT_GetWorkingDayDate (Current date:C33(*)+1+[xxBBL_ReglasParaItems:69]Reserva_Caducan:8;-2);3)

WEB_SendHtmlFile ("reservation_1.shtml")
