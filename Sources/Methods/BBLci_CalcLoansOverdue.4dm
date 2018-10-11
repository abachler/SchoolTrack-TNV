//%attributes = {}
  //BBLci_CalcLoansOverdue

QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Hasta:4<Current date:C33;*)
QUERY:C277([BBL_Prestamos:60]; & [BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
$currentDate:=Current date:C33(*)
SELECTION TO ARRAY:C260([BBL_Prestamos:60]Hasta:4;$aDueDate;[BBL_Prestamos:60]Días_de_atraso:15;$aDaysLate)
For ($i;1;Size of array:C274($aDueDate))
	$aDaysLate{$i}:=$currentDate-$aDueDate{$i}
End for 
READ WRITE:C146([BBL_Prestamos:60])
ARRAY TO SELECTION:C261($aDaysLate;[BBL_Prestamos:60]Días_de_atraso:15)
UNLOAD RECORD:C212([BBL_Prestamos:60])
READ ONLY:C145([BBL_Prestamos:60])