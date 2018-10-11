//%attributes = {}
  // // KRL_VerifyRecordStructure()
  // Por: Alberto Bachler: 08/03/13, 16:57:12
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_BOOLEAN:C305($2)
C_POINTER:C301($3)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_mostrarResultado)
_O_C_INTEGER:C282($i_tablas)
C_LONGINT:C283($i;$l_error;$l_errores;$l_numeroTabla;$l_recNum)
C_POINTER:C301($y_errores_at;$y_tabla;$y_tablas_ay)
C_TEXT:C284($t_nombreTabla;$t_textoError)

ARRAY LONGINT:C221($al_recNums;0)
If (False:C215)
	C_POINTER:C301(KRL_VerifyRecordStructure ;$1)
	C_BOOLEAN:C305(KRL_VerifyRecordStructure ;$2)
	C_POINTER:C301(KRL_VerifyRecordStructure ;$3)
End if 

$y_errores_at:=$1

Case of 
	: (Count parameters:C259=3)
		$b_mostrarResultado:=$2
		$y_tablas_ay:=$3
		COPY ARRAY:C226($y_tablas_ay->;$ay_Tablas)
		If (Size of array:C274($ay_Tablas)=0)
			For ($i;1;Get last table number:C254)
				If (Is table number valid:C999($i))
					APPEND TO ARRAY:C911($ay_Tablas;Table:C252($i))
				End if 
			End for 
		End if 
		
	: (Count parameters:C259=2)
		$b_mostrarResultado:=$2
		For ($i;1;Get last table number:C254)
			If (Is table number valid:C999($i))
				APPEND TO ARRAY:C911($ay_Tablas;Table:C252($i))
			End if 
		End for 
		
	Else 
		ARRAY POINTER:C280($ay_Tablas;Get last table number:C254)
		For ($i;1;Get last table number:C254)
			If (Is table number valid:C999($i))
				APPEND TO ARRAY:C911($ay_Tablas;0)
			End if 
		End for 
End case 

For ($i_tablas;1;Size of array:C274($ay_Tablas))
	If (Is table number valid:C999($i_tablas))
		$l_numeroTabla:=Table:C252($ay_Tablas{$i_tablas})
		$y_tabla:=Table:C252($l_numeroTabla)
		$t_nombreTabla:=Table name:C256($l_numeroTabla)
		READ ONLY:C145($y_tabla->)
		ALL RECORDS:C47($y_tabla->)
		LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums;"")
		
		Case of 
			: (Size of array:C274($al_recNums)#Records in table:C83($y_tabla->))
				$t_textoError:="["+$t_nombreTabla+"]"+": Diferencia entre el número de registros leídos ("+String:C10(Size of array:C274($al_recNums))+") y el contador de registros de la tabla ("+String:C10(Records in table:C83($y_tabla->))+")."
				APPEND TO ARRAY:C911($y_errores_at->;$t_textoError)
				$l_errores:=$l_errores+1
				
			: (Size of array:C274($al_recNums)#Records in selection:C76($y_tabla->))
				$t_textoError:="["+$t_nombreTabla+"]"+": Diferencia entre el número de registros leídos ("+String:C10(Size of array:C274($al_recNums))+") y el contador de registros en la selección ("+String:C10(Records in table:C83($y_tabla->))+")."
				APPEND TO ARRAY:C911($y_errores_at->;$t_textoError)
				$l_errores:=$l_errores+1
				
			Else 
				$l_IdProcesoAvance:=IT_Progress (1;0;0;__ ("Verificando estructura de registros...  \rTabla ")+$t_nombreTabla)
				For ($i;1;Size of array:C274($al_recNums))
					KRL_GotoRecord ($y_tabla;$al_recNums{$i};False:C215;->$l_recNum)
					If ($l_recNum<0)
						$l_error:=API Record To Blob ($l_numeroTabla;$x_blob)
						$t_textoError:="["+$t_nombreTabla+"]"+": Estructura del registro # "+String:C10($al_recNums{$i})+"dañada. Datos leidos: "+String:C10(BLOB size:C605($x_blob))
						APPEND TO ARRAY:C911($y_errores_at->;$t_textoError)
						$l_errores:=$l_errores+1
					End if 
					$l_IdProcesoAvance:=IT_Progress (0;$l_IdProcesoAvance;$i/Size of array:C274($al_recNums);__ ("Verificando estructura de registros...  \rTabla ")+$t_nombreTabla)
				End for 
				IT_Progress (-1;$l_IdProcesoAvance)
		End case 
	End if 
End for 

If ($b_mostrarResultado)
	If ($l_errores>0)
		SET BLOB SIZE:C606($x_blob;0)
		For ($i;1;Size of array:C274($y_errores_at->))
			TEXT TO BLOB:C554(($y_errores_at->{$i}+Char:C90(Carriage return:K15:38));$x_blob;Mac text without length:K22:10;*)
		End for 
		CLEAR PASTEBOARD:C402
		APPEND DATA TO PASTEBOARD:C403("TEXT";$x_blob)
		
		ALERT:C41("Se detectaron "+String:C10($l_errores)+" situaciones de corrupción de datos. \rEl detalle está en el portapeles. \rPuede pegarlo en cualquier documento que soporte el formato texto.")
		
	Else 
		ALERT:C41("No se detectó ningún daño en los datos.")
	End if 
End if 

KRL_UnloadAll 
