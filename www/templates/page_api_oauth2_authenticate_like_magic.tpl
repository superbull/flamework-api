{capture assign="page_title"}Authorize the {$key.app_title} application (like magic) | API{/capture}
{include file="inc_head.tpl"}

{include file="inc_api_header.tpl" title="Create a new access token for yourself"}

{if $step==3}

<div class="api-sect">
<p class="confirm">Hooray! We've created your new access token. It is <strong>{$token.access_token|escape}</strong> and you can see all <a href="{$cfg.abs_root_url}api/oauth2/tokens/{$api_key.api_key|escape}/">the details over here.</a></p>
{if $key_rsp=='ok'}
<p class="error">Argh! There was a problem creating your token. This is what we know so far: {$error|escape}</p>
{else}
</div>

{/if}

{elseif $step==2}

<div class="api-sect">

<form method="POST" action="{$cfg.abs_root_url}api/oauth2/authenticate/like-magic/" accept-encoding="UTF-8">
	{$crumb_key|crumb_input}
	<input type="hidden" name="done" value="1" />
	<input type="hidden" name="title" value="{$title|escape}" />
	<input type="hidden" name="perms" value="{$perms|escape}" />
	<input type="hidden" name="ttl" value="{$ttl|escape}" />

<table class="api-key-or-token">
       <tr><td>Name</td><td>{$title|escape}</td></tr>
       <tr><td>Permissions</td><td>{$permissions.$perms|escape}</td></tr>
       <tr class="api-admin"><td>Terms of Service</td><td><div class="api-tos">{include file="inc_api_tos.tpl"}</td></tr>
       <tr class="api-admin"><td>&nbsp;</td><td><input type="checkbox" name="confirm" /> <label for="confirm">I agree!</label></td></tr>
       <tr class="api-admin"><td>&nbsp;</td><td><input type="submit" value="MAKE IT SO (PLEASE)" /></td></tr>
</table>

</form>

</div>

{else}

<div class="api-sect">

<form method="POST" action="{$cfg.abs_root_url}api/oauth2/authenticate/like-magic/" accept-encoding="UTF-8">
	{$crumb_key|crumb_input}
	<input type="hidden" name="done" value="1" />

<table class="api-key-or-token">

       <tr>
        <td>Name</td>
	<td><input type="text" value="{$title|escape}" name="title" placeholder="Give your token/application a name" /></td>
	</tr>

       <tr>
	<td>Permissions</td>
	<td>
	<select name="perms">
		<option />
	{foreach from=$permissions item="label" key="id"}
		<option value="{$id|escape}">{$label|escape}</option>
	{/foreach}
	</select>
	</td>
       </tr>

       <tr>
        <td>Make this token valid</td>
	<td>
	<select name="ttl">
	{foreach from=$ttl_map item="label" key="ttl"}
		<option value="{$ttl|escape}">{$label|escape}</option>
	{/foreach}
	</select>
	</td>

	<tr class="api-admin">
	    <td>&nbsp;</td>
	    <td><input type="submit" value="CREATE" /></td>
	</tr>

</table>
</form>
</div>

{/if}

{include file="inc_foot.tpl"}
