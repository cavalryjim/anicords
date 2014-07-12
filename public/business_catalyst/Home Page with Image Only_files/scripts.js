/*
 * jQuery throttle / debounce - v1.1 - 3/7/2010
 * http://benalman.com/projects/jquery-throttle-debounce-plugin/
 * 
 * Copyright (c) 2010 "Cowboy" Ben Alman
 * Dual licensed under the MIT and GPL licenses.
 * http://benalman.com/about/license/
 */
(function(b,c){var $=b.jQuery||b.Cowboy||(b.Cowboy={}),a;$.throttle=a=function(e,f,j,i){var h,d=0;if(typeof f!=="boolean"){i=j;j=f;f=c}function g(){var o=this,m=+new Date()-d,n=arguments;function l(){d=+new Date();j.apply(o,n)}function k(){h=c}if(i&&!h){l()}h&&clearTimeout(h);if(i===c&&m>e){l()}else{if(f!==true){h=setTimeout(i?k:l,i===c?e-m:e)}}}if($.guid){g.guid=j.guid=j.guid||$.guid++}return g};$.debounce=function(d,e,f){return f===c?a(d,e,false):a(d,f,e!==false)}})(this);

/*! http://mths.be/placeholder v2.0.7 by @mathias */
;(function(f,h,$){var a='placeholder' in h.createElement('input'),d='placeholder' in h.createElement('textarea'),i=$.fn,c=$.valHooks,k,j;if(a&&d){j=i.placeholder=function(){return this};j.input=j.textarea=true}else{j=i.placeholder=function(){var l=this;l.filter((a?'textarea':':input')+'[placeholder]').not('.placeholder').bind({'focus.placeholder':b,'blur.placeholder':e}).data('placeholder-enabled',true).trigger('blur.placeholder');return l};j.input=a;j.textarea=d;k={get:function(m){var l=$(m);return l.data('placeholder-enabled')&&l.hasClass('placeholder')?'':m.value},set:function(m,n){var l=$(m);if(!l.data('placeholder-enabled')){return m.value=n}if(n==''){m.value=n;if(m!=h.activeElement){e.call(m)}}else{if(l.hasClass('placeholder')){b.call(m,true,n)||(m.value=n)}else{m.value=n}}return l}};a||(c.input=k);d||(c.textarea=k);$(function(){$(h).delegate('form','submit.placeholder',function(){var l=$('.placeholder',this).each(b);setTimeout(function(){l.each(e)},10)})});$(f).bind('beforeunload.placeholder',function(){$('.placeholder').each(function(){this.value=''})})}function g(m){var l={},n=/^jQuery\d+$/;$.each(m.attributes,function(p,o){if(o.specified&&!n.test(o.name)){l[o.name]=o.value}});return l}function b(m,n){var l=this,o=$(l);if(l.value==o.attr('placeholder')&&o.hasClass('placeholder')){if(o.data('placeholder-password')){o=o.hide().next().show().attr('id',o.removeAttr('id').data('placeholder-id'));if(m===true){return o[0].value=n}o.focus()}else{l.value='';o.removeClass('placeholder');l==h.activeElement&&l.select()}}}function e(){var q,l=this,p=$(l),m=p,o=this.id;if(l.value==''){if(l.type=='password'){if(!p.data('placeholder-textinput')){try{q=p.clone().attr({type:'text'})}catch(n){q=$('<input>').attr($.extend(g(this),{type:'text'}))}q.removeAttr('name').data({'placeholder-password':true,'placeholder-id':o}).bind('focus.placeholder',b);p.data({'placeholder-textinput':q,'placeholder-id':o}).before(q)}p=p.removeAttr('id').hide().prev().attr('id',o).show()}p.addClass('placeholder');p[0].value=p.attr('placeholder')}else{p.removeClass('placeholder')}}}(this,document,jQuery));

// To add the selected class on the li of navigation elements
var path = location.pathname.substring(1);
if (path){ // if there is a value for the varible path
	
	/*-- for the primary nav - if path equals the href give the parent a class of selected
	     example: nav ul li.selected a --*/
	$('nav a[href$="' + path + '"]').parent().addClass('selected');
	
	/*-- for dropdown nav - if path equals the href of the drop down links give the top level link a class of selected
	     example: nav ul li.selected a --*/
	$('nav ul ul a[href$="' + path + '"]').parents(':eq(2)').addClass('selected');
	
	/*-- for the aside nav - if path equals the href give the parent a class of selected
	     example: aside ul li.selected a --*/
	$('aside li a[href$="' + path + '"]').parent().addClass('selected');
};


/*
	Double Tap to Go Plugin
	AUTHOR: Osvaldas Valutis, www.osvaldas.info
	http://osvaldas.info/drop-down-navigation-responsive-and-touch-friendly
*/
;
(function (t, n, r, i) {
    t.fn.doubleTapToGo = function (i) {
        if (!("ontouchstart" in n) && !n.navigator.msPointerEnabled && !navigator.userAgent.toLowerCase().match(/windows phone os 7/i)) return false;
        this.each(function () {
            var n = false;
            t(this).on("click", function (e) {
                var r = t(this);
                if (r[0] != n[0]) {
                    e.preventDefault();
                    n = r
                }
            });
            t(r).on("click touchstart MSPointerDown", function (e) {
                var r = true,
                    i = t(e.target).parents();
                for (var s = 0; s < i.length; s++) if (i[s] == n[0]) r = false;
                if (r) n = false
            })
        });
        return this
    }
})(jQuery, window, document);

/*
$(function () {
	if(device != "desktop"){
    	$('nav li:has(ul)').doubleTapToGo();
	}
});
*/


// Click to open sign in box
$(function () {
    var btnSearch = $("#js-search-btn");

    $(btnSearch).on('click', function (e) {
        e.preventDefault();
		searchBox = $("#js-search");
		
    	$(searchBox).fadeToggle(200);
		$(this).toggleClass("open");
    });
	
	$('input, textarea').placeholder();
	
});

// navigation button for mobile
var $window = $(window),
    $menuBtn = $('#menu-toggle'),
    $navUl = $("#window"),
    _windowSize = function () {
        return $window.width();
    },
    _setNavStyle = function () {
        var currentSize = _windowSize();
        if (currentSize >= 590) {
            $navUl.removeAttr("style");
        }
    },
    dbSetNavStyle = $.debounce(250, _setNavStyle);

_setNavStyle();

$window.on("resize", dbSetNavStyle);

$($menuBtn).on("click", function (e) {
    e.preventDefault();
    $navUl.toggle();
});

// Check login, if logged in display #member-nav if logged in, otherwise display #utility-nav
	
	if (_isLoggedIn) // if _isLoggedIn equals true (or 1)
	{
		$("#utn-1").css({ "display": "block" });
	} 
	else // if _isLoggedIn does not equal true (or 0)
	{ 
		$("#utn-0").css({ "display": "block" });
	}
	
	if ($("body#shop")) {
		$(".shop-product-small input[type=submit]").addClass("button radius");
	}
	
$(function () {
	// When user clicks on forgot password link:
	// Sign In form hides, Forgot password form shows
    $("#btn-password").on('click', function (e) {
        e.preventDefault();
        $("#form-login").fadeOut(function(){
		   $("#form-password").fadeIn();
		});
    });
	// When user clicks on Nevermind link:
	// Sign In form shows, Forgot password form hides
    $("#btn-login").on('click', function (e) {
        e.preventDefault();
        $("#form-password").fadeOut(function(){
			$("#form-login").fadeIn();
		});
    });
	// Will show the Create Account form once clicked
    $("#needCreate").on('click', function (e) {
        e.preventDefault();
        $(".create-form").fadeIn();
    });
});