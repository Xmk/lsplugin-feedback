{include file='header.tpl'}

<div class="container">
	{if $oConfig->GetValue('view.tinymce')}
		<script src="{cfg name='path.root.engine_lib'}/external/tinymce-jq/tiny_mce.js"></script>
		<script>
			jQuery(function($){
				tinyMCE.init(ls.settings.getTinymce());
			});
		</script>
	{else}
		{include file='window_load_img.tpl' sToLoad='feedback-text'}
		<script>
			jQuery(function($){
				ls.lang.load({lang_load name="panel_b,panel_i,panel_u,panel_url,panel_url_promt,panel_image,panel_quote,panel_list,panel_list_ul,panel_list_ol,panel_clear_tags,panel_list_li,panel_image_promt"});
				// Подключаем редактор
				$('#feedback-text').markItUp(ls.feedback.getMarkitup());
			});
		</script>
	{/if}

	<div class="row">
		<div class="width-12">
			<h2 class="title-5">{$aLang.plugin.feedback.feedback}</h2>
		</div>
	</div>

	<form action="{router page='feedback'}" method="POST" id="feedback-form" class="feedback-form">
		<div class="wrapper-content row">
			<div class="width-12">
				{hook run='form_feedback_begin'}

				{if $oConfig->GetValue('plugin.feedback.field.name')}
				<dl class="form-item">
					<dt><label for="feedback-name">{$aLang.plugin.feedback.send_name}:</label></dt>
					<dd>
						<div class="form-group">
							<div class="input-icon">
					          	<span class="font-icon-user btn"></span>
					        	<input type="text" name="name" id="feedback-name" value="{$_aRequest.name}" class="js-ajax-validate">
					        	<span class="font-icon-question-sign btn js-infobox" title="{$aLang.plugin.feedback.send_name_notice}"></span>
					        </div>
				        </div>
						<small class="validate-error-hide validate-error-field-name help-block bg-error"></small>
					</dd>
				</dl>
				{/if}

				<dl class="form-item">
					<dt><label for="feedback-mail">{$aLang.plugin.feedback.send_mail}:</label></dt>
					<dd>
						<div class="form-group">
							<div class="input-icon">
					          	<span class="font-icon-social-email btn"></span>
					        	<input type="text" id="feedback-mail" name="mail" value="{$_aRequest.mail}" class="js-ajax-validate">
					        	<span class="font-icon-question-sign btn js-infobox" title="{$aLang.plugin.feedback.send_mail_notice}"></span>
					        </div>
				        </div>
						<small class="validate-error-hide validate-error-field-mail help-block bg-error"></small>
					</dd>
				</dl>

				{if $oConfig->GetValue('plugin.feedback.field.title')}
				<dl class="form-item">
					<dt><label for="feedback-title">{$aLang.plugin.feedback.send_title}:</label></dt>
					<dd>
						{if $oConfig->GetValue('plugin.feedback.field.title') == 1}
							<div class="form-group">
								<div class="input-icon">
						          	<span class="font-icon-text-width btn"></span>
						        	<input type="text" id="feedback-title" name="title" value="{$_aRequest.title}" class="js-ajax-validate">
						        	<span class="font-icon-question-sign btn js-infobox" title="{$aLang.plugin.feedback.send_title_notice}"></span>
						        </div>
				        	</div>
						{else}
							<select name="title" id="feedback-title" class="input-width-400 js-ajax-validate">
								<option value="">&nbsp;</option>
								{foreach from=$oConfig->GetValue('plugin.feedback.title') item=sTitle}
								<option value="{$sTitle}"{if $_aRequest.title==$sTitle} selected{/if}>{$sTitle}</option>
								{/foreach}
							</select>
						{/if}
						<small class="validate-error-hide validate-error-field-title help-block bg-error"></small>
					</dd>
				</dl>
				{/if}

				<dl class="form-item">
					<dt><label for="feedback-text">{$aLang.plugin.feedback.send_text}:</label></dt>
					<dd>
						<textarea name="text" id="feedback-text" rows="20" class="mce-editor js-ajax-validate">{$_aRequest.text}</textarea>
						<small class="validate-error-hide validate-error-field-text help-block bg-error"></small>
						<div class="form-item-help form-item-help-text">
							<i class="icon-ok-green validate-ok-field-text" style="display: none"></i>
							<i class="icon-question-sign js-tip-help" title="{$aLang.plugin.feedback.send_text_notice}"></i>
						</div>
					</dd>
				</dl>
				</div>
			</div>

			<div class="wrapper-content wrapper-content-dark row">

				<div class="width-12">
					<small class="validate-error-hide validate-error-field-ip help-block bg-error"></small>

					{hookb run="feedback_captcha"}
					<dl class="form-item">
						<dt><label for="feedback-captcha">{$aLang.plugin.feedback.captcha}:</label></dt>
						<dd>
							<img src="{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}" 
								 onclick="this.src='{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}&n='+Math.random();" 
								 class="captcha-image" />
							<input type="text" name="captcha" id="feedback-captcha" value="" maxlength="3" class="input-text input-width-100 js-ajax-validate" style="width: 165px" />
							<small class="validate-error-hide validate-error-field-captcha help-block bg-error"></small>
						</dd>
					</dl>
					{/hookb}
				</div>
			
		</div>

		{hook run='form_feedback_end'}

		<div class="wrapper-content row">
			<div class="width-12">
				<dl class="form-item">
					<dt></dt>
					<dd>
						<button type="submit" name="submit_feedback" class="button button-primary" id="feedback-form-submit" disabled="disabled">{$aLang.plugin.feedback.button_send}</button>
					</dd>
				</dl>
				{hook run='feedback_copyright'}
			</div>
		</div>
	</form>
</div>
{include file='footer.tpl'}