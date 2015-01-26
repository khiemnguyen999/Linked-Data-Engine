<?xml version="1.0" encoding="utf-8" standalone="no"?>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.smartcardio.ATR"%>
<%@page import="com.sun.org.apache.xerces.internal.xni.parser.XMLDocumentScanner"%>
<%@page import="com.sun.org.apache.xerces.internal.parsers.XMLDocumentParser"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.apache.catalina.util.URLEncoder"%>
<%@page import="com.sun.corba.se.spi.ior.ObjectKey"%>
<%@page import="java.io.*" %>
<%@page import="java.net.*" %>
<%@page import="java.util.*" %>
<%@page import="javax.xml.xpath.XPath"%>
<%@page import="javax.xml.xpath.XPathConstants"%>
<%@page import="javax.xml.xpath.XPathFactory" %>
<%@page import="com.sun.jersey.api.client.Client" %>
<%@page import="com.sun.jersey.api.client.ClientResponse"%>
<%@page import="com.sun.jersey.api.client.WebResource"%>
<%@page import="com.sun.jersey.api.client.config.ClientConfig"%>
<%@page import="com.sun.jersey.api.client.config.DefaultClientConfig"%>
<%@page import="com.sun.jersey.api.json.JSONConfiguration"%>
<%@page import="org.codehaus.jackson.JsonFactory"%>
<%@page import="org.codehaus.jackson.JsonParseException"%>
<%@page import="org.codehaus.jackson.JsonParser"%>
<%@page import="org.codehaus.jettison.json.JSONArray"%>
<%@page import="org.codehaus.jettison.json.JSONException"%>
<%@page import="org.codehaus.jettison.json.JSONObject"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="javax.xml.transform.*, javax.xml.transform.stream.*, java.io.*"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" errorPage=""%>
<%@page import="javax.xml.transform.stream.StreamResult"%>  
<%@page import="javax.xml.transform.stream.StreamSource"%>  
<%@page import="javax.xml.transform.dom.DOMSource"%>  
<%@ page import="java.net.URLDecoder"%>

<%
if (
		 ( request.getHeader("accept").contains("text/html") ||
		   request.getHeader("accept").contains("application/xhtml+xml")||
		   request.getHeader("accept").contains("application/xml") 
		  )
		 &&
		   ((request.getContentType() == null) || 
			(request.getContentType().contains("text/html")) || 
			(request.getContentType().contains("text/webviewhtml")) ||
			(request.getContentType().contains("text/x-server-parsed-html")) ||
			(request.getContentType().contains("application/x-www-form-urlencoded")) ||
			(request.getContentType().contains("application/xhtml+xml"))
		   )&&
          ( request.getHeader("User-Agent").contains("Mozilla/5.0 "))
   )
{
%>
			<script type="text/javascript">
			window.location.href="linked_data_engine.jsp?" +
				"URI="    + encodeURIComponent("http://bci.pet.cs.nctu.edu.tw/ontology#")   + "&" +
				"SEARCH=" + encodeURIComponent(window.location.search) + "&" +
				"HASH="   + encodeURIComponent(window.location.hash);
			</script>
<%
}
else{
		/*
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		String pathxml    = application.getRealPath("/BCI.owl");
		
	 	Document docRDF = db.parse(pathxml);
	    Transformer transformer = TransformerFactory.newInstance().newTransformer();
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
	
		StreamResult result = new StreamResult(new StringWriter());
		DOMSource source = new DOMSource(docRDF);
		transformer.transform(source, result);
		
		String rdfString = result.getWriter().toString();
		
		out.clear();
		out.clearBuffer();
		out.print(rdfString);
		out.flush();
	    */
	    HttpServletResponse res=null;
	    String url="http://bci.pet.cs.nctu.edu.tw/ontology/BCI.owl";
		res.setStatus(HttpServletResponse.SC_SEE_OTHER);
		response.setContentType("text/plain");
	    response.setHeader("Location", url);
	    //response.addHeader("Location", url);

		
}
%>
