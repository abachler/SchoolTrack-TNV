//%attributes = {}
  //ACTdgi_CargaInfo

$l_idApdo:=$1

READ WRITE:C146([ACT_UY_InfoDGI:200])
QUERY:C277([ACT_UY_InfoDGI:200];[ACT_UY_InfoDGI:200]id_persona:3=$l_idApdo)

ORDER BY:C49([ACT_UY_InfoDGI:200];[ACT_UY_InfoDGI:200]Periodo:4;<)

  //READ WRITE([xShell_ExecutionErrors])
  //QUERY([xShell_ExecutionErrors];[xShell_ExecutionErrors]method=$l_idApdo)

  //ORDER BY([xShell_ExecutionErrors];[xShell_ExecutionErrors]component;<)