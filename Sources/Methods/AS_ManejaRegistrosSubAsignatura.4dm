//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 20-08-18, 19:40:13
  // ----------------------------------------------------
  // Método: AS_ManejaRegistrosSubAsignatura
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

  //Método para crear subAsignaturas o eliminar subAsignaturas

READ WRITE:C146([xxSTR_Subasignaturas:83])

C_OBJECT:C1216($o_parametros;$o_respuesta)
C_BOOLEAN:C305($b_esAnual)

$t_accion:=$1
$o_parametros:=$2
$t_nombreSubasignatura:=OB Get:C1224($o_parametros;"nombre")
$l_idMadre:=OB Get:C1224($o_parametros;"madreID";Is longint:K8:6)
$l_columna:=OB Get:C1224($o_parametros;"columna";Is longint:K8:6)
$b_esAnual:=OB Get:C1224($o_parametros;"Anual";Is boolean:K8:9)

$b_validaTrans:=True:C214

QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_idMadre)
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)

Case of 
	: ($t_accion="crear")
		If ($b_esAnual)
			For ($l_periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
				$t_referencia:=String:C10($l_idMadre)+"."+String:C10($l_periodo)+"."+String:C10($l_columna)
				QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_referencia)
				If (Records in selection:C76([xxSTR_Subasignaturas:83])=0)
					CREATE RECORD:C68([xxSTR_Subasignaturas:83])
					[xxSTR_Subasignaturas:83]Name:2:=$t_nombreSubasignatura
					[xxSTR_Subasignaturas:83]ID_Mother:6:=$l_idMadre
					[xxSTR_Subasignaturas:83]Periodo:12:=$l_periodo
					[xxSTR_Subasignaturas:83]Columna:13:=$l_columna
					SAVE RECORD:C53([xxSTR_Subasignaturas:83])
					ASsev_InitArrays 
					ASsev_GuardaNomina (Record number:C243([xxSTR_Subasignaturas:83]))
				Else 
					$l_periodo:=Size of array:C274(atSTR_Periodos_Nombre)
					$b_validaTrans:=False:C215
				End if 
				
			End for 
		Else 
			$l_periodo:=OB Get:C1224($o_parametros;"periodo";Is longint:K8:6)
			$t_referencia:=String:C10($l_idMadre)+"."+String:C10($l_periodo)+"."+String:C10($l_columna)
			QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_referencia)
			If (Records in selection:C76([xxSTR_Subasignaturas:83])=0)
				CREATE RECORD:C68([xxSTR_Subasignaturas:83])
				[xxSTR_Subasignaturas:83]Name:2:=$t_nombreSubasignatura
				[xxSTR_Subasignaturas:83]ID_Mother:6:=$l_idMadre
				[xxSTR_Subasignaturas:83]Periodo:12:=$l_periodo
				[xxSTR_Subasignaturas:83]Columna:13:=$l_columna
				SAVE RECORD:C53([xxSTR_Subasignaturas:83])
				ASsev_InitArrays 
				ASsev_GuardaNomina (Record number:C243([xxSTR_Subasignaturas:83]))
			Else 
				  //OB SET($o_respuesta;"Mensaje";__ ("Ya existe una sub-asignatura para la columna"))
				$l_periodo:=Size of array:C274(atSTR_Periodos_Nombre)
				$b_validaTrans:=False:C215
			End if 
		End if 
		
		
	: ($t_accion="conservar")
		
		If ($b_esAnual)
			For ($l_periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
				$t_referencia:=String:C10($l_idMadre)+"."+String:C10($l_periodo)+"."+String:C10($l_columna)
				QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_referencia)
				[xxSTR_Subasignaturas:83]Columna:13:=0
				SAVE RECORD:C53([xxSTR_Subasignaturas:83])
				$b_validaTrans:=True:C214
			End for 
		Else 
			$l_periodo:=OB Get:C1224($o_parametros;"periodo";Is longint:K8:6)
			$t_referencia:=String:C10($l_idMadre)+"."+String:C10($l_periodo)+"."+String:C10($l_columna)
			QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_referencia)
			[xxSTR_Subasignaturas:83]Columna:13:=0
			SAVE RECORD:C53([xxSTR_Subasignaturas:83])
			$b_validaTrans:=True:C214
		End if 
		
		
	: ($t_accion="eliminar")
		
		If ($b_esAnual)
			For ($l_periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
				$t_referencia:=String:C10($l_idMadre)+"."+String:C10($l_periodo)+"."+String:C10($l_columna)
				QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_referencia)
				DELETE RECORD:C58([xxSTR_Subasignaturas:83])
				$b_validaTrans:=True:C214
			End for 
		Else 
			$l_periodo:=OB Get:C1224($o_parametros;"periodo";Is longint:K8:6)
			$t_referencia:=String:C10($l_idMadre)+"."+String:C10($l_periodo)+"."+String:C10($l_columna)
			QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_referencia)
			DELETE RECORD:C58([xxSTR_Subasignaturas:83])
			$b_validaTrans:=True:C214
		End if 
		
	: ($t_accion="asigna")
		If ($b_esAnual)
			For ($l_periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
				$t_referencia:=String:C10($l_idMadre)+"."+String:C10($l_periodo)+"."+String:C10(0)
				QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_referencia)
				QUERY SELECTION:C341([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Name:2=$t_nombreSubasignatura)
				[xxSTR_Subasignaturas:83]Columna:13:=$l_columna
				$b_validaTrans:=True:C214
			End for 
		Else 
			$l_periodo:=OB Get:C1224($o_parametros;"periodo";Is longint:K8:6)
			$t_referencia:=String:C10($l_idMadre)+"."+String:C10($l_periodo)+"."+String:C10(0)
			QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_referencia)
			QUERY SELECTION:C341([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Name:2=$t_nombreSubasignatura)
			[xxSTR_Subasignaturas:83]Columna:13:=$l_columna
			$b_validaTrans:=True:C214
		End if 
End case 

If ($b_validaTrans)
	OB SET:C1220($o_respuesta;"LongID";[xxSTR_Subasignaturas:83]LongID:7)
Else 
	OB SET:C1220($o_respuesta;"LongID";-1)
End if 

OB SET:C1220($o_respuesta;"TransValida";$b_validaTrans)

$0:=$o_respuesta


