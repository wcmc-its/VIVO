<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Default individual browse view -->

<#import "lib-properties.ftl" as p>

<li class="individual" role="listitem" role="navigation">

<#assign cwid = "${individual.uri}"?replace("http://vivo.med.cornell.edu/individual/cwid-","") />
<#assign imageUrl = "https://directory.weill.cornell.edu/api/v1/person/profile/${cwid}.png?returnGenericOn404=true" />
<#if (individual.uri?contains('http://vivo.med.cornell.edu/individual/cwid-')) >
    <img class="individual-image" src="${imageUrl}" width="90" alt="${individual.name}" onError="this.onerror=null;this.src='/vivo/images/DirectoryGenericPhoto.png';"/>
<#else>
	<img class="individual-image" src="/vivo/images/DirectoryGenericPhoto.png" width="90" alt="${individual.name}"/>
</#if>
    <h1 class="thumb">
        <a href="${individual.profileUrl}" title="${i18n().view_profile_page_for} ${individual.name}}">${individual.name}</a>
    </h1>


<#if (extra[0].pt)?? >
    <span class="title">${extra[0].pt}</span>
<#else>
    <#assign cleanTypes = 'edu.cornell.mannlib.vitro.webapp.web.TemplateUtils$DropFromSequence'?new()(individual.mostSpecificTypes, vclass) />
    <#if cleanTypes?size == 1>
        <span class="title">${cleanTypes[0]}</span>
    <#elseif (cleanTypes?size > 1) >
        <span class="title">
            <ul>
                <#list cleanTypes as type>
                <li>${type}</li>
                </#list>
            </ul>
        </span>
    </#if>
</#if>

</li>

