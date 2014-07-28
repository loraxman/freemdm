class AngularGenerator
  def initialize(table)
    @@table = table
  end
  
  def generate_angular
    generate_form
    generate_controller
    write_to_appdir
  end
  
  def generate_form
=begin
   <div ng-controller="#{@table.name}Controller">
    <form novalidate class="simple-form">
      Name: <input type="text" ng-model="user.name" /><br />
      E-mail: <input type="email" ng-model="user.email" /><br />
      Gender: <input type="radio" ng-model="user.gender" value="male" />male
      <input type="radio" ng-model="user.gender" value="female" />female<br />
      <button ng-click="reset()">RESET</button>
      <button ng-click="update(user)">SAVE</button>
    </form>
    <pre>form = {{user | json}}</pre>
    <pre>master = {{master | json}}</pre>
  </div>
=end

  end
  def generate_controller
    puts "stuff"
=begin
    angular.module('formExample', [])
       .controller('ExampleController', ['$scope', function($scope) {
         $scope.master = {};
   
         $scope.update = function(user) {
           $scope.master = angular.copy(user);
         };
   
         $scope.reset = function() {
           $scope.user = angular.copy($scope.master);
         };
   
         $scope.reset();
       }]);  
=end
  end
  
  def write_to_appdir
  end
  end
  
