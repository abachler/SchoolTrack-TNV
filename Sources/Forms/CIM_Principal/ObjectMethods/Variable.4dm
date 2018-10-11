  // CIM_Principal.Variable()
  // Por: Alberto Bachler Klein: 24-10-15, 10:17:05
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

  //webArea_Url:=Self->
$t_url:=Self:C308->
$t_url:=Replace string:C233($t_url;" ";"%20")
WA OPEN URL:C1020(*;"webArea";$t_url)