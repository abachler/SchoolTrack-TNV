//%attributes = {}
  // BBLci_Prestamo_Devolucion()
  // Por: Alberto Bachler: 25/09/13, 12:26:26
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_recNumLector:=$1
$l_recNumRegistro:=$2

KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector)
KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistro)
$l_recNumItem:=KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]Numero:1;->[BBL_Registros:66]Número_de_item:1;True:C214)
QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_registro:1=[BBL_Registros:66]ID:3;*)
QUERY:C277([BBL_Prestamos:60]; & [BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
If (Records in selection:C76([BBL_Prestamos:60])>0)
	$l_recNumPrestamo:=Record number:C243([BBL_Prestamos:60])
	$l_recNumLectorActual:=Find in field:C653([BBL_Lectores:72]ID:1;[BBL_Prestamos:60]Número_de_lector:2)
Else 
	$l_recNumPrestamo:=-1
	$l_recNumLectorActual:=-1
End if 

Case of 
		  //: (($l_recNumItem>=0) & ($l_recNumLector<0) & ($l_recNumPrestamo>=0))  //devolución a usuario no seleccionado
		  //BBLci_Devolucion ($l_recNumRegistro;$l_recNumPrestamo)
		
	: (($l_recNumItem>=0) & ($l_recNumLector=$l_recNumLectorActual) & ($l_recNumPrestamo>=0))  //devolucion al usuario seleccionado
		BBLci_Devolucion ($l_recNumRegistro;$l_recNumPrestamo)
		
	: (($l_recNumItem>=0) & ($l_recNumPrestamo>=0) & ($l_recNumLector#$l_recNumLectorActual))  //item prestado a otro usuario, Devolucion ?
		KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLectorActual)
		$t_nombreLectorActual:=[BBL_Lectores:72]NombreCompleto:3
		$l_idLectorActual:=[BBL_Lectores:72]ID:1
		IT_SetTextStyle_Bold (->$t_nombreLectorActual)
		$t_nombreLectorActual:=$t_nombreLectorActual+" ("+[BBL_Lectores:72]BarCode_SinFormato:38+")"
		KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector)
		$t_nombreNuevoLector:=[BBL_Lectores:72]NombreCompleto:3
		$l_idNuevoLector:=[BBL_Lectores:72]ID:1
		IT_SetTextStyle_Bold (->$t_nombreNuevoLector)
		$t_nombreNuevoLector:=$t_nombreNuevoLector+" ("+[BBL_Lectores:72]BarCode_SinFormato:38+")"
		Case of 
			: (($l_idLectorActual>0) & ($l_idNuevoLector>0))
				$t_mensaje:=__ ("Esta documento esta prestado a ^0\r\r¿Desea registrar su devolución y el préstamo a ^1?")
			: (($l_idLectorActual>0) & ($l_idNuevoLector<0))
				$t_mensaje:=__ ("Esta documento esta prestado a ^0\r\r¿Desea asignarle el estado ^1?")
			: (($l_idLectorActual<0) & ($l_idNuevoLector<0))
				$t_mensaje:=__ ("Esta documento tiene el estado ^0\r\r¿Desea cambiar el estado ^1?")
			: (($l_idLectorActual<0) & ($l_idNuevoLector>0))
				$t_mensaje:=__ ("Esta documento tiene el estado ^0\r\r¿Realmente desea registrar el préstamo  ^1?")
		End case 
		$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_nombreLectorActual)
		$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_nombreNuevoLector)
		$t_mensaje:=Replace string:C233($t_mensaje;"()";"")
		$r:=CD_Dlog (0;$t_mensaje;"";__ ("Sí");__ ("No"))
		
		
		If ($r=2)
			REDUCE SELECTION:C351([BBL_Registros:66];0)
			REDUCE SELECTION:C351([BBL_Items:61];0)
			REDUCE SELECTION:C351([BBL_Prestamos:60];0)
			KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector;False:C215)
		Else 
			  //registro de la devolución      
			BBLci_Devolucion ($l_recNumRegistro;$l_recNumPrestamo)
			If (OK=1)
				  //registro del prestamo
				BBLci_Prestamo ($l_recNumRegistro;$l_recNumItem;$l_recNumLector)
			Else 
				GOTO RECORD:C242([BBL_Lectores:72];$l_recNumLector)
			End if 
		End if 
		
	: (($l_recNumItem>=0) & ($l_recNumLector>=0))
		BBLci_Prestamo ($l_recNumRegistro;$l_recNumItem;$l_recNumLector)
		
	: (($l_recNumItem>=0) & (Records in selection:C76([BBL_Lectores:72])=0))
		$r:=CD_Dlog (0;__ ("No hay ningún usuario seleccionado. El código de barra ingresado fue ignorado."))
End case 


