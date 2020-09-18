<#--
Copyright (c) 2013, Cornell University
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.
    * Neither the name of Cornell University nor the names of its contributors
      may be used to endorse or promote products derived from this software
      without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->

<#-- Custom object property statement view for http://vivoweb.org/ontology/core#hasRole and its child properties.
    
     This template must be self-contained and not rely on other variables set for the individual page, because it
     is also used to generate the property statement during a deletion.  
 -->

<#import "lib-datetime.ftl" as dt>

<@showRole statement />

<#-- Use a macro to keep variable assignments local; otherwise the values carry over to the
     next statement -->
<#macro showRole statement>
<#if statement.hideThis?has_content>
    <span class="hideThis">&nbsp;</span>
    <script type="text/javascript" >
        $('span.hideThis').parent().parent().addClass("hideThis");
        if ( $('h3#hasResearcherRole').attr('class') == undefined ) {
            $('h3#hasResearcherRole').addClass('hiddenGrants');
        }
        $('span.hideThis').parent().remove();
    </script>
<#else>
    <#local linkedIndividual>
    	
        <#if statement.activity??>
            <a href="${profileUrl(statement.uri("activity"))}" title="activity name">${statement.activityLabel!statement.activityName!}</a>
        <#else>
            <#-- This shouldn't happen, but we must provide for it -->
            <a href="${profileUrl(statement.uri("role"))}" title="missing activity">missing activity</a>
        </#if>
    </#local>
    
    <#local awardOrAdminBy>
        <#if statement.awardedByLabel??>
            &nbsp;awarded by&nbsp;<a href="${profileUrl(statement.uri("awardedBy"))}" title="awarded by">${statement.awardedByLabel!}</a>
        <#elseif statement.adminedByLabel??>
            &nbsp;administered by&nbsp;<a href="${profileUrl(statement.uri("adminedBy"))}" title="administered by">${statement.adminedByLabel!}</a>
        </#if>
    </#local>
        
    <#local dateTime>
        <#if statement.dateTimeStartRole?has_content || statement.dateTimeEndRole?has_content>
            <@dt.yearIntervalSpan "${statement.dateTimeStartRole!}" "${statement.dateTimeEndRole!}" />
        <#else>
            <@dt.yearIntervalSpan "${statement.dateTimeStartGrant!}" "${statement.dateTimeEndGrant!}" />
        </#if>
    </#local>
    
    <#local roleType>
	    <#if statement.subclass?has_content && statement.subclass?contains("KeyPersonnelRole")>
	    	<span class="publication-type">Key&nbsp;Personnel</span>
	    </#if>
	    <#if statement.subclass?has_content && statement.subclass?contains("#PrincipalInvestigatorRole")>
	    	<span class="publication-type">Principal&nbsp;Investigator</span>
	    </#if>
	    <#if statement.subclass?has_content && statement.subclass?contains("PrincipalInvestigatorSubawardRole")>
	    	<span class="publication-type">Principal&nbsp;Investigator&nbsp;Subaward</span>
	    </#if>
	    <#if statement.subclass?has_content && statement.subclass?contains("#CoPrincipalInvestigatorRole")>
	    	<span class="publication-type">Co-Principal&nbsp;Investigator</span>
	    </#if>
	    <#if statement.subclass?has_content && statement.subclass?contains("#CoInvestigatorRole")>
	    	<span class="publication-type">Co-Investigator</span>
	    </#if>
    </#local>

    ${linkedIndividual} ${awardOrAdminBy} ${roleType!} ${dateTime!}
</#if>
</#macro>