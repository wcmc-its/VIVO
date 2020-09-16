<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Icon controls displayed in upper-right corner -->

<#-- a href="${individual.rdfUrl}"><img id="uriIcon" title="View profile in RDF format." src="${urls.images}/individual/share-uri-icon.png" alt="View profile in RDF format." /></a -->
<#-- img id="uriIcon" title="${individual.uri}" src="${urls.images}/individual/share-uri-icon.png" alt="${i18n().share_the_uri}" / -->
<#-- @qr.renderCode qrCodeIcon / -->

<#--

Some contact information is displayed on the profile page by default; e.g., phone numbes and 
email addresses. If an institution has an additional location for contact info, such as a 
university directory, a third "contact" icon is available that can be used to direct users to 
that directory. The <a> tag below shows an example using Cornell University's directory.

<#assign netid = individual.selfEditingId()!>
<#if netid?has_content>
    <a href="http://www.cornell.edu/search/?tab=people&netid=${netid}" title="Cornell University directory entry for ${netid}" target="_blank">
        <img src="${urls.images}/individual/contact-info-icon.png"  title="view additional contact information" alt="contact info" />
    </a>
</#if>

-->