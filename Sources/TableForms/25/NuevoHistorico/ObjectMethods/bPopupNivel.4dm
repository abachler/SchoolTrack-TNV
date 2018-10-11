  // [Alumnos_Historico].NuevoHistorico.bPopupNivel()
  // Por: Alberto Bachler K.: 22-05-14, 15:18:05
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1)
SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]NumeroNivel:6;$aNivelesExistentes;[Alumnos_SintesisAnual:210]Promovido:91;$aPromovidos)
SORT ARRAY:C229($aNivelesExistentes;$aPromovidos)

USE SET:C118("NivelesDisponibles")
SELECTION TO ARRAY:C260([xxSTR_HistoricoNiveles:191]NumeroNivel:3;$aNumerosNivel;[xxSTR_HistoricoNiveles:191]NombreInterno:5;$aNombresNivel)
SORT ARRAY:C229($aNumerosNivel;$aNombresNivel;>)

For ($i;1;Size of array:C274($aNivelesExistentes))
	If ($aPromovidos{$i})
		$el:=Find in array:C230($aNumerosNivel;$aNivelesExistentes{$i})
		If ($el>0)
			DELETE FROM ARRAY:C228($aNumerosNivel;$el)
			DELETE FROM ARRAY:C228($aNombresNivel;$el)
		End if 
	End if 
End for 

For ($i;Size of array:C274($aNumerosNivel);1;-1)
	If (($aNumerosNivel{$i}=0) | ($aNumerosNivel{$i}<-1000))
		DELETE FROM ARRAY:C228($aNumerosNivel;$i)
		DELETE FROM ARRAY:C228($aNombresNivel;$i)
	End if 
End for 

$choice:=Pop up menu:C542(AT_array2text (->$aNombresNivel;";"))
If ($choice>0)
	If (Size of array:C274($aNivelesExistentes)>0)
		$nivelPrimerHistorico:=$aNivelesExistentes{1}
		$offsetNivelSelecionado:=Abs:C99($nivelPrimerHistorico-$aNumerosNivel{$choice})
		
		$continuar:=True:C214
		Case of 
			: ($offsetNivelSelecionado=0)
				$answer:=CD_Dlog (0;__ ("Ya existe un registro histórico para ")+$aNombresNivel{$choice}+__ (". \r\r¿Está seguro(a) que ")+[Alumnos:2]apellidos_y_nombres:40+__ (" reprobó ")+$aNombresNivel{$choice}+__ (" en ")+vt_YearName+__ ("?");__ ("");__ ("No");__ ("Si"))
				If ($answer=1)
					$continuar:=False:C215
				End if 
				
			: ($offsetNivelSelecionado#1)
				$answer:=CD_Dlog (0;__ ("El nivel seleccionado no precede al nivel del registro histórico más antiguo. \r\r¿Está seguro(a) que ")+[Alumnos:2]apellidos_y_nombres:40+__ (" cursó ")+$aNombresNivel{$choice}+__ (" en ")+vt_YearName+__ ("?");__ ("");__ ("No");__ ("Si"))
				If ($answer=1)
					$continuar:=False:C215
				End if 
		End case 
	Else 
		$continuar:=True:C214
	End if 
Else 
	$continuar:=False:C215
End if 



If ($continuar)
	vl_NivelSeleccionado:=$aNumerosNivel{$choice}
	vt_Nivel:=$aNombresNivel{$choice}
	OBJECT SET COLOR:C271(vt_Nivel;-15)
End if 