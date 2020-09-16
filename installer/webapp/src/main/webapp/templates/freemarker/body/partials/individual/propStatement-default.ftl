<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- VIVO-specific default object property statement template. 
    
     This template must be self-contained and not rely on other variables set for the individual page, because it
     is also used to generate the property statement during a deletion.  
-->

<@showStatement statement />

<#macro showStatement statement>
    <#-- The query retrieves a type only for Persons. Post-processing will remove all but one. --> 
    <#assign urlStr = statement.uri("object") >
	<#if urlStr?contains("/citation")>
		<a target="ScopusWindow" href="http://www.scopus.com/results/citedbyresults.url?sort=plf-f&cite=2-s2.0-${urlStr?replace("http://vivo.med.cornell.edu/individual/citation-pubid", "")!}&src=s&imp=t&sot=cite&sdt=a&sl=0&origin=resultslist">${statement.label!statement.localName!}</a>
	<#elseif !urlStr?contains("/concept")>
		<a href="${profileUrl(statement.uri("object"))}" title="${i18n().name}">${statement.label!statement.localName!}</a>&nbsp; ${statement.title!statement.type!}
	<#else>	
		${statement.label!statement.localName!} 
	</#if>
</#macro>