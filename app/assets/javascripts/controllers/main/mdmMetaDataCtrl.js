    // script.js

    // create the module and name it freemdm
        // also include ngRoute for all our routing needs
    var freemdm = angular.module('freemdm', ['ngRoute']);

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

    freemdm.controller('contactController', function($scope, $routeParams) {
        alert($routeParams.contactId);
        $scope.message = 'Contact us! JK. This is just a demo.' + $routeParams.contactId;
    });
    
    
