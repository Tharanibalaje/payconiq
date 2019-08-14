@test 
Feature: As a user, i would like to verify CRUD operations in gist

Background: Setting base url 
	* url demoBaseUrl

Scenario: To verify a Read operation of all gists 
	Given path '/gists' 
	And header Authorization = authorization 
	When method GET 
	Then status 200 
	
Scenario: To verify a Create operation without authorization 
	Given path '/gists' 
	And request read('classpath:postResponse.json') 
	When method POST 
	Then status 401 
	
Scenario: To verify an Update operation without authorization 
	Given path '/gists/b3124c4f7c714fd89f8d621ddc11dd2c' 
	And request read('classpath:putResponse.json') 
	When method PATCH 
	Then status 404 
	
Scenario: To verify an Delete operation without authorization 
	Given path '/gists/b3124c4f7c714fd89f8d621ddc11dd2c' 
	When method DELETE 
	Then status 404 
	
Scenario: To verify an create operation without request body 
	Given path '/gists' 
	And header Authorization = authorization 
	And request {} 
	When method POST 
	Then status 422 
	
Scenario: To verify an patch operation without body 
	Given path '/gists/b3124c4f7c714fd89f8d621ddc11dd2c' 
	And header Authorization = authorization 
	And request {} 
	When method PATCH 
	Then status 422 
	
Scenario: To verify get operation with authorization unknown gist
	Given path '/gists/b3124c4f7c714fd89f8d621ddc11dd2c45' 
	And header Authorization = authorization
	When method GET 
	Then status 404


	
Scenario: To verify CRUD operations, a new gist is Created, Read, update and delete the gist 
# create new gist
	Given path '/gists' 
	And header Authorization = authorization 
	And request read('classpath:postResponse.json') 
	When method POST 
	Then status 201 
	* def gistId = $.id 
	* print gistId 
	* def gistResponse = $ 
	
	Given path '/gists/'+gistId 
	When method GET 
	And header Authorization = authorization 
	Then status 200 
	And match $.git_pull_url contains gistResponse.git_pull_url 
	
# updating gist
	
	Given    path '/gists/'+gistId 
	And   header Authorization = authorization
	And    request read('classpath:putResponse.json') 
	When    method PATCH 
	Then    status 200 
	
# getting updated gist
	Given    path '/gists/'+gistId 
	And   header Authorization = authorization 
	When    method GET 
	Then    status 200 
	
#deleting gist
	Given    path '/gists/'+gistId 
	And   header Authorization = authorization 
	When    method DELETE 
	Then    status 204 
	
# getting updated gist
	Given    path '/gists/'+gistId 
	And   header Authorization = authorization 
	When    method GET 
	Then    status 404