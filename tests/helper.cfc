<cfcomponent extends="wheelsMapping.Test">

	<cffunction name="setup">
		<cfset loc.controller = controller(name="dummy")>
		<cfset loc.argsaction = loc.controller.urlfor()>
		<cfset loc.user = model("user").new()>
	</cffunction>
	
	<cffunction name="test_model_must_be_an_object">
		<cfset loc.e = "WheelsPlugin.FormFor">
		<cfset loc.r = raised('loc.controller.formfor(model="User").end()')>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="test_invoking_with_defaults">
		<cfset loc.r = loc.controller.formfor(model=loc.user).end()>
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#</form>'>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="test_specifying_custom_builder_path_valid">
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#</form>'>
		<cfset loc.r = loc.controller.formfor(model=loc.user, builder="plugins.formfor.tests.assets.Extended").end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="test_specifying_custom_builder_path_invalid">
		<cfset loc.e = "WheelsPlugin.FormFor">
		<cfset loc.r = raised('loc.controller.formfor(model=loc.user, builder="blah.blah.FormBuilder2").end()')>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="test_specifying_a_model_aliasing">
		<cfset loc.r = loc.controller.formfor(model=loc.user, as="wheelsUser").textfield(property="lastname").end()>
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#<label for="wheelsUser-lastname">Lastname<input id="wheelsUser-lastname" maxlength="50" name="wheelsUser[lastname]" type="text" value="" /></label>#chr(10)#</form>'>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
</cfcomponent>