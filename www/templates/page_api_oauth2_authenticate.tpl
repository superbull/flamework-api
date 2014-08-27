{capture assign="page_title"}Authorize the {$key.app_title} application | API{/capture}
{include file="inc_head.tpl"}

{capture assign="title"}The application called {$key.app_title} would like to access your account{/capture}
{include file="inc_api_header.tpl" title=$title}

{if ! $key.app_callback}
<p class="warning">Hey, that's weird. The <strong>{$key.app_title|escape}</strong> application is asking you to authorize it but the developer has not provided a callback URL. That's <em>not good</em> so we're just going to stop things right here in case something creepy is going on.</p>

{elseif $error}

<p class="error">
{if $error=='existing_grant'}
Hey, wait a second! You've already approved this application's request to access your account. However, the application still hasn't completed the authorization process on their end. We apologize for any inconvenience but we're not going to go any further just in case there's some funny business going on.
{elseif $error=='invalid_scope'}
If you're seeing this it means that the {$key.app_title|escape} application forgot to include some data (or sent incorrect data) as part of their authorization request. We apologize for the inconvenience but as a precaution we're not going to go any further. In case you're wondering about the details: The requested permissions – the <code>scope</code> – are missing or look funny.
{elseif $error=='invalid_type'}
If you're seeing this it means that the {$key.app_title|escape} application forgot to include some data (or sent incorrect data) as part of their authorization request. We apologize for the inconvenience but as a precaution we're not going to go any further. In case you're wondering about the details: The required <code>response_type</code> parameter is missing or looks funny.
{elseif $error=='invalid_callback'}
If you're seeing this it means that the {$key.app_title|escape} application forgot to include some data (or sent incorrect data) as part of their authorization request. We apologize for the inconvenience but as a precaution we're not going to go any further. In case you're wondering about the details: The required <code>redirect_uri</code> parameter is missing or looks funny.
{else}
Okay, that's just weird. If you're seeing this it means that something very wrong is happening. We apologize for the inconvenience but as a precaution we're not going to go any further.
{/if}
</p>

{else}

<div class="api-sect">
{include file="inc_api_oauth2_authenticate_permissions.tpl"}
</div>

<div class="api-sect" style="text-align:center;">
<form method="POST" action="{$cfg.abs_root_url}api/oauth2/authenticate/">
	{$crumb_key|crumb_input}
	<input type="hidden" name="done" value="1" />
	<input type="hidden" name="client_id" value="{$key.api_key|escape}" />
	<input type="hidden" name="response_type" value="code" />
	<input type="hidden" name="scope" value="{$str_perms|escape}" />
	<input type="hidden" name="redirect_uri" value="{$key.app_callback|escape}" />

	<div style="text-align:left !important;margin-bottom:2em;">
	<p>By default access tokens are valid until you revoke them. You may also set a predefined expiry date for this token after which it will no longer be able to perform functions on your behalf.</p>

	<p>This access token will remain valid 
	<select name="ttl">
	{foreach from=$ttl_map item="label" key="ttl"}
		<option value="{$ttl|escape}">{$label|escape}</option>
	{/foreach}
	</select>
	</p>
	</div>

	<input type="submit" name="confirm" value="YES, I AGREE" />
	<input type="submit" name="confirm" value="NO, I DON'T THINK SO" />
</form>
</div>

{/if}

{include file="inc_foot.tpl"}
