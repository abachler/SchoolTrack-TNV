//%attributes = {"executedOnServer":true}
  // ___v20131228_PrimaryKeys()
  // Por: Alberto Bachler K.: 28-12-13, 17:22:29
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_reintegrarConsultas)
_O_C_INTEGER:C282($i_campos;$i_tablas)
C_LONGINT:C283($l_idTermometro;$l_ultimaTabla)
C_TEXT:C284($t_nombreCampo;$t_nombreTabla;$t_rutaArchivo;$t_SQL)

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_CamposUUIDs;0)
C_TEXT:C284(vt_nombreTabla)
C_POINTER:C301(vy_fieldPointer)

<>vb_ImportHistoricos_STX:=True:C214





UD_v20131220_VerificaUUID 

$proc:=IT_UThermometer (1;0;__ ("Actualizando estructura virtual..."))
XSvs_RestauraLocalizaciones 
XSvs_ActualizaEstructuraVirtual 
IT_UThermometer (-2;$proc)

$proc:=IT_UThermometer (1;0;__ ("Guardando librerías..."))
EXE_SaveCommandLibrary 
XS_SaveExecutableObjects 
QR_SaveReportLibrary 
QRY_SaveStandardQueries 
TBL_SaveLibrary 
RObj_SaveLibrary 
ACTwtrf_SaveLibrary 
IN_ACT_SaveTablaBancos 
IT_UThermometer (-2;$proc)


$l_primeraTabla:=1
$l_ultimaTabla:=Get last table number:C254
$l_idTermometro:=IT_Progress (1;0;0;"Estableciendo llaves primarias en la tabla ...")

For ($i_tablas;$l_primeraTabla;$l_ultimaTabla)
	
	If (Is table number valid:C999($i_tablas))
		$t_nombreTabla:=Table name:C256($i_tablas)
		$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_tablas/$l_ultimaTabla;"Estableciendo llaves primarias en la tabla ..."+$t_nombreTabla)
		
		$b_Crear_AutoUUID:=True:C214
		For ($i_campos;1;Get last field number:C255($i_tablas))
			If (Is field number valid:C1000($i_tablas;$i_campos))
				$t_nombreCampo:=Field name:C257($i_tablas;$i_campos)
				
				If ($t_nombreCampo="Auto_UUID")
					ON ERR CALL:C155("ERR_GenericOnError")
					$t_SQL:="ALTER TABLE "+$t_nombreTabla+" DROP PRIMARY KEY;"
					Begin SQL
						EXECUTE IMMEDIATE :$t_SQL
					End SQL
					ON ERR CALL:C155("")
					
					  //ON ERR CALL("ERR_GenericOnError")
					$t_SQL:="ALTER TABLE "+$t_nombreTabla+" ADD CONSTRAINT "+" pk"+String:C10($i_tablas)+" PRIMARY KEY (Auto_UUID);"
					Begin SQL
						EXECUTE IMMEDIATE :$t_SQL
					End SQL
					  //ON ERR CALL("")
					  //If (error#0)
					  //TRACE
					  //End if 
					$i_campos:=Get last field number:C255($i_tablas)
					$b_Crear_AutoUUID:=False:C215
				End if 
			End if 
		End for 
		
		
		If ($b_Crear_AutoUUID)
			ON ERR CALL:C155("ERR_GenericOnError")
			$t_SQL:="ALTER TABLE "+$t_nombreTabla+" DROP PRIMARY KEY;"
			Begin SQL
				EXECUTE IMMEDIATE :$t_SQL
			End SQL
			ON ERR CALL:C155("")
			
			
			  //ON ERR CALL("ERR_GenericOnError")
			$t_nombreCampo:="Auto_UUID"
			$t_SQL:="ALTER TABLE "+$t_nombreTabla+" ADD "+$t_nombreCampo+" UUID PRIMARY KEY AUTO_GENERATE;"
			Begin SQL
				EXECUTE IMMEDIATE :$t_SQL
			End SQL
			  //ON ERR CALL("")
			  //If (error#0)
			  //TRACE
			  //End if 
		End if 
		
		
	End if 
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
<>vb_ImportHistoricos_STX:=False:C215

