<h1>FormFor</h1>

<p>This plugin allows you to use a DSL to build forms instead of individual functions.</p>

<h3>Example</h3>

<pre>
// instead of doing this:
#startforTag(action="create")#
	#textField(label="User Name:", objectName="user", property="username")#
	#passwordField(label="Password:", objectName="user", property="password")#
#endFormTag()#

// you can do this:
formfor(model=user, action="create")
	.textField(label="User Name", property="username")
	.passwordField(label="Password:", property="password")
.end()
</pre>

<h3>What's the big deal?</h3>

<p>I'll admit that its still four lines of code, but this does save you some typing as you don't have to specify the `objectName` for each field. The true benefit is where we can go from here!</p>
<p>By using `formfor`, things can happen automagically like:</p>
<ul>
	<li>the form being set to multipart automatically just be specifying a fileField or fileFieldTag</li>
	<li>handling `put` or `push` methods automatically</li>
	<li>... more cool stuff coming soon!</li>
</ul>

<p>The true You can also obvously extend the underline FormBuilder.cfc and create your own builder as well! To use your new custom builder, just specify it with the `formbuilder` and formbuilderPath` argument on `formfor`:</p>
<pre>
// using your own builder:
formfor(model=user, action="create", formbuilder="MyCustomBuilder", formbuilderPath="lib")
	.textField(label="User Name", property="username")
	.passwordField(label="Password:", property="password")
.end()
</pre>

<h3>Again... what's the big deal?</h3>

<p>Think about this way. By creating your own builders, you'll be able to encapsulate the entire form creation into a single component that you can swap out by changing two arguments! You create as many builders as you want so you could have a builder for your frontend form, one for your backend, a builder that wraps twitter bootstrap or one that use tables even!</p>
<p>The best part is to share these builders across your other projects, you just copy the component you created.</p>

<p>This plugin is in its early stages and should be expected to evolve. Some of the things I'm adding:</p>
<ul>
	<li>UTF-8 support</li>
	<li>nested properties!</li>
</ul>