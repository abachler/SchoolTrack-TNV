//%attributes = {}
  //BKPs3_ConsultaLog

C_TEXT:C284($0)
C_OBJECT:C1216($ob)

BKPs3_EscribeLog (Current method name:C684+". Colegium permite envío: "+PREF_fGet (0;"AWS_PERMITE_ENVIO_CLG";"1")+". Colegio permite envío: "+PREF_fGet (0;"AWS_COLEGIO_PERMITE_ENVIO_CLG";"1")+".")

OB SET ARRAY:C1227($ob;"error";<>atBKPaws_log)
$0:=JSON Stringify array:C1228($ob)