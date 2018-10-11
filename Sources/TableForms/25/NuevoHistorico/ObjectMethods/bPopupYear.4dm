  // [Alumnos_Historico].NuevoHistorico.bPopupYear()
  // Por: Alberto Bachler K.: 13-05-14, 19:31:31
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


ARRAY TEXT:C222($aYears;0)

ALL RECORDS:C47([xxSTR_DatosDeCierre:24])
QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1<<>gYear;*)
QUERY:C277([xxSTR_DatosDeCierre:24]; & [xxSTR_DatosDeCierre:24]Year:1>=1990)
SELECTION TO ARRAY:C260([xxSTR_DatosDeCierre:24]Year:1;$aYearNumber;[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5;$aYearNames)
SORT ARRAY:C229($aYearNumber;$aYearNames;<)

SET QUERY DESTINATION:C396(Into variable:K19:4;$found)
For ($i;Size of array:C274($aYearNumber);1;-1)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$found)
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2;=;$aYearNumber{$i})
	$continuar:=True:C214
	If ($found>0)
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2;=;$aYearNumber{$i};*)
		QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]EsNivel_SubAnual:19;=;True:C214)
		
		Case of 
			: ($found=0)
				AT_Delete ($i;1;->$aYearNumber;->$aYearNames)
			: ($found>0)
				
		End case 
	End if 
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)

$choice:=Pop up menu:C542(AT_array2text (->$aYearNames;";");0)

If ($choice>0)
	vt_yearName:=$aYearNames{$choice}
	vl_Year:=$aYearNumber{$choice}
	SET QUERY DESTINATION:C396(Into variable:K19:4;$found)
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2;=;$aYearNumber{$choice})
	$continuar:=True:C214
	If ($found>0)
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2;=;$aYearNumber{$choice};*)
		QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]EsNivel_SubAnual:19;=;True:C214)
		
		Case of 
			: ($found=0)
				$r:=CD_Dlog (0;__ ("Ya existe un registro histórico para ")+[Alumnos:2]apellidos_y_nombres:40+__ (" en ")+vt_yearName+__ ("."))
				$continuar:=False:C215
			: ($found>0)
				$r:=CD_Dlog (0;__ ("Ya existe un registro histórico para ")+[Alumnos:2]apellidos_y_nombres:40+__ (" en ")+vt_yearName+__ (".\r¿Desea realmente crear un nuevo registro histórico en el mismo año?");__ ("");__ ("No");__ ("Si"))
				If ($r=2)
					$continuar:=True:C214
				Else 
					$continuar:=True:C214
				End if 
		End case 
	End if 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	
	
	If ($continuar)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$found)
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1)
		If ($found>0)
			QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1;*)
			QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2;=;$aYearNumber{$choice}+1)
			If ($found=0)
				$answer:=CD_Dlog (0;__ ("El año seleccionado no precede inmediatamente al registro histórico más antiguo. ¿Está seguro que desea agregar un registro histórico para el año ")+vt_yearName+__ ("?");__ ("");__ ("No");__ ("Si"))
				If ($answer=1)
					$continuar:=False:C215
				End if 
			End if 
		Else 
			$continuar:=True:C214
		End if 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
	End if 
	
	
	If ($continuar)
		OBJECT SET COLOR:C271(vt_yearName;-15)
		
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3;<;[Alumnos:2]nivel_numero:29;*)
		QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]Año:2;=;$aYearNumber{$choice})
		CREATE SET:C116([xxSTR_HistoricoNiveles:191];"NivelesDisponibles")
		If (Records in selection:C76([xxSTR_HistoricoNiveles:191])=0)
			$r:=CD_Dlog (0;__ ("No hay niveles académicos disponibles para añadir un nuevo registro histórico."))
		Else 
			
		End if 
		
	Else 
		vl_Year:=0
		vt_yearName:="Seleccione el año..."
		OBJECT SET COLOR:C271(vt_yearName;-14)
	End if 
	
	
	
End if 

