function IndexCtrl($scope,$http,$location) {
    $scope.title = 'Hola amigos!';
       startit();
		kaboom();
		setInterval(redraw, 3000);
	
	alert($location.absUrl() );
	var loc = $location.absUrl();
	var apiurl=loc.split("/home/index");
	if (apiurl.length > 0) {
		apiurl=apiurl[0] +'/api/mdm_models' ;
	}
	else {
		apiurl = '/api/mdm_models' ;
	}
	alert(apiurl);
	$http({method: 'GET', url: apiurl}).
    success(function(data, status, headers, config) {
      // this callback will be called asynchronously
      // when the response is available
      $scope.mdmmodels = data;
      
   
    });

};


