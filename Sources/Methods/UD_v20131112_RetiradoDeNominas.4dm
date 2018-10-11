//%attributes = {}
  // UD_v20131112_RetiradoDeNominas()
  // Por: Alberto Bachler: 12/11/13, 20:49:31
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------





<>vb_ImportHistoricos_STX:=True:C214
MESSAGES ON:C181
READ WRITE:C146([Alumnos:2])
ALL RECORDS:C47([Alumnos:2])
APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]ocultoEnNominas:89:=False:C215)
QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="Retirado@";*)
QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20="RET"+String:C10(<>gYear))
APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]ocultoEnNominas:89:=True:C214)
MESSAGES OFF:C175
<>vb_ImportHistoricos_STX:=False:C215  //ASM para activar los trigger nuevamente.



