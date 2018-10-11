  // [xShell_Reports].Repositorio.opcionesLista()
  // Por: Alberto Bachler K.: 20-08-14, 23:17:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_editable;$b_soloModificados)
C_LONGINT:C283($i;$l_color;$l_colorAzul;$l_estilo;$l_icono;$r)
C_POINTER:C301($y_expresion;$y_palabrasCompletas;$y_tipoComparacion)
C_TEXT:C284($t_refMenu;$t_resultado)

$y_tipoComparacion:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoComparacion")
$y_palabrasCompletas:=OBJECT Get pointer:C1124(Object named:K67:5;"palabrasCompletas")

$t_refMenu:=Create menu:C408
APPEND MENU ITEM:C411($t_refMenu;"Contiene cualquiera de las palabras")
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"0")
APPEND MENU ITEM:C411($t_refMenu;"Contiene todas las palabras")
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"1")
APPEND MENU ITEM:C411($t_refMenu;"Comienza con")
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"2")
APPEND MENU ITEM:C411($t_refMenu;"Es exactamente igual a")
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"3")
APPEND MENU ITEM:C411($t_refMenu;"(-")
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"")
APPEND MENU ITEM:C411($t_refMenu;"Palabras completas")
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"palabrasCompletas")

APPEND MENU ITEM:C411($t_refMenu;"(-")
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"")
APPEND MENU ITEM:C411($t_refMenu;__ ("Todos"))
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"todos")
APPEND MENU ITEM:C411($t_refMenu;__ ("Solo modificados"))
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"modificados")
APPEND MENU ITEM:C411($t_refMenu;"(-")
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"")
APPEND MENU ITEM:C411($t_refMenu;__ ("Obtener todos los reportes desde el repositorio"))
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"descargar")
APPEND MENU ITEM:C411($t_refMenu;__ ("Actualizar todos los reportes de la librería"))
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"actualizar")

If ($y_palabrasCompletas->=1)
	SET MENU ITEM MARK:C208($t_refMenu;6;Char:C90(18))
Else 
	SET MENU ITEM MARK:C208($t_refMenu;6;"")
End if 

Case of 
	: ($y_tipoComparacion->=0)
		SET MENU ITEM MARK:C208($t_refMenu;1;Char:C90(18))
	: ($y_tipoComparacion->=1)
		SET MENU ITEM MARK:C208($t_refMenu;2;Char:C90(18))
	: ($y_tipoComparacion->=2)
		SET MENU ITEM MARK:C208($t_refMenu;3;Char:C90(18))
	: ($y_tipoComparacion->=3)
		SET MENU ITEM MARK:C208($t_refMenu;4;Char:C90(18))
End case 

$t_resultado:=Dynamic pop up menu:C1006($t_refMenu)
RELEASE MENU:C978($t_refMenu)
Case of 
	: ($t_resultado="")
		$r:=1
		
	: ($t_resultado="todos")
		(OBJECT Get pointer:C1124(Object named:K67:5;"soloModificados"))->:=0
		
	: ($t_resultado="modificados")
		(OBJECT Get pointer:C1124(Object named:K67:5;"soloModificados"))->:=1
		
	: ($t_resultado="descargar")
		$r:=CD_Dlog (0;__ ("Se obtendrán y/o actualizarán todos los reportes disponibles en el repositorio (si el reporte no existe en la librería, se obtendrá. Si el reporte existe en la librería, se actualizará si corresponde).")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
		If ($r=1)
			RIN_DescargaLibreria 
		End if 
		
	: ($t_resultado="actualizar")
		$r:=1
		RIN_ActualizaInformes 
		
		
	: ($t_resultado="palabrasCompletas")
		$y_palabrasCompletas->:=Choose:C955($y_palabrasCompletas->=0;1;0)
		POST KEY:C465(Character code:C91("+");Command key mask:K16:1+Option key mask:K16:7)
	Else 
		$y_tipoComparacion->:=Num:C11($t_resultado)
		POST KEY:C465(Character code:C91("+");Command key mask:K16:1+Option key mask:K16:7)
End case 

If ($r>0)
	RIN_BuscaInformes (vSearch)
	$l_colorAzul:=IT_IndexColor2RGB (Dark blue:K11:6)
	$b_soloModificados:=(OBJECT Get pointer:C1124(Object named:K67:5;"soloModificados"))->=1
	If ($b_soloModificados)
		For ($i;Count list items:C380(hlRIN_Informes);1;-1)
			SELECT LIST ITEMS BY POSITION:C381(hlRIN_Informes;$i)
			GET LIST ITEM PROPERTIES:C631(hlRIN_Informes;*;$b_editable;$l_estilo;$l_icono;$l_color)
			If ($l_color=$l_colorAzul)
				DELETE FROM LIST:C624(hlRIN_Informes;*)
			End if 
		End for 
	End if 
	
End if 

