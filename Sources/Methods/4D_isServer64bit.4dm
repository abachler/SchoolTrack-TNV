//%attributes = {"executedOnServer":true}
  // Método: 4D_isServer64bit
  //
  //
  // por Alberto Bachler Klein
  // creación 24/01/18, 16:25:15
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($0)


If (False:C215)
	C_BOOLEAN:C305($0)
End if 

$0:=Version type:C495 ?? 64 bit version:K5:25


