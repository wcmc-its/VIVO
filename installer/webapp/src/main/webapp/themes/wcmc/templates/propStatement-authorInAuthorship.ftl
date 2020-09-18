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

<#-- Custom object property statement view for http://vivoweb.org/ontology/core#authorInAuthorship. 
    
     This template must be self-contained and not rely on other variables set for the individual page, because it
     is also used to generate the property statement during a deletion.  
 -->
 
<#import "lib-sequence.ftl" as s>
<#import "lib-datetime.ftl" as dt>

<@showAuthorship statement />

<#-- Use a macro to keep variable assignments local; otherwise the values carry over to the
     next statement -->
<#macro showAuthorship statement>
<#if statement.hideThis?has_content>
    <span class="hideThis">&nbsp;</span>
    <script type="text/javascript" >
        $('span.hideThis').parent().parent().addClass("hideThis");
        if ( $('h3#authorInAuthorship').attr('class') == undefined ) {
            $('h3#authorInAuthorship').addClass('hiddenPubs');
        }
        $('span.hideThis').parent().remove();
    </script>
<#else>
    <#local citationDetails>
        <#if statement.subclass??>

            <#if statement.subclass?contains("Article")>
                <#if statement.journal??>
                    <i>${statement.journal!}</i>.&nbsp;
                    <#if statement.volume?? && statement.number?? && statement.startPage?? && statement.endPage??>
                        ${statement.volume!}(${statement.number!}):${statement.startPage!}-${statement.endPage!}.
                    <#elseif statement.volume?? && statement.startPage?? && statement.endPage??>
                        ${statement.volume!}:${statement.startPage!}-${statement.endPage!}.
                    <#elseif statement.volume?? && statement.startPage??>
                        ${statement.volume!}:${statement.startPage!}.
                    <#elseif statement.volume??>
                        ${statement.volume!}.
                    <#elseif statement.startPage?? && statement.endPage??>
                        ${statement.startPage!}-${statement.endPage!}.
                    <#elseif statement.startPage??>
                        ${statement.startPage!}.
                    </#if>
                </#if>
            <#elseif statement.subclass?contains("Chapter")>
                <#if statement.journal??>
                    <i>${statement.journal!}</i>.
                <#elseif statement.appearsIn??>
                    <em>${statement.appearsIn!}</em>.
                <#elseif statement.partOf??>
                    <em>${statement.partOf!}</em>.
                </#if>
                <#if statement.editor??>
                    Ed.&nbsp;${statement.editor!}.&nbsp;
                </#if>
                <#if statement.locale?? && statement.publisher??>
                    ${statement.locale!}:&nbsp;${statement.publisher!}.
                <#elseif statement.locale??>
                    ${statement.locale!}.
                <#elseif statement.publisher??>
                    ${statement.publisher!}.
                </#if>
                <#if statement.startPage?? && statement.endPage??>
                    ${statement.startPage!}-${statement.endPage!}.
                <#elseif statement.startPage??>
                    ${statement.startPage!}.
                </#if>
            <#elseif statement.subclass?contains("Book")>
                <#if statement.volume??>
                    Vol.&nbsp;${statement.volume!}.&nbsp;
                </#if>
                <#if statement.editor??>
                    Ed.&nbsp;${statement.editor!}.&nbsp;
                </#if>
                <#if statement.locale?? && statement.publisher??>
                    ${statement.locale!}:&nbsp;${statement.publisher!}.
                <#elseif statement.locale??>
                    ${statement.locale!}.
                <#elseif statement.publisher??>
                    ${statement.publisher!}.
                </#if>
            <#else>
                <#if statement.journal??>
                    <i>${statement.journal!}</i>.
                <#elseif statement.appearsIn??>
                    <em>${statement.appearsIn!}</em>.
                <#elseif statement.partOf??>
                    <em>${statement.partOf!}</em>.
                </#if>
                <#if statement.editor??>
                    Ed. ${statement.editor!}.&nbsp;
                </#if>
                <#if statement.startPage?? && statement.endPage??>
                    ${statement.startPage!}-${statement.endPage!}.
                <#elseif statement.startPage??>
                    ${statement.startPage!}.
                </#if>
            </#if>
            
        </#if>
    </#local>

    <#local resourceTitle>
        <#if statement.infoResource??>
            <#if citationDetails?has_content>
                <a href="${profileUrl(statement.uri("infoResource"))}"  title="resource name">${statement.infoResourceName}</a>.&nbsp;
            <#else>
                <a href="${profileUrl(statement.uri("infoResource"))}"  title="resource name">${statement.infoResourceName}</a>
            </#if>
        <#else>
            <#-- This shouldn't happen, but we must provide for it -->
            <a href="${profileUrl(statement.uri("authorship"))}" title="missing resource">missing information resource</a>
        </#if>
    </#local>

	<#local resourceType>
        <#if statement.subclass??>
            
            <#assign biboType = '${statement.subclass?replace("http://purl.org/ontology/bibo/", "")}'>
        	<#assign wcmcType = '${statement.subclass?replace("http://weill.cornell.edu/vivo/ontology/wcmc#", "")}'>
        	<#assign coreType = '${statement.subclass?replace("http://vivoweb.org/ontology/core#", "")}'>
			
			<!-- default: assign to bibo type -->
			<#assign subclassType = "${biboType}">

			<!-- if it does not have the bibo namespace, assign to core namespace -->
			<#if "${subclassType}"?contains("http")>
				<#assign subclassType = "${coreType}">
			</#if>
			
			<!-- if it does not have the core namespace, assign to wcmc namespace -->
			<#if "${subclassType}"?contains("http")>
				<#assign subclassType = "${wcmcType}">
			</#if>

			<span class="publication-type">${subclassType?replace("([A-Z])", "&nbsp;$1", "rc")?replace("^&nbsp;", "", "rc")}</span>
        </#if>
    </#local>
    
    <#local timesCited>
		<#if statement.globalCitationCount??>
			<br/>Times cited: <a target="ScopusWindow" href="http://www.scopus.com/results/citedbyresults.url?sort=plf-f&cite=2-s2.0-${statement.scopusDocId!}&src=s&imp=t&sot=cite&sdt=a&sl=0&origin=resultslist">${statement.globalCitationCount!}</a>
		</#if>
    </#local>

	<#local getIt>
		<#if statement.pmid?has_content>
			<a class="getit-type" target="PMIDWindow" href="https://weillcornell-primo.hosted.exlibrisgroup.com/primo-explore/openurl?sid=Entrez:PubMed&id=pmid:${statement.pmid!}&vid=WCMC&institution=01WCMC&url_ctx_val=&url_ctx_fmt=null&isSerivcesPage=true">GET&nbsp;IT</a>
		<#elseif statement.doi?has_content>
			<a class="getit-type" target="DOIWindow" href="https://weillcornell-primo.hosted.exlibrisgroup.com/primo-explore/openurl?sid=Entrez:PubMed&id=doi:${statement.doi!}&vid=WCMC&institution=01WCMC&url_ctx_val=&url_ctx_fmt=null&isSerivcesPage=true">GET&nbsp;IT</a>
		</#if>
    </#local>
    

    <#local authors>
		<#if statement.authors?has_content>

<!--
				<b>authors: ${statement.authors!}</b>
				<br/>
				<b>ranks: ${statement.ranks!}</b>
				<br/>
				<b>uris: ${statement.uris!}</b>
				<br/>
				<b>self author: ${statement.selfAuthor!}</b>
				<br/>
				<b>self authorship: ${statement.selfAuthorshipLabel!}</b>
-->

			<!-- assign ranks to list -->        
	        <#assign rankList = [] />
			<#list "${statement.ranks}"?split("; ") as x>
				<#assign rankNumber = x?number />
				<#assign rankList = rankList + [ rankNumber ] />
			</#list>
			<#list rankList as x>
	
			</#list>
				
			<!-- assign authors to list -->      
	        <#assign authorList = [] />
			<#list "${statement.authors}"?replace("Authorship for ", "")?replace(", ", " ")?split("; ") as x>
				<#assign authorList = authorList + [ x ] />
			</#list>
			<#list authorList as x>
	
			</#list>
				
			<!-- assign uris to list -->        
	        <#assign uriList = [] />
			<#list "${statement.uris}"?split("; ") as x>
				<#assign uriList = uriList + [ x ] />
			</#list>
			<#list uriList as x>
	
			</#list>
			
			<!-- assign rankToAuthorMap -->
			<#assign rankToAuthorMap = [] />
			<#assign counter = 0 />
			<#list rankList as x>
				<#assign author = authorList[counter] />
				<#assign rankToAuthorMap = rankToAuthorMap + [{"rank":x, "author":author}] />
				<#assign counter = counter + 1 />
			</#list>

			<!-- assign rankToUriMap -->
			<#assign rankToUriMap = {} />
			<#assign counter = 0 />
			<#list rankList as x>
				<#assign uri = uriList[counter] />
				<#assign rankToUriMap = rankToUriMap + {x:uri} />
				<#assign counter = counter + 1 />
			</#list>
			
			<!-- iterate maps -->
			<#assign counter = 1 />

			<#list rankToAuthorMap?sort_by("rank") as m>
				<#assign rankStr = m.rank?string />
				<#assign authorStr = m.author?string />
				<#assign uri = rankToUriMap[rankStr] />
				<#if (counter == rankToAuthorMap?size) >
					<#if uri?contains("cwid-")>
						<#if "${authorStr}" == "${statement.authorshipFor!}"?replace("Authorship for ", "")>
							<b>${authorStr}</b>.
						<#else>
							<a target="profilePage" href="${uri}">${authorStr}</a>.
						</#if>
					<#else>
						${authorStr}.
					</#if>
				<#else>
					<#if uri?contains("cwid-")>
						<#if "${authorStr}" == "${statement.authorshipFor!}"?replace("Authorship for ", "")>
							<b>${authorStr}</b>,
						<#else>
							<a target="profilePage" href="${uri}">${authorStr}</a>,
						</#if>
					<#else>
						${authorStr},
					</#if>
				</#if>
				<#assign counter = counter + 1 />
			</#list>

        </#if>
	</#local>

    ${authors?replace("..", ".")?replace(".</a>.", "</a>.")} ${resourceTitle?replace(".</a>.", ".</a>")} ${citationDetails} <@dt.yearSpan "${statement.dateTime!}" /> ${resourceType} ${getIt} ${timesCited}

</#if>
</#macro>
