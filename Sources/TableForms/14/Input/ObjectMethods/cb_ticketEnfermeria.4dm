PREF_Set (0;"ImprimirTicketEnfermeria";String:C10(cb_ticketEnfermeria))
  //If (cb_ticketEnfermeria=1)
  //OBJECT SET VISIBLE(*;"rep@";True)
  //OBJECT SET VISIBLE(*;"b_imprimir";True)
  //Else 
  //OBJECT SET VISIBLE(*;"rep@";False)
  //OBJECT SET VISIBLE(*;"b_imprimir";False)
  //End if 
  //ASM 20150318 Ticket 142743
  // MOD Ticket N° 215398 Patricio Aliaga 20180830
  //If (cb_ticketEnfermeria=1)
  //OBJECT SET VISIBLE(*;"rep@";True)
  //If (Is new record([Alumnos_EventosEnfermeria]))
  //OBJECT SET VISIBLE(*;"b_imprimir";False)
  //Else 
  //OBJECT SET VISIBLE(*;"b_imprimir";True)
  //End if 
  //Else 
  //OBJECT SET VISIBLE(*;"rep@";False)
  //OBJECT SET VISIBLE(*;"b_imprimir";False)
  //End if 