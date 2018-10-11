//%attributes = {}
  //LOC_LoadList

  //`xShell, Alberto Bachler
  //Metodo: LOC_LoadList
  //Por abachler
  //Creada el 16/08/2004, 10:43:15
  //Modificaciones:
If ("DESCRIPCION"="")
	  //carga la lista correspondiente al lenguaje seleccionado
	  //Sintaxis: $error:=LOC_LoadList(&T)
	  //-> $1: Nombre de la lista (text
	  //<- $0: Resultado
	  //          <>0: referencia de la lista
	  //          0: la lista no pudo ser cargada
	  //         
End if 

  //****DECLARACIONES****
C_TEXT:C284($1;$t_nombreLista)
C_LONGINT:C283($0)

  //****INICIALIZACIONES****
$t_nombreLista:=$1

  //****CUERPO****
$l_listRef:=New list:C375
Case of 
	: ($t_nombreLista="ACT_TramosIngreso")
		APPEND TO LIST:C376($l_listRef;__ ("No informado");1)
		APPEND TO LIST:C376($l_listRef;__ ("Inferior a 100 mil");2)
		APPEND TO LIST:C376($l_listRef;__ ("Entre 101 mil y 150 mil");3)
		APPEND TO LIST:C376($l_listRef;__ ("Entre 151 mil y 200 mil");4)
		APPEND TO LIST:C376($l_listRef;__ ("Entre 201 mil y 300 mil");5)
		APPEND TO LIST:C376($l_listRef;__ ("Entre 301 mil y 400 mil");6)
		APPEND TO LIST:C376($l_listRef;__ ("Entre 401 mil y 600 mil");7)
		APPEND TO LIST:C376($l_listRef;__ ("Entre 601 mil y 1 millón");8)
		APPEND TO LIST:C376($l_listRef;__ ("Más de un millón");9)
		
	: ($t_nombreLista="ACT_modo_de_pago")
		APPEND TO LIST:C376($l_listRef;__ ("En el Colegio");1)
		APPEND TO LIST:C376($l_listRef;__ ("Pago Automático de Cuenta");2)
		APPEND TO LIST:C376($l_listRef;__ ("Cargo a Tarjeta de Crédito");3)
		APPEND TO LIST:C376($l_listRef;__ ("Cuponera");4)
		
	: ($t_nombreLista="VarTypes SuperReport")
		APPEND TO LIST:C376($l_listRef;__ ("Variable");1)
		APPEND TO LIST:C376($l_listRef;__ ("Arreglo (Automático)");2)
		APPEND TO LIST:C376($l_listRef;__ ("Elemento de arreglo");3)
		
	: ($t_nombreLista="ACT_ItemsEspeciales")
		APPEND TO LIST:C376($l_listRef;__ ("Intereses");1)
		APPEND TO LIST:C376($l_listRef;__ ("Recargos por adelantado");2)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento por caja afecto");3)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento por caja exento");4)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento diferencia moneda");5)
		APPEND TO LIST:C376($l_listRef;__ ("Cargo diferencia moneda");6)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento exento nota de crédito");7)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento afecto nota de crédito");8)
		APPEND TO LIST:C376($l_listRef;__ ("Devolución nota de crédito");9)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento por cuenta");10)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento por número de hijo");11)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento por número de cargas");12)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento por generador");13)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento Relativo");14)
		APPEND TO LIST:C376($l_listRef;__ ("Cargo Relativo");15)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento afecto condonación");16)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento exento condonación");17)
		APPEND TO LIST:C376($l_listRef;__ ("Cargo eliminación descuento afecto");18)
		APPEND TO LIST:C376($l_listRef;__ ("Cargo eliminación descuento exento");19)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento afecto por tramo");20)
		APPEND TO LIST:C376($l_listRef;__ ("Descuento exento por tramo");21)
		
	: ($t_nombreLista="ACT_MotivosProtesto")
		APPEND TO LIST:C376($l_listRef;__ ("Firma disconforme");1)
		APPEND TO LIST:C376($l_listRef;__ ("Fecha inexistente");2)
		APPEND TO LIST:C376($l_listRef;__ ("Diferencia entre la cantidad expresa en números y la cantidad expresa en palabras");3)
		APPEND TO LIST:C376($l_listRef;__ ("Caducidad del cheque");4)
		APPEND TO LIST:C376($l_listRef;__ ("Orden de no pago");5)
		APPEND TO LIST:C376($l_listRef;__ ("Falta de fondos");6)
		APPEND TO LIST:C376($l_listRef;__ ("Cuenta cerrada");7)
		APPEND TO LIST:C376($l_listRef;__ ("Endoso irregular");8)
		APPEND TO LIST:C376($l_listRef;__ ("Endoso incompleto");9)
		
	: ($t_nombreLista="ACT_MotivosProtestoLC")
		APPEND TO LIST:C376($l_listRef;__ ("Falta de Aceptación");1)
		APPEND TO LIST:C376($l_listRef;__ ("Falta de fecha de Aceptación");2)
		APPEND TO LIST:C376($l_listRef;__ ("Falta de pago");3)
		
	: ($t_nombreLista="ACT_PaginasIngresoPago")
		APPEND TO LIST:C376($l_listRef;__ ("Aviso");1)
		APPEND TO LIST:C376($l_listRef;__ ("Item");2)
		APPEND TO LIST:C376($l_listRef;__ ("Cuenta");3)
		APPEND TO LIST:C376($l_listRef;__ ("Período");4)
		
	: ($t_nombreLista="SNT_ConfigLogs")
		APPEND TO LIST:C376($l_listRef;__ ("Envíos");1)
		APPEND TO LIST:C376($l_listRef;__ ("Recepciones");2)
		
	: ($t_nombreLista="TS_Aplicacion")
		APPEND TO LIST:C376($l_listRef;"SchoolTrack";1)
		APPEND TO LIST:C376($l_listRef;"MediaTrack";2)
		APPEND TO LIST:C376($l_listRef;"AccountTrack";3)
		APPEND TO LIST:C376($l_listRef;"AdmissionTrack";4)
		
	: ($t_nombreLista="TS_TipoIncidente")
		APPEND TO LIST:C376($l_listRef;"Consulta";1)
		APPEND TO LIST:C376($l_listRef;"Reporte de defecto";2)
		APPEND TO LIST:C376($l_listRef;"Requerimiento";3)
		
	: ($t_nombreLista="TS_CategoriaDefecto")
		APPEND TO LIST:C376($l_listRef;__ ("Cierre o bloqueo de la aplicación");1)
		APPEND TO LIST:C376($l_listRef;__ ("Resultado Inesperado");2)
		APPEND TO LIST:C376($l_listRef;__ ("Impide utilizar función");3)
		APPEND TO LIST:C376($l_listRef;__ ("Mensaje de error");4)
		APPEND TO LIST:C376($l_listRef;__ ("Error Ortográfico");4)
		APPEND TO LIST:C376($l_listRef;__ ("Apariencia");4)
		
	: ($t_nombreLista="TS_Prioridad")
		APPEND TO LIST:C376($l_listRef;"Muy baja";1)
		APPEND TO LIST:C376($l_listRef;"Baja";2)
		APPEND TO LIST:C376($l_listRef;"Media";3)
		APPEND TO LIST:C376($l_listRef;"Alta";4)
		APPEND TO LIST:C376($l_listRef;"Muy Alta";4)
End case 

$0:=$l_listRef