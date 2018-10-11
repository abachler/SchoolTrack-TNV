//%attributes = {}
  //ADTmnu_CheckFamSexGroup

$familiyUndefined:=0
$groupUndefined:=0
$sexUndefined:=0
$msg:=""
ALL RECORDS:C47([ADT_Candidatos:49])
While (Not:C34(End selection:C36([ADT_Candidatos:49])))
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
	Case of 
		: ([Alumnos:2]Familia_Número:24=0)
			$familiyUndefined:=$familiyUndefined+1
		: ([Alumnos:2]Sexo:49="")
			$sexUndefined:=$sexUndefined+1
		: ([ADT_Candidatos:49]Grupo:21="")
			$groupUndefined:=$groupUndefined+1
	End case 
	NEXT RECORD:C51([ADT_Candidatos:49])
End while 

If (($familiyUndefined+$groupUndefined+$sexUndefined)>0)
	$msg:=__ ("Algunos registros de postulantes no tienen toda la información requerida para asignarles entrevistas, presentaciones o examenes:\r")
	If ($familiyUndefined>0)
		$msg:=$msg+"\r"+Replace string:C233(__ ("   - ˆ0 postulantes no tienen familia definida");"ˆ0";String:C10($familiyUndefined))
	End if 
	If ($groupUndefined>0)
		$msg:=$msg+"\r"+Replace string:C233(__ ("   - ˆ0 postulantes no han sido asignados a ningún grupo");"ˆ0";String:C10($groupUndefined))
	End if 
	If ($sexUndefined>0)
		$msg:=$msg+"\r"+Replace string:C233(__ ("   - ˆ0 postulantes no tienen información sobre su sexo");"ˆ0";String:C10($sexUndefined))
	End if 
	$msg:=$msg+__ ("La asignación solo se realizará para los postulantes con la información requerida")
End if 
If ($msg#"")
	CD_Dlog (0;$msg)
End if 