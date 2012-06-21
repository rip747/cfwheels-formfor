<cfcomponent extends="wheelsMapping.Test">

	<cffunction name="setup">
		<cfset loc.orgApp = duplicate(application)>
		<cfset loc.controller = controller(name="dummy")>
		<cfset loc.argsaction = loc.controller.urlfor()>
		<cfset loc.formbuilder = $createObjectFromRoot(
			path = "plugins.formfor"
			,fileName="FormBuilder"
			,method = "init"
		)>
		<cfset loc.user = model("user").new()>
		<cfset loc.controller._getVariablesScope = _getVariablesScope>
		<cfset loc.context = loc.controller._getVariablesScope()>
		<cfset loc.args = {}>
		<cfset loc.args.model=loc.user>
		<cfset loc.args.context=loc.context>
		<cfset application.wheels.plugins.coldroute = {}>
	</cffunction>
	
	<cffunction name="teardown">
		<cfset application = loc.orgApp>
	</cffunction>
		
	<cffunction name="test_basic_form_tag_with_put_method">
		<cfset loc.args.method="put">
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#</form>'>
		<cfset loc.r = loc.formbuilder.start(argumentCollection=loc.args).end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="_getVariablesScope">
		<cfreturn variables>
	</cffunction>

</cfcomponent>