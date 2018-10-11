IT_ShowHide4DWindow 

  //

  //If (◊vb_4DWindowVisible=False)

  //◊vb_4DWindowVisible:=True

  //AP SET PARAM (13;3)

  //AP SET PARAM (14;10)

  //AP SET PARAM (15;60)

  //AP SET PARAM (16;860)

  //AP SET PARAM (17;610)

  //SHOW WINDOW(◊vl_4DDefaultWindow)

  //wdw_SetFrontmost (◊vl_4DDefaultWindow)

  //Else 

  //HIDE WINDOW(◊vl_4DDefaultWindow)

  //AP SET PARAM (13;2)

  //AP SET PARAM (14;-1)

  //AP SET PARAM (15;-1)

  //AP SET PARAM (16;1)

  //AP SET PARAM (17;1)

  //◊vb_4DWindowVisible:=False

  //End if 

