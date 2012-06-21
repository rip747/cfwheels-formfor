<cfcomponent output="false">
	
	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="objectName" type="string" required="true">
		<cfargument name="objectInstance" type="any" required="true">
		<cfargument name="context" type="struct" required="true">
		<cfset variables[arguments.objectName] = arguments.objectInstance>
		<cfset StructAppend(variables, arguments.context, true)>
		<cfset StructAppend(this, arguments.context, true)>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="fieldset">
		<cfscript>
		var loc = {};
		$args(name="fieldset", args=arguments);
		loc.returnValue = $tag(name="fieldset", close=false, attributes=arguments);
		</cfscript>
		<cfreturn loc.returnValue>
	</cffunction>
	
	<cffunction name="endFieldset">
		<cfreturn "</fieldset>">
	</cffunction>
	
	<cffunction name="legend">
		<cfargument name="content" type="string" required="true">
		<cfscript>
		var loc = {};
		$args(name="legend", args=arguments);
		loc.content = arguments.content;
		StructDelete(arguments, "content", false);
		loc.returnValue = $element(name="legend", content="#loc.content#", attributes="#arguments#");
		</cfscript>
		<cfreturn loc.returnValue>
	</cffunction>
	
	<cfset fieldsetTag = fieldset>
	<cfset endFieldsetTag = endFieldset>
	<cfset legendTag = legend>
</cfcomponent>