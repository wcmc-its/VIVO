/*
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
*/$(document).ready(function(){$.fn.exists=function(){return this.length!==0},$.fn.moreLess=function(){$(this).each};var e={showMore:function(t,n){t.click(function(){return n.show(),$(this).attr("href","#show less content"),$(this).text("less"),e.showLess(t,n),!1})},showLess:function(t,n){t.click(function(){return n.hide(),$(this).attr("href","#show more content"),$(this).text("more..."),e.showMore(t,n),!1})}},t=$(".property-list:not(:has(>li>ul))");t.each(function(){var t=$(this).find("li:gt(4)");if(t.exists()){var n=$('<div class="additionalItems" />').appendTo(this),r=$('<a class="more-less" href="#show more content">more...</a>').appendTo(this);t.appendTo(n),n.hide(),e.showMore(r,n)}});var n=$(".subclass-property-list");n.each(function(){var t=$(this).find("li:gt(4)");if(t.exists()){var n=$('<div class="additionalItems" />').appendTo(this),r=$('<a class="more-less" href="#show more content">more...</a>').appendTo(this);t.appendTo(n),n.hide(),e.showMore(r,n)}});var r=n.closest("li").last().nextAll(),i=n.closest("li").last().parent(),s=r.slice(3);if(s.length>0){var o=$('<div class="additionalItems" />').appendTo(i),u=$('<a class="more-less" href="#show more content">more...</a>').appendTo(i);s.appendTo(o),o.hide(),e.showMore(u,o)}$('a#verbosePropertySwitch:contains("Turn off")').addClass("verbose-off"),$("#qrIcon, .qrCloseLink").click(function(){return $("#qrCodeImage").toggleClass("hidden"),!1})});