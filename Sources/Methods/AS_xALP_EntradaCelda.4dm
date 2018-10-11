//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 24-04-18, 14:43:17
  // ----------------------------------------------------
  // Método: AS_xALP_EntradaCelda
  // Descripción
  // Se restaura método para controlar el ingreso a la celda
  //
  // Parámetros
  // ----------------------------------------------------



C_LONGINT:C283($1)  //AreaList Pro object reference
C_LONGINT:C283($2)  //entrycause
C_LONGINT:C283($3)  // only useful when fields are being displayed 
vRow:=AL_GetAreaLongProperty ($1;ALP_Area_EntryRow)  // find out which cell 
vCol:=AL_GetAreaLongProperty ($1;ALP_Area_EntryColumn)

ARRAY POINTER:C280($ay_arrayNames;0)
$error:=AL_GetObjects ($1;ALP_Object_Columns;$ay_arrayNames)

If (vb_AvisaSiCambioPeriodo)
	$l_respuestaUsuario:=CD_Dlog (0;__ ("¡Atención!\rEl período en el que usted se dispone a ingresar evaluaciones no es el período actual."))
	vb_AvisaSiCambioPeriodo:=False:C215
End if 