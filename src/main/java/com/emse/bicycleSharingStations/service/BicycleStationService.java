package com.emse.bicycleSharingStations.service;
import com.emse.bicycleSharingStations.model.BicycleStation;
import org.apache.jena.query.*;
import org.apache.jena.rdf.model.Literal;
import org.apache.jena.rdf.model.RDFNode;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BicycleStationService {
    private List<BicycleStation> bicycleStations;
    String FUESKI_LOCAL_ENDPOINT = "http://localhost:3030/bicycleStations";
    public List <BicycleStation> findStationsByCity(String cname) {
        List<BicycleStation> stationsList = new ArrayList<BicycleStation>();
        String query = "PREFIX foaf: <http://xmlns.com/foaf/0.1/> \n" +
                "PREFIX schema: <http://schema.org/> \n" +
                "PREFIX ex: <http://example.org/> \n" +
                "PREFIX geo: <https://www.w3.org/2003/01/geo/wgs84_pos#> \n" +
                "\n" +
                "SELECT ?name ?lat ?lon ?capacity\n" +
                "WHERE {\n" +
                "  ?station schema:City ?city .\n" +
                "  ?station foaf:name ?name .\n" +
                "  ?station geo:lat ?lat .\n" +
                "  ?station geo:long ?lon .\n" +
                "  ?station <http://www.example.org/capacity> ?capacity .\n" +
                "  FILTER(?city = \"" + cname + "\" )} ";

        System.out.println(query);
//        String query = "SELECT * WHERE { ?s ?p ?o} limit 10";

        Query qu = QueryFactory.create(query);
        QueryExecution q = QueryExecutionFactory.sparqlService(FUESKI_LOCAL_ENDPOINT, qu);
        ResultSet results = q.execSelect();
        System.out.println(results.toString());
        while (results.hasNext()) {
            QuerySolution qs = results.next();
            RDFNode name = qs.get("name");
            RDFNode lat = qs.get("lat");
            RDFNode lon = qs.get("lon");
            RDFNode capacity = qs.get("capacity");
            Literal lLat = lat.asLiteral();
            Literal lLon = lon.asLiteral();
            Literal lCapacity = capacity.asLiteral();
            BicycleStation bs = new BicycleStation(name.toString(), name.toString(), lLat.getString(), lLon.getString(), lCapacity.getString());
            stationsList.add(bs);
        }
        return stationsList;
    }

    public List <BicycleStation>  iniDataForTesting(String cname) {
        bicycleStations = new ArrayList<BicycleStation>();
        BicycleStation bs1 = new BicycleStation("id1", "name1", "0.1", "0.2", "3");
        BicycleStation bs2 = new BicycleStation("id2", "name1", "0.1", "0.2", "3");
        BicycleStation bs3 = new BicycleStation("id3", "name1", "0.1", "0.2", "3");
        bicycleStations.add (bs1);
        bicycleStations.add (bs2);
        bicycleStations.add (bs3);
        return bicycleStations;
    }
}
