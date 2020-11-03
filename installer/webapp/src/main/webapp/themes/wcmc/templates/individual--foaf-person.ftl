<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- 

    This version of individual--foaf-person.ftl is a "router" template. The original VIVO 
    version of this template now resides in the /themes/wilma/templates directory.
    
    This version of the template is used when the profile page types feature is enabled. 
    This template serves to "rout" the user to the correct template based (1) the 
    profile page type of the foaf person being displayed or (2) the targeted view that 
    the user wants to see. For example, when a user is routed to a quick view template, 
    the user has the option of displaying the full view. If the user chooses that option, 
    the targetedView variable gets set. 
    
    This template could also be used to load just the "individual--foaf-person-2column.ftl"
    without enabling profile page types. "individual--foaf-person-2column.ftl" is a slightly
    different design than the "individual--foaf-person.ftl" template in the themes/wilma 
    directory.
        
 -->

<#include "individual-setup.ftl">

<#-- 
    First, check to see if profile page types are enabled. If not, get the 2 column template:
    "individual--foaf-person-2column.ftl".

    NOTE: the assumption here is that if this template is being loaded, rather than the
    individual--foaf-person.ftl template that resides in the theme directory, than the site
    administrator wants to use 2 column template by itself or with the quick view template.
-->

<#-- Individual profile page template for foaf:Person individuals -->
<!--[if IE 7]>
<link rel="stylesheet" href="${urls.base}/css/individual/ie7-standard-view.css" />
<![endif]-->
<#-- <#include "individual-setup.ftl"> -->

<#import "lib-vivo-properties.ftl" as vp>
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

<#assign visRequestingTemplate = "foaf-person-2column">

    
    
  
<section id="individual-intro" class="vcard person" role="region">

        <#include "individual-adminPanel.ftl">
    <header>
            <#if relatedSubject??>
                <h2>${relatedSubject.relatingPredicateDomainPublic} for ${relatedSubject.name}</h2>
                <p><a href="${relatedSubject.url}" title="return to">&larr; return to ${relatedSubject.name}</a></p>
            <#else>
                <h1 class="vcard foaf-person">
                    <#-- Label -->
                    <#-- <span class="fn"><@p.label individual editable labelCount/></span> -->
                    
                    
					<#assign personLabel = propertyGroups.pullProperty("${wcmc}personLabel")!>
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
				    	<span class="fn"><@p.label individual editable labelCount/></span>
				    </#if>
                    
                    <#--  Display preferredTitle if it exists; otherwise mostSpecificTypes -->
                    
                    <#assign cwidValue = "${individual.rdfUrl}"?replace("/individual/cwid-ars2013/cwid-", "")?replace(".rdf", "") />
                    
                    <#assign title = propertyGroups.pullProperty("http://purl.obolibrary.org/obo/ARG_2000028","http://www.w3.org/2006/vcard/ns#Title")!>
                    
                    <#if title?has_content> <#-- true when the property is in the list, even if not populated (when editing) -->
                        <#if (title.statements?size < 1) >
                            <@p.addLinkWithLabel title editable /> 
                        <#elseif editable>
                            <h2>${title.name?capitalize!}</h2>
                            <@p.verboseDisplay title />
                        </#if>
                        
                        <#list title.statements as statement>
	                            <span class="display-title<#if editable>-editable</#if>">${statement.preferredTitle!}</span>
	                            <@p.editingLinks "${title.localName}" "${title.name}" statement editable title.rangeUri />
	                    </#list>
                    </#if>
                    <#-- If preferredTitle is unpopulated, display mostSpecificTypes -->
                    <#if ! (title.statements)?has_content>
                        <@p.mostSpecificTypes individual />
                    </#if>
                </h1>
            </#if>


    </header> 
        
        
        
    <#-- Property group menu -->
    <#include "individual-propertyGroupMenu.ftl">
    <section id="share-contact" role="region">
	<#assign cwid = "${individual.uri}"?replace("https://vivo.med.cornell.edu/individual/cwid-","") />
	<#-- Image -->
        <#if (individual.uri?contains('https://vivo.med.cornell.edu/individual/cwid-')) >
                <#assign individualImage>
                     <@p.directoryImage individual=individual
                      propertyGroups=propertyGroups
                      namespaces=namespaces
                      editable=editable
                      directoryImageurl="https://directory.weill.cornell.edu/api/v1/person/profile/${cwid}.png?returnGenericOn404=true"
                      showPlaceholder="always"
                      />
        </#assign>

        <#else>
                <#assign individualImage>
                        <@p.directoryImage individual=individual
                        propertyGroups=propertyGroups
                        namespaces=namespaces
                        editable=editable
                        directoryImageurl="/images/DirectoryGenericPhoto.png"
                        showPlaceholder="always"
                 />
                </#assign>

        </#if>


        <#if ( individualImage?contains('<img class="individual-photo"') )>
            <#assign infoClass = 'class="withThumb"'/>
        </#if>

        <div id="photo-wrapper">${individualImage}</div>
        <#include "individual-visualizationFoafPerson.ftl">

            <#include "individual-contactInfo.ftl">

        <#-- Links -->
        <@vp.webpages propertyGroups editable "individual-urls-people" />
        <nav role="navigation">
            <ul id ="individual-tools-people" role="list">
                <li role="listitem" class="rdfBtn"><a class="uriIcon ss-link right" href="${individual.uri}" class="middle" src="${urls.images}/../themes/wcmc/images/rdfBtn.png" alt="uri icon"/ style="display:inline-block; width: 10px; height:10px; overflow:hidden; color: white;"></a></li>
            </ul>
        </nav>

        <div id="individual-tools-people">
            <span id="iconControlsLeftSide">
				<#include "individual-iconControls.ftl">        
            </span>
        </div>

    </section>        
        
        
    <section id="individual-info" ${infoClass!} role="region">
    
            <#-- Positions -->
            <#assign positions = propertyGroups.pullProperty("${core}relatedBy", "${core}Position")!>
            <#if positions?has_content> <#-- true when the property is in the list, even if not populated (when editing) -->
                <@p.objectPropertyListing positions editable />
            </#if>
            
            
        <!-- Overview -->
        <#if !editable>
            <p></p>
        </#if>
        <#include "individual-overview.ftl">            

        <#-- Research Areas -->
        <#assign researchAreas = propertyGroups.pullProperty("${core}hasResearchArea")!>
        <#if researchAreas?has_content> <#-- true when the property is in the list, even if not populated (when editing) -->
            <@p.objectPropertyListing researchAreas editable />
        </#if>           
            
        <!-- Geographic Focus -->
		<#assign geographicFoci = propertyGroups.pullProperty("${core}geographicFocus")!> 
			<#if geographicFoci?has_content> <#-- true when the property is in the list, even if not populated (when editing) -->
			<@p.objectPropertyListing geographicFoci editable />
		</#if>
		
		<#include "individual-openSocial.ftl">

	</section>
        
 </section>       
        
<#assign nameForOtherGroup = "other"> <#-- used by both individual-propertyGroupMenu.ftl and individual-properties.ftl -->

<#-- Ontology properties -->
<#if !editable>
	<#-- We don't want to see the first name and last name unless we might edit them. -->
	<#assign skipThis = propertyGroups.pullProperty("http://xmlns.com/foaf/0.1/firstName")!>
	<#assign skipThis = propertyGroups.pullProperty("http://xmlns.com/foaf/0.1/lastName")!>
</#if>

<#include "individual-properties.ftl">

<#assign rdfUrl = individual.rdfUrl>

<#if rdfUrl??>
    <script>
        var individualRdfUrl = '${rdfUrl}';
    </script>
</#if>
        
<!-- Below was taken from default individual--foaf-person-2column.ftl -->        

<#if profilePageTypesEnabled && (targetedView?has_content || user.loggedIn) >
<span id="quickViewLink" >
    <a href="${urls.base}/display/${individual.localName}?destination=quickView" >
        <img id="quickViewIcon" src="${urls.images}/individual/quickViewIcon.png" alt="${i18n().quick_view_icon}"/>
    </a>
</span>
</#if>
<#if !editable>
<script>
    var title = $('div#titleContainer').width();
    var name = $('h1.vcard').width();
    var total = parseInt(title,10) + parseInt(name,10);
    if ( name < 280 && total > 600 ) {
        var diff = total - 600;
        $('div#titleContainer').width(title - diff);
    }
    else if ( name > 279 && name + title > 600 ) {
        $('div#titleContainer').width('620');
    }
</script>
</#if>
<script>
    var imagesPath = '${urls.images}';
</script>
<#assign rdfUrl = individual.rdfUrl>

<#if rdfUrl??>
    <script>
        var individualRdfUrl = '${rdfUrl}';
    </script>
</#if>
<script type="text/javascript">
var profileTypeData = {
    processingUrl: '${urls.base}/edit/primitiveRdfEdit',
    individualUri: '${individual.uri!}',
    defaultProfileType: '${profileType!}'
};
var i18nStrings = {
    errorProcessingTypeChange: '${i18n().error_processing_type_change}',
    displayLess: '${i18n().display_less}',
    displayMoreEllipsis: '${i18n().display_more_ellipsis}',
    showMoreContent: '${i18n().show_more_content}',
    verboseTurnOff: '${i18n().verbose_turn_off}',
    standardviewTooltipOne: '${i18n().standardview_tooltip_one}',
    standardviewTooltipTwo: '${i18n().standardview_tooltip_two}',
    researchAreaTooltipOne: '${i18n().research_area_tooltip_one}',
    researchAreaTooltipTwo: '${i18n().research_area_tooltip_two}'
};
var i18nStringsUriRdf = {
    shareProfileUri: '${i18n().share_profile_uri}',
    viewRDFProfile: '${i18n().view_profile_in_rdf}',
    closeString: '${i18n().close}'
};
</script>

${stylesheets.add('<link rel="stylesheet" href="${urls.base}/css/individual/individual.css" />',
                  '<link rel="stylesheet" href="${urls.base}/css/individual/individual-vivo.css" />',
                  '<link rel="stylesheet" href="${urls.base}/themes/wcmc/css/wcmc_coi.css" />',
                  '<link rel="stylesheet" href="${urls.base}/css/individual/individual-2column-view.css" />',
                  '<link rel="stylesheet" href="${urls.base}/js/jquery-ui/css/smoothness/jquery-ui-1.8.9.custom.css" />')}

${headScripts.add('<script type="text/javascript" src="${urls.base}/js/tiny_mce/tiny_mce.js"></script>',
                  '<script type="text/javascript" src="${urls.base}/js/jquery_plugins/qtip/jquery.qtip-1.0.0-rc3.min.js"></script>',
                  '<script type="text/javascript" src="${urls.base}/js/json2.js"></script>',
                  '<script type="text/javascript" src="${urls.base}/themes/wcmc/js/plugins/jquery.truncator.js"></script>')}

${scripts.add('<script type="text/javascript" src="${urls.base}/js/individual/individualUriRdf.js"></script>',
              '<script type="text/javascript" src="${urls.base}/js/individual/individualQtipBubble.js"></script>',
              '<script type="text/javascript" src="${urls.base}/js/jquery-ui/js/jquery-ui-1.8.9.custom.min.js"></script>',
              '<script type="text/javascript" src="${urls.base}/themes/wcmc/js/individualUtils.js"></script>',
              '<script type="text/javascript" src="${urls.base}/js/individual/individualProfilePageType.js"></script>',
              '<script type="text/javascript" src="${urls.base}/js/imageUpload/imageUploadUtils.js"></script>',
              '<script type="text/javascript" src="https://d1bxh8uas1mnw7.cloudfront.net/assets/embed.js"></script>')}
