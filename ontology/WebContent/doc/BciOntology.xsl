<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				version="1.0"
     xmlns:k="http://bci.pet.cs.nctu.edu.tw/ontology#"
     xml:base="http://bci.pet.cs.nctu.edu.tw/ontology"
     xmlns:protege="http://protege.stanford.edu/plugins/owl/protege#"
     xmlns:xsp="http://www.owl-ontologies.com/2005/08/07/xsp.owl#"
     xmlns:ssn="http://purl.oclc.org/NET/ssnx/ssn#"
     xmlns:sqwrl="http://sqwrl.stanford.edu/ontologies/built-ins/3.4/sqwrl.owl#"
     xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
     xmlns:swrl="http://www.w3.org/2003/11/swrl#"
     xmlns:dul="http://www.loa-cnr.it/ontologies/DUL.owl#"
     xmlns:dbp="http://dbpedia.org/ontology/"
     xmlns:swrlb="http://www.w3.org/2003/11/swrlb#"
     xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
     xmlns:owl="http://www.w3.org/2002/07/owl#"
     xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
     xmlns:swrla="http://swrl.stanford.edu/ontologies/3.3/swrla.owl#"
     xmlns:fn="http://www.w3.org/2005/xpath-functions">
                
     
<xsl:template match="/">
<html>
<head>
	<title>BCI Ontology</title>
	
<style type="text/css">

    code.xml .text {
      color: #000000;
      background: transparent;
    }
    code.xml .elem {
      color: #000080; 
      background: transparent;
    }
    code.xml .attr {
      color: #008080;
      background: transparent;
    }
    code.xml .attrVal {
      color: #666666;
      background: transparent;
    }
    code.xml .highlight {
      background: #ffff00;
    }
    
        h1, h2, h3, h4, h5, h6 {
                font-family: Georgia, "Times New Roman", Times, serif;
                font-style:italic;
        }    
        
        pre {
          border: 1px #9999cc dotted;
          background-color: #f3f3ff;
          color: #000000; 
    width: 90%;
        }
        
        blockquote {
          border-style: solid;
          border-color: #d0dbe7;
          border-width: 0 0 0 .25em;
          padding-left: 0.5em;
        }
        
        blockquote, q {
          font-style: italic;
        } 
        
        body {
                font-family: verdana, geneva, arial, sans-serif;
        }
        
        a, p,blockquote, q, dl, dd, dt {
                font-family: verdana, geneva, arial, sans-serif;
                font-size: 1em;
        }
        
        
        dt {
                font-weight: bold;
        }
        
        
:link { color: #00C; background: transparent }
:visited { color: #609; background: transparent }
:link:active, :visited:active { color: #C00; background: transparent }
:link:hover, :visited:hover { background: #ffa; }
code :link, code :visited { color: inherit; }

h1, h2, h3, h4, h5, h6 { text-align: left }
h1, h2, h3 { color: #996633; background: transparent; }
h1 { font: 900 170% sans-serif; border-bottom: 1px solid gray; } 
h2 { font: 800 140% sans-serif; border-bottom: 1px solid gray; } 
h3 { font: 700 120% sans-serif } 
h4 { font: bold 100% sans-serif }
h5 { font: italic 100% sans-serif }
h6 { font: small-caps 100% sans-serif }

body { padding: 0 4em 2em 4em;  line-height: 1.35; }
        
pre { margin-left: 2em; /* overflow: auto; */ }
h1 + h2 { margin-top: 0; }
h2 { margin: 3em 0 1em 0; }
h2 + h3 { margin-top: 0; }
h3 { margin: 2em 0 1em 0; }
h4 { margin: 1.5em 0 0.75em 0; }
h5, h6 { margin: 1.5em 0 1em; }
p { margin: 1em 0; }
dl, dd { margin-top: 0; margin-bottom: 0; }
dt { margin-top: 0.75em; margin-bottom: 0.25em; clear: left; }
dd dt { margin-top: 0.25em; margin-bottom: 0; }
dd p { margin-top: 0; }
p + * &gt; li, dd li { margin: 1em 0; }
dt, dfn { font-weight: bold; font-style: normal; }
pre, code { font-size: inherit; font-family: monospace; }
pre strong { color: black; font: inherit; font-weight: bold; background: yellow; }
pre em { font-weight: bolder; font-style: normal; }
var sub { vertical-align: bottom; font-size: smaller; position: relative; top: 0.1em; }
blockquote { margin: 0 0 0 2em; border: 0; padding: 0; font-style: italic; }
ins { background: green; color: white; /* color: green; border: solid thin lime; padding: 0.3em; line-height: 1.6em; */ text-decoration: none; }
del { background: maroon; color: white; /* color: maroon; border: solid thin red; padding: 0.3em; line-height: 1.6em; */ text-decoration: line-through; }
body ins, body del { display: block; }
body * ins, body * del { display: inline; }


<!--
table.properties { margin-left: 1em; width: 80%; background-color: #f3f3ff; }
table.properties th { text-align: left; width: 9em; font-weight: normal;}

table { border-collapse: collapse;  border: solid #999999 1px;}
table thead { border-bottom: solid #999999 2px; }
table td, table th { border-left: solid #999999 1px; border-right: solid #999999 1px; border-bottom: solid #999999 1px;; vertical-align: top; padding: 0.2em; }
 -->
.historyList {
  font-size: 0.9em;
}

</style>

</head>

<body>

<xsl:comment>
   <h1><xsl:value-of select="rdf:RDF/owl:Ontology/rdfs:label"/></h1>

<dl class="doc-info">
    <xsl:for-each select="rdf:RDF/owl:Ontology">

      	<dt>Author</dt>
  	    <dd> PET Lab, Computer Science College, NCTU, Taiwan </dd>

      	<dt>Description</dt>
  	    <dd><xsl:value-of select="rdfs:comment"/></dd>

      	<dt>Latest Version</dt>
		<dd> <xsl:value-of select="owl:versionInfo"/> </dd>

      	<dt>URI</dt>
  	    <dd>The namespace for this ontology is <xsl:value-of select="@rdf:about"/> </dd>

      	<dt>Prefix</dt>
  	    <dd> When used in XML documents the suggested prefix is bci </dd>
    
    </xsl:for-each> 
</dl>
</xsl:comment>
	

<div class="property">	
<h2>Class Section</h2>
   <xsl:for-each select="rdf:RDF/owl:Class"> 
      <xsl:apply-templates select="."/>
   </xsl:for-each>
<h2>ObjectProperty Section</h2>
   <xsl:for-each select="rdf:RDF/owl:ObjectProperty"> 
      <xsl:apply-templates select="."/>
   </xsl:for-each>
<h2>DatatypeProperty Section</h2>
   <xsl:for-each select="rdf:RDF/owl:DatatypeProperty"> 
      <xsl:apply-templates select="."/>
   </xsl:for-each>

</div>
</body></html>
</xsl:template>
<xsl:include href="content.xsl" />
<xsl:template match = "*|text()"/>
</xsl:stylesheet>