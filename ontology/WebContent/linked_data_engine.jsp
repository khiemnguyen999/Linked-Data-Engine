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

<%!
/******************************************************FUNCTION/PROCEDURE******************************************************************/
public String generateHTML_header() {

	return ("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n"+
			"<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">\n"+
    	    "<head>\n");
}
public String generateHTML_header_end(){
	return ("</head>\n");
}

public String generateHTML_footer() {
	return(
			"</div>\n"+
		"</div>\n"+
	"</body>\n"+
 "</html>");
}
public String generateHTML_Body_begin(){
	return(" <body align=\"left\">\n");
}

public String generateHTML_Body_midle(){
	return(
			"<div id=\"wrapper\">\n"+
		    "<div id=\"contentbox\">\n"
		   );
}
public String generateHTML_Body_des(){
	return(
			"<h2 align=\"center\">BCI Ontology - Linked Data Engine (Description of Resources)</h2>\n"
		  );
}

//Receive Response from ser
public String getResponse(String requireURI){
	
	String hash=requireURI.substring(requireURI.indexOf("#")+1);
   	final String base_URL="http://bci.pet.cs.nctu.edu.tw/ontology/service.jsp";
   	String full_URL=base_URL;//+hash;
   	String afterHash= requireURI.substring(requireURI.indexOf("#")+1);	    
       
   	ClientConfig clientConfig = new DefaultClientConfig();
    clientConfig.getFeatures().put(JSONConfiguration.FEATURE_POJO_MAPPING, Boolean.TRUE);
    Client client = Client.create(clientConfig);
    WebResource webResource = client.resource(full_URL);
    ClientResponse result = webResource.accept("application/json").type("application/json").get(ClientResponse.class);
    String output = result.getEntity(String.class);
	return output;
	
}
// Have Result
public String getResult(JSONArray jsonArray,JSONObject jPre, String requireURI ){
	String  result = 	" <h2>The result from Server</h2>\n"  +
				"There has" + jsonArray.length() + " Items in database <br/>"+ 
				"Subject Item <br/>"+ requireURI ;

				result =result+	    "<table>\n" +  
					   									"	<tr>\n" + 
														"		<td>P</td>\n" + 
														"		<td>O</td>\n" + 
														"	</tr>\n";			
						
				 String P="", O="";
		try{
			    JSONObject pred,obj; 
				for (int i=0;i<jsonArray.length();i++ ){
					   JSONObject job=jsonArray.getJSONObject(i);
					   result=result+					"   <tr>";
					   result=result+					"   <td>";
					   				
					   				/*
					   				pred = job.getJSONObject("P");
					   				P= pred.get("value").toString();
					   				result= result+ shortenNameSpace(P, jPre);
					   				*/
					 				result=result+		"   </td> "+
											   			"    <td> ";
									/*		   			
						   			obj = job.getJSONObject("O");
					   				O= obj.get("value").toString();
					   				result= result+ shortenNameSpace(O, jPre);
					   				*/
											           result=result+ "	</td>"+
									        						  "  </tr>\n";
									         			}  
				
													  result=result+  "  </table> \n";
		}
		catch(Exception ex){ex.printStackTrace();}			
	return result;
}

//Message for no result
public String getEmptyResult(String requireURI){
	String result="<h2> Result </h2>"+
				 "No resource was found with the requested URI <span style=\"color:red\">" +
				 requireURI +"</span>."+
				 "For more information about the BCI Ontology, please visit the following link"+
				 "<span style=\"color:red\"><a href=\"http://bci.pet.cs.nctu.edu.tw/ontology#\">http://bci.pet.cs.nctu.edu.tw/ontology#</a></span>";
	
	return result;
}

//  describe Result
public String processResult(String requireURI, JSONObject jPre ){
	    String resultResource="No change";
	    String output = getResponse(requireURI);
        JSONArray jsonArray= new JSONArray();
    	try{
		     jsonArray= new JSONArray(output);
		     //String res= jsonArray.toString();
		     if(jsonArray.length()>1)
		    	 resultResource= getResult(jsonArray, jPre, requireURI);
		     else
		    	 resultResource= getEmptyResult(requireURI);
    	}catch(Exception ex){ex.printStackTrace();};
	return resultResource;
}


//describe Result in XML of PowderTemplate
public String processPowderResult(String requireURI, JSONObject jPre ){
	    String resultXmlResource="";
	    String output = getResponse(requireURI);
        JSONArray jsonArray= new JSONArray();
    	try{
		     jsonArray= new JSONArray(output);
		     String res= jsonArray.toString();
		     if(jsonArray.length()>1)
		    	 resultXmlResource= getResult(jsonArray, jPre, requireURI);
		     else
		    	 resultXmlResource="Sample Resouce: http://bci.pet.cs.nctu.edu.tw/ontology#Study";
    	}catch(Exception ex){ex.printStackTrace();};
	return resultXmlResource;
}

//Generate the prefixes table:
public String genPrefix(String[]nameSpace,String[] prefix){
	int sizePre= nameSpace.length;
	
	String HTML_PrefixesTable = "	<h2>Namspaces</h2>\n" +   
			"		<table>\n" + 
			"			<tr>\n" + 
			"				<td>Prefix</td>\n" + 
			"		   		<td>Namespace</td>\n" + 
			"		   </tr>";
			
			   for(int j=0;j<sizePre;j++)
			   {
					HTML_PrefixesTable = HTML_PrefixesTable +
					"			<tr>\n" + 
					"				<td>";
					if(nameSpace[j].contains(":"))
						HTML_PrefixesTable = HTML_PrefixesTable + (nameSpace[j].substring(nameSpace[j].indexOf(":")+1));
				  	else
						HTML_PrefixesTable = HTML_PrefixesTable + (nameSpace[j]);
					HTML_PrefixesTable = HTML_PrefixesTable + "</td>\n"; 
					HTML_PrefixesTable = HTML_PrefixesTable + "				<td>" + (prefix[j]) + "</td>" ;
					HTML_PrefixesTable = HTML_PrefixesTable + "			</tr>\n";
				}
			   HTML_PrefixesTable = HTML_PrefixesTable + "		</table>\n";
			   
	return HTML_PrefixesTable;
	
}
//Make a procedure to generate the the short namespace:
public String shortenNameSpace(String fullNameSpace, JSONObject jPre){
	String shortNS="";
	String fullPre="",shortPre="",resource="";
	if(fullNameSpace.contains("#")){
		fullPre=fullNameSpace.substring(0,fullNameSpace.indexOf("#")+1);
		resource=fullNameSpace.substring(fullNameSpace.indexOf("#")+1);
	}
	//else: In the case of [ xml:base="http://bci.pet.cs.nctu.edu.tw/ontology"]??
	try{
		shortPre=jPre.getString(fullPre);
		if(shortPre.contains(":")){
			shortNS= shortPre.substring(shortPre.indexOf(":"+1)) +":"+resource;
		}
		else
		{
			shortNS=  "bci:"+resource;
		} 	
	}catch(Exception ex){ex.printStackTrace();}
	
	return shortNS;
	
}
/***********************************************************************************************************************************************/
%>
<!-- We can put body here -->
  		<% 
  		String pathPowder = application.getRealPath("/PowderTemplate.xml");
  		String pathTest   = application.getRealPath("/service.jsp");
  		String pathxsl    = application.getRealPath("/doc/BciOntology.xsl");
		String pathhtml   = application.getRealPath("/doc/BciOntology.html");
		String pathxml    = application.getRealPath("/BCI.owl");
		
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		Document doc = db.parse(pathxml);
		NodeList xmlData = doc.getElementsByTagName("rdf:RDF");
		Element listPrefix = (Element) xmlData.item(0); // XPATH: { /rdf:RDF }
        
		NamedNodeMap attribute= listPrefix.getAttributes();
		int numAtt= attribute.getLength();
		String[]nameSpace= new String[numAtt-2];
		int h=0;
		for(int in= 0; in< numAtt;in++){
			Attr att= (Attr)attribute.item(in);
			String attrName = att.getNodeName();
			if((attrName.compareTo("xml:base")!=0) && (attrName.compareTo("xmlns")!=0))
			{
				nameSpace[h]=attrName;
				h++;
			}
			
		}
		
		int sizePre=nameSpace.length;
		String[] prefix= new String[sizePre];
		JSONObject jPre= new JSONObject();
		
		for(int p=0;p<sizePre;p++){
			prefix[p]=listPrefix.getAttribute(nameSpace[p]);
			jPre.put(prefix[p], nameSpace[p]);
		}
		
		//Parse request URL
		String requestURI="",requestURI_SearchPart="",requestURI_HashPart="",requireURI="";
		requestURI_SearchPart = URLDecoder.decode(request.getParameter("SEARCH"));	
		if(requestURI_SearchPart.compareTo("?test_result")==0)
		{
			requestURI=request.getParameter("test_URI") + "";
			if(requestURI.contains("#")) 
				requestURI_HashPart=requestURI.substring(requestURI.indexOf("#"));
			requireURI=requestURI;
			requestURI_SearchPart ="?test_result";
		}
		else
		{
			requestURI = URLDecoder.decode(request.getParameter("URI"));
		  	requestURI_HashPart = URLDecoder.decode(request.getParameter("HASH"));
		  	requireURI=requestURI;
		  	
		}		
		//out.println("RequireURI: "+requireURI +"------- SearchPart: "+requestURI_SearchPart+"------- HashPart: "+requestURI_HashPart +"------requestURI: "+requestURI +"<br/>" );
		%>
<!-- 			
************************************************************************************************************************************************************ 
** TEST THE REQUESTED URI FOR THE FOLLOWING CASES:
	0) IF the requestURI == "http://bci.pet.cs.nctu.edu.tw/ontology?cerebraweb.rdf" then... serve cerebraweb.rdf <END />  
	1) IF the requestURI_SearchPart is "?test" or "?test+result" then... TEST functionality
	2) IF the last part of requestURI_HashPart is ".POWDER" then... generate the POWDER DR Document.
	3) DESCRIBE RESOURCE:
		a) IF (requestURI_HashPart.lenght() > 1) // It has a Hash Part.
		b) ELSE 
			IF (requestURI == " [check for 3 or 4 defaults URIs to generate HTML document] ") // Generate HTML version of the OWL file.
			ELSE { Generate a friendly error message. }

************************************************************************************************************************************************************/

/************************************************************************************************************************************************************ 
** #0 Sceneario: cerebraweb.rdf. 
************************************************************************************************************************************************************/
 -->
<%
if (requireURI.compareTo("http://bci.pet.cs.nctu.edu.tw/ontology/?cerebraweb.rdf")==0)
{
	// redirect to file: "cerebraweb.rdf"
	response.sendRedirect("/ontology/cerebraweb.rdf");%>
    <!-- <a href="/ontology/cerebraweb.rdf"download> See cerebraweb.rdf</a> -->

    <%
    //Stop execution
    if(1==1){
    	return;
    	}
    // END.
	
}		
/************************************************************************************************************************************************************ 
** #1 Sceneario: TESTing. 
************************************************************************************************************************************************************/
if ((requestURI_SearchPart.compareTo("?test")==0) || (requestURI_SearchPart.compareTo("?test_result"))==0)
{ %>

    <% out.print(generateHTML_header()); %>
	<%@include file="inc/inc_head.jspf" %>
	<% out.print(generateHTML_header_end());
	out.print(generateHTML_header_end());
	out.print(generateHTML_Body_begin());%>
	<%@include file="inc/inc_panel.jspf" %>
	<%out.print(generateHTML_Body_midle());%>
	<%out.print(generateHTML_Body_des());%>

	<h2>Test Page</h2>
	<%
	   if (requestURI_SearchPart == "?test") { requestURI = ""; }
	   if (requestURI_SearchPart == "?test_result") { 
		   requestURI = request.getParameter("test_URI");  // We get the Request URI from the FORM. 
	   	   /*
		   There are 3 cases of request URI from FORM:
			   a] Request URI have resource
			   b] Request URI doesn't have resouce, need display owl file
			   c] Request URI wrong
		   */
		   if(requestURI.substring(requestURI.indexOf("#")).length()>1){
			   requestURI_HashPart = requestURI.substring(requestURI.indexOf("#"), requestURI.length());
		   }
	   }
	%>
	<form action="linked_data_engine.jsp?URI=http%3A%2F%2Fbci.pet.cs.nctu.edu.tw%2Fontology%2F%3Ftest_result&SEARCH=%3Ftest_result&HASH=" method="post" align ="center">
	URI: 
	<input type="text" size="100"  name="test_URI" value="<%out.print(requestURI);%>" /><br/> 
	<p></p>
	<input type="submit" value="Parse"/> 
	</form> 
	<%
	String a="";
	if (requestURI != null || requestURI != "")  a=requestURI;
	if(a.contains("//") && a.contains("/")  && a.contains("#") && a.substring(a.indexOf("#")+1).length()>0 ){
		%>
		<h4>Domain:  <% out.println(a.substring(a.lastIndexOf("//")+2,a.lastIndexOf("#"))) ; %> </h4>
		<%
		String body= a.substring(a.lastIndexOf("#")+1,a.length());
		String b[];
		b=body.split("/");
		int k=b.length;
		String[] arr= new String[k];
		int i=0;
		for(String r:b){
		arr[i]=r;
		i++;
		};
		%>
		<h4>Body: <% out.println(body) ; %> </h4>
		The part of path: <br/>
		<%
		
		for(String c:arr){  %>
		<br/> 
		<%	
		 out.println(c);
		}
	}
	%>
	<h2>Type request: </h2>
	<table border="1">
	<%
	Enumeration enumeration = request.getHeaderNames();//content_type Mime
	while (enumeration.hasMoreElements()) {
	String name_enum = (String) enumeration.nextElement();
	String value = request.getHeader(name_enum);
	%>
	<tr><td><%= name_enum %></td><td><%= value %></td></tr>
	<%
	}
	%>
	</table>
	<%
	// out.print("---------------------"+request.getHeader("accept"));
	  
	 out.print(genPrefix(nameSpace, prefix));
	
	 out.print(generateHTML_footer());
	
}
/************************************************************************************************************************************************************ 
** #2 Sceneario: Generation of POWDER DR Document. 
************************************************************************************************************************************************************/
//If request have ?Powder
if(requestURI.substring(requestURI.length()-7).compareTo(".POWDER")==0){ // COMMENT: Do not use "contains".  Check for it AT THE LAST PART OF THE STRING.
        %>
        <%
        // a] DESCRIBE the resource: HTTP GET JSON Object from the API >> Put this functionality into a PROCEDURE / FUNCTION.

        // b] Generate the XML document.
        String fileName= requestURI_HashPart.substring(1,requestURI_HashPart.length()-7);
	    NodeList nList = doc.getElementsByTagName("owl:Ontology");
		Node nNode = nList.item(0);
		String comment="", label="";
		if (nNode.getNodeType() == Node.ELEMENT_NODE) {
			Element eElement = (Element) nNode;
	    	comment= eElement.getElementsByTagName("rdfs:comment").item(0).getTextContent();
	    	label= eElement.getElementsByTagName("rdfs:label").item(0).getTextContent();
	   }
		// load XML document.
	    Document docPOWDER = db.parse(pathPowder);
        
        DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
	    String formattedDate = df.format(new Date())+"00:00:00";
	 		 	
	 	NodeList attribution= docPOWDER.getElementsByTagName("attribution");
	    Element att=null;
	 	att = (Element) attribution.item(0);
        Node issued = att.getElementsByTagName("issued").item(0).getFirstChild();
        issued.setNodeValue("'"+formattedDate+"'");
        
	 	       
	 	NodeList iriset= docPOWDER.getElementsByTagName("iriset");
	 	Element iri=null;
	 	iri = (Element) iriset.item(0);
        Node includeexactfragment = iri.getElementsByTagName("includeexactfragment").item(0).getFirstChild();
        includeexactfragment.setNodeValue("'"+requestURI_HashPart+"'");
   
	 	NodeList descriptorset= docPOWDER.getElementsByTagName("descriptorset");
	 	Element des=null;
	 	des = (Element) descriptorset.item(0);
	 	des.setAttribute("rdf:resource","'"+requestURI+"'");
	 	
	 	 String output = getResponse(requireURI);
	        JSONArray jsonArray= new JSONArray();
	    	try{
			     jsonArray= new JSONArray(output);
			     if(jsonArray.length()>1){
			    	 for (int i=0;i<jsonArray.length();i++ ){
			    		 JSONObject job=jsonArray.getJSONObject(i);
			    		    
			    		 	//create RDF_triple
			    		 	Element triples= docPOWDER.createElement("RDF-triple");
			    		 	des.appendChild(triples);
			    		 	
			    		 	//Read Father
			    		 	NodeList triple= docPOWDER.getElementsByTagName("RDF-triple");
			    		 	Element rdf=null;
			    		 	rdf = (Element) triple.item(i);
			    		 	
			    		 	//Node Subject
			    		 	Element su = docPOWDER.createElement("subject");
			    		 	su.appendChild(docPOWDER.createTextNode("'"+ shortenNameSpace(requireURI, jPre) +"'"));
			    		 	rdf.appendChild(su);
			    		 	
			    		 	//Node Predicate
			    		 	Element pre = docPOWDER.createElement("predicate");
			    		 	pre.appendChild(docPOWDER.createTextNode("'"+shortenNameSpace(job.getString("P"),jPre)+"'"));
			    		 	rdf.appendChild(pre);
			    		 	//Node Object
			    		 	Element obj = docPOWDER.createElement("object");
			    		 	obj.appendChild(docPOWDER.createTextNode("'"+shortenNameSpace(job.getString("O"),jPre)+"'"));
			    		 	rdf.appendChild(obj);
			    	 } 
			     }

	    	}catch(Exception ex){ex.printStackTrace();};

	 	Node seealso = des.getElementsByTagName("seealso").item(0).getFirstChild();
	 	seealso.setNodeValue(" Not have");
		
	 	Node typeof = des.getElementsByTagName("typeof").item(0).getFirstChild();
	 	typeof.setNodeValue(" Not have");

	 	Node comments = des.getElementsByTagName("comment").item(0).getFirstChild();
	 	comments.setNodeValue("'"+comment+"'");
	 	
	 	Node labels = des.getElementsByTagName("label").item(0).getFirstChild();
	 	labels.setNodeValue("'"+comment+"'");

	 	// out.print(flush the XML document structure).
        // <END />
		
		Transformer transformer = TransformerFactory.newInstance().newTransformer();
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		
		//initialize StreamResult with File object to save to file
		StreamResult result = new StreamResult(new StringWriter());
		DOMSource source = new DOMSource(docPOWDER);
		transformer.transform(source, result);
		
		String xmlString = result.getWriter().toString();
		
		out.clear();
		out.clearBuffer();
		response.addHeader("Content-Disposition", ("attachment; filename="+fileName+"_POWDER.xml"));
		response.setContentType("application/powder+xml");

		out.print(xmlString);
		out.flush();
		// stop the execution to continue.
		if(1==1){return;}
}//If the request have .POWDER

/************************************************************************************************************************************************************ 
** #3 Sceneario: DESCRIBE resource. 
************************************************************************************************************************************************************/
if(requestURI.substring(requestURI.length()-7).compareTo(".POWDER")!=0 && requestURI_HashPart.length()>1){ // requestURI_HashPart.lenght() > 1
%>
				<% out.print(generateHTML_header()); %>
				<%@include file="inc/inc_head.jspf" %>
				<% out.print(generateHTML_header_end());
				   out.print(generateHTML_header_end());
				   out.print(generateHTML_Body_begin());%>
				<%@include file="inc/inc_panel.jspf" %>
				<% out.print(generateHTML_Body_midle());
				   out.print(generateHTML_Body_des());
	
	out.print(genPrefix(nameSpace, prefix));
	// a] DESCRIBE the resource: HTTP GET JSON Object from the API >> Put this functionality into a PROCEDURE / FUNCTION.
	out.print(processResult(requireURI, jPre));
	%>
   <br/>
   <h2> <a href="http://www.w3.org/TR/powder-primer/">POWDER</a> <a href="http://www.w3.org/TR/powder-dr/">DR</a></h2>
	The Protocol for Web Description Resources (POWDER) provides a mechanism (better means) to describe and discover Web resources: it create trustmarks to aid content discovery.<br />
	You can retrieve a POWDER DR document associated to the resource <% out.print(requireURI); %> in <a target="_blank" href="http://bci.pet.cs.nctu.edu.tw/ontology<% out.print(requestURI_HashPart);%>.POWDER">here</a>.<!--  have .POWDER -->
				<%out.print(generateHTML_footer());%>
	<%
	
	} 
	else {
		if(( requireURI.compareTo("http://bci.pet.cs.nctu.edu.tw/ontology#")==0) ||
			(requireURI.compareTo("http://bci.pet.cs.nctu.edu.tw/ontology")==0)||
			(requireURI.compareTo("http://bci.pet.cs.nctu.edu.tw/ontology/")==0) ||
			(requireURI.compareTo("http://bci.pet.cs.nctu.edu.tw/ontology/#")==0))
		    { 
							    %>
				    <% out.print(generateHTML_header()); %>
					<%@include file="inc/inc_head.jspf" %>
	
					<% out.print(generateHTML_header_end());
					
	            	   out.print(generateHTML_Body_begin());%>
					<%@include file="inc/inc_panel.jspf" %>
					<%out.print(generateHTML_Body_midle());%>
					<%
						NodeList nList = doc.getElementsByTagName("owl:Ontology");
						Node nNode = nList.item(0);
						String titile="", author="", comment1="",comment2="",comment3="", label="",version="", right="", com_prefix="", uri="";
						if (nNode.getNodeType() == Node.ELEMENT_NODE) {
							Element eElement = (Element) nNode;
							
							titile= eElement.getElementsByTagName("dc:title").item(0).getTextContent();
							author= eElement.getElementsByTagName("dc:creator").item(0).getTextContent();
					    	comment1= eElement.getElementsByTagName("rdfs:comment").item(0).getTextContent();
					    	comment2= eElement.getElementsByTagName("rdfs:comment").item(1).getTextContent();
					    	comment3= eElement.getElementsByTagName("rdfs:comment").item(2).getTextContent();
					    	label= eElement.getElementsByTagName("rdfs:label").item(0).getTextContent();
					    	version= eElement.getElementsByTagName("owl:versionInfo").item(0).getTextContent();
					    	right= eElement.getElementsByTagName("dc:rights").item(0).getTextContent();
					    	com_prefix= eElement.getElementsByTagName("rdfs:comment").item(3).getTextContent();
					    	uri= eElement.getElementsByTagName("dc:identifier").item(0).getTextContent();
				   }
					%>
					  	<h2><%out.print(titile); %></h2>
					  
					  	<%
					  		out.print("accept:  " + request.getHeader("accept") +"\n");
	  						out.print("user-agent: "+request.getHeader("User-Agent")+"\n"); 
	  						out.print("user-agent: "+request.getContentType()+"\n"); 
	
	  					%>
					  	
					  	
					  
					  	<dt>Author</dt>
		  	    		<dd><%out.print(author); %></dd>
		
		      			<dt>Description</dt>
		  	    		<dd><%out.print(comment1); %></dd>
		  	    		<dd><%out.print(comment2); %></dd>
		  	    		<dd><%out.print(comment3); %></dd>
		
		      			<dt>Latest Version</dt>
						<dd><%out.print(version); %></dd>
						
						<dt>Rights</dt>
						<dd><%out.print(right); %></dd>
		                 
		      			<dt>URI</dt>
		  	    		<dd><%out.print(uri); %></dd>
		
		      			<dt>Prefix</dt>
		  	    		<dd><%out.print(com_prefix); %></dd>
			  	    <%
			  	    	out.print(genPrefix(nameSpace, prefix));
							 try
							    {
							        TransformerFactory transformerfactory =
							            TransformerFactory.newInstance();
							        Transformer transformer = transformerfactory.newTransformer
							            (new StreamSource(new File (pathxsl)));
							        transformer.transform(new StreamSource(new File(pathxml)),
							        	 new StreamResult(new File(pathhtml)));
							    }
							    catch(Exception e) {}
	
							 FileReader filereader = new FileReader(pathhtml);
							 BufferedReader bufferedreader = new BufferedReader(filereader);
							 String textString;
			
						     while((textString = bufferedreader.readLine()) != null) {
								%>
						        <%= textString %>
								<%
						        }
						        filereader.close();
							%>
							<hr>
				   Documentation generated using a generation tool derived from <a href="http://www.w3.org/2005/Incubator/ssn/ssnx/ssn" target="_blank"> ssn w3c ontology.</a>
				<%	
				   out.print(generateHTML_footer());
					// close if of bci.ontology display	
   	 }
}
%>
