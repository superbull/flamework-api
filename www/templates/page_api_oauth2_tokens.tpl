{capture assign="page_title"}Authentication tokens | API{/capture}
{include file="inc_head.tpl"}

{capture assign="token_count"}{$pagination.total_count}{/capture}

{capture assign="subtitle"}
{if $token_count}
{if $token_count > 1}You've authorized {$token_count} applications{else}You've authorized a single application{/if}
{/if}
{/capture}

{include file="inc_api_header.tpl" title="Your access tokens"}

<div class="api-sect">

<h2>Access tokens</h2>

<ul class="api-list-o-things">
{foreach from=$tokens item="row"}
{assign var="perms" value=$row.perms}

<li>

	<a href="{$cfg.abs_root_url}api/oauth2/tokens/{$row.app.api_key|escape}/">{$row.app.app_title|escape}</a>

	<span class="count-objects">

	<span class="object-thingy">
	This token was created on {$row.created|date_format} and grants <strong>{$permissions.$perms|escape}</strong> permissions to the <strong></strong> application.
	</span>

	</span>

</li>
{/foreach}
	<li><a href="{$cfg.abs_root_url}api/oauth2/authenticate/like-magic/">Create a new access token for yourself</li>
</ul>

</div>

{include file="inc_pagination.tpl"}
{include file="inc_foot.tpl"}
