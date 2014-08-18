    // script.js

    // create the module and name it freemdm
        // also include ngRoute for all our routing needs
    var freemdm = angular.module('freemdm', ['ngRoute','ui_bootstrap']);

    // configure our routes
    freemdm.config(function($routeProvider, $locationProvider) {
  //  $locationProvider.html5Mode(true);
 
        $routeProvider

            // route for the home page
            .when('/contact/:contactId', {
                templateUrl : "<%= asset_path('assets/angular/views/about.html') %>",
                controller  : 'contactController'
            })

            // route for the about page
            .when('/about', {
                templateUrl : 'assets/angular/views/about.html',
                controller  : 'aboutController'
            })

            // route for the contact page
            .when('/main', {
                templateUrl :  "<%= asset_path('assets/angular/views/about.html') %>",
                controller  : 'mainController'
            });
    });

    // create the controller and inject Angular's $scope
    freemdm.controller('mainController', function($scope) {
        // create a message to display in our view
        $scope.message = 'Everyone come and see how good I look!';
    });

    freemdm.controller('aboutController', function($scope) {
        $scope.message = 'Look! I am an about page.';
       
    });
   freemdm.controller('mdmobjectController', function($scope, $routeParams) {
       
        $scope.message = 'Contact us! JK. This is just a demo.' + $routeParams.mdmobjectId;
    });
    
   

    freemdm.controller('contactController', function($scope, $routeParams) {
        alert($routeParams.contactId);
        $scope.message = 'Contact us! JK. This is just a demo.' + $routeParams.contactId;
    });
    
    
    
    
var DatepickerDemoCtrl = function ($scope) {
  $scope.today = function() {
    $scope.dt = new Date();
  };
  $scope.today();

  $scope.clear = function () {
    $scope.dt = null;
  };

  // Disable weekend selection
  $scope.disabled = function(date, mode) {
    return ( mode === 'day' && ( date.getDay() === 0 || date.getDay() === 6 ) );
  };

  $scope.toggleMin = function() {
    $scope.minDate = $scope.minDate ? null : new Date();
  };
  $scope.toggleMin();

  $scope.open = function($event) {
    $event.preventDefault();
    $event.stopPropagation();

    $scope.opened = true;
  };

  $scope.dateOptions = {
    formatYear: 'yy',
    startingDay: 1
  };

  $scope.initDate = new Date('2016-15-20');
  $scope.formats = ['dd-MMMM-yyyy', 'yyyy/MM/dd', 'dd.MM.yyyy', 'shortDate'];
  $scope.format = $scope.formats[0];
};
    
    
