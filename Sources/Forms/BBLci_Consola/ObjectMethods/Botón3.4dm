  // BBLci_Consola.Botón3()
  //
  //
  // creado por: Alberto Bachler Klein: 19-01-16, 18:00:08 (2013)
  // -----------------------------------------------------------
C_DATE:C307($d_fechaDevolucionFija)
C_LONGINT:C283($i;$l_hoja;$l_itemSeleccionado;$l_progress;$l_refHoja;$l_refXLS)
C_POINTER:C301($y_fechaDevolucionFija;$y_nil)
C_TEXT:C284($t_fecha;$t_ItemsMenu;$t_rutaDocumento)

ARRAY TEXT:C222($at_fecha;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY POINTER:C280($ay_columnas;0)
ARRAY TEXT:C222($at_accion;0)
ARRAY TEXT:C222($at_encabezados;0)
ARRAY TEXT:C222($at_evento;0)
ARRAY TEXT:C222($at_lector;0)
ARRAY TEXT:C222($at_registro;0)

$y_fechaDevolucionFija:=OBJECT Get pointer:C1124(Object named:K67:5;"fechaDevolucionFija")
$d_fechaDevolucionFija:=$y_fechaDevolucionFija->
If ($d_fechaDevolucionFija=!00-00-00!)
	$t_ItemsMenu:=__ ("Opciones de la consola...")+";(-;"+__ ("Fijar fecha de devolución...")+";"+"!"+Char:C90(18)+__ ("Fecha de devolución calculada")+";(-;"+__ ("Mostrar Bitácora en Microsoft Excel ®")
Else 
	$t_ItemsMenu:=__ ("Opciones de la consola...")+";(-;"+"!"+Char:C90(18)+__ ("Fecha de devolución fija: ")+String:C10($d_fechaDevolucionFija;Internal date short special:K1:4)+";"+__ ("Fecha de devolución calculada")+";(-;"+__ ("Mostrar Bitácora en Microsoft Excel ®")
End if 

$l_itemSeleccionado:=Pop up menu:C542($t_ItemsMenu)

Case of 
	: ($l_itemSeleccionado=1)
		BBLci_PreferenciasConsola ("Editar")
		BBLci_estableceModo (vl_modoConsola)
		
	: ($l_itemSeleccionado=3)
		$d_fechaDevolucionFija:=DT_PopCalendar 
		If ($d_fechaDevolucionFija#!00-00-00!)
			If ($d_fechaDevolucionFija>=Current date:C33(*))
				$y_fechaDevolucionFija->:=$d_fechaDevolucionFija
				ModernUI_Notificacion ("Fijación de la fecha de devolución de préstamos";"A contar de este momento la fecha de devolución queda fijada al "+String:C10($d_fechaDevolucionFija;Internal date short special:K1:4)+".\r\rPuede volver a la fecha calculada cuando lo desee seleccionando el ítem \"Fecha de devolución calculada\" en las opciones de la consola.")
			Else 
				ModernUI_Notificacion ("No se puede fijar como fecha de devolución una fecha anterior a hoy")
			End if 
		End if 
		
	: ($l_itemSeleccionado=4)
		$y_fechaDevolucionFija->:=!00-00-00!
		
	: ($l_itemSeleccionado=6)
		ALL RECORDS:C47([xxBBL_Logs:41])
		SELECTION TO ARRAY:C260([xxBBL_Logs:41];$al_recNums)
		$l_refXLS:=XLS_CreateBook 
		$l_refHoja:=XLS_CreateSheet ($l_refXLS;"Bitácora de circulación")
		$l_hoja:=1
		$l_progress:=Progress New 
		Progress SET TITLE ($l_progress;"Exportando bitácora a Excel")
		For ($i;1;Size of array:C274($al_recNums))
			GOTO RECORD:C242([xxBBL_Logs:41];$al_recNums{$i})
			$t_fecha:=DTS_GetDateTimeString ([xxBBL_Logs:41]DTS:2)
			APPEND TO ARRAY:C911($at_fecha;$t_fecha)
			APPEND TO ARRAY:C911($at_evento;BBLci_eventoConsola )
			APPEND TO ARRAY:C911($at_accion;[xxBBL_Logs:41]Texto_Operacion:11)
			APPEND TO ARRAY:C911($at_lector;[xxBBL_Logs:41]Texto_lector:9)
			APPEND TO ARRAY:C911($at_registro;[xxBBL_Logs:41]Texto_registro_o_item:10)
			Progress SET PROGRESS ($l_progress;$i/Size of array:C274($al_recNums))
		End for 
		Progress QUIT ($l_progress)
		AT_AppendItems2TextArray (->$at_encabezados;"Fecha";"Evento";"Detalle";"Lector";"Ítem o registro")
		AT_AppendToPointerArray (->$ay_columnas;->$at_fecha;->$at_evento;->$at_accion;->$at_lector;->$at_registro)
		XLS_SetColumns ($l_refHoja;->$ay_columnas;->$at_encabezados)
		$t_rutaDocumento:=Temporary folder:C486+"Bitacora de Circulacion.xls"
		XLS_SaveDocument ($l_refXLS;$t_rutaDocumento)
		XLS_ClearSheet ($l_refHoja)
		XLS_ClearBook ($l_refXLS)
		
		OPEN URL:C673($t_rutaDocumento)
		
	: ($l_itemSeleccionado=4)
		
End case 










