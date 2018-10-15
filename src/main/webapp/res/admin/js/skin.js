$(function(){
	var skins = $('.li-skinitem span').click(function() {
		var $this = $(this);
		if($this.hasClass('cs-skin-on')) return;
		skins.removeClass('cs-skin-on');
		$this.addClass('cs-skin-on');
		var skin = $this.attr('rel');
		changeSkin($('#swicth-style'),skin);
		setCookie('cs-skin', skin);
		skin == 'dark-hive' ? $('.cs-north-logo').css('color', '#FFFFFF') : $('.cs-north-logo').css('color', '#000000');
		
		$("iframe").each(function(){
			var iframe = $(this);
			var style =iframe.contents().find("#swicth-style");
			changeSkin(style,skin);
		});
	});

	if(getCookie('cs-skin')) {
		var skin = getCookie('cs-skin');
		var url = $('#swicth-style').attr('href');
		var ps = url.split("/");
		ps[ps.length-2] = skin;
		url = ps.join("/");
		$('#swicth-style').attr('href', url);
		$this = $('.li-skinitem span[rel='+skin+']');
		if($this.length>0){
			$this.addClass('cs-skin-on');
			skin == 'dark-hive' ? $('.cs-north-logo').css('color', '#FFFFFF') : $('.cs-north-logo').css('color', '#000000');
		}
	}
});

function changeSkin(doc,skin){
	if(doc.length>0){
		var url = doc.attr('href');
		var ps = url.split("/");
		ps[ps.length-2] = skin;
		doc.attr('href', ps.join("/"));
	}
}

function setCookie(name,value) {//两个参数，一个是cookie的名子，一个是值
    var Days = 30; //此 cookie 将被保存 30 天
    var exp = new Date();    //new Date("December 31, 9998");
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

function getCookie(name) {//取cookies函数        
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;
}