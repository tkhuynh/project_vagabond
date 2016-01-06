$(function () {

    var user_slug = $("#posts_chart").attr('class');
    console.log(user_slug);
    $.get("/users/" + user_slug + ".json",function(data){
        var user_posts = data;
        if (user_posts.length > 0) {
            $.get("/cities.json",function(cities){
                var all_cities = cities;
                var data_for_chart = [];
                for (var i = 0; i < all_cities.length; i++) {
                    var posts_for_each_city = 0;
                    for (var y = 0; y < user_posts.length; y++) {
                        if (user_posts[y].city_id == all_cities[i].id) {
                            posts_for_each_city++;
                        }
                    }
                    data_for_chart.push({name: all_cities[i].name, y: posts_for_each_city});
                }
                // Build the chart
                $('#posts_chart').highcharts({
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: 'City Posts Chart'
                    },
                    tooltip: {
                        pointFormat: '{series.name}: <b>{point.y:f} post(s)</b>'
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: false
                            },
                            showInLegend: true
                        }
                    },
                    series: [{
                        name: 'Posts',
                        colorByPoint: true,
                        data: data_for_chart
                    }]
                });
            });
        }
    });
});