//%attributes = {}
  // BBLci_LeePreferencias()
  // Por: Alberto Bachler: 09/10/13, 12:55:14
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_Blob)
_O_C_INTEGER:C282($i_Items)
C_LONGINT:C283($l_ItemModoBusqueda;$l_ItemPalabraCompletaAutor;$l_ItemPalabraCompletaMateria;$l_ItemPalabraCompletaTitulo;$l_ItemTipoBusquedaAutor;$l_ItemTipoBusquedaMateria;$l_ItemTipoBusquedaTitulo;$l_LectorBuscarSobreNombre;$l_LectorModoBusqueda;$l_LectorPalabraCompleta)
C_LONGINT:C283($l_LectorTipoBusquedaNombre;$l_puerto;$l_utilizarSSL;$l_modoAutenticacion)
C_TIME:C306($h_refDocumento)
C_POINTER:C301($y_nil;$y_objeto)
C_TEXT:C284($t_contraseña;$t_cuentaCorreo;$t_mensaje;$t_preferenciasConsola;$t_rutaPreferencias;$t_rutaPreferencias4D;$t_servidorCorreo)

ARRAY LONGINT:C221($al_TipoItems;0)
ARRAY TEXT:C222($at_nombreItems;0)

C_LONGINT:C283(vl_refObjectoPreferencias_BBLci)
C_LONGINT:C283(vl_RefCampoBusqueda_BBLci)

$t_mensaje:=$1

$t_rutaPreferencias4D:=Get 4D folder:C485(Active 4D Folder:K5:10)
$t_rutaPreferencias:=System folder:C487(User preferences_user:K41:4)+"Colegium"+Folder separator:K24:12+"MediaTrack"+Folder separator:K24:12
$t_preferenciasConsola:=$t_rutaPreferencias+"Preferencias Consola MediaTrack.pref"
Case of 
	: ($t_mensaje="Leer")
		If (OT IsObject (vl_refObjectoPreferencias_BBLci)=1)
			OT Clear (vl_refObjectoPreferencias_BBLci)
		End if 
		If (Test path name:C476($t_preferenciasConsola)#Is a document:K24:1)
			SYS_CreatePath ($t_rutaPreferencias)
			$h_refDocumento:=Create document:C266($t_preferenciasConsola)
			CLOSE DOCUMENT:C267($h_refDocumento)
		End if 
		DOCUMENT TO BLOB:C525($t_preferenciasConsola;$x_Blob)
		If (BLOB size:C605($x_Blob)=0)
			BBLci_PreferenciasConsola ("Inicializar")
			BBLci_PreferenciasConsola ("Leer")
		Else 
			vl_refObjectoPreferencias_BBLci:=OT BLOBToObject ($x_Blob)
			OT GetAllProperties (vl_refObjectoPreferencias_BBLci;$at_nombreItems;$al_TipoItems)
			For ($i_Items;1;Size of array:C274($at_nombreItems))
				$y_objeto:=Get pointer:C304($at_nombreItems{$i_Items})
				OT GetVariable (vl_refObjectoPreferencias_BBLci;$at_nombreItems{$i_Items};$y_objeto)
			End for 
		End if 
		
		
	: ($t_mensaje="Inicializar")
		vl_refObjectoPreferencias_BBLci:=OT New 
		$l_LectorModoBusqueda:=Barcode_Lector
		$l_LectorBuscarSobreNombre:=1  // 1 busca sobre nombre cuando no encuentra codigo de barra 
		$l_LectorTipoBusquedaNombre:=Contiene todas las palabras
		$l_LectorPalabraCompleta:=1
		$l_ItemModoBusqueda:=MultiCriterio_Item
		$l_ItemTipoBusquedaTitulo:=Contiene alguna de las palabras
		$l_ItemPalabraCompletaTitulo:=1
		$l_ItemTipoBusquedaAutor:=Contiene alguna de las palabras
		$l_ItemPalabraCompletaAutor:=1
		$l_ItemTipoBusquedaMateria:=Contiene alguna de las palabras
		$l_ItemPalabraCompletaMateria:=0
		$t_cuentaCorreo:=""
		$t_contraseña:=""
		$t_servidorCorreo:=""
		$l_puerto:=0
		$l_utilizarSSL:=0
		$l_modoAutenticacion:=2
		
		
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorModoBusqueda";->$l_LectorModoBusqueda)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorBuscarSobreNombre";->$l_LectorBuscarSobreNombre)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorTipoBusquedaNombre";->$l_LectorTipoBusquedaNombre)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorPalabraCompleta";->$l_LectorPalabraCompleta)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemModoBusqueda";->$l_ItemModoBusqueda)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaTitulo";->$l_ItemTipoBusquedaTitulo)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaTitulo";->$l_ItemPalabraCompletaTitulo)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaAutor";->$l_ItemTipoBusquedaAutor)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaAutor";->$l_ItemPalabraCompletaAutor)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaMateria";->$l_ItemTipoBusquedaMateria)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaMateria";->$l_ItemPalabraCompletaMateria)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$t_cuentaCorreo";->$t_cuentaCorreo)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$t_contraseña";->$t_contraseña)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$t_servidorCorreo";->$t_servidorCorreo)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_puerto";->$l_puerto)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_utilizarSSL";->$l_utilizarSSL)
		OT PutVariable (vl_refObjectoPreferencias_BBLci;"$l_modoAutenticacion";->$l_modoAutenticacion)
		
		$x_blob:=OT ObjectToNewBLOB (vl_refObjectoPreferencias_BBLci)
		BLOB TO DOCUMENT:C526($t_preferenciasConsola;$x_Blob)
		
	: ($t_mensaje="Editar")
		WDW_OpenPopupWindow ($y_nil;->[BBL_Prestamos:60];"OpcionesConsola";Plain form window:K39:10)
		DIALOG:C40([BBL_Prestamos:60];"OpcionesConsola")
		CLOSE WINDOW:C154
		
	: ($t_mensaje="Guardar")
		$x_blob:=OT ObjectToNewBLOB (vl_refObjectoPreferencias_BBLci)
		BLOB TO DOCUMENT:C526($t_preferenciasConsola;$x_Blob)
		
	: ($t_mensaje="Liberar")
		OT Clear (vl_refObjectoPreferencias_BBLci)
		vl_refObjectoPreferencias_BBLci:=0
		
End case 

