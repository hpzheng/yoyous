(function(angular) {
  'use strict';
var myApp = angular.module('quoteApp', []);

myApp.controller('quoteController', ['$scope', function($scope) {

    $scope.chiliSpicy = function() {
        $scope.spice = 'chili';
    };

    $scope.jalapenoSpicy = function() {
        $scope.spice = 'jalapeño';
    };

    $scope.quote_days = function( regions ) {
	var days;
	days = 3;
	if(regions.value1) { days += 5;};
	if(regions.value2) { days += 5;};
	if(regions.value3) { days += 5;};
	if(regions.value4) { days += 5;};
	if(regions.value5) { days += 6;};
	if(regions.value6) { days += 6;};
	return days;
    }
    
    $scope.quote_cost = function( regions, days, group_size ) {
	var cost;
	var nrooms = 1 + Math.ceil(group_size / 2);
	var flight_cost = 8000 * group_size;
	var hotel_cost = nrooms * days * 598;
	var pp_cost = group_size * days * 298;
	var guide_cost = days * 1098;
	var guide_flight_cost = 0;
	if(regions.value2) { guide_flight_cost += 2000;};
	if(regions.value5) { guide_flight_cost += 2000;};
	if(regions.value6) { guide_flight_cost += 2000;};
	cost = flight_cost + hotel_cost + pp_cost + guide_cost + guide_flight_cost;
	return cost / group_size;
    }

    $scope.updateQuote = function(map_click) {
      var region1 = ['VA','MD','PA','NY','NJ','CT','MA','DE','DC','RI'];
      var region2 = ['CA','NV'];
      var region3 = ['MI','IL','IN','OH','WV'];
      var region4 = ['NC','SC','GA','FL'];
      var region5 = ['UT','WY','SD'];
      var region6 = ['WA','OR','ME'];
      var cities1 = "美东海岸：华盛顿，费城，纽约，波士顿";
      var cities2 = "美西海岸：拉斯维加斯，旧金山，洛杉矶，圣地亚哥";
      var cities3 = "五大湖区：芝加哥，底特律，多伦多，尼亚加拉瀑布";
      var cities4 = "美东南：亚特兰大，奥兰多，迈阿密";
      var cities5 = "美国中部：盐湖城，黄石公园，总统山";
      var cities6 = "加拿大边境：西雅图，温哥华，渥太华，蒙特利尔，波特兰";

      if(typeof map_click !== 'undefined') {
        if($.inArray(map_click, region1) != -1) { $scope.quote_regions.value1 = ! $scope.quote_regions.value1; }
        if($.inArray(map_click, region2) != -1) { $scope.quote_regions.value2 = ! $scope.quote_regions.value2; }
        if($.inArray(map_click, region3) != -1) { $scope.quote_regions.value3 = ! $scope.quote_regions.value3; }
        if($.inArray(map_click, region4) != -1) { $scope.quote_regions.value4 = ! $scope.quote_regions.value4; }
        if($.inArray(map_click, region5) != -1) { $scope.quote_regions.value5 = ! $scope.quote_regions.value5; }
        if($.inArray(map_click, region6) != -1) { $scope.quote_regions.value6 = ! $scope.quote_regions.value6; }
      }

      function select_region(region_list, region_variable) {
	var color="#025";
        if(region_variable) { color = "#2C2"; }
	for(var state in region_list) {
          $('#map').usmap('select', region_list[state], color)
	}
      }
      select_region(region1, $scope.quote_regions.value1);
      select_region(region2, $scope.quote_regions.value2);
      select_region(region3, $scope.quote_regions.value3);
      select_region(region4, $scope.quote_regions.value4);
      select_region(region5, $scope.quote_regions.value5);
      select_region(region6, $scope.quote_regions.value6);
      if($scope.quote_regions.value1 == true) { $scope.quote_regions.cities1 = cities1; } else { $scope.quote_regions.cities1 = ""; }
      if($scope.quote_regions.value2 == true) { $scope.quote_regions.cities2 = cities2; } else { $scope.quote_regions.cities2 = ""; }
      if($scope.quote_regions.value3 == true) { $scope.quote_regions.cities3 = cities3; } else { $scope.quote_regions.cities3 = ""; }
      if($scope.quote_regions.value4 == true) { $scope.quote_regions.cities4 = cities4; } else { $scope.quote_regions.cities4 = ""; }
      if($scope.quote_regions.value5 == true) { $scope.quote_regions.cities5 = cities5; } else { $scope.quote_regions.cities5 = ""; }
      if($scope.quote_regions.value6 == true) { $scope.quote_regions.cities6 = cities6; } else { $scope.quote_regions.cities6 = ""; }
      $scope.qdays = $scope.quote_days($scope.quote_regions);
      $scope.qcost = $scope.quote_cost($scope.quote_regions, $scope.qdays, $scope.qsize);
    }

    $scope.spice = 'very';
    $scope.qsize = 4;
    $scope.qfrom = '中国各地';
    $scope.quote_regions = [];
    $scope.quote_regions.value1 = true;
    $scope.quote_regions.value2 = true;
    $scope.quote_regions.value3 = false;
    $scope.quote_regions.value4 = false;
    $scope.quote_regions.value5 = false;
    $scope.quote_regions.value6 = false;
    $scope.updateQuote();
}]);
})(window.angular);


