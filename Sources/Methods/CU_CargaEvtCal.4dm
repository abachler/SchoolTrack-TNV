//%attributes = {}
  // CU_CargaEvtCal()
  // 
  //
  // creado por: Alberto Bachler Klein: 05-08-16, 12:43:16
  // -----------------------------------------------------------


C_DATE:C307($d_fecha)
C_LONGINT:C283($feriados;$l_botonMouse;$l_columna;$l_fila;$l_horizontal;$l_index;$l_MouseX;$l_MouseY;$l_vertical)
C_TEXT:C284($t_texto)

GET MOUSE:C468($l_MouseX;$l_MouseY;$l_botonMouse)
$l_horizontal:=$l_MouseX-9
$l_vertical:=$l_MouseY-100
$l_columna:=Int:C8($l_horizontal/154)+1
$l_fila:=Int:C8($l_vertical/80)+1
If ($l_fila>1)
	$l_index:=(($l_fila-1)*5)+$l_columna
Else 
	$l_index:=$l_columna
End if 

If (($l_index>0) & ($l_index<=Size of array:C274(ad_date1)))
	$t_texto:=(OBJECT Get pointer:C1124(Object named:K67:5;"vt_Events"+String:C10($l_index)))->
	  //If ($t_texto#"")
	$d_fecha:=ad_date1{$l_index}
	vd_fechaBloqueoDia:=$d_fecha
	WDW_OpenFormWindow (->[Cursos:3];"Eventos_Agenda";0;4;__ ("Eventos Correspondientes al: ")+String:C10($d_fecha))
	DIALOG:C40([Cursos:3];"Eventos_Agenda")
	CLOSE WINDOW:C154
	  //End if 
Else 
	BEEP:C151
End if 