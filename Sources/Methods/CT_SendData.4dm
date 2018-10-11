//%attributes = {}
  // CT_SendData()
  // 
  //
  // modificado por: Alberto Bachler Klein: 22-12-16, 11:50:25
  // reemplazo de CMT_Transferencia ("CargaLibreria";->$vt_modulo) por CMT_CargaLibreria con ejecución en el server, eliminación de semaforo innecesario
  // -----------------------------------------------------------



C_BOOLEAN:C305($1)
<>vbCMT_SendSoloModificados:=$1

While (Semaphore:C143("CT_SendData"))
	DELAY PROCESS:C323(Current process:C322;30)
End while 

If (Not:C34(<>vbCMT_SendSoloModificados))
	CMT_CargaLibreria 
End if 

CMT_Send_Info 
vbCMT_LoadedSTLog:=False:C215

<>vbCMT_SendSoloModificados:=True:C214  //esto queda así ya que para los procesos automáticos siempre es solo lo modificado.

CLEAR SEMAPHORE:C144("CT_SendData")