  // VC4D.Botón 3D()
  //
  //
  // creado por: Alberto Bachler Klein: 14-02-16, 16:57:02
  // -----------------------------------------------------------
C_POINTER:C301($y_integrable)
C_TEXT:C284($t_accion;$t_menu)

$y_integrable:=OBJECT Get pointer:C1124(Object named:K67:5;"integrable")
$y_listbox:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_vc4d")
$y_Rutas:=OBJECT Get pointer:C1124(Object named:K67:5;"ruta")

$t_menu:=Create menu:C408
MNU_Append ($t_menu;"Integrar en servidor…";"integrar";(Find in array:C230($y_integrable->;True:C214)>0))
MNU_Append ($t_menu;"(-")
MNU_Append ($t_menu;"Configuración";"configurar")
MNU_Append ($t_menu;"(-")
MNU_Append ($t_menu;"Explorar VC4D";"explorar")


$t_accion:=Dynamic pop up menu:C1006($t_menu)
RELEASE MENU:C978($t_accion)


Case of 
	: ($t_accion="integrar")
		For ($i;1;Size of array:C274($y_integrable->))
			If ($y_integrable->{$i})
				LISTBOX SELECT ROW:C912(*;"lb_vc4d";$i;lk add to selection:K53:2)
			Else 
				LISTBOX SELECT ROW:C912(*;"lb_vc4d";$i;lk remove from selection:K53:3)
			End if 
		End for 
		VC4D_CommitCode 
		
	: ($t_accion="configurar")
		VC4D_Setup 
		
	: ($t_accion="explorar")
		FORM GOTO PAGE:C247(2)
End case 

