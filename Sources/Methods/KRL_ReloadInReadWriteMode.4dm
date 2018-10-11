//%attributes = {}
  // KRL_ReloadInReadWriteMode()
  // Por: Alberto Bachler K.: 08-12-13, 10:05:45
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


If (Read only state:C362($1->))  // ABK 20131208 - solo se recarga el registro si está en solo lectura, evitando que la perdida de modificaciones no guardadas previamente
	If (Record number:C243($1->)>No current record:K29:2)
		READ WRITE:C146($1->)
		LOAD RECORD:C52($1->)
	Else 
		READ WRITE:C146($1->)
	End if 
End if 

