//%attributes = {}
  //SYS_OpenFileInWebBrowser

$document:=$1  //document path (full path)
If (SYS_TestPathName ($document)=1)
	Case of 
		: (SYS_IsMacintosh )
			$doc:="file:///"+Substring:C12($document;Position:C15(Folder separator:K24:12;$document)+1)
			OPEN URL:C673($doc;*)
		: (SYS_IsWindows )
			$doc:="file:///"+$document
			OPEN URL:C673($doc)
	End case 
End if 