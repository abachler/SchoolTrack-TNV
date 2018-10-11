//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 30-09-17, 16:52:16
  // ----------------------------------------------------
  // Método: UD_v20170930_CargaResposableLB
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



ARRAY TEXT:C222(at_funcionarioNombre;0)
ARRAY TEXT:C222(at_cargoFuncionario;0)
ARRAY LONGINT:C221(al_IdFuncionario;0)

READ WRITE:C146([xxSTR_Niveles:6])
ALL RECORDS:C47([xxSTR_Niveles:6])
SELECTION TO ARRAY:C260([xxSTR_Niveles:6]ID_DirectorNivel:52;$al_DirectorNivel;[xxSTR_Niveles:6]Director:13;$at_director)

$l_progres:=IT_Progress (1;0;0;"Verificando responsable de nivel...")
For ($i;1;Size of array:C274($al_DirectorNivel))
	AT_Initialize (->at_funcionarioNombre;->at_cargoFuncionario;->al_IdFuncionario)
	$l_progres:=IT_Progress (0;$l_progres;$i/Size of array:C274($al_DirectorNivel);"Verificando responsable de nivel...")
	If ([xxSTR_Niveles:6]ID_DirectorNivel:52>0)
		APPEND TO ARRAY:C911(at_funcionarioNombre;$at_director{$i})
		APPEND TO ARRAY:C911(al_IdFuncionario;$al_DirectorNivel{$i})
		APPEND TO ARRAY:C911(at_cargoFuncionario;"Director(a)")
	End if 
	
	C_OBJECT:C1216($ob_responsable)
	$ob_responsable:=OB_Create 
	OB_SET ($ob_responsable;->at_funcionarioNombre;"nombre")
	OB_SET ($ob_responsable;->at_cargoFuncionario;"cargo")
	OB_SET ($ob_responsable;->al_IdFuncionario;"id")
	[xxSTR_Niveles:6]OB_responsable:28:=$ob_responsable
	
	SAVE RECORD:C53([xxSTR_Niveles:6])
	
End for 
$l_progres:=IT_Progress (-1;$l_progres)