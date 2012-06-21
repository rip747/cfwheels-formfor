<cfcomponent extends="wheelsMapping.Test">

	<cffunction name="setup">
		<cfset loc.controller = controller(name="dummy")>
		<cfset loc.argsaction = loc.controller.urlfor()>
		<cfset loc.user = model("user").new()>
	</cffunction>
	
	<cffunction name="test_defaults_respected">
		<cfset loc.r = loc.controller.formfor(model=loc.user, builder="plugins.formfor.tests.assets.Custom").textField(property="firstName").end()>
		<cfset loc.e = '<form action="#loc.argsaction#" method="post" tonytest=":)">#chr(10)#<label for="user-firstName">Firstname<input class="custombuildertest" id="user-firstName" maxlength="50" name="user[firstName]" type="text" value="" /></label>#chr(10)#</form>'>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>

</cfcomponent>