//%attributes = {}
  //dbu_delOrphanRels

If (False:C215)
	<>V443_UD:=True:C214
	  //BY: Alberto Bachler
	  //DATE: 4/8/98 a 00:45
End if 


CREATE EMPTY SET:C140([Familia_RelacionesFamiliares:77];"Orphans")
ALL RECORDS:C47([Familia_RelacionesFamiliares:77])
CREATE SET:C116([Familia_RelacionesFamiliares:77];"mySet")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando integridad de las relaciones familiares…"))
$rec:=Records in selection:C76([Familia_RelacionesFamiliares:77])
For ($i;1;$rec)
	QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
	If (Records in selection:C76([Personas:7])=0)
		ADD TO SET:C119([Familia_RelacionesFamiliares:77];"Orphans")
	End if 
	NEXT RECORD:C51([Familia_RelacionesFamiliares:77])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$rec;__ ("Verificando integridad de las relaciones familiares…"))
End for 
READ WRITE:C146([Familia_RelacionesFamiliares:77])
USE SET:C118("Orphans")
DELETE SELECTION:C66([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

CREATE EMPTY SET:C140([Familia_RelacionesFamiliares:77];"Orphans")
ALL RECORDS:C47([Familia_RelacionesFamiliares:77])
CREATE SET:C116([Familia_RelacionesFamiliares:77];"mySet")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Re-verificando integridad de las relaciones familiares…"))
$rec:=Records in selection:C76([Familia_RelacionesFamiliares:77])
For ($i;1;$rec)
	QUERY:C277([Familia:78];[Familia:78]Numero:1=[Familia_RelacionesFamiliares:77]ID_Familia:2)
	If (Records in selection:C76([Familia:78])=0)
		ADD TO SET:C119([Familia_RelacionesFamiliares:77];"Orphans")
	End if 
	NEXT RECORD:C51([Familia_RelacionesFamiliares:77])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$rec;__ ("Re-Verificando integridad de las relaciones familiares…"))
End for 
READ WRITE:C146([Familia_RelacionesFamiliares:77])
USE SET:C118("Orphans")
DELETE SELECTION:C66([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

