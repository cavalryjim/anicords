# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#@app = angular.module("Dooliddl", ["ngResource"])



#@app.controller 'OrganizationCtrl', ['$scope', '$location', '$http', ($scope, $location, $http) ->
#  url = $(location).attr('pathname').split('/')
#  organization_id = url[2]
#  animal_id = url[4] 
#  $scope.organization = ''
#  $scope.animals = []
#  $http.get('../organizations/'+organization_id+'.json').success((data) ->
#    $scope.organization = data
#  )
#  if animal_id
#    $http.get('../organizations/'+organization_id+'/animals/'+animal_id+'.json').success((data) ->
#      $scope.animals = data
#    )
#]