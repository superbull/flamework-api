{capture assign="page_title"}OAuth2 | API{/capture}
{include file="inc_head.tpl"}

{include file="inc_api_header.tpl" title="OAuth2"}

<div class="api-sect">
<p>We require <a href="http://tools.ietf.org/html/rfc6749#section-4.2">OAuth (version 2) access tokens</a> to monitor and limit access to the API. OAuth2 access tokens are granted limited, specific permissions that allow applications to act on your behalf. They are:</p>
</div>

{include file="inc_api_oauth2_permissions_glossary.tpl"}

{if "api_authenticate_self"|@features_is_enabled}

<div class="api-sect">
<p>If you are <strong>not</strong> a developer and would like to try out the API then <a href="{$cfg.abs_root_url}api/oauth2/authenticate/like-magic/">you should visit this page</a> to create an access token for yourself. If you are a developer then you probably want to start by <a href="{$cfg.abs_root_url}api/keys/register/">creating an API key</a>. If you are a developer please consult the <a href="{$cfg.abs_root_url}api/oauth2/howto/">OAuth2 How To</a> page for details.</p>
</div>

{/if}

{include file="inc_foot.tpl"}
