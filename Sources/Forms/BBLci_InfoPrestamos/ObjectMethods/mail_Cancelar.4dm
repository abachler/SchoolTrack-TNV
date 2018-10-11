  // BBLci_InfoPrestamos.Botón 3D1()
  // Por: Alberto Bachler: 26/10/13, 17:19:13
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_recNumLector)

IT_RestableceGeometriaObjetos 
USE NAMED SELECTION:C332("prestamos")
CLEAR NAMED SELECTION:C333("prestamos")
ORDER BY:C49([BBL_Prestamos:60];[BBL_Prestamos:60]Fecha_de_devolución:5;>;[BBL_Prestamos:60]Hasta:4;<)
GOTO SELECTED RECORD:C245([BBL_Prestamos:60];0)
OBJECT SET VISIBLE:C603(*;"rectangulo1";True:C214)
OBJECT SET VISIBLE:C603(*;"accion@";False:C215)
OBJECT SET VISIBLE:C603(*;"encabezado@";True:C214)
  //OBJECT GET COORDINATES(*;"subformulario";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
  //GET WINDOW RECT($l_izquierdaV;$l_ArribaV;$l_derechaV;$l_abajoV)
  //SET WINDOW RECT($l_izquierdaV;$l_ArribaV;$l_derechaV;$l_ArribaV+$l_abajo)
$l_recNumLector:=Record number:C243([BBL_Lectores:72])
KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector)
Case of 
	: (Application version:C493>="1400")
		FORM GOTO PAGE:C247(1)
	: (vt_nombreSubFormulario="ListaPrestamos_Lector")
		FORM GOTO PAGE:C247(1)
	: (vt_nombreSubFormulario="ListaPrestamos_Items")
		FORM GOTO PAGE:C247(4)
End case 


