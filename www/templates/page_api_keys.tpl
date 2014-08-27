{capture assign="page_title"}Your API keys | API{/capture}
{include file="inc_head.tpl"}

{capture assign="key_count"}{$pagination.total_count}{/capture}

{capture assign="subtitle"}
{if $key_count}
{if $key_count > 1}You've created {$key_count} API keys{else}You've created one API key{/if}
 /
<a href="{$cfg.abs_root_url}api/keys/register/">Create a new API key</a>
{/if}
{/capture}

{include file="inc_api_header.tpl" title="Your API keys"}

<div class="api-sect">

<h2>API keys</h2>

<ul class="api-list-o-things">
{foreach from=$keys item="row"}
<li>
	<a href="{$cfg.abs_root_url}api/keys/{$row.api_key|escape}/">{$row.app_title|escape}</a>
	&#8212; created on {$row.created|date_format} 
</li>
{/foreach}

	<li><a href="{$cfg.abs_root_url}api/keys/register/">Create a new API key</a></li>
</ul>

</div>

{include file="inc_pagination.tpl"}
{include file="inc_foot.tpl"}
