public with sharing class CASConnectorIdentity {

        public String href {get;set;}

        public List<user_identities> user_identities;

        public class user_identities{

            //"id":138281,"type":"Admissions User","organization":"Canadian College of Naturopathic Medicine","association":"NDCAS","cycle":"2015 - 2016","institution":"Canadian College of Naturopathic Medicine"

            public Integer id {get; set;}

            public String type {get; set;}

            public String organization {get; set;}

            public String association {get; set;}

            public String cycle {get; set;}

            public String institution {get; set;}

        }

        public class Iteration{
            //{format=Comma-Separated Values, id=195593, list_type=null, mime_type=text/csv;charset=iso-8859-1, name=winter2017}

            public String format {get; set;}

            public String id {get; set;}

            public String list_type {get; set;}

            public String mime_type {get; set;}

            public String charset {get; set;}

            public String name {get; set;}

        }

}

