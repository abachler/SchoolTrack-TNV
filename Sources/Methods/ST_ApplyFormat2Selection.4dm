//%attributes = {}
  //ST_ApplyFormat2Selection


  //`xShell, Alberto Bachler
  //Metodo: ST_ApplyFormat2Selection
  //Por abachler
  //Creada el 01/03/2004, 10:18:57
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_POINTER:C301($tablePointer;$fieldPointer)
C_LONGINT:C283($1;$2;$tableRef;$fieldRef)
C_REAL:C285($3;$formatRef)
ARRAY LONGINT:C221($aRecNums;0)

C_BOOLEAN:C305($b_ok;$0)
C_TEXT:C284($t_valorCampo)
C_BOOLEAN:C305($b_ok;$0)

  //****INICIALIZACIONES****
$tableRef:=$1
$fieldRef:=$2
$formatRef:=Dec:C9($3)
$tablePointer:=Table:C252($tableRef)
$fieldPointer:=Field:C253($tableRef;$fieldRef)


  //****CUERPO****
  //MESSAGES OFF
  //READ WRITE($tablePointer->)
  //ALL RECORDS($tablePointer->)
  //$thermID:=IT_UThermometer (1;0;__ ("Leyendo referencias de datos a modificar..."))
  //SELECTION TO ARRAY($tablePointer->;$aRecNums)
  //IT_UThermometer (-2;$thermID)

  //$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Aplicando formato..."))
  //For ($i;1;Size of array($aRecNums))
  //GOTO RECORD($tablePointer->;$aRecNums{$i})
  //$fieldPointer->:=ST_Format2 ($fieldPointer;$formatRef*10)
  //SAVE RECORD($tablePointer->)
  //If (Dec($i/25)=0)
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array($aRecNums);__ ("Aplicando formato..."))
  //End if 
  //End for 
  //$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
  //  //****LIMPIEZA****

  //UNLOAD RECORD($tablePointer->)
  //READ ONLY($tablePointer->)

  //MONO 213762
$thermID:=IT_UThermometer (1;0;__ ("Leyendo referencias de datos a modificar..."))

READ WRITE:C146($tablePointer->)
ALL RECORDS:C47($tablePointer->)
ARRAY TEXT:C222($at_formatearCampo;0)
SELECTION TO ARRAY:C260($fieldPointer->;$at_formatearCampo)
IT_UThermometer (-2;$thermID)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Aplicando formato..."))
For ($i;1;Size of array:C274($at_formatearCampo))
	$t_valorCampo:=$at_formatearCampo{$i}
	$at_formatearCampo{$i}:=ST_Format2 (->$t_valorCampo;$formatRef*10)
	If (Dec:C9($i/25)=0)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($at_formatearCampo);__ ("Aplicando formato..."))
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
START TRANSACTION:C239
$thermID:=IT_UThermometer (1;0;__ ("Guardando cambios de formato..."))
ARRAY TO SELECTION:C261($at_formatearCampo;$fieldPointer->)
IT_UThermometer (-2;$thermID)
KRL_UnloadReadOnly ($tablePointer)
If (Records in set:C195("LockedSet")>0)
	CANCEL TRANSACTION:C241
	CD_Dlog (0;__ ("Existen registros que esta intentando formatear que se encuentran en uso por otros usuarios, la aplicación del formato ha sido cancelada. Se recomienda hacerlo en monousuario o cuando no tenga usuarios trabajando debido a que esto afecta a todos los "+"registros."))
Else 
	VALIDATE TRANSACTION:C240
	$b_ok:=True:C214
End if 

$0:=$b_ok