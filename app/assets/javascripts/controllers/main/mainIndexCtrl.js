function IndexCtrl($scope,$http) {
    $scope.title = 'Hola amigos!';

	
	
	$http({method: 'GET', url: '/api/mdm_models'}).
    success(function(data, status, headers, config) {
      // this callback will be called asynchronously
      // when the response is available
      $scope.mdmmodels = data;
      
      console.log($scope.mdmmodels);
    });


};