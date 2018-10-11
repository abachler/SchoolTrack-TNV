  // [BBL_Préstamos].PreferenciaBusquedaConsola()
  // Por: Alberto Bachler: 07/10/13, 11:17:01
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_indice;$l_ItemModoBusqueda;$l_ItemPalabraCompletaAutor;$l_ItemPalabraCompletaMateria;$l_ItemPalabraCompletaTitulo;$l_ItemTipoBusquedaAutor;$l_ItemTipoBusquedaMateria;$l_ItemTipoBusquedaTitulo;$l_LectorBuscarSobreNombre;$l_LectorModoBusqueda)
C_LONGINT:C283($l_LectorPalabraCompleta;$l_LectorTipoBusquedaNombre;$l_puerto;$l_utilizarSSL;$l_modoAutenticacion;$l_valorPreferencia)
C_POINTER:C301($y_nil;$y_objeto)
C_TEXT:C284($t_contraseña;$t_cuentaCorreo;$t_servidorCorreo)

ARRAY LONGINT:C221($al_refModoComparacion;0)
ARRAY TEXT:C222($at_modoComparacion;0)
Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET RGB COLORS:C628(*;"barra@";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Fondo)
		OBJECT SET RGB COLORS:C628(*;"lineaSeparador@";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Borde)
		OBJECT SET RGB COLORS:C628(*;"divisorBarra@";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Borde)
		OBJECT SET RGB COLORS:C628(*;"botonBarra@";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
		OBJECT SET RGB COLORS:C628(*;"lector";<>vl_ColorTextoBoton_Azul;<>vl_ColorFondoBoton)
		OBJECT SET RGB COLORS:C628(*;"titulo";<>vl_ColorTextoBoton_Normal;<>vl_ColorBarra_Fondo)
		OBJECT SET RGB COLORS:C628(*;"marcoMenu@";<>vl_ColorCajaMenu_Borde;<>vl_ColorCajaMenu_Fondo)
		
		OBJECT DUPLICATE:C1111(*;"botonBarra1";"botonBarra2";$y_nil;"botonBarra1";140;0)
		OBJECT DUPLICATE:C1111(*;"botonBarra1";"botonBarra3";$y_nil;"botonBarra1";280;0)
		OBJECT DUPLICATE:C1111(*;"divisorBarra1";"divisorBarra2";$y_nil;"";140;0)
		OBJECT DUPLICATE:C1111(*;"divisorBarra1";"divisorBarra3";$y_nil;"";280;0)
		OBJECT SET TITLE:C194(*;"botonBarra1";__ ("Lectores"))
		OBJECT SET TITLE:C194(*;"botonBarra2";__ ("Items"))
		OBJECT SET TITLE:C194(*;"botonBarra3";__ ("Notificaciones"))
		
		OBJECT SET RGB COLORS:C628(*;"botonBarra@";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
		OBJECT SET RGB COLORS:C628(*;"botonBarra1";<>vl_ColorTextoBoton_Azul;<>vl_ColorFondoBoton)
		
		OBJECT SET RGB COLORS:C628(*;"pie_Boton1";<>vl_ColorBarraPie_BotonPrincipal;<>vl_ColorFondoBoton)
		
		If ($t_contraseña#"")
			OBJECT SET FONT:C164(*;"$t_contraseña";"%Password")
		End if 
		
		BBLci_PreferenciasConsola ("Leer")
		
		BBLci_ModosBusquedaObjeto ("L")
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorModoBusqueda";->$l_LectorModoBusqueda)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_LectorModoBusqueda")
		COPY ARRAY:C226(at_nombreCampoObjeto;$y_objeto->)
		$l_indice:=Find in array:C230(al_refModoBusquedaObjeto;$l_LectorModoBusqueda)
		$y_objeto->:=$l_indice
		
		BBLci_ModosBusquedaObjeto ("I")
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemModoBusqueda";->$l_ItemModoBusqueda)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_ItemModoBusqueda")
		COPY ARRAY:C226(at_nombreCampoObjeto;$y_objeto->)
		$l_indice:=Find in array:C230(al_refModoBusquedaObjeto;$l_ItemModoBusqueda)
		$y_objeto->:=$l_indice
		
		  // menu para seleccionar el modo de comparación al buscar sobre el nombre completo del lector
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_LectorTipoBusquedaNombre")
		QRY_ModosBusquedaPalabrasClave ($y_objeto;->$al_refModoComparacion)
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorTipoBusquedaNombre";->$l_LectorTipoBusquedaNombre)
		$l_valorPreferencia:=Find in array:C230($al_refModoComparacion;$l_LectorTipoBusquedaNombre)
		$y_objeto->:=$l_valorPreferencia
		
		  // menu para seleccionar el modo de comparación al buscar sobre el titulo del item
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_ItemTipoBusquedaTitulo")
		QRY_ModosBusquedaPalabrasClave ($y_objeto;->$al_refModoComparacion)
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaTitulo";->$l_ItemTipoBusquedaTitulo)
		$l_valorPreferencia:=Find in array:C230($al_refModoComparacion;$l_ItemTipoBusquedaTitulo)
		$y_objeto->:=$l_valorPreferencia
		
		  // menu para seleccionar el modo de comparación al buscar sobre el autor del item
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_ItemTipoBusquedaAutor")
		QRY_ModosBusquedaPalabrasClave ($y_objeto;->$al_refModoComparacion)
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaAutor";->$l_ItemTipoBusquedaAutor)
		$l_valorPreferencia:=Find in array:C230($al_refModoComparacion;$l_ItemTipoBusquedaAutor)
		$y_objeto->:=$l_valorPreferencia
		
		  // menu para seleccionar el modo de comparación al buscar sobre el autor del item
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_ItemTipoBusquedaMateria")
		QRY_ModosBusquedaPalabrasClave ($y_objeto;->$al_refModoComparacion)
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaMateria";->$l_ItemTipoBusquedaMateria)
		$l_valorPreferencia:=Find in array:C230($al_refModoComparacion;$l_ItemTipoBusquedaMateria)
		$y_objeto->:=$l_valorPreferencia
		
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorBuscarSobreNombre";->$l_LectorBuscarSobreNombre)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_LectorBuscarSobreNombre")
		$y_objeto->:=$l_LectorBuscarSobreNombre
		
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorPalabraCompleta";->$l_LectorPalabraCompleta)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_LectorPalabraCompleta")
		$y_objeto->:=$l_LectorPalabraCompleta
		
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaTitulo";->$l_ItemPalabraCompletaTitulo)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_ItemPalabraCompletaTitulo")
		$y_objeto->:=$l_ItemPalabraCompletaTitulo
		
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaAutor";->$l_ItemPalabraCompletaAutor)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_ItemPalabraCompletaAutor")
		$y_objeto->:=$l_ItemPalabraCompletaAutor
		
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaMateria";->$l_ItemPalabraCompletaMateria)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_ItemPalabraCompletaMateria")
		$y_objeto->:=$l_ItemPalabraCompletaMateria
		
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$t_cuentaCorreo";->$t_cuentaCorreo)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$t_cuentaCorreo")
		$y_objeto->:=$t_cuentaCorreo
		
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$t_contraseña";->$t_contraseña)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$t_contraseña")
		$y_objeto->:=$t_contraseña
		
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$t_servidorCorreo";->$t_servidorCorreo)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$t_servidorCorreo")
		$y_objeto->:=$t_servidorCorreo
		
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_puerto";->$l_puerto)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_puerto")
		$y_objeto->:=$l_puerto
		
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_utilizarSSL";->$l_utilizarSSL)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_utilizarSSL")
		$y_objeto->:=$l_utilizarSSL
		
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_modoAutenticacion";->$l_modoAutenticacion)
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"$l_modoAutenticacion")
		APPEND TO ARRAY:C911($y_objeto->;"Determinado por el servidor")
		APPEND TO ARRAY:C911($y_objeto->;"Plain")
		APPEND TO ARRAY:C911($y_objeto->;"Login")
		APPEND TO ARRAY:C911($y_objeto->;"CRAM-MD5")
		$y_objeto->:=$l_modoAutenticacion
		
		If ($t_contraseña#"")
			OBJECT SET FONT:C164(*;"$t_contraseña";"%Password")
		End if 
		
		
		  // activo la página 1 del formulario
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"botonBarra1")
		$y_objeto->:=1
		FORM GOTO PAGE:C247(1)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		BBLci_PreferenciasConsola ("Guardar")
		  //BBLci_PreferenciasConsola ("Liberar")//MONO Ticket 204231
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

