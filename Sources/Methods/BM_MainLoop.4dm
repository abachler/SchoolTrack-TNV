//%attributes = {}
  // BM_MainLoop()
  // 
  //
  // modificado por: Alberto Bachler Klein: 22-12-16, 18:10:01
  // -----------------------------------------------------------


C_BOOLEAN:C305($b_ejecutado)
C_LONGINT:C283($i;$l_ticksPausa)

ARRAY LONGINT:C221($al_recNumTareas;0)
C_BOOLEAN:C305(<>stopDaemons)
C_PICTURE:C286(vpXS_IconModule)
C_BLOB:C604($x_blobVacio)

$l_ultimoConteoRegistros:=Milliseconds:C459

MESSAGES OFF:C175
KRL_UnloadAll 
$b_ejecutado:=False:C215
If (Application type:C494#4D Server:K5:6)
	dhBM_Initialisations 
	vsBWR_CurrentModule:="Procesador de tareas"
	GET PICTURE FROM LIBRARY:C565("Module SchoolTrack";vpXS_IconModule)
	
	$l_ticksPausa:=60
	While (Not:C34(<>stopDaemons))
		READ ONLY:C145(*)
		READ ONLY:C145([xShell_BatchRequests:48])
		$ws:=Current machine:C483+"/"+Current system user:C484
		
		QUERY:C277([xShell_BatchRequests:48];[xShell_BatchRequests:48]Key:7#"")
		QUERY SELECTION:C341([xShell_BatchRequests:48];[xShell_BatchRequests:48]EjecutarEn:12="";*)
		QUERY SELECTION:C341([xShell_BatchRequests:48]; | ;[xShell_BatchRequests:48]EjecutarEn:12=$ws)
		
		If (Records in selection:C76([xShell_BatchRequests:48])>0)
			ORDER BY:C49([xShell_BatchRequests:48];[xShell_BatchRequests:48]EjecutarEn:12;<;[xShell_BatchRequests:48]DTS:10;>)
			LONGINT ARRAY FROM SELECTION:C647([xShell_BatchRequests:48];$al_recNumTareas;"")
			For ($i;1;Size of array:C274($al_recNumTareas))
				If (Not:C34(<>stopDaemons))
					KRL_GotoRecord (->[xShell_BatchRequests:48];$al_recNumTareas{$i};True:C214)
					If (OK=1)
						$b_ejecutado:=dhBM_ProcessTasks 
						If ($b_ejecutado)
							KRL_GotoRecord (->[xShell_BatchRequests:48];$al_recNumTareas{$i};True:C214)  //recargamos el registro en caso que haya sido descargado en alguna tarea
							If (OK=1)
								[xShell_BatchRequests:48]Action:1:=""
								[xShell_BatchRequests:48]Msg:2:=""
								[xShell_BatchRequests:48]Key:7:=""
								[xShell_BatchRequests:48]Parameters:8:=$x_blobVacio
								[xShell_BatchRequests:48]DTS:10:=""
								[xShell_BatchRequests:48]EjecutarEn:12:=""
								SAVE RECORD:C53([xShell_BatchRequests:48])
							End if 
						End if 
					End if 
				Else 
					$i:=Size of array:C274($al_recNumTareas)+1
				End if 
				KRL_UnloadAll 
			End for 
		End if 
		
		DELAY PROCESS:C323(Current process:C322;$l_ticksPausa)
	End while 
End if 