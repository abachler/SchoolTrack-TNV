//%attributes = {"publishedWeb":true}
  //BBLw_PostReservation

If (False:C215)
	  //Method: BBLw_PostReservation
	  //Written by  Alberto Bachler on 11/7/98
	  //Module: 
	  //Purpose: 
	  //Syntax:  BBLw_PostReservation()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>ST_v4517:=False:C215
End if 


  //DECLARATIONS
C_TEXT:C284(vtWEB_ApellidoLector;vtWEB_NumeroLector;vtWEB_NumeroItem)



  //INITIALIZATION
vt_msg:=""
READ ONLY:C145([BBL_Items:61])
READ ONLY:C145([BBL_Lectores:72])
READ ONLY:C145([xxBBL_ReglasParaItems:69])
READ ONLY:C145([xxBBL_ReglasParaUsuarios:64])
READ ONLY:C145([BBL_Registros:66])
READ ONLY:C145([BBL_Reservas:115])
PERIODOS_Init 
PERIODOS_LoadData (0;-2)

vtWEB_ApellidoLector:=ST_GetCleanString (vtWEB_ApellidoLector)
$IDPatron:=ST_GetCleanString (vtWEB_NumeroLector)
$IDItem:=Num:C11(ST_GetCleanString (vtWEB_NumeroItem))


$from:=DT_GetWorkingDayDate (Current date:C33(*);-2)
QUERY:C277([BBL_Items:61];[BBL_Items:61]Numero:1=$IDItem)
QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1=[BBL_Items:61]Regla:20)
If (Not:C34([xxBBL_ReglasParaItems:69]Reserva_Permitida:9))
	vt_reservationDate:=""
	vt_msg:=_O_Mac to ISO:C519("Lo siento. No se permiten reservas sobre este item.")
	WEB_SendHtmlFile ("Reservation_1.shtml")
Else 
	vt_reservationDate:=String:C10(DT_GetWorkingDayDate (Current date:C33(*)+1+[xxBBL_ReglasParaItems:69]Reserva_Caducan:8);3)
	
	QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=$IDItem;*)
	QUERY:C277([BBL_Registros:66]; & [BBL_Registros:66]StatusID:34=Disponible)
	If (Records in selection:C76([BBL_Registros:66])>0)
		If ([xxBBL_ReglasParaItems:69]Reserva_Caducan:8=0)
			$date:=$from
		Else 
			$date:=DT_GetWorkingDayDate (Current date:C33(*)+[xxBBL_ReglasParaItems:69]Reserva_Caducan:8)
		End if 
	Else 
		QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=$IDItem;*)
		QUERY:C277([BBL_Registros:66]; & [BBL_Registros:66]StatusID:34=Prestado)
		If (Records in selection:C76([BBL_Registros:66])>0)
			ORDER BY:C49([BBL_Registros:66];[BBL_Registros:66]Fecha_de_devolución:15;>)
			FIRST RECORD:C50([BBL_Registros:66])
			If ([xxBBL_ReglasParaItems:69]Reserva_Caducan:8=0)
				$date:=[BBL_Registros:66]Fecha_de_devolución:15
			Else 
				$date:=DT_GetWorkingDayDate ([BBL_Registros:66]Fecha_de_devolución:15+[xxBBL_ReglasParaItems:69]Reserva_Caducan:8)
			End if 
		Else 
			QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=$IDItem;*)
			QUERY:C277([BBL_Registros:66]; & [BBL_Registros:66]StatusID:34=Reservado)
			If (Records in selection:C76([BBL_Registros:66])>0)
				KRL_RelateSelection (->[BBL_Reservas:115]ID_Item:2;->[BBL_Items:61]Numero:1;"")
				ORDER BY:C49([BBL_Reservas:115];[BBL_Reservas:115]Until:4;>)
				FIRST RECORD:C50([BBL_Reservas:115])
				If ([xxBBL_ReglasParaItems:69]Reserva_Caducan:8=0)
					$date:=[BBL_Reservas:115]Until:4
				Else 
					$date:=DT_GetWorkingDayDate ([BBL_Reservas:115]Until:4+[xxBBL_ReglasParaItems:69]Reserva_Caducan:8)
				End if 
			End if 
		End if 
	End if 
	
	$barCode:=$IDPatron
	$recNumLector:=Find in field:C653([BBL_Lectores:72]BarCode_SinFormato:38;$barCode)
	If ($recNumLector#-1)
		GOTO RECORD:C242([BBL_Lectores:72];$recNumLector)
	Else 
		REDUCE SELECTION:C351([BBL_Lectores:72];0)
	End if 
	
	
	  //verificamos si existe una reserva para el mismo item y mismo lector
	SET QUERY DESTINATION:C396(Into variable:K19:4;$reservasActuales)
	QUERY:C277([BBL_Reservas:115];[BBL_Reservas:115]ID_User:3=[BBL_Lectores:72]ID:1;*)
	QUERY:C277([BBL_Reservas:115]; & [BBL_Reservas:115]ID_Item:2=[BBL_Items:61]Numero:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	
	KRL_FindAndLoadRecordByIndex (->[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;->[BBL_Lectores:72]Regla:4)
	
	Case of 
		: ($idPatron="")
			vt_msg:=_O_Mac to ISO:C519(__ ("Lo siento, no puedo aceptar una reserva si no indicas tu número de lector."))
			WEB_SendHtmlFile ("Reservation_1.shtml")
			
		: (vtWEB_ApellidoLector="")
			vt_msg:=_O_Mac to ISO:C519(__ ("Lo siento, no puedo aceptar una reserva si no indicas tu apellido paterno."))
			WEB_SendHtmlFile ("Reservation_1.shtml")
			
		: ([xxBBL_ReglasParaUsuarios:64]Max_Reservas:5=0)
			vt_msg:=_O_Mac to ISO:C519("Lo siento, usted no está autorizado para reservar ítems.")
			WEB_SendHtmlFile ("Reservation_1.shtml")
			
		: (Records in selection:C76([BBL_Lectores:72])=0)
			vt_msg:=_O_Mac to ISO:C519(__ ("Lo siento, el número de lector que ingresaste no existe."))
			WEB_SendHtmlFile ("Reservation_1.shtml")
			
		: (Records in selection:C76([BBL_Lectores:72])>1)
			vt_msg:=_O_Mac to ISO:C519(__ ("Lo siento, se produjo un error interno (mas de un lector con el mismo número).\rLa reserva es imposible."))
			WEB_SendHtmlFile ("Reservation_1.shtml")
			
		: ((Records in selection:C76([BBL_Lectores:72])=1) & (ST_GetCleanString ([BBL_Lectores:72]Apellido_paterno:12)#vtWEB_ApellidoLector))
			vt_msg:=_O_Mac to ISO:C519(__ ("Lo siento, el apellido paterno que ingresaste no corresponde al número de lector.\rPor favor verifica e intenta nuevamente."))
			WEB_SendHtmlFile ("Reservation_1.shtml")
			
		: ($reservasActuales>0)
			vt_msg:=_O_Mac to ISO:C519([BBL_Lectores:72]NombreCompleto:3+" ya reservó "+[BBL_Items:61]Primer_título:4)
			WEB_SendHtmlFile ("Reservation_1.shtml")
			
		: ([BBL_Items:61]Copias_disponibles:43<=0)
			vt_msg:=_O_Mac to ISO:C519(__ ("Lo siento, no existe en este momento ninguna copia disponible de este item."))
			WEB_SendHtmlFile ("Reservation_1.shtml")
			
		: ([BBL_Items:61]Copias_reservadas:44>=[BBL_Items:61]Copias_disponibles:43)
			vt_msg:=_O_Mac to ISO:C519("Las copias disponibles del item "+[BBL_Items:61]Primer_título:4+" ya están reservadas")
			WEB_SendHtmlFile ("Reservation_1.shtml")
			
		Else 
			QUERY:C277([BBL_Reservas:115];[BBL_Reservas:115]ID_User:3=$IDPatron)
			If ((Records in selection:C76([BBL_Reservas:115])<[xxBBL_ReglasParaUsuarios:64]Max_Reservas:5))
				READ WRITE:C146([BBL_Items:61])
				LOAD RECORD:C52([BBL_Items:61])
				If (Not:C34(Locked:C147([BBL_Items:61])))
					[BBL_Items:61]Copias_reservadas:44:=[BBL_Items:61]Copias_reservadas:44+1
					SAVE RECORD:C53([BBL_Items:61])
					KRL_ReloadAsReadOnly (->[BBL_Items:61])
					READ WRITE:C146([BBL_Reservas:115])
					CREATE RECORD:C68([BBL_Reservas:115])
					[BBL_Reservas:115]ID:1:=SQ_SeqNumber (->[BBL_Reservas:115]ID:1)
					[BBL_Reservas:115]ID_User:3:=[BBL_Lectores:72]ID:1
					[BBL_Reservas:115]ID_Item:2:=$idItem
					[BBL_Reservas:115]From:5:=$from
					[BBL_Reservas:115]Until:4:=$date
					[BBL_Reservas:115]UserName:6:=[BBL_Lectores:72]NombreCompleto:3
					SAVE RECORD:C53([BBL_Reservas:115])
					KRL_ReloadAsReadOnly (->[BBL_Reservas:115])
					vt_msg:=_O_Mac to ISO:C519(__ ("Tu reserva fue correctamente registrada.\rNo olvides de retirar el item antes del ")+String:C10($date;3))
					WEB_SendHtmlFile ("okReservation_1.shtml")
				Else 
					vt_msg:="No fue posible registrar la reserva ahora."+"\r"+"Por favor inténtelo nuevamente mas tarde."
					vt_msg:=_O_Mac to ISO:C519(vt_msg)
					WEB_SendHtmlFile ("okReservation_1.shtml")
				End if 
			Else 
				vt_msg:=_O_Mac to ISO:C519(Replace string:C233(__ ("Lo siento, ya tienes ^0 items reservados.\rNo es posible reservar otros items mientras no retires tus reservas previas de la biblioteca.");"^0";String:C10(Records in selection:C76([BBL_Reservas:115]))))
				WEB_SendHtmlFile ("okReservation_1.shtml")
			End if 
	End case 
End if 