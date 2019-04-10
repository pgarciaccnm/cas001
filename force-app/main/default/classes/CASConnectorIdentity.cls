public with sharing class CASConnectorIdentity {

        public String href {get;set;}

        public List<exports> exports;

        public List<user_identities> user_identities;

        public List<export_files> export_files;
    

        public class user_identities{

            //"id":138281,"type":"Admissions User","organization":"Canadian College of Naturopathic Medicine","association":"NDCAS","cycle":"2015 - 2016","institution":"Canadian College of Naturopathic Medicine"

            public Integer id {get; set;}

            public String type {get; set;}

            public String organization {get; set;}

            public String association {get; set;}

            public String cycle {get; set;}

            public String institution {get; set;}

        }
        public class exports{

            public Integer id {get; set;}

            public String name {get; set;}

            public String list_type {get; set;}

            public String format {get; set;}

            public String mime_type {get; set;}


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

        public class export_files{

            public String id {get; set;}

            public String href {get; set;}

            public Integer export_id {get; set;}

            public String status {get; set;}
            
        }

}