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

<#-- Contact info on individual profile page -->

<#-- Primary Email -->
<@emailLinks "${core}primaryEmail" />

<#-- Additional Emails -->
<@emailLinks "${core}email" />

<#-- Phone Prakash Modified to take in wcmc phone types -->
<#assign officePhone = propertyGroups.pullProperty("${wcmc}officePhone")!>
<#assign clinicalPhone = propertyGroups.pullProperty("${wcmc}clinicalPhone")!>
<#assign laboratoryPhone = propertyGroups.pullProperty("${wcmc}laboratoryPhone")!>
<#assign departmentalPhone = propertyGroups.pullProperty("${wcmc}departmentalPhone")!>

<#if officePhone?has_content || clinicalPhone?has_content || laboratoryPhone?has_content || departmentalPhone?has_content  >   
        <h6>Phone</h6>
        
        <#if officePhone?has_content || clinicalPhone?has_content || laboratoryPhone?has_content >
        
	        <#if officePhone?has_content> <#-- true when the property is in the list, even if not populated (when editing) -->
	            <#if officePhone.statements?has_content> <#-- if there are any statements -->
	                <ul id="individual-phone" role="list">
	                	<#if editable>
		                    <#list officePhone.statements as statement>
		                        <li role="listitem">
		                            <@p.editingLinks "${officePhone.localName}" "${officePhone.name}" statement editable "" />
		                           ${statement.value}
		                        </li>
		                    </#list>
	                	<#else>
	                        <li role="listitem">
	                            <@p.editingLinks "${officePhone.localName}" "${officePhone.name}" "${officePhone.statements[0]}" editable "" />
	                           ${officePhone.statements[0].value}
	                        </li>
	                	</#if>
	                </ul>
	            </#if>
	        </#if>
	
	        <#if clinicalPhone?has_content> <#-- true when the property is in the list, even if not populated (when editing) -->
	            <#if clinicalPhone.statements?has_content> <#-- if there are any statements -->
	                <ul id="individual-phone" role="list">
	                	<#if editable>
		                    <#list clinicalPhone.statements as statement>
		                        <li role="listitem">
		                            <@p.editingLinks "${clinicalPhone.localName}" "${clinicalPhone.name}" statement editable "" />
		                           ${statement.value} (Clinical)
		                        </li>
		                    </#list>
	                	<#else>
	                        <li role="listitem">
	                            <@p.editingLinks "${clinicalPhone.localName}" "${clinicalPhone.name}" "${clinicalPhone.statements[0]}" editable "" />
	                           ${clinicalPhone.statements[0].value} (Clinical)
	                        </li>
	                	</#if>
	                </ul>
	            </#if>
	        </#if>
	        
	        <#if laboratoryPhone?has_content> <#-- true when the property is in the list, even if not populated (when editing) -->
	            <#if laboratoryPhone.statements?has_content> <#-- if there are any statements -->
	                <ul id="individual-phone" role="list">
	                	<#if editable>
	                    <#list laboratoryPhone.statements as statement>
	                        <li role="listitem">
	                            <@p.editingLinks "${laboratoryPhone.localName}" "${laboratoryPhone.name}" statement editable "" />
	                           ${statement.value} (Lab)
	                        </li>
	                    </#list>
	                	<#else>
                        <li role="listitem">
                            <@p.editingLinks "${laboratoryPhone.localName}" "${laboratoryPhone.name}" "${laboratoryPhone.statements[0]}" editable "" />
                           ${laboratoryPhone.statements[0].value} (Lab)
                        </li>
	                	</#if>
	                </ul>
	            </#if>
	        </#if>
	    
	    <#else>
		    	    
	    	<#if departmentalPhone?has_content> 
	            <#if departmentalPhone.statements?has_content> 
	                <ul id="individual-phone" role="list">
	                	<#if editable>
		                    <#list departmentalPhone.statements as statement>
		                        <li role="listitem">
		                            <@p.editingLinks "${departmentalPhone.localName}" "${departmentalPhone.name}" statement editable "" />
		                           ${statement.value} (Department)
		                        </li>
		                    </#list>
	                	<#else>
	                        <li role="listitem">
	                            <@p.editingLinks "${departmentalPhone.localName}" "${departmentalPhone.name}" "${departmentalPhone.statements[0]}" editable "" />
	                           ${departmentalPhone.statements[0].value} (Department)
	                        </li>
	                	</#if>
	                </ul>
	            </#if>
	        </#if>
        
        </#if>

</#if>

<#macro emailLinks property>
    <#assign email = propertyGroups.pullProperty(property)!>
    <#if property == "${core}primaryEmail">
        <#local listId = "primary-email">
        <#local label = "Primary Email">
    <#else>
        <#local listId = "additional-emails">
        <#local label = "Additional Emails">
    </#if>
    <#if email?has_content> <#-- true when the property is in the list, even if not populated (when editing) -->
        <@p.addLinkWithLabel email !editable label/>
        <#if email.statements?has_content> <#-- if there are any statements -->
            <#if !editable>
                <h6>Email</h6>
            </#if>
            <ul id="${listId}" class="individual-emails" role="list">
                <#list email.statements as statement>
                    <li role="listitem">
                        <@p.editingLinks "${email.localName}" statement !editable />
                        <a class="email" href="mailto:${statement.value}" title="email">${statement.value}</a>
                    </li>
                </#list>
            </ul>
        </#if>
    </#if>
</#macro>
