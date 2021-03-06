{capture assign="page_title"}{$key.app_title} | {$key.api_key} | API{/capture}
{include file="inc_head.tpl"}

{include file="inc_api_header.tpl" title=$key.app_title}

{if $smarty.get.success}
<p class="confirm">Hooray! Here is your new API key.</p>
{/if}

{if $do_update}

{if $update_ok}
	<p class="confirm">You API key has been updated. Pow!</p>
{else}
	<p class="error">There was a problem updating your API key. The robots has reported the following error: {$error|escape}</p>
{/if}

{elseif $error}

<p class="error">
{if $error=='no_title'}Your API key must have a name
{elseif $error=='no_description'}Your API key must have a description
{else}INVISIBLE ERROR CAT HISSES AT YOU: {$error|escape}
{/if}
</p>

{else}{/if}

<div class="api-sect">

<form method="POST" action="{$cfg.abs_root_url}api/keys/{$key.api_key|escape}/">
	{$crumb_key|crumb_input}
	<input type="hidden" name="done" value="1" />

<table class="api-key-or-token">
	<tr>
		<td>API Key</td><td class="api-credential">{$key.api_key|escape}</td>
	</tr>

	{if 0}
	<tr>
		<td>Application Secret</td><td>{$key.app_secret|escape}</td>
	</tr>
	{/if}

	<tr>
		<td>Authentication Tokens</td>
		<td>
		{if !$token_count}
		There are no authenticated users for this API key
		{else}

		{if $token_count==1}

		    {if $has_self_token}
		    	<a href="{$cfg.abs_root_url}api/oauth2/tokens/{$key.api_key|escape}/">You have auth-ed this API key</a>
		    {else}
			<a href="{$cfg.abs_root_url}api/keys/{$key.api_key|escape}/tokens/">One person has auth-ed this API key</a>
		    {/if}

		{else}
			<a href="{$cfg.abs_root_url}api/keys/{$key.api_key|escape}/tokens/">{$token_count|escape} people have auth-ed this API key</a>

		{if $has_self_token}
		<div style="margin-top: 20px; font-size:small;">
		    	<a href="{$cfg.abs_root_url}api/oauth2/tokens/{$key.api_key|escape}/">You have auth-ed this API key</a>
		</div>
		{/if}

		{/if}

		{/if}

		{if !$has_self_token}
		<div style="margin-top: 20px; font-size:small;">
		<a href="{$cfg.abs_root_url}api/oauth2/authenticate?api_key={$key.api_key|escape}&self=1">Create an access token for yourself using this API key</a>
		</div>
		{/if}

		</td>
	</tr>

	<tr>
		<td>Created</td><td>{$key.created|date_format} at {$key.last_modified|date_format:"%H:%M"}</td>
	</tr>

	{if $key.created != $key.last_modified}

	<tr>
		<td>Last Modified</td><td>{$key.last_modified|date_format} at {$key.last_modified|date_format:"%H:%M"}</td>
	</tr>

	{/if}

	{if $key.disabled}

	<tr style="font-weight:700; color:red;"><td>Disabled</td><td>{$key.disabled|date_format}</td></tr>

	<tr><td>Title</td><td>{$key.app_title|escape}</td></tr>
	<tr><td>Description</td><td>{$key.app_description|escape}</td></tr>

	{else}

	<tr>
		<td><label for="title">Title</label></td><td><input type="text" size="28" name="title" value="{$key.app_title|escape}" /></td>
	</tr>

	<tr>
		<td><label for="description">Description</label></td>
		<td><textarea rows="10" cols="40" name="description">{$key.app_description|escape}</textarea></td>
	</tr>

	<tr>
		<td><label for="description">Callback URL</label></td>
		<td><input type="text" size="28" name="callback" value="{$key.app_callback|escape}" /></td>
	</tr>

	<tr class="api-admin">
		<td>&nbsp;</td>
		<td class="api-delete"><input type="checkbox" name="delete" /> <label for="delete">Actually, I'd like to delete this API key</label></td>
	</tr>

	<tr class="api-admin">
		<td>&nbsp;</td>
		<td><input type="submit" value="UPDATE" />
	</tr>

	{/if}

</table>

</form>

</div>

{include file="inc_foot.tpl"}
