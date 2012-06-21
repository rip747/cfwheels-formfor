<cfcomponent output="false">

	<cffunction name="init">
		<cfset this.version = "1.1.8">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="formFor" mixin="controller">
		<cfargument name="model" type="any" required="true" hint="name of the model to build the form for">
		<cfargument name="as" type="string" required="false" default="" hint="the alias to use in the form for the model.">
		<cfargument name="builder" type="string" required="false" default="plugins.formfor.FormBuilder" hint="the component path of which builder to use">
		<cfscript>
		var loc = {};
		
		// model has to be an object
		if (!IsObject(arguments.model))
		{
			$throw(type="WheelsPlugin.FormFor", message="the model must be an object");
		}
		
		loc.args = {method = "init"};
		
		// pop off the builder and builderPaths
		loc.args.fileName = ListLast(arguments.builder, '.');
		loc.args.path = reverse(ListRest(reverse(arguments.builder), '.'));		
		
		// just in case the builder and helper components are in the same component path
		if (loc.args.fileName eq loc.args.path)
		{
			StructDelete(loc.args, "path", false);
		}

		// create a formbuilder object
		try
		{
			loc.builderObj = $createObjectFromRoot(argumentCollection=loc.args);
		}
		catch(Any e)
		{
			loc.builderObj = "";
		}
		
		// make sure it's an object
		if (!IsObject(loc.builderObj))
		{
			$throw(type="WheelsPlugin.FormFor", message="invalid builder object: #arguments.builder#");
		}
		
		// remove builder from arguments scope
		StructDelete(arguments, "builder", false);
		
		// reference the context for the controller we're in
		// this allows the builder to inherit any overloaded methods from plugins
		// as well the params.
		arguments.context = variables;
		</cfscript>
		<cfreturn loc.builderObj.start(argumentCollection=arguments)>
	</cffunction>

</cfcomponent>