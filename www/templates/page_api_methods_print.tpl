{capture assign="page_title}API methods | API{/capture}
{include file="inc_head.tpl"}

<div class="container api-methods-toc">
{include file="inc_api_methods_toc.tpl" title="API methods"}
</div>

<div class="container">
<div id="api_methods" class="api-methods-print">

{foreach from=$method_classes item="class_details" key="class"}
{foreach from=$class_details.methods item="method"}
	{include file="inc_api_method.tpl" method=$method.name details=$method}
{/foreach}
{/foreach}

</div>
</div>

{include file="inc_foot.tpl"}
