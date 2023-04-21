<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Template for property listing on individual profile page -->
<#import "lib-properties.ftl" as p>
<#assign subjectUri = individual.controlPanelUrl()?split("=") >
<#assign coAuthorVisUrl = individual.coAuthorVisUrl() >
<#assign coInvestigatorVisUrl = individual.coInvestigatorVisUrl()>

<script src="${urls.base}/js/jquery-1.9.1.js"></script>
<script src="${urls.base}/js/jquery_plugins/jquery.tinysort-1.5.6.min.js"></script>

<#list propertyGroups.all as group>

    <#assign groupName = group.getName(nameForOtherGroup)>
    <#assign verbose = (verbosePropertySwitch.currentValue)!false>
    
    <section class="property-group" role="region">
        <nav class="scroll-up" role="navigation">
            <a href="#branding" title="scroll up">
                <img src="${urls.images}/individual/scroll-up.gif" alt="scroll to property group menus" />
            </a>
        </nav>
        
        <#-- Display the group heading --> 
        <#assign groupNameHtmlId="">
        <#assign propSize = group.properties?size >
        <#if (groupName?has_content && group.properties?size > 0) >
    		<#--the function replaces spaces in the name with underscores, also called for the property group menu-->
        	<#assign groupNameHtmlId = p.createPropertyGroupHtmlId(groupName) >
            <h2 id="${groupNameHtmlId}">${groupName?capitalize}</h2>			

            <#if groupNameHtmlId == "publications">
            	<div class="group-controls">
            		<span>Sort by</span>
                    <select id="dropdown_options" class="button" title="Sort by">
                        <option value="newest" selected>Newest</option>
                        <option value="oldest">Oldest</option>
                        <option value="citation">Times Cited</option>
                        <option value="pubtype">Publication Type</option>
                        <option value="pubname">Journal Name</option>
                    </select>   

					<div id="coauthorship_link_container" class="collaboratorship-link-container">
						<div class="collaboratorship-icon">
							<a href="${coAuthorVisUrl}" class="button ss-globe right" title="co-author">Co-Author Network</a>
							<!-- Add edit article link to feedback form -->
	                        <#if editable> 
		                        <#assign cwidValue = "${coAuthorVisUrl}"?replace("/vis/author-network/cwid-", "")?replace("/vivo", "") />
		                        <div class="pubfeedback"></div>
		                        
		                        <script type="text/javascript">
			                        var currDomain = document.domain;
			                        if (currDomain.indexOf(".med.cornell.edu") > -1) {
			                        	$( ".pubfeedback" ).append( '<a href="/contact" class="button ss-globe right" title="edit-article" target="_blank">Publication Feedback</a>' );  
			                        } else {
			                        	$( ".pubfeedback" ).append( '<a href="/vivo/contact" class="button ss-globe right" title="edit-article" target="_blank">Publication Feedback</a>' );  
			                        }
		
		                        </script>
	                        </#if>
						</div>
					</div>
				
				</div>
				       
            </#if>
            
		</#if>

		<#assign numResearchList = 0 />
		<#assign rangeClass = "noRangeClass">
        <#list group.properties as property>

            <#if property.rangeUri?has_content && property.rangeUri?contains("#")>
                <#assign rangeClass = property.rangeUri?substring(property.rangeUri?last_index_of("#")+1)>
            <#elseif property.rangeUri?has_content >
                <#assign rangeClass = property.rangeUri?substring(property.rangeUri?last_index_of("/")+1)>
            </#if>
        
			<#if (rangeClass == "PrincipalInvestigatorRole" || rangeClass == "KeyPersonnelRole" || rangeClass == "PrincipalInvestigatorSubawardRole" || rangeClass == "CoPrincipalInvestigatorRole" || rangeClass == "CoInvestigatorRole") >
        		<#if (numResearchList == 0) >
        		
	            	<div class="group-controls">
			            <span>Sort by</span>
			            <select id="research_dropdown_options" class="button" title="Sort by">
			                <option value="newest" selected>Newest</option>
			                <option value="oldest">Oldest</option>
			                <option value="researchrole">Researcher Role</option>
			            </select> 
	
			            <div id="coinvestigator_link_container" class="collaboratorship-link-container">
			                <div class="collaboratorship-icon">
			                    <a class="button ss-globe right" href="${coInvestigatorVisUrl}" title="co-investigator network">Co-investigator Network</a>
			                </div>
	            		</div>
		            </div>   
	            
					<script type="text/javascript">
						$(document).ready(function(){
							$('ul#researchRoleList>li').tsort({order:'desc',attr:'sdate'});
						});
						
						$('#research_dropdown_options').on('change', function (e) {
							var len = $('ul#researchRoleList>li').size();
							if (len > 5) {
								$('ul#researchRoleList li:gt(5)').show();
							}
						    var optionSelected = $("option:selected", this);
						    var valueSelected = this.value;
						    if (valueSelected == 'oldest') {
								$('ul#researchRoleList>li').tsort({attr:'sdate'});
						    } else if (valueSelected == 'newest') {
								$('ul#researchRoleList>li').tsort({order:'desc',attr:'sdate'});
						    } else if (valueSelected == 'researchrole') {
								$('ul#researchRoleList>li').tsort({order:'desc',attr:'researchrole'});
						    }
						    if (len > 5) {
								$('ul#researchRoleList li:gt(5)').hide();
								$("#lessLongListResearchRole").hide();
								$("#moreLongListResearchRole").show();
							}
						});
					</script>
        		
        			<a name="${groupNameHtmlId}" />
        			<article class="property" role="article">
        			<h3 id="authorInAuthorship">Funding awarded</h3>
        			<ul class="property-list" role="list" id="researchRoleList">
        			<#assign numResearchList = numResearchList + 1 />
        		</#if>
        	<#else>
        		<a name="${rangeClass}" />
        		<article class="property" role="article">
        	</#if>

			<#-- Property display name -->
            <#if rangeClass == "Authorship" && individual.editable && (property.domainUri)?? && property.domainUri?contains("Person")>
                <h3 id="${property.localName}-${rangeClass}">${property.name} <@p.addLink property editable /> <@p.verboseDisplay property /> 
                    <a id="managePubLink" class="manageLinks" href="${urls.base}/managePublications?subjectUri=${subjectUri[1]!}" title="${i18n().manage_publications_link}" <#if verbose>style="padding-top:10px"</#if> >
                        ${i18n().manage_publications_link}
                    </a>
                </h3>
            <#elseif (rangeClass == "PrincipalInvestigatorRole" || rangeClass == "KeyPersonnelRole" || rangeClass == "PrincipalInvestigatorSubawardRole" || rangeClass == "CoPrincipalInvestigatorRole" || rangeClass == "CoInvestigatorRole") >
                <#if individual.editable>
                    <h3 id="${property.localName}-${rangeClass}">${property.name} <@p.addLink property editable /> <@p.verboseDisplay property /> 
                        <a id="manageGrantLink" class="manageLinks" href="${urls.base}/manageGrants?subjectUri=${subjectUri[1]!}" title="${i18n().manage_grants_and_projects_link}" <#if verbose>style="padding-top:10px"</#if> >
                            ${i18n().manage_grants_and_projects_link}
                        </a>
                    </h3>
                </#if>
            <#elseif rangeClass == "Position" && individual.editable  >
                <h3 id="${property.localName}-${rangeClass}">${property.name} <@p.addLink property editable /> <@p.verboseDisplay property /> 
                    <a id="managePeopleLink" class="manageLinks" href="${urls.base}/managePeople?subjectUri=${subjectUri[1]!}" title="${i18n().manage_affiliated_people}" <#if verbose>style="padding-top:10px"</#if> >
                        ${i18n().manage_affiliated_people_link}
                    </a>
                </h3>
            <#elseif rangeClass == "Name" && property.statements?has_content && editable >
                <h3 id="${property.localName}">${property.name}  <@p.verboseDisplay property /> </h3>
            <#elseif rangeClass == "Title" && property.statements?has_content && editable >
                <h3 id="${property.localName}">${property.name}  <@p.verboseDisplay property /> </h3>
			<#elseif rangeClass == "noRangeClass" && (property.localName == "meshFor" || property.localName == "subjectAreaOf") && !editable>

            <#else>
            	<!-- For wcmc publications, change to Publications authored from the Admin UI -->
                <h3 id="${property.localName}">${property.name} <@p.addLink property editable /> <@p.verboseDisplay property /> </h3>
            </#if>
                
            <!-- wcmc feature -->
            <#assign propertyName = "noPropertyName">
		    <#if property.name?has_content>
				<#assign propertyName = property.name?lower_case>
		    </#if>
    
        	<#if property.localName == "relatedBy" && rangeClass == "Authorship" && propertyName?contains("publication") >

				<script type="text/javascript">

					$('#dropdown_options').on('change', function (e) {
						var len = $('ul#${property.localName}${rangeClass}List>li').size();
						if (len > 5) {
							$('ul#${property.localName}${rangeClass}List li:gt(5)').show();
						}
					    var optionSelected = $("option:selected", this);
					    var valueSelected = this.value;
					    if (valueSelected == 'oldest') {
							$('ul#${property.localName}${rangeClass}List>li').tsort({attr:'datetime'});
					    } else if (valueSelected == 'newest') {
							$('ul#${property.localName}${rangeClass}List>li').tsort({order:'desc',attr:'datetime'});
					    } else if (valueSelected == 'citation') {
							$('ul#${property.localName}${rangeClass}List>li').tsort({order:'desc',attr:'citation'});
					    } else if (valueSelected == 'pubtype') {
							$('ul#${property.localName}${rangeClass}List>li').tsort({attr:'pubname'}).tsort({attr:'pubtype'});
					    } else if (valueSelected == 'pubname') {
							$('ul#${property.localName}${rangeClass}List>li').tsort({attr:'pubtype'}).tsort({attr:'pubname'});
					    }
					    if (len > 5) {
							$('ul#${property.localName}${rangeClass}List li:gt(5)').hide();
							$("#lessLongList${rangeClass}").hide();
							$("#moreLongList${rangeClass}").show();
						}
					});
				</script>
			</#if>
        	
        	<#if (rangeClass == "PrincipalInvestigatorRole" || rangeClass == "KeyPersonnelRole" || rangeClass == "PrincipalInvestigatorSubawardRole" || rangeClass == "CoPrincipalInvestigatorRole" || rangeClass == "CoInvestigatorRole") >
                    <#-- data property -->
                    <#if property.type == "data">
                        <@p.dataPropertyList property editable />
                    <#-- object property -->
                    <#else>
                        <@p.objectProperty property editable /> 
                    </#if>
			<#elseif rangeClass == "noRangeClass" && (property.localName == "meshFor" || property.localName == "subjectAreaOf") && !editable >

        	<#else>
                <#-- List the statements for each property -->
                <ul class="property-list" role="list" id="${property.localName}${rangeClass}List">
                    <#-- data property -->
                    <#if property.type == "data">
                        <@p.dataPropertyList property editable />
                    <#-- object property -->
                    <#else>
                        <@p.objectProperty property editable /> 
                    </#if>
                </ul>
            </#if>

	    	<#if (rangeClass != "PrincipalInvestigatorRole" && rangeClass != "KeyPersonnelRole" && rangeClass != "PrincipalInvestigatorSubawardRole" && rangeClass != "CoPrincipalInvestigatorRole" && rangeClass != "CoInvestigatorRole") >
	            </article> <!-- end property -->
	    	</#if>
 

			<#if property.localName == "relatedBy" && rangeClass == "Authorship" && propertyName?contains("publication")>
    			<p>
					<div id="moreLongList${rangeClass}"><a class="moreless-type" href="#${rangeClass}">more ...</a></div>
					<div id="lessLongList${rangeClass}"><a class="moreless-type" href="#${rangeClass}">less ...</a></div>
				</p>
    		</#if>
        </#list>
        


			<#if (rangeClass == "PrincipalInvestigatorRole" || rangeClass == "KeyPersonnelRole" || rangeClass == "PrincipalInvestigatorSubawardRole" || rangeClass == "CoPrincipalInvestigatorRole" || rangeClass == "CoInvestigatorRole") >
        		</ul>
        		</article> <!-- end property -->
    			<p>
					<div id="moreLongListResearchRole"><a class="moreless-type" href="#${groupNameHtmlId}">more ...</a></div>
					<div id="lessLongListResearchRole"><a class="moreless-type" href="#${groupNameHtmlId}">less ...</a></div>
				</p>
    		</#if>

        
        </section> <!-- end property-group -->
</#list>
