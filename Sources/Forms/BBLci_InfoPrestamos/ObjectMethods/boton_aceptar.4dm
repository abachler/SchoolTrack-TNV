  // BBLci_InfoPrestamos.Botón 3D1()
  // Por: Alberto Bachler: 26/10/13, 17:19:13
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_abajo;$l_abajoV;$l_Arriba;$l_ArribaV;$l_condonarMulta;$l_derecha;$l_derechaV;$l_izquierda;$l_izquierdaV;$l_multaPagada)
C_LONGINT:C283($l_recNumLector;$l_recNumRegistro;$l_selected;$l_soloMulta)
C_POINTER:C301($y_Variable)
C_REAL:C285($r_multa)

CREATE SET:C116([BBL_Prestamos:60];"$prestamos")

$y_Variable:=OBJECT Get pointer:C1124(Object named:K67:5;"opcionMulta_condonar")
$l_condonarMulta:=$y_Variable->

$y_Variable:=OBJECT Get pointer:C1124(Object named:K67:5;"opcionMulta_soloMulta")
$l_soloMulta:=$y_Variable->

$y_Variable:=OBJECT Get pointer:C1124(Object named:K67:5;"opcionMulta_MultaPagada")
$l_multaPagada:=$y_Variable->

$y_montoMulta:=OBJECT Get pointer:C1124(Object named:K67:5;"montoMulta")
$r_multa:=$y_montoMulta->

$y_recNumPrestamo:=OBJECT Get pointer:C1124(Object named:K67:5;"recNumPrestamo")
$l_recNumPrestamo:=$y_recNumPrestamo->
KRL_GotoRecord (->[BBL_Prestamos:60];$l_recNumPrestamo)

BBLci_RegistraDevolucion ($l_recNumPrestamo)
Case of 
	: ($l_multaPagada=1)
		BBLci_MultaPorDevolucionTardia (Record number:C243([BBL_Prestamos:60]);$r_multa)
		BBLci_RegistraPago ([BBL_Prestamos:60]Número_de_lector:2;$r_multa)
		
	: ($l_soloMulta=1)
		BBLci_MultaPorDevolucionTardia (Record number:C243([BBL_Prestamos:60]);$r_multa)
		
		
	: ($l_condonarMulta=1)
		  // nada se omite la multa
End case 

REMOVE FROM SET:C561([BBL_Prestamos:60];"$prestamos")
USE SET:C118("$prestamos")
CLEAR SET:C117("$prestamos")

If (Records in selection:C76([BBL_Prestamos:60])>0)
	IT_RestableceGeometriaObjetos 
	$l_recNumLector:=Record number:C243([BBL_Lectores:72])
	$l_selected:=Selected record number:C246([BBL_Prestamos:60])
	GOTO SELECTED RECORD:C245([BBL_Prestamos:60];$l_selected)
	$l_recNumRegistro:=Find in field:C653([BBL_Registros:66]ID:3;[BBL_Prestamos:60]Número_de_registro:1)
	ORDER BY:C49([BBL_Prestamos:60];[BBL_Prestamos:60]Fecha_de_devolución:5;>;[BBL_Prestamos:60]Hasta:4;<)
	KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector)
	
	OBJECT GET COORDINATES:C663(*;"subformulario";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
	GET WINDOW RECT:C443($l_izquierdaV;$l_ArribaV;$l_derechaV;$l_abajoV)
	SET WINDOW RECT:C444($l_izquierdaV;$l_ArribaV;$l_derechaV;$l_ArribaV+$l_abajo)
	OBJECT SET RGB COLORS:C628(*;"fondo";0x00FFFFFF;0x00FFFFFF)
	Case of 
		: (Application version:C493>="1400")
			FORM GOTO PAGE:C247(1)
		: (vt_nombreSubFormulario="ListaPrestamos_Lector")
			FORM GOTO PAGE:C247(1)
		: (vt_nombreSubFormulario="ListaPrestamos_Items")
			FORM GOTO PAGE:C247(4)
	End case 
Else 
	CANCEL:C270
End if 


BBLci_InformacionesItem ("Set")
BBLci_InformacionesLector ("Set")





