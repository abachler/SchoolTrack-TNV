//%attributes = {}
  //CUpr_ExportPlanilla

If (SYS_IsWindows )
	USE CHARACTER SET:C205("windows-1252";0)
Else 
	USE CHARACTER SET:C205("MacRoman";0)
End if 

C_BOOLEAN:C305(CrearPlanilla)
If (Count parameters:C259=1)
	$periodo:=$1
Else 
	$periodo:=0
End if 

$path:=SYS_SelectFolder ("")
If (ok=1)
	If ($path[[Length:C16($path)]]#Folder separator:K24:12)
		$path:=$path+Folder separator:K24:12
	End if 
End if 

_O_PLATFORM PROPERTIES:C365($platForm)
$t:="\t"
$r:="\r"


If (ok=1)
	SELECTION TO ARRAY:C260([Cursos:3];$aRecNums)
	CrearPlanilla:=True:C214
	For ($iCursos;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([Cursos:3];$aRecNums{$iCursos})
		If ($periodo>0)
			CUpr_PlanillaPeriodo ($periodo;"file")
			GOTO RECORD:C242([Cursos:3];$aRecNums{$iCursos})
			$file:=$path+[Cursos:3]Curso:1+", Promedios "+ST_GetValidName (atSTR_Periodos_Nombre{$periodo})
		Else 
			CUpr_PlanillaMultiPagina ("file")
			GOTO RECORD:C242([Cursos:3];$aRecNums{$iCursos})
			$file:=$path+"Promedios "+[Cursos:3]Curso:1
		End if 
		
		  // Modificado por: Saúl Ponce (08-08-2016) Ticket N° 165499
		  // Se valida que que se solicite la exportación de 'Todos' los períodos o 'Promedios Generales' (la nomenclatura cambia de acuerdo al informe obtenido), ya que de otro modo los % de aprobación quedan desplazados, en columnas incorrectas
		If ($periodo=0)
			Case of 
				: (Size of array:C274(atSTR_Periodos_Nombre)=2)
					$columns2Add:=4
				: (Size of array:C274(atSTR_Periodos_Nombre)=3)
					$columns2Add:=5
				: (Size of array:C274(atSTR_Periodos_Nombre)=4)
					$columns2Add:=6
			End case 
		Else 
			$columns2Add:=0
		End if 
		
		
		If (CrearPlanilla=True:C214)
			$ref:=Create document:C266($file;"TEXT")
			$record:="Nº"+$t+"Alumno"
			For ($i;1;Size of array:C274(aAsgAbrev))
				If ($periodo=0)
					$record:=$record+$t+aAsgName{$i}+($t*$columns2Add)
				Else 
					$record:=$record+$t+aAsgName{$i}
				End if 
			End for 
			If ($periodo>0)
				$record:=$record+$t+"PP"+$t+"PF"+$t+"% asist."+$r
			Else 
				$record:=$record+$t+"PF"+$t+"% asist."+$r
			End if 
			If ($platForm=3)
				SEND PACKET:C103($ref;_O_Mac to Win:C463($record))
			Else 
				SEND PACKET:C103($ref;$record)
			End if 
			
			For ($i;1;Size of array:C274(aC0))
				$record:=String:C10(aOrder{$i})+$t+aC0{$i}
				For ($j;1;vi_columns)
					$arrPointer:=Get pointer:C304("aC"+String:C10($j))
					If ($i<=Size of array:C274($arrPointer->))
						  //valido envio de datos para el porcentaje de aprobados
						  //ticket 154450 JVP 2016160111
						
						
						If (aC0{$i}="aprobados@")
							$record:=$record+($t*($columns2Add+1))+$arrPointer->{$i}
						Else 
							$record:=$record+$t+$arrPointer->{$i}
						End if 
						
						
					End if 
				End for 
				If ($periodo>0)
					$record:=$record+$t+aCavgP{$i}+$t+aCavg{$i}+$t+String:C10(aPctAsistencia{$i};"##0,0%")+$r
				Else 
					$record:=$record+$t+aCavg{$i}+$t+String:C10(aPctAsistencia{$i};"##0,0%")+$r
				End if 
				If ($platForm=3)
					SEND PACKET:C103($ref;_O_Mac to Win:C463($record))
				Else 
					SEND PACKET:C103($ref;$record)
				End if 
			End for 
			TRACE:C157
			CLOSE DOCUMENT:C267($ref)
		Else 
			CrearPlanilla:=True:C214
		End if 
	End for 
End if 
USE CHARACTER SET:C205(*;0)
