<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <%@include file="inc/inc_head.jspf" %>
</head>
<%@ page import="javax.xml.transform.*, javax.xml.transform.stream.*, java.io.*" %>
    <body align="left">
<%@include file="inc/inc_panel.jspf" %>
        <div id="wrapper">
        <div id="contentbox">
        
        <%
	 try
    {
        TransformerFactory transformerfactory =
            TransformerFactory.newInstance();
        Transformer transformer = transformerfactory.newTransformer
            (new StreamSource(new File ("BciOntology.xsl")));

        transformer.transform(new StreamSource(new File("C:/Users/Khiem/workspace/XSLT/WebContent/BciOntology.xml")),
        		new StreamResult(new File("C:/Users/Khiem/workspace/XSLT/WebContent/BciOntology.html")));

    }
    catch(Exception e) {}

    FileReader filereader = new FileReader("C:/Users/Khiem/workspace/XSLT/WebContent/BciOntology.html");
    BufferedReader bufferedreader = new BufferedReader(filereader);
    String textString;

    while((textString = bufferedreader.readLine()) != null) {
		%>
        <%= textString %>
		<%
        }
        filereader.close();
        %>

	  <%--<jsp:include page="/BciOntology.html" /> --%>
	
        </div>
		</div>
	</body>
 </html>   
   