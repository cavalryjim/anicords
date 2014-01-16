dooliddlApp = angular.module('dooliddlApp', ['ngResource'])

# JDavis: cross-site request forgery from rails
dooliddlApp.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
  
# JDavis: routing for the angularjs portion
dooliddlApp.config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $routeProvider.when '/', redirectTo: '/organizations/:organization_id'
  #$routeProvider.when '/dashboard', templateUrl: '/templates/dashboard.html', controller: 'DashboardController'
  $routeProvider.when '/organizations/:organization_id', templateUrl: '/templates/organization.html', controller: 'OrganizationController'   

# JDavis: This makes turbolinks play nice with angularjs
$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])
    
# JDavis: make the 'PATCH' request work
defaults = $http.defaults.headers
defaults.patch = defaults.patch || {}
defaults.patch['Content-Type'] = 'application/json'