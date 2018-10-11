//%attributes = {}
  // Método: 4D_DesignModeTasks
  //
  // 
  // por Alberto Bachler Klein
  // creación 03/11/17, 12:32:12
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


C_BOOLEAN:C305($b_ignore)
C_LONGINT:C283($i;$l_ignore;$l_origen;$l_winRef)
C_TEXT:C284($t_currentWindowTitle;$t_ignore;$t_version)


If (Not:C34(Is compiled mode:C492))
	If ((Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Remote mode:K5:5))
		
		
		ARRAY LONGINT:C221($al_windowRefs;0)
		ARRAY LONGINT:C221($l_refVentanas;0)
		
		$t_estructura:=Structure file:C489(*)
		If (Application type:C494=4D Local mode:K5:1)
			$t_estructura:=SYS_Path2FileName ($t_estructura)
		End if 
		$t_estructura:=$t_estructura+" - "
		
		
		$t_nombreMaquina:=SYS_GetServerProperty (XS_MachineName)
		
		$t_version:=" - "+<>vt_ApplicationSignature+" "+SYS_LeeVersionEstructura 
		
		Case of 
			: (Application type:C494=4D Local mode:K5:1)
				$t_version:=$t_version+" (Local)"
			: (Application type:C494=4D Remote mode:K5:5)
				$t_version:=$t_version+" (4D Server: "+$t_nombreMaquina+")"
		End case 
		
		
		If (Count parameters:C259=0)
			$l_proceso:=New process:C317(Current method name:C684;64*1024;"$DesignMode tasks";"";*)
			
		Else 
			While (Not:C34(Process aborted:C672))
				WINDOW LIST:C442($al_windowRefs)
				
				
				For ($i;1;Size of array:C274($al_windowRefs))
					$l_winRef:=$al_windowRefs{$i}
					PROCESS PROPERTIES:C336(Window process:C446($l_winRef);$t_ignore;$l_ignore;$l_ignore;$b_ignore;$l_ignore;$l_origen)
					
					If ($l_origen=Design process:K36:9)
						
						$t_currentWindowTitle:=Get window title:C450($l_winRef)
						$t_currentWindowTitle:=Replace string:C233($t_currentWindowTitle;$t_estructura;"")
						
						
						If (Position:C15($t_version;$t_currentWindowTitle)=0)
							SET WINDOW TITLE:C213($t_currentWindowTitle+$t_version;$l_winRef)
						End if 
						
						
					End if 
				End for 
				DELAY PROCESS:C323(Current process:C322;30)
			End while 
		End if 
	End if 
End if 