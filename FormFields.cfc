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
	
</cfcomponent>