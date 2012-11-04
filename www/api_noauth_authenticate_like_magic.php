<?php

	# noauth - as in "not oauth"

	# This is a little piece of syntactic sugar for logged-in users.
	#
	# So all this page does is mint a brand new key and access token
	# for a user in one go. It doesn't set a callback URL or do anything
	# fancy. It just gives them an access_token so they can start
	# using the API. (20121026/straup)

	include("include/init.php");

	features_ensure_enabled("api");
	features_ensure_enabled("api_delegated_auth");
	features_ensure_enabled("api_authenticate_self");

	login_ensure_loggedin();

	loadlib("api_keys");
	loadlib("api_noauth_access_tokens");

	$crumb_key = 'access_token_authenticate_like_magic';
	$GLOBALS['smarty']->assign("crumb_key", $crumb_key);

	$perms_map = api_noauth_access_tokens_permissions_map();
	$GLOBALS['smarty']->assign_by_ref("permissions", $perms_map);

	$ttl_map = api_noauth_access_tokens_ttl_map();
	$GLOBALS['smarty']->assign_by_ref("ttl_map", $ttl_map);

	$step = 1;

	if ((post_isset("done")) && (crumb_check($crumb_key))){

		$ok = 1;

		$title = post_str("title");
		$perms = post_str("perms");
		$ttl = post_int32("ttl");
		$conf = post_str("confirm");

		if (($ok) && (! $title)){
			$GLOBALS['smarty']->assign("error", "no_title");
			$ok = 0;
		}

		if (($ok) && (! api_noauth_access_tokens_is_valid_permission($perms))){
			$GLOBALS['smarty']->assign("error", "bad_perms");
			$ok = 0;
		}

		# We're not going to worry about descriptions

		if ($ok){
			$GLOBALS['smarty']->assign("title", $title);
			$GLOBALS['smarty']->assign("perms", $perms);
			$GLOBALS['smarty']->assign("ttl", $ttl);
			$step = 2;
		}

		if (($ok) && ($conf)){

			$key = null;
			$token = null;
			$step = 3;

			$description = "";

			$rsp = api_keys_create($GLOBALS['cfg']['user']['id'], $title, $description);
			$key = $rsp['key'];
		
			if (! $rsp['ok']){
				$ok = 0;
			}

			if ($ok){

				$rsp = api_noauth_access_tokens_create($key, $GLOBALS['cfg']['user'], $perms, $ttl);
				$token = $rsp['token'];
		
				if (! $rsp['ok']){
					$ok = 0;
				}
			}

			$GLOBALS['smarty']->assign("try_update", 1);
			$GLOBALS['smarty']->assign("update_ok", $ok);
			$GLOBALS['smarty']->assign_by_ref("api_key", $key);
			$GLOBALS['smarty']->assign_by_ref("token", $token);
		}
	}

	$GLOBALS['smarty']->assign("step", $step);

	$GLOBALS['smarty']->display("page_api_noauth_authenticate_like_magic.txt");
	exit();

?>