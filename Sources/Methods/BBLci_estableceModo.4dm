//%attributes = {}
  // BBLci_estableceModo()
  // Por: Alberto Bachler: 24/09/13, 12:06:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_PICTURE:C286($p_noImagen)
C_LONGINT:C283($l_modoConsola)
C_POINTER:C301(vy_CampoBusqueda_BBLci)
C_TEXT:C284($t_fondoBoton;$t_nombreBoton;$t_tip)

If (False:C215)
	C_LONGINT:C283(BBLci_estableceModo ;$1)
End if 

If (Count parameters:C259=0)
	$t_nombreBoton:=OBJECT Get name:C1087(Object current:K67:2)
	If ($t_nombreBoton#"")
		$l_modoConsola:=Num:C11($t_nombreBoton)
	Else 
		$l_modoConsola:=Num:C11(Get selected menu item parameter:C1005)
	End if 
Else 
	$l_modoConsola:=$1
End if 

If ($l_modoConsola>0)
	$t_nombreBoton:="modo"+String:C10($l_modoConsola)
	$t_fondoBoton:="fondoBoton"+String:C10($l_modoConsola)
	vl_modoConsola:=$l_modoConsola
	
	OBJECT SET RGB COLORS:C628(*;"lector.titulo";0x00303030;0x00FFFFFF)
	OBJECT SET RGB COLORS:C628(*;"item.titulo";0x00303030;0x00FFFFFF)
	
	  // restablezco las propiedades por defecto de los botones
	OBJECT SET RGB COLORS:C628(*;"modo@";0x00687D8E;0x00DDEEFB)
	
	  //  // establezco las propiedades del botón seleccionado
	OBJECT SET RGB COLORS:C628(*;$t_nombreBoton;0x002D93FF;0x00CAE8FB)
	OBJECT SET RGB COLORS:C628(*;"separadorBarra@";0x00E4F2FC;0x00E4F2FC)
	
	REDUCE SELECTION:C351([BBL_Items:61];0)
	  //REDUCE SELECTION([BBL_Lectores];0)
	REDUCE SELECTION:C351([BBL_Registros:66];0)
	
	$y_variableImagen:=OBJECT Get pointer:C1124(Object named:K67:5;"item_imagen")
	$y_variableImagen->:=$p_noImagen
	vt_InstruccionConsola_BBL:=""
	vt_barcodeLector:=""
	vt_barcodeRegistro:=""
	HIGHLIGHT TEXT:C210(vt_InstruccionConsola_BBL;1;1)
	
	DISABLE MENU ITEM:C150(3;10)
	SET MENU ITEM:C348(3;10;__ ("Registrar Multa o Pago"))
	
	Case of 
		: (vl_modoConsola=Prestamo)  // prestamos
			BBLci_ModosBusquedaObjeto ("LR")
			OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorModoBusqueda";->vl_RefCampoBusqueda_BBLci)
			OBJECT SET TITLE:C194(*;"item.titulo";"Documento")
			OBJECT SET TITLE:C194(*;"lector.titulo";"Lector")
			OBJECT SET VISIBLE:C603(*;"item@";True:C214)
			OBJECT SET VISIBLE:C603(*;"lector@";True:C214)
			  //OBJECT SET RGB COLORS(*;"lector@";0x00A0A0A0;0x00FBFBFF)
			  //OBJECT SET RGB COLORS(*;"item@";0x00A0A0A0;0x00FBFBFF)
			  //OBJECT SET RGB COLORS(*;"lector.rectangulo";0x00FBFBFF;0x00FBFBFF)
			  //OBJECT SET RGB COLORS(*;"item.rectangulo";0x00FBFBFF;0x00FBFBFF)
			
		: (vl_modoConsola=Devolucion)  // devolucion
			REDUCE SELECTION:C351([BBL_Lectores:72];0)
			BBLci_ModosBusquedaObjeto ("R")
			vl_RefCampoBusqueda_BBLci:=Barcode_Documento
			OBJECT SET TITLE:C194(*;"item.titulo";"Documento")
			OBJECT SET TITLE:C194(*;"lector.titulo";"")
			OBJECT SET VISIBLE:C603(*;"item@";True:C214)
			OBJECT SET VISIBLE:C603(*;"lector@";False:C215)
			  //OBJECT SET RGB COLORS(*;"lector.rectangulo";0x00FBFBFF;0x00FBFBFF)
			  //OBJECT SET RGB COLORS(*;"lector.rectangulo";0x00FBFBFF;0x00FBFBFF)
			
		: (vl_modoConsola=Renovacion)  // renovacion
			REDUCE SELECTION:C351([BBL_Lectores:72];0)
			BBLci_ModosBusquedaObjeto ("RL")
			vl_RefCampoBusqueda_BBLci:=Barcode_Documento
			OBJECT SET TITLE:C194(*;"item.titulo";"Documento")
			OBJECT SET TITLE:C194(*;"lector.titulo";"")
			OBJECT SET VISIBLE:C603(*;"item@";True:C214)
			OBJECT SET VISIBLE:C603(*;"lector@";False:C215)
			
		: (vl_modoConsola=Reservas)  // reserva
			Case of 
				: (Record number:C243([BBL_Lectores:72])>No current record:K29:2)
					BBLci_ModosBusquedaObjeto ("I")
					OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemModoBusqueda";->vl_RefCampoBusqueda_BBLci)
					BBLci_InfoCampoBusqueda (vl_RefCampoBusqueda_BBLci;->$t_tip;->vy_CampoBusqueda_BBLci)
				Else 
					BBLci_ModosBusquedaObjeto ("L")
					OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorModoBusqueda";->vl_RefCampoBusqueda_BBLci)
					BBLci_InfoCampoBusqueda (vl_RefCampoBusqueda_BBLci;->$t_tip;->vy_CampoBusqueda_BBLci)
			End case 
			OBJECT SET TITLE:C194(*;"item.titulo";"Item")
			OBJECT SET TITLE:C194(*;"lector.titulo";"Lector")
			OBJECT SET VISIBLE:C603(*;"item@";True:C214)
			OBJECT SET VISIBLE:C603(*;"lector@";True:C214)
			
			
		: (vl_modoConsola=Multa)  // multa
			BBLci_ModosBusquedaObjeto ("L")
			OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorModoBusqueda";->vl_RefCampoBusqueda_BBLci)
			OBJECT SET TITLE:C194(*;"item.titulo";"")
			OBJECT SET TITLE:C194(*;"lector.titulo";"Lector")
			OBJECT SET VISIBLE:C603(*;"item@";False:C215)
			OBJECT SET VISIBLE:C603(*;"lector@";True:C214)
			If (Record number:C243([BBL_Lectores:72])>No current record:K29:2)
				SET MENU ITEM:C348(3;10;__ ("Registrar Multa…"))
				ENABLE MENU ITEM:C149(3;10)
			Else 
				DISABLE MENU ITEM:C150(3;10)
				SET MENU ITEM:C348(3;10;__ ("Registrar Multa o Pago"))
			End if 
			
		: (vl_modoConsola=Pago)  // pago
			OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorModoBusqueda";->vl_RefCampoBusqueda_BBLci)
			vl_RefCampoBusqueda_BBLci:=Barcode_Lector
			OBJECT SET TITLE:C194(*;"item.titulo";"")
			OBJECT SET TITLE:C194(*;"lector.titulo";"Lector")
			OBJECT SET VISIBLE:C603(*;"item@";False:C215)
			OBJECT SET VISIBLE:C603(*;"lector@";True:C214)
			If (Record number:C243([BBL_Lectores:72])>No current record:K29:2)
				SET MENU ITEM:C348(3;10;__ ("Registrar Pago…"))
				ENABLE MENU ITEM:C149(3;10)
			Else 
				DISABLE MENU ITEM:C150(3;10)
				SET MENU ITEM:C348(3;10;__ ("Registrar Multa o Pago"))
			End if 
			
		: (vl_modoConsola=Busqueda Item)  // busqueda de item
			REDUCE SELECTION:C351([BBL_Lectores:72];0)
			BBLci_ModosBusquedaObjeto ("I")
			OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemModoBusqueda";->vl_RefCampoBusqueda_BBLci)
			OBJECT SET TITLE:C194(*;"item.titulo";"Ítem")
			OBJECT SET TITLE:C194(*;"lector.titulo";"")
			OBJECT SET VISIBLE:C603(*;"item@";True:C214)
			OBJECT SET VISIBLE:C603(*;"lector@";False:C215)
			
		: (vl_modoConsola=Busqueda Lector)  // busqueda de lector
			  //REDUCE SELECTION([BBL_Lectores];0)
			BBLci_ModosBusquedaObjeto ("L")
			OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorModoBusqueda";->vl_RefCampoBusqueda_BBLci)
			OBJECT SET TITLE:C194(*;"item.titulo";"")
			OBJECT SET TITLE:C194(*;"lector.titulo";"Lector")
			OBJECT SET VISIBLE:C603(*;"item@";False:C215)
			OBJECT SET VISIBLE:C603(*;"lector@";True:C214)
			
	End case 
	
	BBLci_InfoCampoBusqueda (vl_RefCampoBusqueda_BBLci;->$t_tip;->vy_CampoBusqueda_BBLci)
	BBLci_InformacionesLector ("set")
End if 