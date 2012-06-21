<cfset application.wheels.dataSourceName = "wheelstestdb">
<cfset loc.assetsPath = "/plugins/formfor/tests/assets">
<cfset loc.assetsCPath = "plugins.formfor.tests.assets">
<cfset application.wheels.cacheQueriesDuringRequest = false>
<cfset application.wheels.modelPath = "#loc.assetsPath#/models">		
<cfset application.wheels.modelComponentPath = "#loc.assetsCPath#.models">
<cfset application.wheels.transactionMode = "none">
<cfset application.wheels.plugins = {}>