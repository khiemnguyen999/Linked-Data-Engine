  <%@page import="org.codehaus.jettison.json.JSONArray"%>
<%@page contentType="text/html; charset=UTF-8"%>
  <%@page import="org.json.simple.JSONObject"%>
  <%
 
  JSONArray ja= new JSONArray();
  
  JSONObject obj1= new JSONObject();
  
  obj1.put("value", "http://purl.oclc.org/NET/ssnx/ssn#hasMeasurementCapability");
  obj1.put("type", "uri");
  
  JSONObject obj2= new JSONObject();
  
  obj2.put("value", "http://bci.pet.cs.nctu.edu.tw/ontology#EegBciDevice_01");
  obj2.put("type", "uri");
  
  JSONObject obj3= new JSONObject();
  obj3.put("value", "NCTU");
  obj3.put("datatype", "http://bci.pet.cs.nctu.edu.tw/ontology#MeasurementCapability_01");
  obj3.put("type", "uri");
  
  for(int i=0;i<=5;i++){
	JSONObject obj=new JSONObject();
	obj.put("P",obj1);
    obj.put("S",obj2);
    obj.put("O",obj3);
    
    ja.put(obj);
  }
    
  out.print(ja);
    

  %>