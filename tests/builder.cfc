<cfcomponent extends="wheelsMapping.Test">

	<cffunction name="setup">
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
	</cffunction>
		
	<cffunction name="test_basic_start_and_end_form_tag_with_post_method">
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#</form>'>		
		<cfset loc.r = loc.formbuilder.start(argumentCollection=loc.args).end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="test_multiple_calls">
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#</form>'>		
		<cfset loc.r = loc.formbuilder.start(argumentCollection=loc.args).end()>
		<cfset assert('loc.e eq loc.r')>
		<cfset loc.r = loc.formbuilder.start(argumentCollection=loc.args).end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>

	<cffunction name="test_basic_start_and_end_tag_with_get_method">
		<cfset loc.args.method="get">
		<cfset loc.e = '<form action="#loc.argsaction#" method="get">#chr(10)#</form>'>
		<cfset loc.r = loc.formbuilder.start(argumentCollection=loc.args).end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="test_basic_form_tag_to_external_site_explicit_http">
		<cfset loc.args.action = "http://www.google.com">
		<cfset loc.e = '<form action="http://www.google.com" method="post">#chr(10)#</form>'>
		<cfset loc.r = loc.formbuilder.start(argumentCollection=loc.args).end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="test_basic_form_tag_with_put_method">
		<cfset loc.args.method="put">
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#<input id="_method" name="_method" type="hidden" value="put" />#chr(10)#</form>'>
		<cfset loc.r = loc.formbuilder.start(argumentCollection=loc.args).end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="test_basic_form_with_input_tag">
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#<label for="user-firstName">First Name<input id="user-firstName" maxlength="50" name="user[firstName]" type="text" value="" /></label>#chr(10)#</form>'>
		<cfset loc.r = loc.formbuilder
						.start(argumentCollection=loc.args)
						.textField(label="First Name", property="firstName")
						.end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>

	<cffunction name="test_apply_multipart_automatically_when_using_fileField">
		<cfset loc.e = '<form action="#loc.argsaction#" enctype="multipart/form-data" method="post">#chr(10)#<label for="user-firstName">First Name<input id="user-firstName" name="user[firstName]" type="file" /></label>#chr(10)#</form>'>
		<cfset loc.r = loc.formbuilder
						.start(argumentCollection=loc.args)
						.fileField(label="First Name", property="firstName")
						.end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>

	<cffunction name="test_inserting_arbitrary_text_into_the_form_building_process">
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#<p>StartText</p>#chr(10)#<label for="user-firstName">First Name<input id="user-firstName" maxlength="50" name="user[firstName]" type="text" value="" /></label>#chr(10)#<p>EndText</p>#chr(10)#</form>'>
		<cfset loc.r = loc.formbuilder
						.start(argumentCollection=loc.args)
						.append("<p>StartText</p>")
						.textField(label="First Name", property="firstName")
						.append("<p>EndText</p>")
						.end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="test_renaming_the_model">
		<cfset loc.args.as = "wheelsUser">
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#<label for="wheelsUser-firstName">First Name<input id="wheelsUser-firstName" maxlength="50" name="wheelsUser[firstName]" type="text" value="" /></label>#chr(10)#</form>'>
		<cfset loc.r = loc.formbuilder
						.start(argumentCollection=loc.args)
						.textField(label="First Name", property="firstName")
						.end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="test_just_making_sure_field_attributes_work">
		<cfset loc.args.as = "wheelsUser">
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#<label for="wheelsUser-firstName">First Name<input id="wheelsUser-firstName" maxlength="100" name="wheelsUser[firstName]" type="text" value="" /></label>#chr(10)#</form>'>
		<cfset loc.r = loc.formbuilder
						.start(argumentCollection=loc.args)
						.textField(label="First Name", property="firstName", maxlength="100")
						.end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="test_fieldset_and_legend_functionality">
		<cfset loc.e = '<form action="#loc.argsaction#" method="post">#chr(10)#<fieldset>#chr(10)#<legend>User Information</legend>#chr(10)#<label for="user-firstName">First Name<input id="user-firstName" maxlength="50" name="user[firstName]" type="text" value="" /></label>#chr(10)#</fieldset>#chr(10)#</form>'>
		<cfset loc.r = loc.formbuilder
						.start(argumentCollection=loc.args)
							.fieldset()
								.legend("User Information")
								.textField(label="First Name", property="firstName")
							.end()
						.end()>
		<cfset assert('loc.e eq loc.r')>
		<cfset loc.r = loc.formbuilder
						.start(argumentCollection=loc.args)
							.fieldsetTag()
								.legendTag("User Information")
								.textField(label="First Name", property="firstName")
							.end()
						.end()>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>
	
	<cffunction name="_getVariablesScope">
		<cfreturn variables>
	</cffunction>

</cfcomponent>