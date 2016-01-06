$(function(){

   // render map
  L.mapbox.accessToken = 'pk.eyJ1IjoidGtodXluaDgwOCIsImEiOiJjaWoxbDd2ZWowMGE4dWRsdzRnd3MyaWY0In0.dOwBmtvVJdP7p0tj87XgLg';

  var map = L.mapbox.map('map', 'tkhuynh808.okb0b6be', {
            center: [34, -97],
            zoom: 2,
            minZoom: 2,
            zoomControl: false,
            maxBounds: [[-90, -180], [90, 180]]
  });

  // map.dragging.disable();
  map.touchZoom.disable();
  map.doubleClickZoom.disable();
  map.scrollWheelZoom.disable();
  // Disable tap handler, if present.
  if (map.tap) map.tap.disable();

        //set variables
  var geocoder = L.mapbox.geocoder('mapbox.places-v1');
  // function to show markers on map
  var showMarker = function(lng, lat, city, city_id) {
    city_id = city.replace(/\s/g, "-").toLowerCase();
    L.mapbox.featureLayer({
      type: 'Feature',
      geometry: {
        type: 'Point',
        coordinates: [lng, lat]
      },
      properties: {
      description: "<a href='http://localhost:3000/cities/" + city_id +"'>"+ city +"</a>",
        'marker-size': 'small',
        'marker-color': '#57633E',
        'marker-symbol': 'circle-stroked'

      }
    }).addTo(map);
  };

  $.get("/cities.json",function(data){
    data.forEach(function (city){
      var cityName = city.name;
      var city_id = city.id;
      if (city.name !== undefined) {
        geocoder.query(city.name, function(err, geo) {  
          console.log(geo);        
          if (!err) {
            showMarker(geo.latlng[1], geo.latlng[0], cityName, city_id);
          }
        });
      }
    });
  });
});
