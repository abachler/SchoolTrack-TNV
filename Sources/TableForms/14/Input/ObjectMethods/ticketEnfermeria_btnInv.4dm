  //MONO TICKET 203131
ARRAY TEXT:C222($at_TicketEnf;0)

$y_objtEnf:=OBJECT Get pointer:C1124(Object named:K67:5;"ticketEnfermeria_Obj")
$y_nomTickEnfSel:=OBJECT Get pointer:C1124(Object named:K67:5;"ticketEnfermeria_nombre")

OB GET ARRAY:C1229($y_objtEnf->;"ticketEnfermeria_nombre";$at_TicketEnf)

$text:=AT_array2text (->$at_TicketEnf)
$choice:=Pop up menu:C542($text)

If ($choice#0)
	$at_TicketEnf:=$choice
	$y_nomTickEnfSel->:=$at_TicketEnf{$at_TicketEnf}
	OB SET ARRAY:C1227($y_objtEnf->;"ticketEnfermeria_nombre";$at_TicketEnf)
	OB SET:C1220($y_objtEnf->;"ticketEnfermeria_seleccionado";$choice)
End if 