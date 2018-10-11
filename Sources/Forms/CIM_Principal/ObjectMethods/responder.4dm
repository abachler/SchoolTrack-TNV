  // CIM_Principal.responder()
  // Por: Alberto Bachler K.: 04-11-14, 07:34:03
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

vtTS_EventID:=String:C10(alTS_TicketNumber{alTS_TicketNumber})
vtTS_Topic:=atTS_Asunto{alTS_TicketNumber}

If (LB_GetSelectedRows (->lb_ComentariosTicket)=0)
	vtTS_ComentarioOriginal:=""
End if 

WDW_OpenFormWindow (->[xxSTR_Constants:1];"TS_EnviaIncidente";-1;8;__ ("Comentario para ticket N˚ ")+vtTS_EventID)
DIALOG:C40([xxSTR_Constants:1];"TS_EnviaIncidente")
CLOSE WINDOW:C154