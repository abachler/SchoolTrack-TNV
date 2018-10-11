$ref:=Create document:C266("";"TEXT")
If (document#"")
	CLOSE DOCUMENT:C267($ref)
	BLOB TO DOCUMENT:C526(document;vx_Blob)
End if 

