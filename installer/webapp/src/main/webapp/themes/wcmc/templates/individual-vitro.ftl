<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->
<#--Number of labels present-->
<#if !labelCount??>
    <#assign labelCount = 0 >
</#if>
<#--Number of available locales-->
<#if !localesCount??>
	<#assign localesCount = 1>
</#if>
<#--Number of distinct languages represented, with no language tag counting as a language, across labels-->
<#if !languageCount??>
	<#assign languageCount = 1>
</#if>	

<#-- Default individual profile page template -->
<#--@dumpAll /-->
<section id="individual-intro" class="vcard" role="region">
    <section id="share-contact" role="region">
	
	<#-- Image -->
	<#-- Image -->
        <#assign individualImage>
        <@p.image individual=individual
            propertyGroups=propertyGroups
            namespaces=namespaces
            editable=editable
            showPlaceholder="with_add_link" />
        </#assign>

        <#if ( individualImage?contains('<img class="individual-photo"') )>
            <#assign infoClass = 'class="withThumb"'/>
        </#if>
        <div id="photo-wrapper">${individualImage}</div>
    </section>
    <!-- start section individual-info -->
    <section id="individual-info" ${infoClass!} role="region">
        <#include "individual-adminPanel.ftl">
        
        <header>
            <#if relatedSubject??>
                <h2>${relatedSubject.relatingPredicateDomainPublic} for ${relatedSubject.name}</h2>
                <p><a href="${relatedSubject.url}" title="${i18n().return_to(relatedSubject.name)}">&larr; ${i18n().return_to(relatedSubject.name)}</a></p>                
            <#else>                
                <h1 class="fn">
                    <#-- Label -->
                    <#-- @p.label individual editable labelCount localesCount languageCount/ -->
					<#if personLabel?has_content >
			            <#if personLabel.statements?has_content>
				            <#if editable>		                
			                    <#list personLabel.statements as statement>		                        	                            
			                           <span class="fn">${statement.value}&nbsp;&nbsp;</span>
			                    </#list>
				            <#else>
			                    <span class="fn">${personLabel.statements[0].value}&nbsp;&nbsp;</span>
				            </#if>
			            </#if>
				    <#else>
				    	<span class="fn"><@p.label individual editable labelCount localesCount languageCount/></span>
				    </#if>

                    <#--  Most-specific types -->
                    <@p.mostSpecificTypes individual />
                    <a class="wcmcUriIcon" href="${individual.rdfUrl}"><img id="uriIcon" title="${individual.uri}" class="middle" src="${urls.images}/individual/uriIcon.gif" alt="uri icon"/></a>
                </h1>
            </#if>
        </header>
                
    <#if individualProductExtension??>
        ${individualProductExtension}
    <#else>
            </section> <!-- individual-info -->
        </section> <!-- individual-intro -->
    </#if>

<#assign nameForOtherGroup = "${i18n().other}"> 

<!-- Property group menu or tabs -->
<#-- 
    With release 1.6 there are now two types of property group displays: the original property group
     menu and the horizontal tab display, which is the default. If you prefer to use the property
     group menu, simply substitute the include statement below with the one that appears after this
     comment section.
     
     <#include "individual-property-group-menus.ftl">
-->

<#-- include "individual-property-group-tabs.ftl" -->

<#-- wcmc: Ontology properties -->
<#include "individual-properties.ftl">

<#assign rdfUrl = individual.rdfUrl>

<#if rdfUrl??>
    <script>
        var individualRdfUrl = '${rdfUrl}';
    </script>
</#if>
<script>
    var i18nStringsUriRdf = {
        shareProfileUri: '${i18n().share_profile_uri}',
        viewRDFProfile: '${i18n().view_profile_in_rdf}',
        closeString: '${i18n().close}'
    };
</script>

${stylesheets.add('<link rel="stylesheet" href="${urls.base}/css/individual/individual.css" />')}

${headScripts.add('<script type="text/javascript" src="${urls.base}/js/jquery_plugins/qtip/jquery.qtip-1.0.0-rc3.min.js"></script>',
                  '<script type="text/javascript" src="${urls.base}/js/tiny_mce/tiny_mce.js"></script>')}

${scripts.add('<script type="text/javascript" src="${urls.base}/js/imageUpload/imageUploadUtils.js"></script>',
              '<script type="text/javascript" src="${urls.base}/js/individual/individualUriRdf.js"></script>')}

<script type="text/javascript">
    i18n_confirmDelete = "${i18n().confirm_delete}"
</script>
