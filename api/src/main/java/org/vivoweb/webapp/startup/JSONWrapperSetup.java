/* $This file is distributed under the terms of the license in /doc/license.txt$ */

package org.vivoweb.webapp.startup;

import com.hp.hpl.jena.query.QuerySolution;
import com.hp.hpl.jena.query.ResultSet;
import edu.cornell.mannlib.vitro.webapp.beans.Individual;
import edu.cornell.mannlib.vitro.webapp.controller.VitroRequest;
import edu.cornell.mannlib.vitro.webapp.controller.freemarker.UrlBuilder;
import edu.cornell.mannlib.vitro.webapp.controller.individuallist.IndividualJsonWrapper;
import edu.cornell.mannlib.vitro.webapp.dao.ObjectPropertyStatementDao;
import edu.cornell.mannlib.vitro.webapp.dao.WebappDaoFactory;
import edu.cornell.mannlib.vitro.webapp.dao.jena.QueryUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONException;
import org.json.JSONObject;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.Collection;
import java.util.Map;

public class JSONWrapperSetup implements ServletContextListener {
    private static final Log log = LogFactory.getLog(JSONWrapperSetup.class);

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        IndividualJsonWrapper.setAddJSONFields(new IndividualJsonWrapper.AddJSONFields() {
            @Override
            public void add(JSONObject jo, VitroRequest vreq, Individual ind) throws JSONException {
                jo.put("preferredTitle", findPreferredTitle(vreq, ind));
            }

            private String VCARD_DATA_QUERY = ""
                    + "PREFIX obo: <http://purl.obolibrary.org/obo/> \n"
                    + "PREFIX vcard: <http://www.w3.org/2006/vcard/ns#>  \n"
                    + "SELECT DISTINCT ?title  \n" + "WHERE {  \n"
                    + "    ?subject obo:ARG_2000028 ?vIndividual .  \n"
                    + "    ?vIndividual vcard:hasTitle ?vTitle . \n"
                    + "    ?vTitle vcard:title ?title . \n" + "} ";

            private String findPreferredTitle(VitroRequest vreq, Individual ind) {
                String queryStr = QueryUtils.subUriForQueryVar(VCARD_DATA_QUERY,
                        "subject", ind.getURI());
                log.debug("queryStr = " + queryStr);
                String value = "";
                try {
                    ResultSet results = QueryUtils.getQueryResults(queryStr, vreq);
                    while (results.hasNext()) {
                        QuerySolution soln = results.nextSolution();
                        String t = QueryUtils.nodeToString(soln.get("title"));
                        if (StringUtils.isNotBlank(t)) {
                            value = t;
                        }
                    }
                } catch (Exception e) {
                    log.error(e, e);
                }
                return value;
            }
        });
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
