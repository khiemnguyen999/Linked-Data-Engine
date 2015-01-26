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
     xmlns:fn="http://www.w3.org/2005/xpath-functions"
     xmlns:dc="http://purl.org/dc/elements/1.1/">
     <xsl:output method ="xml" indent ="yes"/>
<xsl:template match="owl:Class|owl:ObjectProperty| owl:DatatypeProperty">
   	<xsl:if test="@*">
   	  <xsl:if test="string(substring(@rdf:about,8,3))='bci'">
   	   
 		<xsl:choose>
	        		<xsl:when test="substring-before(@rdf:about,'#')!= '' ">
	        			<h3><strong><xsl:value-of select="substring-after(@rdf:about,'#')"/></strong></h3> 
	        		</xsl:when>
	        		<xsl:otherwise>
	               		<h3><strong><xsl:value-of select="substring-after(@rdf:about,';')"/></strong></h3> 
	      			</xsl:otherwise>
	    </xsl:choose>
	    
	    <xsl:for-each select="rdfs:comment">
     	<xsl:value-of select="." /><br />
 		</xsl:for-each>
	<div>
	<table  class="properties">
		<tr>
			<td><strong>URI</strong></td>
			<td>
				<xsl:choose>
	        		<xsl:when test="substring-before(@rdf:about,'#')!= '' ">
	        			<xsl:value-of select="@rdf:about"/>
	        		</xsl:when>
	        		<xsl:otherwise>
	            	<xsl:if test= "string(substring-before(@rdf:about,';')) = string('#dbp') ">
	               		<xsl:value-of select="concat('http://dbpedia.org/ontology/',substring-after(@rdf:about,';'))"/>
	               	</xsl:if>

	            	<xsl:if test= "string(substring-before(@rdf:about,';')) = string('#ssn') ">
	               		<xsl:value-of select="concat('http://purl.oclc.org/NET/ssnx/ssn#',substring-after(@rdf:about,';'))"/>
	               	</xsl:if>
	            
	            	<xsl:if test= "string(substring-before(@rdf:about,';')) = string('#dul') ">
	               		<xsl:value-of select="concat('http://www.loa-cnr.it/ontologies/DUL.owl#',substring-after(@rdf:about,';'))"/>
	            	</xsl:if>
	            
	       			</xsl:otherwise>
				</xsl:choose> 
			</td>
		</tr>
		
		<!-- dc:title -->
		<xsl:if test="dc:title != '' ">
		 <tr>
			<td><strong>title</strong></td>
			<td>
			  <xsl:value-of select="dc:title"/>
			</td>
		 </tr>
		</xsl:if>
		
		<xsl:if test="rdfs:label != '' ">
		 <tr>
			<td><strong>Label</strong></td>
			<td>
			  <xsl:value-of select="rdfs:label"/>
			</td>
		 </tr>
		</xsl:if>
		
		<xsl:if test="owl:versionInfo != '' ">
		 <tr>
			<td><strong>Latest version</strong></td>
			<td>
			  <xsl:value-of select="owl:versionInfo"/>
			</td>
		 </tr>
		</xsl:if>
		
		<xsl:if test="owl:priorVersion != '' ">
		 <tr>
			<td><strong>Prior version</strong></td>
			<td>
			  <xsl:value-of select="owl:priorVersion"/>
			</td>
		 </tr>
		</xsl:if>
		
		<xsl:if test="owl:deprecated != '' ">
		 <tr>
			<td><strong>Deprecated</strong></td>
			<td>
			  <xsl:value-of select="owl:deprecated"/>
			</td>
		 </tr>
		</xsl:if>
		
		<xsl:if test="owl:seeAlso != '' ">
		 <tr>
			<td><strong>See also</strong></td>
			<td>
			  <xsl:value-of select="owl:seeAlso"/>
			</td>
		 </tr>
		</xsl:if>
		
		<!-- dc:source -->
		<xsl:if test="dc:source != '' ">
		 <tr>
			<td><strong>Source</strong></td>
			<td>
			  <xsl:value-of select="dc:source"/>
			</td>
		 </tr>
		</xsl:if>
		
		
	</table>
	</div>
	<br/>
	<b> Schema: </b><br/>
	
    <div style="overflow:hidden; border:1px dotted gray; float:none">
			<code class="xml">
				<span class="elem"> &lt;<xsl:value-of select="name(.)"/></span>  <span class="attr"><xsl:value-of select="name(@*[1])"/></span>="<span class=
					"attrVal"><xsl:value-of select="@*[1]"/></span>"<span class="elem">&gt;</span><br/>
					<xsl:apply-templates select="descendant::owl:Class | descendant::owl:ObjectProperty| descendant::owl:DatatypeProperty|*"/>
			    <span class="elem">&lt;/<xsl:copy-of select="name(.)"/></span><span class="elem">&gt;</span>
		    
		    </code>
	</div>
	</xsl:if>
  </xsl:if>
</xsl:template>

 <xsl:template match="owl:Class/node()[not(self::rdfs:comment | self::rdfs:label)]  |
 					  owl:ObjectProperty/node()[not(self::rdfs:comment | self::rdfs:label| child::owl:Class| descendant::owl:Class|self::owl:Class)] |
 					  owl:DatatypeProperty/node()[not(self::rdfs:comment | self::rdfs:label)]">
	   			<xsl:text>&#160;&#160;</xsl:text>
	   		   	<span class="elem">&lt;<xsl:value-of select="name(.)"/></span>  
	   		   	    <xsl:if test="name(@*[1])">
	   		   		    <span class="attr"><xsl:value-of select="name(@*[1])"/></span>="<span class="attrVal"><xsl:value-of select="@*[1]"/></span>"<span class="elem">&gt;</span>
	   		   		</xsl:if>
	   		   	
			    <xsl:choose>
		   			<xsl:when test="*"><br/>
		   			
				         		<xsl:for-each select="child::*[not(self::owl:Class)]">
							          <xsl:text>&#160;&#160;&#160;</xsl:text>
							          <span class="elem"> &lt;<xsl:value-of select="name(.)"/></span>
							          <xsl:if test="name(@*[1])">  
							          		<span class="attr"><xsl:value-of select="name(@*[1])"/></span>="<span class="attrVal"><xsl:value-of select="@*[1]"/></span>"<span class="elem">&gt;</span>
							          </xsl:if>
									       		<xsl:choose>
										   			<xsl:when test="*"><br/>
											         		<xsl:for-each select="descendant::*[not(self::owl:Class)]"> <!-- take all descendants of Specs -->
														          <xsl:text>&#160;&#160;&#160;&#160;&#160;</xsl:text>
														          <span class="elem"> &lt;<xsl:value-of select="name(.)"/></span>
														          <xsl:if test="name(@*[1])">  
														          		<span class="attr"><xsl:value-of select="name(@*[1])"/></span>="<span class="attrVal"><xsl:value-of select="@*[1]"/></span>"
														          </xsl:if>
																  <span class="elem">&gt;</span>
														          		<xsl:value-of select="."/> 
														          <span class="elem">&lt;/<xsl:copy-of select="name(.)"/></span><span class="elem">&gt;</span><br/>
													        </xsl:for-each>
											    	</xsl:when>
													<xsl:otherwise>
															<xsl:value-of select="."/> 	
													</xsl:otherwise>
												</xsl:choose>      
									<xsl:text>&#160;&#160;&#160;</xsl:text>
							          <span class="elem">&lt;/<xsl:copy-of select="name(.)"/></span><span class="elem">&gt;</span><br/>
						        </xsl:for-each>
	 
			    	</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/> 
					</xsl:otherwise>
				
				</xsl:choose>
				<xsl:text>&#160;&#160;</xsl:text>      
	   			<span class="elem">&lt;/<xsl:copy-of select="name(.)"/></span><span class="elem">&gt;</span><br/>
	 
 </xsl:template>
	 <xsl:template match="text()">
        <xsl:value-of select="normalize-space()"/>
    </xsl:template>
</xsl:stylesheet>

<!-- 
   <div style="overflow:hidden; border:1px dotted gray; float:none">
	<span class="elem">&lt;owl:<xsl:copy-of select="local-name()"/></span> <span class="attr">rdf:about</span>="<span class=
				"attrVal"><xsl:value-of select="@rdf:about"/></span>"<span class="elem">&gt;</span>
				
	           <xsl:copy-of select=" @*|node()[not(self::rdfs:label)][not(self::rdfs:comment)]"/>
	           
    <span class="elem">&lt;/owl:<xsl:copy-of select="local-name()"/></span><span class="elem">&gt;</span>
        
	<table>
		<tr>
			<td>
			  <xmp><xsl:copy-of select="@*|node()[not(self::rdfs:label)][not(self::rdfs:comment)]"/></xmp>
			</td>
		</tr>
	</table>
	 -->