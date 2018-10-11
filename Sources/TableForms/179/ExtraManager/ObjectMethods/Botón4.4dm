If (Records in table:C83([xxACT_GlosasExtraordinarias:5])>0)
	$ref:=ACTabc_CreaDocumento ("DEFExtras";"DEFExtras"+String:C10(Day of:C23(Current date:C33(*)))+String:C10(Month of:C24(Current date:C33(*)))+String:C10(Year of:C25(Current date:C33(*))))
	
	If (ok=1)
		READ ONLY:C145([xxACT_GlosasExtraordinarias:5])
		ALL RECORDS:C47([xxACT_GlosasExtraordinarias:5])
		ORDER BY:C49([xxACT_GlosasExtraordinarias:5];[xxACT_GlosasExtraordinarias:5]Glosa:1;>)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo con items extraordinarios..."))
		$title:="Items extraordinarios al "+String:C10(Current date:C33(*);7)+"\r\r"
		IO_SendPacket ($ref;$title)
		ARRAY TEXT:C222(aHeaders;0)
		ARRAY TEXT:C222(aHeaders;6)
		aHeaders{1}:="Glosa"
		aHeaders{2}:="Imputacion Unica"
		aHeaders{3}:="Cuenta Contable"
		aHeaders{4}:="Centro de Costos"
		aHeaders{5}:="Contra Cuenta Contable"
		aHeaders{6}:="Contra Centro de Costos"
		$headers:=AT_array2text (->aHeaders;"\t")+"\r"
		IO_SendPacket ($ref;$headers)
		FIRST RECORD:C50([xxACT_GlosasExtraordinarias:5])
		While (Not:C34(End selection:C36([xxACT_GlosasExtraordinarias:5])))
			$line:=[xxACT_GlosasExtraordinarias:5]Glosa:1+"\t"+ST_Boolean2Str ([xxACT_GlosasExtraordinarias:5]Imputacion_Unica:6;"SI";"NO")+"\t"
			$line:=$line+[xxACT_GlosasExtraordinarias:5]No_de_Cuenta_Contable:2+"\t"+[xxACT_GlosasExtraordinarias:5]Centro_de_Costos:3+"\t"
			$line:=$line+[xxACT_GlosasExtraordinarias:5]No_CCta_contable:4+"\t"+[xxACT_GlosasExtraordinarias:5]CCentro_de_costos:5+"\r"
			IO_SendPacket ($ref;$line)
			NEXT RECORD:C51([xxACT_GlosasExtraordinarias:5])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([xxACT_GlosasExtraordinarias:5])/Records in table:C83([xxACT_GlosasExtraordinarias:5]);__ ("Generando archivo con items extraordinarios..."))
		End while 
		CLOSE DOCUMENT:C267($ref)
		
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		CD_Dlog (0;__ ("Archivo generado con éxito. Puede encontrarlo en\r\r")+document)
		AT_Initialize (->aHeaders)
	Else 
		CD_Dlog (0;__ ("Se ha producido un error al grabar el archivo."))
	End if 
Else 
	CD_Dlog (0;__ ("No existen items extraordinarios."))
End if 