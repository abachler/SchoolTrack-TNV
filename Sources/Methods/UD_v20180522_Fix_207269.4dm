//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 22-05-18, 13:12:07
  // ----------------------------------------------------
  // Método: UD_v20180522_Fix_207269

C_LONGINT:C283($i;$l_idTermometro)
ARRAY LONGINT:C221($al_idProfesores;0)
READ ONLY:C145([Profesores:4])
QUERY:C277([Profesores:4];[Profesores:4]Inactivo:62=True:C214)
SELECTION TO ARRAY:C260([Profesores:4]Numero:1;$al_idProfesores)
$l_idTermometro:=IT_Progress (1;0;0;__ ("Quitando como responsables de nivel a Profesores y Funcionarios inactivos ..."))
For ($i;1;Size of array:C274($al_idProfesores))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_idProfesores))
	NIV_QuitarResponbleNivel ($al_idProfesores{$i})
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)

