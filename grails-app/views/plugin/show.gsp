<%@ page import="org.apache.shiro.SecurityUtils; org.grails.auth.Role" %>
<head>
    <meta content="masterv2" name="layout"/>
    <title>Grails Plugin: ${plugin.title.encodeAsHTML()}</title>
    <asset:stylesheet src="plugin"/>
    <asset:javascript src="plugin"/>
    <g:render template="tagSetup" model="[allTags:allTags]" />
</head>

<body>

<div id="content" class="content-aside" role="main">
    <div class="content-aside-title">
        <h1 id="logo">Plugins <small>You can find out about all the publicly available Grails plugins.</small></h1>
        <g:render template="searchBar" />
        <g:render template="loginBar" />
    </div>
    <g:render template="sideNav"/>
    <section id="main" class="plugin">
        <article class="plugin">
            <header>
                <h1>
                    ${plugin?.title?.encodeAsHTML()}
                    <g:if test="${plugin.official}">
                        <small>Plugin Collection</small>
                    </g:if>
                </h1>
                <ul class="meta">
                    <li>
                        <g:render template="pluginTags" model="[plugin:plugin]" />
                    </li>
                    <li>
                        Latest: <strong>${plugin.currentRelease}</strong>                            
                    </li>
                    <li>Last Updated: <strong><joda:format pattern="dd MMMMM yyyy" value="${plugin.lastReleased}" /></strong></li>
                    <li>
                        Grails version: ${plugin.grailsVersion ?: '*'}
                    </li>
                </ul>
                <ul class="meta">
                    <li>Authors: <%= plugin.authors.collect { it.name.encodeAsHTML() }.join(', ') %></li>
                    <g:if test="${plugin.licenses}">
                        <li>License: <%= plugin.licenses.collect { '<a href="' + it.url.encodeAsHTML() + '">' + it.name + '</a>' }.join(',') %></li>
                    </g:if>
                    <g:if test="${plugin.organization}">
                        <li>Organization:
                            <g:if test="${plugin.organizationUrl}">
                                <a href="${plugin.organizationUrl.encodeAsHTML()}">${plugin.organization.encodeAsHTML()}</a>
                            </g:if>
                            <g:else>
                                ${plugin.organization.encodeAsHTML()}
                            </g:else>
                        </li>
                    </g:if>
                </ul>
                <div class="right">
                   <g:render template="pluginRating" model="[plugin:plugin]" />
                    <g:if test="${plugin.usage>0}">
                        <p class="used">
                            <strong><g:formatNumber number="${plugin.usage}" type="percent"/></strong> of Grails users
                        </p>
                    </g:if>
                    <%--
                    <g:if test="${plugin.isScmGitHub()}">
                        <p class="download">
                            <a href="${plugin.scmUrl}" target="_blank" class="btn primary">Source on GitHub</a>
                        </p>
                    </g:if>
                    --%>
                </div>
            </header>
            <div class="desc">
                <div class="code">
                    <strong>Dependency:</strong>
                    <pre>${plugin.defaultDependencyScope.encodeAsHTML()} "${plugin.dependencyDeclaration.encodeAsHTML()}"</pre>
                    <g:if test="${plugin.customRepositoriesDeclaration}">
                        <strong>Custom repositories:</strong>
                        <pre>${plugin.customRepositoriesDeclaration.encodeAsHTML()}</pre>
                    </g:if>
                </div>
            </div>
            <tmpl:pluginButtons plugin="${plugin}" />
            <div class="documentation">
                <g:if test="${SecurityUtils.subject.hasRole(Role.ADMINISTRATOR) || SecurityUtils.subject.isPermitted('plugin:edit:'+plugin?.name)}">
                    <div class="alert alert-info">
                    <i class="icon-edit"></i> You can
                    <g:link title="Edit Plugin Info" class="actionIcon" action="editPlugin" id="${plugin?.name}">
                        edit the content
                     </g:link> of the plugin.
                    </div>
                </g:if>
                <h2>Summary</h2>
                <div class="wiki-plugin">
                    <wiki:text key="${'pluginInfo_summary_' + plugin?.name}">${plugin?.summary}</wiki:text>
                </div>
                <g:if test="${plugin.installation?.body}">
                <h2>Installation</h2>
                <div class="wiki-plugin">
                    <wiki:text key="${'plugin-' + plugin.name + '-installation'}">${plugin.installation.body}</wiki:text>
                </div>
                </g:if>
                <g:if test="${plugin.description?.body}">
                <h2>Description</h2>
                <div class="wiki-plugin">
                    <wiki:text key="${'plugin-' + plugin.name + '-description'}">${plugin.description.body}</wiki:text>
                </div>
                </g:if>
            </div>
        </article>
        <asset:script>
            tagsInitialized = true
        </asset:script>

    </section>
</div>

</body>
