<cfset application.wheels.dataSourceName = "wheelstestdb">
<cfset loc.assetsPath = "#application.wheels.webpath#plugins/formfor/tests/assets">
<cfset loc.assetsCPath = "#application.wheels.wheelscomponentpath#plugins.formfor.tests.assets">
<cfset request.formfor = {}>
<cfset request.formfor.rootPath = ListChangeDelims(ListPrepend("plugins/formfor", application.wheels.webpath, "/"), "/", "/")>
<cfset request.formfor.rootCPath = ListPrepend("plugins.formfor", application.wheels.wheelscomponentpath, ".")>
<cfset request.formfor.assetsPath = ListChangeDelims(ListPrepend("plugins/formfor/tests/assets", application.wheels.webpath, "/"), "/", "/")>
<cfset request.formfor.assetsCPath = ListPrepend("plugins.formfor.tests.assets", application.wheels.wheelscomponentpath, ".")>
<cfset application.wheels.cacheQueriesDuringRequest = false>
<cfset application.wheels.modelPath = "/wheelsMapping/tests/_assets/models">
<cfset application.wheels.modelComponentPath = "wheelsMapping.tests._assets.models">
<cfset application.wheels.transactionMode = "none">
<cfset application.wheels.plugins = {}>