  // [BBL_Items].Busqueda()
  // Por: Alberto Bachler K.: 16-12-14, 09:35:31
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Case of 
	: (Form event:C388=On Load:K2:1)
		$y_menuRef:=OBJECT Get pointer:C1124(Object named:K67:5;"menuRef")
		$y_menuRef->:=Create menu:C408
		
		$t_refMenuInteres:=Create menu:C408
		For ($i;1;Count list items:C380(<>hl_InterestList))
			GET LIST ITEM:C378(<>hl_InterestList;$i;$l_refElemento;$t_textoElemento)
			APPEND MENU ITEM:C411($t_refMenuInteres;$t_textoElemento)
			SET MENU ITEM PARAMETER:C1004($t_refMenuInteres;-1;"interes_"+$t_textoElemento)
		End for 
		
		
		APPEND MENU ITEM:C411($y_menuRef->;__ ("Buscar en todas partes"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"%enTodasPartes")
		SET MENU ITEM MARK:C208($y_menuRef->;1;Char:C90(18))
		APPEND MENU ITEM:C411($y_menuRef->;"(-")
		
		APPEND MENU ITEM:C411($y_menuRef->;__ ("(Buscar sólo en..."))
		APPEND MENU ITEM:C411($y_menuRef->;__ ("  Encabezamiento de materia"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"_F01_encabezado")
		APPEND MENU ITEM:C411($y_menuRef->;__ ("  Título"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"_F02_titulo")
		APPEND MENU ITEM:C411($y_menuRef->;__ ("  Autor"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"_F03_autor")
		APPEND MENU ITEM:C411($y_menuRef->;__ ("  Editor"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"_F04_editor")
		APPEND MENU ITEM:C411($y_menuRef->;__ ("  Serie"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"_F05_serie")
		APPEND MENU ITEM:C411($y_menuRef->;__ ("  Resúmen"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"_F06_resumen")
		APPEND MENU ITEM:C411($y_menuRef->;__ ("  Notas de contenido"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"_F07_notas")
		
		APPEND MENU ITEM:C411($y_menuRef->;"(-")
		APPEND MENU ITEM:C411($y_menuRef->;__ ("(Opciones de comparación"))
		DISABLE MENU ITEM:C150($y_menuRef->;-1)
		
		APPEND MENU ITEM:C411($y_menuRef->;"  "+__ ("Contiene alguna de las palabras"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"Op_contieneAlgunaPalabra_"+String:C10(Contiene alguna de las palabras))
		SET MENU ITEM MARK:C208($y_menuRef->;13;Char:C90(18))
		
		APPEND MENU ITEM:C411($y_menuRef->;"  "+__ ("Contiene todas las palabras"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"Op_contieneTodasPalabras_"+String:C10(Contiene todas las palabras))
		
		APPEND MENU ITEM:C411($y_menuRef->;"  "+__ ("Contiene la frase"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"Op_contieneExpresionExacta_"+String:C10(Contiene la expresion exacta))
		
		APPEND MENU ITEM:C411($y_menuRef->;"  "+__ ("Comienza con"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"Op_comienzaCon_"+String:C10(Comienza con))
		
		APPEND MENU ITEM:C411($y_menuRef->;"  "+__ ("Termina con"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"Op_terminaCon_"+String:C10(Termina con))
		
		APPEND MENU ITEM:C411($y_menuRef->;"  "+__ ("Es exactamente igual"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"Op_esIgual_"+String:C10(Es exactamente))
		
		APPEND MENU ITEM:C411($y_menuRef->;"(-")
		APPEND MENU ITEM:C411($y_menuRef->;__ ("Solo palabras completas"))
		SET MENU ITEM PARAMETER:C1004($y_menuRef->;-1;"_palabrasCompletas")
		SET MENU ITEM MARK:C208($y_menuRef->;20;Char:C90(18))
		(OBJECT Get pointer:C1124(Object named:K67:5;"palabrasCompletas"))->:=1
		
		If (False:C215)
			  //por implementar
			APPEND MENU ITEM:C411($y_menuRef->;"(-")
			APPEND MENU ITEM:C411($y_menuRef->;__ ("Solo items con interés para...");$t_refMenuInteres)
		End if 
		
		REDUCE SELECTION:C351([BBL_Items:61];0)
		
		OBJECT SET TITLE:C194(*;"tipoBusqueda";__ ("Buscar en todas partes"))
		OBJECT SET TITLE:C194(*;"modoComparacion";"Contiene alguna de las palabras")
		OBJECT SET TITLE:C194(*;"resultadoBusqueda";"")
		
		BBL_BusquedaRapida ("ajustesBarraEstado")
		OBJECT SET VISIBLE:C603(*;"resultadoBusqueda";Records in selection:C76([BBL_Items:61])>0)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

OBJECT SET VISIBLE:C603(*;"mostrarEnExplorador";Records in selection:C76([BBL_Items:61])>0)