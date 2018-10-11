//%attributes = {}
  // BBLci_InfoPrestamos()
  // Por: Alberto Bachler: 24/10/13, 14:44:15
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283(vl_tablaSubForm)
C_POINTER:C301($y_Nil)



vy_tablaSubformulario:=$1
vt_nombreSubFormulario:=$2

$l_recNumLector:=Record number:C243([BBL_Lectores:72])
$l_recNumRegistro:=Record number:C243([BBL_Registros:66])
$l_recNumItem:=Record number:C243([BBL_Items:61])

READ WRITE:C146([BBL_Prestamos:60])
$l_ventana:=Plain form window:K39:10
WDW_OpenPopupWindow (OBJECT Get pointer:C1124(Object current:K67:2);$y_Nil;"BBLci_InfoPrestamos";$l_ventana)
DIALOG:C40("BBLci_InfoPrestamos")
CLOSE WINDOW:C154

vt_InstruccionConsola_BBL:=""
GOTO OBJECT:C206(vt_InstruccionConsola_BBL)
REDRAW WINDOW:C456
REDRAW:C174(vt_InstruccionConsola_BBL)
REDRAW:C174([BBL_Lectores:72]NombreCompleto:3)

Case of 
	: (vt_nombreSubFormulario="ListaPrestamos_Lector")
		If ($l_recNumRegistro=No current record:K29:2)
			REDUCE SELECTION:C351([BBL_Items:61];0)
			REDUCE SELECTION:C351([BBL_Registros:66];0)
		Else 
			KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistro)
			RELATE ONE:C42([BBL_Registros:66]Número_de_item:1)
		End if 
		KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector;False:C215)
		KRL_ReloadAsReadOnly (->[BBL_Lectores:72])
		BBLci_InformacionesLector ("set")
		
	: (vt_nombreSubFormulario="ListaPrestamos_Items")
		If ($l_recNumLector=No current record:K29:2)
			REDUCE SELECTION:C351([BBL_Lectores:72];0)
		Else 
			KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector;False:C215)
			If ($l_recNumRegistro>No current record:K29:2)
				KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistro)
				RELATE ONE:C42([BBL_Registros:66]Número_de_item:1)
			Else 
				KRL_GotoRecord (->[BBL_Items:61];$l_recNumItem)
			End if 
		End if 
		KRL_ReloadAsReadOnly (->[BBL_Items:61])
		KRL_ReloadAsReadOnly (->[BBL_Lectores:72])
		KRL_ReloadAsReadOnly (->[BBL_Registros:66])
		BBLci_InformacionesItem ("set")
End case 
$0:=OK


