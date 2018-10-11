  // [yST_Modificaciones].out.tablacampo()
  // Por: Alberto Bachler K.: 17-01-15, 18:04:16
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


If ((Is table number valid:C999([sync_Modificaciones:284]st_tabla:6)) & (Is field number valid:C1000([sync_Modificaciones:284]st_tabla:6;[sync_Modificaciones:284]st_campo:7)))
	(OBJECT Get pointer:C1124(Object named:K67:5;"tablacampo"))->:="["+Table name:C256([sync_Modificaciones:284]st_tabla:6)+"]"+Field name:C257([sync_Modificaciones:284]st_tabla:6;[sync_Modificaciones:284]st_campo:7)
End if 