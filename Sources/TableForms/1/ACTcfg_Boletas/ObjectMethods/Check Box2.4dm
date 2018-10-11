If (Self:C308->=1)
	READ ONLY:C145([xxACT_Items:179])
	SET QUERY DESTINATION:C396(Into variable:K19:4;$recs1)
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8#0)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$recs2)
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	Case of 
		: (($recs1>0) & ($recs2>0))
			CD_Dlog (0;__ ("Los ítems asignados a categorías serán totalizados en las respectivas categorías mientras que el resto será agrupado de acuerdo con la configuración."))
		: (($recs1>0) & ($recs2=0))
			CD_Dlog (0;__ ("Los ítems asignados a categorías serán totalizados en las respectivas categorías."))
		: (($recs1=0) & ($recs2>0))
			CD_Dlog (0;__ ("No hay categorías de ítems de cargo definidas. Los ítems serán agrupados y ordenados de acuerdo con la configuración."))
	End case 
End if 
LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)