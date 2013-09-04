
    var map = null;
    var geocoder = null;
	  var origin_point = null;

    var default_origin = new GLatLng(42.3223858, -83.0140735); //change this to coord of origin
    
    var caption = "<p style='font-family: Verdana;'><b>Starting at</b><br>" + origin_address + "</p>";
    var directionsPanel;
    var directions;
    
    
	 
    function initialize() {
      if (GBrowserIsCompatible()) {
        map = new GMap2(document.getElementById("map_canvas"));
        directionsPanel = document.getElementById("directions_canvas");
        map.setCenter(default_origin, 13);

        geocoder = new GClientGeocoder();
        geocoder.getLatLng(origin_address, setMapCenter);
        
        //map.enableGoogleBar();
        map.enableScrollWheelZoom();
        var zoom = new GSmallZoomControl();
        map.addControl(zoom);
		
		//Call function below
		getDirections(destination_address);
    drawPolygon();
      }
    }

	function setMapCenter(latlngpoint) {
		origin_point = latlngpoint;
        map.setCenter(origin_point, 13);
		var marker = new GMarker(origin_point);
        map.addOverlay(marker);
        marker.openInfoWindowHtml(caption);
	}
  
    function getDirections(destination) {
        if(!directions) {
            directions = new GDirections(map, directionsPanel); }
            else {
            directions.clear();}
       route = "from: " + origin_address + " to: " + destination; 
	   //alert ("Route is " + route);
       directions.load(route);


      // === Array for decoding the failure codes ===
      var reasons=[];
      reasons[G_GEO_SUCCESS]            = "Success";
      reasons[G_GEO_MISSING_ADDRESS]    = "Missing Address: The address was either missing or had no value.";
      reasons[G_GEO_UNKNOWN_ADDRESS]    = "Unknown Address:  No corresponding geographic location could be found for the specified address.";
      reasons[G_GEO_UNAVAILABLE_ADDRESS]= "Unavailable Address:  The geocode for the given address cannot be returned due to legal or contractual reasons.";
      reasons[G_GEO_BAD_KEY]            = "Bad Key: The API key is either invalid or does not match the domain for which it was given";
      reasons[G_GEO_TOO_MANY_QUERIES]   = "Too Many Queries: The daily geocoding quota for this site has been exceeded.";
      reasons[G_GEO_SERVER_ERROR]       = "Server error: The geocoding request could not be successfully processed.";
      reasons[G_GEO_BAD_REQUEST]        = "A directions request could not be successfully parsed.";
      reasons[G_GEO_MISSING_QUERY]      = "No query was specified in the input.";
      reasons[G_GEO_UNKNOWN_DIRECTIONS] = "The GDirections object could not compute directions between the points.";

      // === catch Directions errors ===
      GEvent.addListener(directions, "error", function() {
        var code = directions.getStatus().code;
        var reason="Code "+code;
        if (reasons[code]) {
          reason = reasons[code]
        } 

        alert("Failed to obtain directions, "+reason);
      });

    } //end of getDirections
    
    function drawPolygon() {
      var polygon = new GPolygon([
        new GLatLng(42.32606,-83.00900),
        new GLatLng(42.32759,-82.98738),
        new GLatLng(42.33165,-82.96944),
        new GLatLng(42.33266,-82.95725),
        new GLatLng(42.33977,-82.94806),
        new GLatLng(	42.31711,	-82.93356),
        new GLatLng(42.32492,-83.00858),
        new GLatLng(42.32606,-83.00900)
        ],
        "#f33f00", 5, 1, "#ff0000", 0);
      map.addOverlay(polygon);
    }

    
