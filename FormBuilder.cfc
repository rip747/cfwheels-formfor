<cfcomponent output="false">
	
	<cfscript>
	// store the output for later rendering
	variables.output = [];
	// track the level that we are at
	variables.levels = [];
	variables.startFormTagAttributes = {};
	// allow per instance defaults for form methods
	variables.defaults = {};
	</cfscript>

	<cffunction name="init">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="start" access="public" returntype="any" output="false">
		<cfargument name="model" type="any" required="true" hint="the model to generate the form for">
		<cfargument name="as" type="string" required="false" default="" hint="an alias for the model. defaults to the model name itself">
		<cfargument name="context" type="struct" required="false" default="" hint="an alias for the model. defaults to the model name itself">
		<cfscript>
		var loc = {};
		
		if (!len(arguments.as))
		{
			arguments.as = $modelToString(arguments.model);
		}
		variables.objectName = arguments.as;
		variables.FormFieldsObj = createobject("component", "FormFields").init(arguments.as, arguments.model, arguments.context);

		// all other arguments passed in are used as default for the start form tag
		StructDelete(arguments, "model", false);
		StructDelete(arguments, "as", false);
		StructDelete(arguments, "context", false);
		
		loc.args = $mergeMethodDefaults("startFormTag", arguments);
		
		variables.startFormTagAttributes = loc.args;
		</cfscript>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="end" access="public" returntype="any" output="true">
		<cfscript>
		var loc = {};
		loc.ret = this;
		
		if ($atRootLevel())
		{
			$hiddenFieldForPutAndPushMethod();
			this.prepend(variables.FormFieldsObj.startFormTag(argumentCollection=variables.startFormTagAttributes));
			this.append(variables.FormFieldsObj.endFormTag());
			loc.ret = ArrayToList(variables.output, chr(10));
			this.$outputForm(loc.ret);
			ArrayClear(variables.output);
		}
		else
		{

			loc.level = $getNextLevel();
			
			switch (loc.level) {
			
				case "fieldset":
					this.append(variables.FormFieldsObj.endFieldSet());
					break;
				
			}
			
		}
		</cfscript>
		<cfreturn loc.ret>
	</cffunction>

	<cffunction name="append" access="public" returntype="any" output="false">
		<cfargument name="text" type="string" required="true" />
		<cfset ArrayAppend(variables.output, arguments.text)>
		<cfreturn this>
	</cffunction>

	<cffunction name="prepend" access="public" returntype="any" output="false">
		<cfargument name="text" type="string" required="true" />
		<cfset ArrayPrepend(variables.output, arguments.text)>
		<cfreturn this>
	</cffunction>
	
	<cffunction>
	
	
	<cffunction name="$atRootLevel" access="public" returntype="boolean" output="false">
		<cfreturn ArrayIsEmpty(variables.levels)>
	</cffunction>
	
	<cffunction name="$getNextLevel" access="public" returntype="string" output="false">
		<cfset var loc = {}>
		<cfset loc.level = variables.levels[1]>
		<cfset ArrayDeleteAt(variables.levels, 1)>
		<cfreturn loc.level>
	</cffunction>
	
	<cffunction name="$createFormField" access="public" returntype="any" output="false">
		<cfargument name="formField" type="string" required="true">
		<cfset var loc = {}>
		
		<!--- save the formField to create --->
		<cfset loc.formField = arguments.formField>
		<cfset StructDelete(arguments, "formField", false)>
		
		<!--- default to the instance model --->
		<cfset arguments["objectName"] = variables.objectName>
		
		<!--- mark the form as an upload if we create a file field --->
		<cfif ListFind("fileField,fileFieldTag", loc.formField)>
			<cfset variables.startFormTagAttributes["multipart"] = true>
		</cfif>
		
		<!--- add a level if fieldset is called --->
		<cfif ListFind("fieldset,fieldsetTag", loc.formField)>
			<cfset ArrayAppend(variables.levels, "fieldset")>
		</cfif>
		
		<!--- don't --->
		<cfif ListFind("fieldset,fieldsetTag,legend,legendTag", loc.formField)>
			<cfset StructDelete(arguments, "objectName", false)>
		</cfif>
		
		<cfset loc.args = $mergeMethodDefaults(loc.formField, arguments)>
		
		<cfinvoke component="#variables.FormFieldsObj#" method="#loc.formField#" argumentcollection="#loc.args#" returnvariable="loc.ret">
		
		<cfset this.append(loc.ret)>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="$outputForm" access="public" returntype="void" output="true">
		<cfargument name="output" type="string" required="false" default="">
		<cfoutput>#arguments.output#</cfoutput>
	</cffunction>
	
	<cffunction name="$hiddenFieldForPutAndPushMethod" access="public" returntype="string" output="false">
		<cfscript>
		// support put and push methods
		if (StructKeyExists(variables.startFormTagAttributes, "method") && ListFindNoCase("put,push", variables.startFormTagAttributes["method"]))
		{
			// newer versions of coldroute handle this
			if (!$coldRouteInstalled())
			{
				this.append(variables.FormFieldsObj.hiddenFieldTag("_method", variables.startFormTagAttributes["method"]));
			}
			variables.startFormTagAttributes["method"] = "post";
		}
		</cfscript>
	</cffunction>
	
	<cffunction name="$coldRouteInstalled" access="public" returntype="boolean" output="false">
		<cfreturn StructKeyExists(application.wheels.plugins, "coldroute")>
	</cffunction>
	
	<cffunction name="$mergeMethodDefaults" access="public" returntype="struct" output="false">
		<cfargument name="method" type="string" required="true">
		<cfargument name="collection" type="struct" required="true">
		<cfif StructKeyExists(variables.defaults, arguments.method)>
			<cfset StructAppend(arguments.collection, variables.defaults[arguments.method], true)>
		</cfif>
		<cfreturn arguments.collection>
	</cffunction>
	
	<cffunction name="$modelToString" access="public" returntype="string" output="false">
		<cfargument name="model" type="any" required="true">
		<cfreturn Lcase(ListLast(getMetaData(arguments.model).name, '.'))>
	</cffunction>
	
	<cffunction name="onMissingMethod"access="public"  returntype="any" output="false">
		<cfargument name="missingMethodName" type="string" required="true">
		<cfargument name="missingMethodArguments" type="struct" required="true">
		<cfreturn this.$createFormField(formField = arguments.missingMethodName, argumentCollection=missingMethodArguments)>
	</cffunction>

</cfcomponent>