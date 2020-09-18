<#--
Copyright (c) 2012, Cornell University
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

<#-- Template for sparkline visualization on individual profile page -->

<#-- Determine whether this person is an author -->
<#assign isAuthor = p.hasStatements(propertyGroups, "${core}authorInAuthorship") />

<#-- Determine whether this person is involved in any grants -->
<#assign isInvestigator = ( p.hasStatements(propertyGroups, "${core}hasInvestigatorRole") ||
                            p.hasStatements(propertyGroups, "${core}hasPrincipalInvestigatorRole") || 
                            p.hasStatements(propertyGroups, "${core}hasCo-PrincipalInvestigatorRole") ) >

<#if (isAuthor || isInvestigator)>
 
    ${stylesheets.add('<link rel="stylesheet" href="${urls.base}/css/visualization/visualization.css" />')}
    <#assign standardVisualizationURLRoot ="/visualization">
    
    <section id="visualization" role="region">
        <#if isAuthor>
            <#assign coAuthorIcon = "${urls.images}/../themes/wcmc/images/authorBtn.png">
            <#assign mapOfScienceIcon = "${urls.images}/visualization/mapofscience/scimap_icon.png">
            <#assign coAuthorVisUrl = individual.coAuthorVisUrl()>
            <#assign mapOfScienceVisUrl = individual.mapOfScienceUrl()>
            
            <!-- Removed assigning a variable to https://www.google.com/jsapi ... --> 
             
          <#-- Removed currently due to performance issues -->
<#--             <div id="mapofscience_link_container" class="collaboratorship-link-container">
                <div class="collaboratorship-icon"> 
                    <a href="${mapOfScienceVisUrl}" title="map of science"><img src="${mapOfScienceIcon}" alt="Map Of Science icon" width="30px" height="30px" /></a>
                </div>
                <div class="collaboratorship-link"><a href="${mapOfScienceVisUrl}" title="map of science">Map Of Science</a></div>
            </div> -->
            

            <script type="text/javascript">
                var visualizationUrl = '${urls.base}/visualizationAjax?uri=${individual.uri?url}';
                var infoIconSrc = '${urls.images}/../themes/wcmc/images/iconInfo.png';
            </script>

            
            <#-- <#if isInvestigator>
                <div class="collaboratorship-link-separator"></div>
            </#if> -->
        </#if>
        
        <#if isInvestigator>
            <#assign coInvestigatorVisUrl = individual.coInvestigatorVisUrl()>
            <#assign coInvestigatorIcon = "${urls.images}/../themes/wcmc/images/investigatorBtn.png">
            
            
        </#if>
    </section>
</#if>