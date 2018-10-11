//%attributes = {}
If (False:C215)
	Begin SQL
		/*
		
		This is a 4D component of the 7z Software.
		
		On Mac OS, this components uses the following;
		7-Zip 9.13 beta  Copyright (c) 1999-2010 Igor Pavlov  2010-04-15
		Binaries are included for Intel and PPC
		
		On Windows, this components uses the following;
		7-Zip 9.20 beta  Copyright (c) 1999-2010 Igor Pavlov 
		
		2011-12-12: Fixed path escaping for windows; added auto path detection for Win64; added error string
		2011-05-18: Added x64 folder for windows
		2011-01-02: Accepts \!\"#$%&'()=~|<>?;*`[] / in file paths on Mac.
		2011-01-02: Accepts optional password argument
		
		*/
	End SQL
End if 

C_TIME:C306($h_time)

$v:=z7_Get_version 

C_BOOLEAN:C305($success_b)
ARRAY TEXT:C222($at_paths;0)
TRACE:C157
If (Macintosh option down:C545 | Windows Alt down:C563)
	$source_path_t:=Select folder:C670
	$source_path_t:=Substring:C12($source_path_t;1;Length:C16($source_path_t)-1)
	If (OK=1)
		$r_sizeUncompressed:=SYS_GetlocalFolderSize ($source_path_t)
	End if 
Else 
	$t_doc:=Select document:C905("";"";"";0;$at_paths)
	If (OK=1)
		$source_path_t:=$at_paths{1}
		$r_sizeUncompressed:=Get document size:C479($source_path_t)
	End if 
End if 

If (OK=1)
	$archive_target_path_t:=$source_path_t+".7z"
	
	$password:=""
	$error:=""
	$l_ms:=Milliseconds:C459
	$success_b:=z7_Archive ($source_path_t;$archive_target_path_t;$password;->$error)
	$l_ms:=Milliseconds:C459-$l_ms
	
	$r_sizeCompressed:=Get document size:C479($archive_target_path_t)
	$h_time:=($l_ms/1000)
	
	$r_tasa:=$r_sizeCompressed/$r_sizeUncompressed
	$r_tasa:=$r_tasa*100
	
	ALERT:C41($source_path_t+"\r\rComprimido en "+String:C10($h_time)+" ("+String:C10($l_ms)+"ms)."\
		+"\rTamaño original: "+String:C10($r_sizeUncompressed;"### ### ### ### ##0")\
		+"\rTamaño comprimido: "+String:C10($r_sizeCompressed;"### ### ### ### ##0")\
		+"\rTasa de compresión: "+String:C10(Round:C94($r_tasa;2))+"% del tamaño original")
	
	SHOW ON DISK:C922($archive_target_path_t)
End if 



If (False:C215)
	$source_archive_file_path_t:=$archive_target_path_t
	$destination_directory_path_t:=System folder:C487(Desktop:K41:16)
	$error:=""
	$success_b:=z7_Extract ($source_archive_file_path_t;$destination_directory_path_t;$password;->$error)
End if 


