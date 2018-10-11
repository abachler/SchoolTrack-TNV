//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 02-09-16, 12:56:22
  // ----------------------------------------------------
  // Método: ST_JustificacionAtrasos
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($l_JustificacionID)


$t_accion:=$1

If (Count parameters:C259=2)
	$l_JustificacionID:=$2
End if 

Case of 
		
	: ($t_accion="inicializa")
		ALL RECORDS:C47([xxSTR_JustificacionAtrasos:227])
		ORDER BY:C49([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]ID:1;>)
		
	: ($t_accion="eliminaMotivo")
		QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]id_justificacion:13=$l_JustificacionID)
		If (Records in selection:C76([Alumnos_Atrasos:55])=0)
			KRL_ReloadInReadWriteMode (->[xxSTR_JustificacionAtrasos:227])
			DELETE RECORD:C58([xxSTR_JustificacionAtrasos:227])
			
			  // Modificado por: Alexis Bustamante (08-06-2017)
			  //agrego LOG
			LOG_RegisterEvt ("Eliminación de motivo en  configuración de  Justificación Atrasos ")
			
			KRL_ReloadAsReadOnly (->[xxSTR_JustificacionAtrasos:227])
			ALL RECORDS:C47([xxSTR_JustificacionAtrasos:227])
			ORDER BY:C49([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]ID:1;>)
		Else 
			CD_Dlog (0;__ ("El motivo está siendo utilizado. Este no puede ser eliminado"))
		End if 
		
	: ($t_accion="AgregaMotivo")
		CREATE RECORD:C68([xxSTR_JustificacionAtrasos:227])
		[xxSTR_JustificacionAtrasos:227]ID:1:=SQ_SeqNumber (->[xxSTR_JustificacionAtrasos:227]ID:1)
		[xxSTR_JustificacionAtrasos:227]Motivo:2:="Ingrese motivo"
		SAVE RECORD:C53([xxSTR_JustificacionAtrasos:227])
		ALL RECORDS:C47([xxSTR_JustificacionAtrasos:227])
		ORDER BY:C49([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]ID:1;>)
		
		  // Modificado por: Alexis Bustamante (08-06-2017)
		  //agrego LOG
		LOG_RegisterEvt ("Se agrega nuevo motivo en configuración de  Justificación Atrasos.")
	: ($t_accion="guardaJustificacion")
		ALL RECORDS:C47([xxSTR_JustificacionAtrasos:227])
		QUERY SELECTION:C341([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]valido:4=False:C215)
		$ok:=KRL_DeleteSelection (->[xxSTR_JustificacionAtrasos:227])
		
	: ($t_accion="cargaVariables")
		ARRAY TEXT:C222(at_JustificacionNombre;0)
		ARRAY LONGINT:C221(al_JustificacionID;0)
		QUERY:C277([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]activo:5=True:C214)
		ORDER BY:C49([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]ID:1;>)
		SELECTION TO ARRAY:C260([xxSTR_JustificacionAtrasos:227]ID:1;al_JustificacionID;[xxSTR_JustificacionAtrasos:227]Motivo:2;at_JustificacionNombre)
End case 