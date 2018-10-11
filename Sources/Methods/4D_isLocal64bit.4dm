//%attributes = {}
  // Método: 4D_isLocal64bit
  //
  //
  // por Alberto Bachler Klein
  // creación 24/01/18, 16:27:52
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($0)


If (False:C215)
	C_BOOLEAN:C305(4D_isLocal64bit ;$0)
End if 

$0:=Version type:C495 ?? 64 bit version:K5:25


