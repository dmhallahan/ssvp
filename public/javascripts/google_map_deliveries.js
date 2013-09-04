

	function setMapCenter(latlngpoint) {
        origin_point = latlngpoint;
        map.setCenter(origin_point, 13);
		var marker = new GMarker(origin_point);
        map.addOverlay(marker);
        marker.openInfoWindowHtml(caption);
	}
  
  
    
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
    
    function addMarker(lat, lng) { // takes lat and lng coords 
        var gll = new GLatLng(lat, lng);
    		var marker = new GMarker(gll);
        map.addOverlay(marker);
        //var point_bubble = "<p style='font-family: Verdana;'><b>Starting at</b><br>" + origin_address + "</p>";
        //marker.openInfoWindowHtml(point_bubble);
    }

    
