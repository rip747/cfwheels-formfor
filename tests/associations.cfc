<cfcomponent extends="wheelsMapping.Test">

	<cffunction name="setup">
		<cfset loc.controller = controller(name="dummy")>
		<cfset loc.argsaction = loc.controller.urlfor()>
		<cfset loc.formbuilder = $createObjectFromRoot(
			path = "plugins.formfor"
			,fileName="FormBuilder"
			,method = "init"
		)>
		<cfset loc.user = model("gallery").new()>
		<cfset loc.controller._getVariablesScope = _getVariablesScope>
		<cfset loc.context = loc.controller._getVariablesScope()>
		<cfset loc.args = {}>
		<cfset loc.args.model=loc.user>
		<cfset loc.args.context=loc.context>
	</cffunction>
	
	<cffunction name="_test_just_making_sure_field_attributes_work">
		<cfset loc.args.as = "wheelsUser">
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#<label for="wheelsUser-firstName">First Name<input id="wheelsUser-firstName" maxlength="100" name="wheelsUser[firstName]" type="text" value="" /></label>#chr(10)#</form>'>
		<cfset loc.r = loc.formbuilder
						.start(argumentCollection=loc.args)
						.textField(label="Title", property="title")
						.fieldsFor()
						.end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="_getVariablesScope">
		<cfreturn variables>
	</cffunction>

</cfcomponent>