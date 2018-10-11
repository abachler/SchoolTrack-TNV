//%attributes = {}
  // SYS_CreaCarpeta(rutaCarpeta:&T{;crearEnServidor})
  // Por: Alberto Bachler K.: 21-10-14, 11:00:01
  //  ---------------------------------------------
  // Crea la ruta pasada en rutaCarpetas
  // Si se pasa TRUE en crearEnServidor, la ruta es creada en el servidor
  //  ---------------------------------------------
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($b_crearEnServidor)
C_TEXT:C284($t_rutaCarpeta)


If (False:C215)
	C_TEXT:C284(SYS_CreaCarpeta ;$1)
	C_BOOLEAN:C305(SYS_CreaCarpeta ;$2)
End if 

$t_rutaCarpeta:=$1
If (Count parameters:C259=2)
	$b_crearEnServidor:=$2
End if 

OK:=0
If ($t_rutaCarpeta#"")
	If ($b_crearEnServidor)
		SYS_CreaCarpetaServidor ($t_rutaCarpeta)
	Else 
		
		If (Test path name:C476($t_rutaCarpeta)#Is a folder:K24:2)
			Case of 
				: (SYS_IsWindows )
					$t_rutaCarpeta:=Replace string:C233($t_rutaCarpeta;":";Folder separator:K24:12)
					$t_rutaCarpeta:=Replace string:C233($t_rutaCarpeta;"\\\\";":\\")
				: (SYS_IsMacintosh )
					$t_rutaCarpeta:=Replace string:C233($t_rutaCarpeta;"\\";Folder separator:K24:12)
			End case 
			
			$t_rutaCarpeta:=Replace string:C233($t_rutaCarpeta;Folder separator:K24:12+Folder separator:K24:12;Folder separator:K24:12)
			
			If (Substring:C12($t_rutaCarpeta;Length:C16($t_rutaCarpeta);1)#Folder separator:K24:12)
				$t_rutaCarpeta:=$t_rutaCarpeta+Folder separator:K24:12
			End if 
			
			CREATE FOLDER:C475($t_rutaCarpeta;*)
		End if 
	End if 
End if 