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

<@widget name="login" include="assets" />
<#include "browse-classgroups.ftl">

<!DOCTYPE html>
<!--[if lt IE 7]>      <html lang="en" class="lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html lang="en" class="lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html lang="en" class="lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html lang="en"> <!--<![endif]-->

    <head>
        <#include "head.ftl">
    </head>
    
    <body class="${bodyClasses!}" onload="${bodyOnload!}">
        <#include "identity.ftl">

        <#include "menu.ftl">

        <section id="intro" role="region">
        
            <h2>Welcome to the VIVO for Weill Cornell Medical College and the CTSC</h2>
<a title="Clinical and Translational Science Center " href="http://med.cornell.edu/ctsc" class="ctsc-logo" target="_blank"><span class="displace">Clinical and Translational Science Center</span></a>

<p>VIVO is a research-focused discovery tool that enables collaboration among scientists across all disciplines. VIVO contains information about researchers associated with WCMC and the <a href="http://weill.cornell.edu/ctsc/" alt="Clinical and Translational Science Center" target="ctsc">Clinical and Translational Science Center</a>.</p>

<!-- Beta message begins -->
<div id="notice" style="width: 700px; background-color: rgb(255,255,217); border-top: 2px rgb(255,255,139) solid; border-bottom: 2px rgb(255,255,139) solid; padding-top: 15px; margin-left: 20px; margin-bottom: 20px;">

<p><strong>VIVO is currently in public beta.</strong> VIVO will have scheduled downtimes every Friday at about 5:30 p.m. as we implement patches to these <a href="http://vivo.med.cornell.edu/support#betanotice">known problems</a>. In future releases of VIVO, many new features will be added. Click <a href="http://vivo.med.cornell.edu/support#h.qhumkawe666u">here</a> for a list of features we are working on.</p>
 
<p style="font-weight: normal !important;">For questions, please contact Support. For feedback, please use our <a href="http://vivo.med.cornell.edu/contact">feedback form</a>. Corrections in publications may be directed <a href="http://vivo.med.cornell.edu:8001/">here</a>.</p>
</div>
<!-- Beta message ends -->




                <p>Browse or search for people, departments, courses, grants, and publications.</p>


            <section id="search-home" role="region">
                <h3>Search VIVO</h3>
                
                <fieldset>
                    <legend>Search form</legend>
                    <form id="search-home-vivo" action="${urls.search}" method="post" name="search-home" role="search">
                        <div id="search-home-field">
                            <input type="text" name="querytext" class="search-home-vivo" value="${querytext!}" />
                            <input type="submit" value="Search" class="search">
                        </div>
                    </form>
                </fieldset>
            </section> <!-- #search-home -->
        </section> <!-- #intro -->
        
        <@widget name="login" />
        
        <@allClassGroups vClassGroups! />
    
    <#include "footer.ftl">

    </body>
</html>
