<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<!-- saved from url=(0014)about:internet -->
<title>MV Sistemas</title>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/favicon.ico" type="image/x-icon" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">
html, body {
    margin: 0;
    padding: 0px;
    height: 100%; 
	background-color: #EFEFEF;
}
td img 
{
	display: block;
}
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	color: #666666;
	font-weight: bold;
}

#detail
{
	font-family: Arial, Helvetica, sans-serif;
	color: #666666;
}

#detail h3
{
   -moz-user-select: -moz-none;
   -khtml-user-select: none;
   -webkit-user-select: none;
	user-select: none;
	
	cursor: pointer;
	text-indent: 30px;
	background-image: url("<%=request.getContextPath() %>/images/vertical_remover_item.png");
	background-repeat: no-repeat;
	background-position: 5px 2px;
}

#exceptionList
{
	display: none;
}

</style>
</head>
<script language="JavaScript" type="text/javascript">
<!--
function toggleDetail() 
{
	var exceptionList = document.getElementById("exceptionList");
	var header = document.getElementById("detailHeader");
	
    if(exceptionList.style.display == "none")
   	{
    	exceptionList.style.display = "block";
   		header.style.backgroundImage = "url('<%=request.getContextPath() %>/images/vertical_adicionar_item.png')";
   	}else
  	{
   		exceptionList.style.display = "none";
    	header.style.backgroundImage = "url('<%=request.getContextPath() %>/images/vertical_remover_item.png')";
  	}
}
-->
</script>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" height="50%">
  <tbody><tr>
   <td><img src="images/spacer.gif" alt="" width="1" border="0" height="1"></td>
   <td><img src="images/spacer.gif" alt="" width="29" border="0" height="1"></td>
   <td><img src="images/spacer.gif" alt="" width="100%" border="0" height="1"></td>
   <td><img src="images/spacer.gif" alt="" width="29" border="0" height="1"></td>
   <td><img src="images/spacer.gif" alt="" width="1" border="0" height="1"></td>
  </tr>

  <tr>
   <td colspan="4" background="<%=request.getContextPath() %>/images/Layout_r1_c1.jpg"><img src="<%=request.getContextPath() %>/images/logo.gif" vspace="10" width="162" border="0" height="47"></td>
   <td><img src="<%=request.getContextPath() %>/images/spacer.gif" alt="" width="1" border="0" height="64"></td>
  </tr>
  
  <tr>
   <td colspan="4" bgcolor="#fcfcfc"><div align="center"><img src="<%=request.getContextPath() %>/images/atenttion.gif" width="81" height="68"></div></td>
   <td><img src="<%=request.getContextPath() %>/images/spacer.gif" alt="" width="1" border="0" height="66"></td>
  </tr>
  
  <tr>
   <td colspan="2"><img name="Layout_r4_c1" src="<%=request.getContextPath() %>/images/Layout_r4_c1.jpg" id="Layout_r4_c1" alt="" width="30" border="0" height="34"></td>
   <td background="<%=request.getContextPath() %>/images/Layout_r4_c3.jpg">&nbsp;</td>
   <td><img name="Layout_r4_c4" src="<%=request.getContextPath() %>/images/Layout_r4_c4.jpg" id="Layout_r4_c4" alt="" width="29" border="0" height="34"></td>
   <td><img src="/<%=request.getContextPath() %>/images/spacer.gif" alt="" width="1" border="0" height="34"></td>
  </tr>
  <tr>
   <td colspan="2" background="<%=request.getContextPath() %>/images/Layout_r5_c1.jpg">&nbsp;</td>
   <td width="100%" bgcolor="#fbf9fa" height="100%"><div align="center"><span class="style1"><%=request.getAttribute("msg")%></span></div></td>
   <td background="<%=request.getContextPath() %>/images/Layout_r5_c4.jpg">&nbsp;</td>
   <td><img src="<%=request.getContextPath() %>/images/spacer.gif" alt="" width="1" border="0"></td>
  </tr>
  <tr>
   <td rowspan="2"><img name="Layout_r6_c1" src="<%=request.getContextPath() %>/images/Layout_r6_c1.jpg" id="Layout_r6_c1" alt="" width="1" border="0" height="70"></td>
   <td><img name="Layout_r6_c2" src="<%=request.getContextPath() %>/images/Layout_r6_c2.jpg" id="Layout_r6_c2" alt="" width="29" border="0" height="34"></td>
   <td background="<%=request.getContextPath() %>/images/Layout_r6_c3.jpg">&nbsp;</td>
   <td><img name="Layout_r6_c4" src="<%=request.getContextPath() %>/images/Layout_r6_c4.jpg" id="Layout_r6_c4" alt="" width="29" border="0" height="34"></td>
   <td><img src="<%=request.getContextPath() %>/images/spacer.gif" alt="" width="1" border="0" height="34"></td>
  </tr>
  <tr>
   <td colspan="3">&nbsp;</td>
   <td><img src="<%=request.getContextPath() %>/images/spacer.gif" alt="" width="1" border="0" height="36"></td>
  </tr>	
</tbody></table>
<div id="detail">
    <h3 id="detailHeader" onclick="toggleDetail()">Detalhes</h3>
    <ul id="exceptionList">
		<%= request.getAttribute("detail") %>
	</ul>
</div>
</body></html>