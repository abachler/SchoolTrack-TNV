  // [BBL_Reservas].Manager.List Box()
  // Por: Alberto Bachler K.: 20-05-15, 12:20:38
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_accion;$l_columna;$l_fila)
C_TEXT:C284($t_asunto;$t_cuerpo;$t_email)

If (Contextual click:C713)
	Case of 
		: (Records in set:C195("$ListboxSet0")=0)
			$l_accion:=Pop up menu:C542("("+__ ("Enviar correo recordatorio...")+";("+__ ("Cancelar Reserva"))
		: (Records in set:C195("$ListboxSet0")=1)
			LISTBOX GET CELL POSITION:C971(*;"lb_reservas";$l_columna;$l_fila)
			READ ONLY:C145([BBL_Reservas:115])
			GOTO SELECTED RECORD:C245([BBL_Reservas:115];$l_fila)
			KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]ID:1;->[BBL_Reservas:115]ID_User:3;False:C215)
			KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]Numero:1;->[BBL_Reservas:115]ID_Item:2;False:C215)
			If (([BBL_Lectores:72]eMail:41#"") & ([BBL_Items:61]Copias_disponibles:43>0))
				$l_accion:=Pop up menu:C542(__ ("Enviar correo recordatorio...")+";"+__ ("Cancelar Reserva"))
			Else 
				$l_accion:=Pop up menu:C542("("+__ ("Enviar correo recordatorio...")+";"+__ ("Cancelar Reserva"))
			End if 
		: (Records in set:C195("$ListboxSet0")>1)
			$l_accion:=Pop up menu:C542("("+__ ("Enviar correo recordatorio...")+";"+__ ("Cancelar Reserva"))
	End case 
	
	Case of 
		: ($l_accion=1)
			$t_email:=[BBL_Lectores:72]eMail:41
			$t_asunto:="Recordatorio de reserva en biblioteca"
			$t_cuerpo:=Choose:C955([BBL_Lectores:72]Sexo:23="F";__ ("Estimada ")+[BBL_Lectores:72]Nombre_Comun:35;__ ("Estimado ")+[BBL_Lectores:72]Nombre_Comun:35)+", \r\r"+\
				__ ("Te informamos que tu reserva de ^0 está disponible para que lo retires en biblioteca antes de ^1.\r\rAtentamente,\r\r\r^2\r^3")
			$t_cuerpo:=Replace string:C233($t_cuerpo;"^0";[BBL_Items:61]Primer_título:4)
			$t_cuerpo:=Replace string:C233($t_cuerpo;"^1";DT_fechaAmigable ([BBL_Reservas:115]Until:4;__ ("el");System date long:K1:3))
			$t_cuerpo:=Replace string:C233($t_cuerpo;"^2";USR_GetUserName )
			$t_cuerpo:=Replace string:C233($t_cuerpo;"^3";<>gBBL_NombreBiblioteca)
			OPEN URL:C673("mailto:"+$t_email+"?cc="+""+"&from="+"noResponder@mediatrack.colegium.com"+"&subject="+$t_asunto+"&body="+$t_Cuerpo)
			BBL_LeeConfiguracion 
			
			
			
		: ($l_accion=2)
			If (Records in set:C195("$ListboxSet0")>0)
				USE SET:C118("$ListboxSet0")
				
				
				START TRANSACTION:C239
				SET QUERY AND LOCK:C661(True:C214)
				KRL_RelateSelection (->[BBL_Items:61]Numero:1;->ID_Item:2)
				If ((Records in set:C195("lockedSet")=0) & (OK=1))
					KRL_DeleteSelection (->[BBL_Reservas:115])
					VALIDATE TRANSACTION:C240
				Else 
					CANCEL TRANSACTION:C241
				End if 
				SET QUERY AND LOCK:C661(False:C215)
				
				
				READ ONLY:C145([BBL_Reservas:115])
				ALL RECORDS:C47([BBL_Reservas:115])
				ORDER BY:C49([BBL_Reservas:115];[BBL_Reservas:115]From:5;>)
			End if 
	End case 
End if 