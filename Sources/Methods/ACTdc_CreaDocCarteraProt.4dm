//%attributes = {}
  //ACTdc_CreaDocCarteraProt

CREATE RECORD:C68([ACT_Documentos_en_Cartera:182])
[ACT_Documentos_en_Cartera:182]ID:1:=SQ_SeqNumber (->[ACT_Documentos_en_Cartera:182]ID:1)
[ACT_Documentos_en_Cartera:182]ID_Apoderado:2:=[ACT_Documentos_de_Pago:176]ID_Apoderado:2
[ACT_Documentos_en_Cartera:182]ID_Tercero:18:=[ACT_Documentos_de_Pago:176]ID_Tercero:48
[ACT_Documentos_en_Cartera:182]ID_DocdePago:3:=[ACT_Documentos_de_Pago:176]ID:1
[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19:=[ACT_Documentos_de_Pago:176]id_forma_de_pago:51
[ACT_Documentos_en_Cartera:182]Tipo_Doc:4:=[ACT_Documentos_de_Pago:176]Tipodocumento:5
[ACT_Documentos_en_Cartera:182]forma_de_pago_new:20:=[ACT_Documentos_de_Pago:176]forma_de_pago_new:52
[ACT_Documentos_en_Cartera:182]Fecha_Doc:5:=[ACT_Documentos_de_Pago:176]Fecha:13
[ACT_Documentos_en_Cartera:182]Numero_Doc:6:=[ACT_Documentos_de_Pago:176]NoSerie:12
[ACT_Documentos_en_Cartera:182]Monto_Doc:7:=[ACT_Documentos_de_Pago:176]MontoPago:6
[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8:="En Cartera"
[ACT_Documentos_en_Cartera:182]id_estado:21:=[ACT_Documentos_de_Pago:176]id_estado:53
[ACT_Documentos_en_Cartera:182]Estado:9:=[ACT_Documentos_de_Pago:176]Estado:14
[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=!00-00-00!
[ACT_Documentos_en_Cartera:182]Ch_Protestadoel:11:=vdACT_FechaProtesto
[ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12:=!00-00-00!
[ACT_Documentos_en_Cartera:182]Ch_Depositarhasta:13:=!00-00-00!
[ACT_Documentos_en_Cartera:182]MotivoProtesto:16:=[ACT_Documentos_de_Pago:176]MotivoProtesto:38
SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])