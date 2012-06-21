/**
 * @desc PetVegas APP SETTINGS
 */
var FACEBOOK_APP_ID = '300602210033160';
var TRIALPAY_CURRENCY_URL = '';
var APP_NAME = 'Test-Fastclik';

/**
 * @desc Global functions
 */
jQuery.topMenuClear = function () {
    $("div#topmenu > ul > li").each(function (i) {
        $("div#topmenu > ul > li:eq(" + i + ")").removeClass("active");
    });
    return false;
};
jQuery.topMenuSetDefault = function () {
    jQuery.topMenuClear();
    $("div#topmenu > ul > li:eq(0)").addClass('active');
};

jQuery.showOverlay = function () {
    crowdparkHTML.consoleLog('>>> showOverlay');

    $("div#container").append('<div id="overlay"></div>');
    $('div#container > #Main').css({'margin-left':'-99999px'});
};

jQuery.hideOverlay = function () {
    crowdparkHTML.consoleLog('>>> hideOverlay');

    jQuery.topMenuSetDefault();
    $("div#container > div#overlay").remove();
    $('div#container > #Main').removeAttr('style');
};

/**
 * @desc HTML namespace
 */
var crowdparkHTML = {

    /* namespace private data, getters & setters */
    _data:new Array(),
    getCdnUrl:function () {
        if (crowdparkHTML._data['cdnUrl'] === undefined) {
            var cdnUrl = document.getElementById('jsMain').getAttribute('src').replace('static/js/main.js', '');
            crowdparkHTML.setCdnUrl(cdnUrl);
        }
        return crowdparkHTML._data['cdnUrl'];
    },
    setCdnUrl:function (value) {
        crowdparkHTML.consoleLog('>>> setCdnUrl: ' + value);
        crowdparkHTML._data['cdnUrl'] = value;
        return crowdparkHTML;
    },
    getStaticUrl:function () {
        if (crowdparkHTML._data['staticUrl'] === undefined) {
            var staticUrl = crowdparkHTML.getCdnUrl() + 'static/';
            crowdparkHTML.setStaticUrl(staticUrl);
        }
        return crowdparkHTML._data['staticUrl'];
    },
    setStaticUrl:function (value) {
        crowdparkHTML.consoleLog('>>> setStaticUrl: ' + value);
        crowdparkHTML._data['staticUrl'] = value;
        return crowdparkHTML;
    },
    getImgUrl:function () {
        if (crowdparkHTML._data['imgUrl'] === undefined) {
            var imgUrl = crowdparkHTML.getStaticUrl() + 'img/';
            crowdparkHTML.setImgUrl(imgUrl);
        }
        return crowdparkHTML._data['imgUrl'];
    },
    setImgUrl:function (value) {
        crowdparkHTML.consoleLog('>>> setImgUrl: ' + value);
        crowdparkHTML._data['imgUrl'] = value;
        return crowdparkHTML;
    },
    getProtocol:function () {
        crowdparkHTML.consoleLog('>>> getProtocol');
        if (crowdparkHTML._data['protocol'] === undefined) {
            var protocol = ('https:' == document.location.protocol) ? 'https://' : 'http://';
            crowdparkHTML.setProtocol(protocol);
        }
        return crowdparkHTML._data['protocol'];
    },
    setProtocol:function (value) {
        crowdparkHTML.consoleLog('>>> setProtocol: ' + value);
        crowdparkHTML._data['protocol'] = value;
        return crowdparkHTML;
    },
    getSwfWmode:function () {
        crowdparkHTML.consoleLog('>>> getSwfWmode');
        if (crowdparkHTML._data['swfWmode'] === undefined) {
            if (navigator.appVersion.indexOf("Win") != -1 && 'Netscape' == navigator.appName) {
                var swfWmode = 'direct';
            } else {
                var swfWmode = 'opaque';
            }
            crowdparkHTML.setSwfWmode(swfWmode);
        }
        return crowdparkHTML._data['swfWmode'];
    },
    setSwfWmode:function (value) {
        crowdparkHTML.consoleLog('>>> setSwfWmode: ' + value);
        crowdparkHTML._data['swfWmode'] = value;
        return crowdparkHTML;
    },
    getUrlComponents:function () {
        crowdparkHTML.consoleLog(">>> getUrlComponents");
        if (crowdparkHTML._data['urlComponents'] === undefined) {
            var urlComponents = {};
            var url = window.location.href;
            if (url.indexOf("?") > -1) {
                var queryString = url.substr(url.indexOf("?") + 1);
                var queryStringItems = queryString.split("&");
                var queryStringItemsCount = queryStringItems.length;
                for (var index = 0; index < queryStringItemsCount; index++) {
                    var item = queryStringItems[index].split("=");
                    urlComponents[item[0]] = item[1];
                }
            }
            crowdparkHTML.setUrlComponents(urlComponents);
        }
        return crowdparkHTML._data['urlComponents'];
    },
    setUrlComponents:function (value) {
        crowdparkHTML.consoleLog('>>> setUrlComponents: ' + value);
        crowdparkHTML._data['urlComponents'] = value;
        return crowdparkHTML;
    },
    getMarketingParam:function () {
        crowdparkHTML.consoleLog('>>> getMarketingParam');
        var urlComponents = crowdparkHTML.getUrlComponents();

        if (urlComponents.sb_src) {
            return urlComponents.sb_src;
        }

        return "";
    },

    /* Display SWF object */
    displaySWF:function () {
        crowdparkHTML.consoleLog('>>> showSWF');

        /* Google Analytics event tracking (flash loading) */
        crowdparkHTML.googleFunnelViewTrack("/flashLoading");

        /* Show body content */
        document.body.removeAttribute("class");

        var swfVersionStr = "10.1";
        var swfLocation = crowdparkHTML.getCdnUrl() + 'PetVegasPure.swf';
        var xiSwfUrlStr = crowdparkHTML.getStaticUrl() + 'swf/playerProductInstall.swf';

        /* Prepare settings */
        var params = {};
        params.quality = "high";
        params.bgcolor = "#ffffff";
        params.allowscriptaccess = "sameDomain";
        params.allowfullscreen = "true";
        params.wmode = "direct";
        params.width = "760";
        params.height = "100%";
        var attributes = {};
        attributes.id = "Main";
        attributes.name = "Main";
        attributes.align = "middle";
        attributes.wmode = crowdparkHTML.getSwfWmode();
        attributes.height = "100%";
        attributes.width = "100%";
        var userData = {};
        var flashvars = {};
        flashvars.cdnUrl = crowdparkHTML.getCdnUrl();
        flashvars.trackMarketingParam = crowdparkHTML.getMarketingParam();

        swfobject.embedSWF(swfLocation, "flashContent", "760", "733",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes,
            function (event) {
                if (event.success) {
                    /* Google Analytics event tracking (flash loaded) */
                    crowdparkHTML.googleFunnelViewTrack("/flashLoaded");
                }
            });
        swfobject.createCSS("#flashContent", "display:block;text-align:center;");

        /* Enable canvas auto-resize */
        FB.Canvas.setAutoResize();
    },

    /* Call Flash methods after object is loaded */
    initializeGameCallback:function () {
        crowdparkHTML.consoleLog(">>> _gameLoadCallback");

        var urlComponents = crowdparkHTML.getUrlComponents();
        crowdparkHTML.consoleDebug(urlComponents);

        /* User reward */
        if (urlComponents.rewardToken) {

            /* Flash callback */
            var dataObject = new Object;
            dataObject.rewardId = urlComponents.rewardToken;
            var flashDataJson = JSON.stringify(dataObject);
            crowdparkHTML.flashCallback('claimReward', flashDataJson);
        }
    },

    /* Facebook app requests handler */
    facebookAppRequestHandler:function () {
        crowdparkHTML.consoleLog('>>> facebookAppRequestsHandler');

        FB.api("/me/apprequests/", function (response) {
            crowdparkHTML.consoleDebug(response);

            var appRequests = response.data;
            if (appRequests && appRequests.length) {

                var inviteRequests = [];
                var index;
                for (index in appRequests) {
                    inviteRequests.push({method:"DELETE", relative_url:appRequests[index].id});
                }

                /* Send delete batch request to Facebook */
                FB.api("/", "POST", {batch:inviteRequests}, function () {
                    crowdparkHTML.consoleLog('>>> inviteRequestsBatchDelete callback!');
                });
            }
        });
    },

    /* Facebook event callback handler */
    facebookAuthPromptCallbackHandler:function (response) {
        crowdparkHTML.consoleLog('>>> facebookAuthPromptCallbackHandler');
        crowdparkHTML.consoleDebug(response);

        /* Google Analytics event tracking (auth) */
        crowdparkHTML.googleFunnelViewTrack("/facebookAuth");
    },
    facebookAuthLoginCallbackHandler:function (response) {
        crowdparkHTML.consoleLog('>>> facebookAuthLoginCallbackHandler');
        crowdparkHTML.consoleDebug(response);

        /* HoneyTracks login event tracking (login, gender) */
        FB.api('/me', function (currentUser) {
            crowdparkHTML.consoleLog('>>>me');
            crowdparkHTML.consoleDebug(currentUser);

            /* Google Analytics event tracking (login) */
            crowdparkHTML.googleFunnelViewTrack("/facebookLogin");

            /* HoneyTracks event tracking (login, gender) */
            var data = new Object;
            data.facebookUserId = currentUser.id;
            data.gender = currentUser.gender;
            var dataJson = JSON.stringify(data);
            crowdparkFlash.HoneyTracks_TrackLogin(dataJson);
            crowdparkFlash.HoneyTracks_TrackUserGender(dataJson);
        });
    },
    facebookAuthLogoutCallbackHandler:function (response) {
        crowdparkHTML.consoleLog('>>> facebookAuthLogoutCallbackHandler');
        crowdparkHTML.consoleDebug(response);

        /* HoneyTracks event tracking (logout) */
        crowdparkFlash.HoneyTracks_TrackLogout();

        /* Google Analytics event tracking (logout) */
        crowdparkHTML.googleFunnelViewTrack("/facebookLogout");
    },
    facebookMessageSendCallbackHandler:function (response) {
        crowdparkHTML.consoleLog('>>> facebookMessageSendCallbackHandler');
        crowdparkHTML.consoleDebug(response);
    },

    /* Facebook redirect login */
    facebookLoginRedirect:function () {
        crowdparkHTML.consoleLog('>>> _getFacebookLoginRedirectURL');

        var redirectUrl = crowdparkHTML.getProtocol() + "www.facebook.com/dialog/oauth/";
        redirectUrl += "?client_id=" + FACEBOOK_APP_ID;
        redirectUrl += "&scope=email,publish_stream";
        redirectUrl += "&type=user_agent";
        redirectUrl += "&redirect_uri=" + crowdparkHTML.getProtocol() + 'apps.facebook.com/' + APP_NAME;
        redirectUrl += window.location.toString().slice(window.location.toString().indexOf('?'));
        top.location.href = redirectUrl;
    },

    /* Facebook popup login */
    facebookLogin:function () {
        crowdparkHTML.consoleLog('>>>facebookLogin');

        FB.login(function (response) {
            crowdparkHTML.consoleDebug(response);

            /* load game on response success ! */
            if (response.status == 'connected') {

                /* Google funnel track request */
                crowdparkHTML.googleFunnelViewTrack("/facebookConnected");

                /* Show SWF object */
                crowdparkHTML.displaySWF();
            }
        }, {scope:'email,publish_stream'});
    },

    /* Marketing parameters tracking */
    trackMarketingParameters:function () {
        crowdparkHTML.consoleLog(">>> trackMarketingParameters");

        var urlComponents = crowdparkHTML.getUrlComponents();
        crowdparkHTML.consoleDebug(urlComponents);

        /* HoneyTracks bookmark click tracking, invite friend acceptance */
        if (urlComponents.fb_source) {
            var data = new Object;
            data.title = urlComponents.fb_source;
            if (urlComponents.ref) {
                data.content = urlComponents.ref;
            }
            var dataJson = JSON.stringify(data);
            crowdparkFlash.HoneyTracks_TrackClick(dataJson);
        }

        /* HoneyTracks app request */
        if (urlComponents.notif_t) {
            var data = new Object;
            data.source = urlComponents.fb_source;
            data.type = urlComponents.app_request_type;
            data.requestParameters = JSON.stringify(urlComponents);
            var dataJson = JSON.stringify(data);
            crowdparkFlash.HoneyTracks_TrackViralityInvitationAcceptance(dataJson);
        }
    },

    /* Build Google funnel tracking request */
    googleFunnelViewTrack:function (key) {
        var data = new Object;
        data.url = key;
        var dataJson = JSON.stringify(data);
        crowdparkFlash.googleFunnelViewTrack(dataJson);

        return crowdparkHTML;
    },

    /* Build HoneyTracks click event request */
    HoneyTracks_TrackNavbarClick:function (title, content) {
        var data = new Object;
        data.title = title;
        data.content = content;
        var dataJson = JSON.stringify(data);
        crowdparkFlash.HoneyTracks_TrackClick(dataJson);
    },

    /* Navbar elements */
    navbarGame:function () {
        /* Flash callback */
        crowdparkHTML.flashCallback('hidePopups');

        /* Google Analytics event tracking (navbar element click) */
        crowdparkHTML.googleFunnelViewTrack("/navbar/Game");

        /* HoneyTracks navbar click tracking */
        crowdparkHTML.HoneyTracks_TrackNavbarClick('navbar', 'Game');
    },
    navbarBuyCoins:function () {
        /* Flash callback */
        crowdparkHTML.flashCallback('popupBuyCoins');

        /* Google Analytics event tracking (navbar element click) */
        crowdparkHTML.googleFunnelViewTrack("/navbar/Buy-Coins");

        /* HoneyTracks navbar click tracking */
        crowdparkHTML.HoneyTracks_TrackNavbarClick('navbar', 'Buy coins');
    },
    navbarEarnCoins:function () {
        crowdparkFlash.trialpayEarnCoins();

        /* Google Analytics event tracking (navbar element click) */
        crowdparkHTML.googleFunnelViewTrack("/navbar/Earn-Coins");

        /* HoneyTracks navbar click tracking */
        crowdparkHTML.HoneyTracks_TrackNavbarClick('navbar', 'Earn coins');
    },
    navbarFreeGifts:function () {
        /* Flash callback */
        crowdparkHTML.flashCallback('popupFreeGifts');

        /* Google Analytics event tracking (navbar element click) */
        crowdparkHTML.googleFunnelViewTrack("/navbar/Free-Gifts");

        /* HoneyTracks navbar click tracking */
        crowdparkHTML.HoneyTracks_TrackNavbarClick('navbar', 'Free gifts');
    },
    navbarInviteFriends:function () {
        crowdparkFlash.facebookInviteFriends();

        /* Google Analytics event tracking (navbar element click) */
        crowdparkHTML.googleFunnelViewTrack("/navbar/Invite-Friends");

        /* HoneyTracks navbar click tracking */
        crowdparkHTML.HoneyTracks_TrackNavbarClick('navbar', 'Invite friends');

        /* HoneyTracks invite event track */
        var data = new Object;
        data.source = 'navbar';
        data.type = '';
        var dataJson = JSON.stringify(data);
        crowdparkFlash.HoneyTracks_TrackViralityInvitation(dataJson);
    },
    /* Flash callback function */
    flashCallback:function (method, parameters, retry) {
        crowdparkHTML.consoleLog(">>> flashCallback: " + method);

        var flashReadyStatus = crowdparkFlash.getFlashReady();
        crowdparkHTML.consoleLog(">>> flashReadyStatus: " + flashReadyStatus);

        if (flashReadyStatus !== true) {
            if (retry == 5) {
                crowdparkHTML.consoleLog(">>> flashReadyStatus: MAX RETRY REACHED");
                return false;
            }

            var t = setTimeout(function () {
                if (retry == undefined) {
                    retry = 1;
                }
                crowdparkHTML.flashCallback(method, parameters, retry);
            }, 4000);

            return false;
        }

        crowdparkHTML.consoleLog(">>> flashCallback: EXECUTE CALLBACK=" + method);
        try {
            switch (method) {
                case 'hidePopups':
                    swfobject.getObjectById('Main').hidePopups();
                    break;

                case 'popupBuyCoins':
                    swfobject.getObjectById('Main').popupBuyCoins();
                    break;

                case 'popupFreeGifts':
                    swfobject.getObjectById('Main').popupFreeGifts();
                    break;

                case 'facebookCreditsPurchase':
                    swfobject.getObjectById('Main').facebookCreditsPurchase(parameters);
                    break;

                case 'facebookBoostersPurchase':
                    swfobject.getObjectById('Main').facebookBoostersPurchase(parameters);
                    break;

                case 'facebookSendGift':
                    swfobject.getObjectById('Main').facebookSendGift(parameters);
                    break;

                case 'facebookShare':
                    swfobject.getObjectById('Main').facebookShare(parameters);
                    break;

                case 'claimReward':
                    swfobject.getObjectById('Main').claimReward(parameters);
                    break;
            }
        } catch (err) {
            crowdparkHTML.consoleLog(">>> JS EXCEPTION: " + err);
        }
    },

    /* Reload page */
    reload:function () {
        var url = document.location.href;
        document.location.href = url;
        return false;
    },

    /* Debugging functions */
    consoleLog:function (content) {
        if (navigator.appName != 'Microsoft Internet Explorer') {
            console.log(content);
        }
    },
    consoleDebug:function (content) {
        if (navigator.appName != 'Microsoft Internet Explorer') {
            console.debug(content);
        }
    }
};

/**
 * @desc FLASH namespace
 */
var crowdparkFlash = {

    /* namespace private data, getters & setters */
    _data:new Array(),
    getFlashReady:function () {
        if (crowdparkFlash._data['flashReady'] === undefined) {
            crowdparkHTML.consoleLog('>>> getFlashReady: undefined');
            return null;
        }
        crowdparkHTML.consoleLog('>>> getFlashReady: ' + crowdparkFlash._data['flashReady']);
        return crowdparkFlash._data['flashReady'];
    },
    setFlashReady:function (value) {
        crowdparkHTML.consoleLog('>>> setFlashReady: ' + value);

        crowdparkFlash._data['flashReady'] = value;
        return crowdparkFlash;
    },

    /* Set callable status */
    flashCallbackSetReadyStatus:function (dataJson) {
        crowdparkHTML.consoleLog('>>> flashCallbackSetReadyStatus');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);
        crowdparkFlash.setFlashReady(dataObject.ready);
    },

    /* Facebook */
    facebookCreditsPurchase:function (dataJson) {
        crowdparkHTML.consoleLog('>>> facebookCreditsPurchase');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        crowdparkHTML.consoleLog('>>> facebookCreditsPurchase request');
        crowdparkHTML.consoleDebug(dataObject);

        jQuery.showOverlay();

        /* Prepare Facebook UI request parameters */
        var facebookRequestParams = {
            method:'pay',
            order_info:'{"id":' + dataObject.id + ',"type":' + dataObject.type + '}',
            purchase_type:'item',
            dev_purchase_params:{
                'oscif':true
            }
        };

        FB.ui(facebookRequestParams, function (response) {
            if (response && response.order_id) {
                /* Flash callback */
                dataObject.success = true;
                var flashDataJson = JSON.stringify(dataObject);
                crowdparkHTML.flashCallback('facebookCreditsPurchase', flashDataJson);
            }

            crowdparkHTML.consoleLog('>>> facebookCreditsPurchase response');
            crowdparkHTML.consoleDebug(dataObject);

            /* show flash object */
            jQuery.hideOverlay();
        });

        /* HoneyTracks click tracking */
        var data = new Object;
        data.title = "facebookCreditsPurchase";
        var dataJson = JSON.stringify(data);
        crowdparkFlash.HoneyTracks_TrackClick(dataJson);
    },
    facebookBoostersPurchase:function (dataJson) {
        crowdparkHTML.consoleLog('>>> facebookBoostersPurchase');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        crowdparkHTML.consoleLog('>>> facebookBoostersPurchase request');
        crowdparkHTML.consoleDebug(dataObject);

        jQuery.showOverlay();

        /* Prepare Facebook UI request parameters */
        var facebookRequestParams = {
            method:'pay',
            order_info:'{"id":' + dataObject.id + ',"type":' + dataObject.type + '}',
            purchase_type:'item',
            dev_purchase_params:{
                'oscif':true
            }
        };

        FB.ui(facebookRequestParams, function (response) {
            if (response && response.order_id) {
                /* Flash callback */
                dataObject.success = true;
                var flashDataJson = JSON.stringify(dataObject);
                crowdparkHTML.flashCallback('facebookBoostersPurchase', flashDataJson);
            }

            crowdparkHTML.consoleLog('>>> facebookBoostersPurchase response');
            crowdparkHTML.consoleDebug(dataObject);

            /* show flash object */
            jQuery.hideOverlay();
        });

        /* HoneyTracks click tracking */
        var data = new Object;
        data.title = "facebookBoostersPurchase";
        var dataJson = JSON.stringify(data);
        crowdparkFlash.HoneyTracks_TrackClick(dataJson);
    },

    /* Facebook Invite friends */
    facebookInviteFriends:function () {
        crowdparkHTML.consoleLog('>>> facebookInviteFriends');

        jQuery.showOverlay();

        /* Prepare Facebook UI request parameters */
        var facebookRequestParams = {
            display:'iframe',
            title:'Select some of your friends',
            message:'Come and play in Pet Vegas',
            data:{
                'swfaddress':'/PetVegasPure.swf',
                'type':'invite',
                'model':''
            },
            'filters':['app_non_users']
        };

        FB.api('/me', function (currentUser) {

            /* Add Facebook UI request parameters */
            facebookRequestParams.app_id = FACEBOOK_APP_ID;
            facebookRequestParams.method = 'apprequests';
            facebookRequestParams.data.id = currentUser.id;
            facebookRequestParams.data.trackingUid = currentUser.id;

            FB.ui(facebookRequestParams, function (response) {
                    jQuery.hideOverlay();
                }
            );
        });

        /* HoneyTracks user invite friends track */
        var data = new Object;
        data.source = 'flash';
        data.type = '';
        var dataJson = JSON.stringify(data);
        crowdparkFlash.HoneyTracks_TrackViralityInvitation(dataJson);
    },

    /* Facebook Send Gift */
    facebookSendGift:function (dataJson) {
        crowdparkHTML.consoleLog('>>> facebookSendGift');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        jQuery.showOverlay();

        /* Prepare Facebook UI request parameters */
        var facebookRequestParams = {
            method:'apprequests',
            title:'Send Gift',
            message:dataObject.message,
            data:{
                'type':dataObject.type,
                'amount':dataObject.amount
            }
        };
        if (dataObject.uid !== undefined) {
            facebookRequestParams.to = dataObject.uid;
        }

        FB.ui(facebookRequestParams, function (response) {
            jQuery.hideOverlay();

            crowdparkHTML.consoleLog('>>> facebookSendGift RESPONSE=');
            crowdparkHTML.consoleDebug(response);

            if (response) {
                dataObject.success = true;
                dataObject.requestId = response.request;
            } else {
                dataObject.success = false;
                dataObject.requestId = 0;
            }

            /* Flash callback */
            var flashDataJson = JSON.stringify(dataObject);
            crowdparkHTML.flashCallback('facebookSendGift', flashDataJson);
        });

        /* HoneyTracks user invite friends track */
        crowdparkFlash.HoneyTracks_TrackViralitySendGift();
    },

    /* Facebook publish data on wall */
    facebookShare:function (dataJson) {
        crowdparkHTML.consoleLog('>>> facebookShare');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        jQuery.showOverlay();

        /* build link (check for reward) */
        var picture = crowdparkHTML.getProtocol() + crowdparkHTML.getImgUrl().replace('//', '') + 'ico_pet90.png';
        var link = crowdparkHTML.getProtocol() + 'apps.facebook.com/' + APP_NAME;
        if (dataObject.rewardId != 0) {
            link = link + '/?rewardToken=' + dataObject.rewardId;
        }

        /* Prepare Facebook UI request parameters */
        var facebookRequestParams = {
            method:'feed',
            name:dataObject.title,
            link:link,
            picture:picture,
            caption:dataObject.title,
            description:dataObject.message
        };

        FB.ui(facebookRequestParams, function (response) {
            crowdparkHTML.consoleLog('>>> facebookShare response=');
            crowdparkHTML.consoleDebug(response);

            jQuery.hideOverlay();

            if (response && response.post_id) {
                dataObject.openGraphId = response.post_id;
                dataObject.success = true;

                /* Flash callback */
                var flashDataJson = JSON.stringify(dataObject);
                crowdparkHTML.flashCallback('facebookShare', flashDataJson);
            }
        });

        /* HoneyTracks user invite friends track */
        crowdparkFlash.HoneyTracks_TrackViralityShare();
    },

    /* Increment level */
    levelUp:function (dataJson) {
        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        if (dataObject.level < 2 || dataObject.level > 5) {
            return;
        }
        crowdparkFlash.trackBrighteroption(dataObject.level + 2);
    },

    /* Brighteroption tracker */
    trackBrighteroption:function (dataJson) {
        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        (function () {
            var p = function (x) {
                var q = [];
                var s = '';

                if (x != null) {
                    s = x.toString();
                }

                if (window.RegExp) {
                    s.replace(new RegExp("(sb_[^?=&]+|__sb_[^?=&]+)(=([^&]*))?", "g"), function ($0, $1, $2, $3) {
                        q.push($1 + '=' + $3);
                    });
                } else {
                    q = ['sb_err=NoRegExp'];
                }

                var i = s.indexOf('?');

                if (i > 0) {
                    s = s.substr(0, i + 1) + q.join('&');
                }

                return (escape(s));
            };

            var userData = new Object();
            userData.location = window.location;
            userData.referrer = document.referrer;

            var u = (document.location.protocol) + "/*track.brighteroption.com/b?"
                + "p=" + Config.samId
                + "&sb_src=" + Config.sb_src
                + "&l=" + dataObject.level
                + "&src=" + userData.location
                + "&sref=" + userData.referrer
                + "&rnd=" + (Math.random() * (1 << 30)).toString(16).replace('.', '');

            $.get(u);
        })();
    },

    /* Change background color */
    changeBackground:function (dataJson) {
        crowdparkHTML.consoleLog('>>> changeBackground');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        $('<img />')
            .attr('src', dataObject.url)
            .load(function () {
                $('body > div#container')
                    .css('background-image', 'url(' + dataObject.url + ')')
                    .css('background-repeat', 'no-repeat')
                    .css('background-attachment', 'fixed')
                    .css('background-position', '0px 0px');
            });
    },

    /* Maintenance mode on / off */
    setMaintenanceModeOn:function () {
        crowdparkHTML.consoleLog('>>> setMaintenanceModeOn');

        var maintenanceContainer = document.createElement('div');
        maintenanceContainer.setAttribute('id', 'maintenance');
        document.body.insertBefore(maintenanceContainer, document.body.childNodes[0]);
    },
    setMaintenanceModeOff:function () {
        crowdparkHTML.consoleLog('>>> setMaintenanceModeOff');

        var maintenanceContainer = document.getElementById('maintenance');
        if (maintenanceContainer === null) {
            return false;
        }
        document.body.removeChild(maintenanceContainer);
    },

    /* TrialPay */
    _trialpayHandlerOnOpen:function () {
        crowdparkHTML.consoleLog('>>> handlerOnOpen');

        jQuery.showOverlay();

        /* Google Analytics event tracking (trialpay modal open) */
        crowdparkHTML.googleFunnelViewTrack("/trialpay/open");

        /* HoneyTracks event tracking */
        var data = new Object;
        data.title = 'trialpay';
        data.content = 'open';
        var dataJson = JSON.stringify(data);
        crowdparkFlash.HoneyTracks_TrackClick(dataJson);
    },
    _trialpayHandlerOnClose:function () {
        crowdparkHTML.consoleLog('>>> _onClose');

        jQuery.hideOverlay();

        /* Google Analytics event tracking (trialpay modal close) */
        crowdparkHTML.googleFunnelViewTrack("/trialpay/close");

        /* HoneyTracks event tracking */
        var data = new Object;
        data.title = 'trialpay';
        data.content = 'close';
        var dataJson = JSON.stringify(data);
        crowdparkFlash.HoneyTracks_TrackClick(dataJson);
    },
    _trialpayHandlerOnTransaction:function (data) {
        crowdparkHTML.consoleLog('>>> handlerOnTransaction');
        crowdparkHTML.consoleDebug(data);

        /* Google Analytics event tracking (trialpay transaction) */
        crowdparkHTML.googleFunnelViewTrack("/trialpay/transaction");

        /* HoneyTracks event tracking */
        var data = new Object;
        data.title = 'trialpay';
        data.content = 'transaction';
        var dataJson = JSON.stringify(data);
        crowdparkFlash.HoneyTracks_TrackClick(dataJson);
    },
    trialpayEarnCoins:function () {
        crowdparkHTML.consoleLog('>>> trialpayEarnCoins');

        FB.api('/me', function (currentUser) {
            crowdparkHTML.consoleLog('>>>> currentUser=');
            crowdparkHTML.consoleDebug(currentUser);

            TRIALPAY.fb.show_overlay(
                FACEBOOK_APP_ID,
                'fbpayments',
                {
                    sid:currentUser.id,
                    currency_url:TRIALPAY_CURRENCY_URL,
                    onOpen:'crowdparkFlash._trialpayHandlerOnOpen',
                    onClose:'crowdparkFlash._trialpayHandlerOnClose',
                    onTransact:'crowdparkFlash._trialpayHandlerOnTransaction'
                }
            );
        });

        /* HoneyTracks user invite friends track */
        crowdparkFlash.HoneyTracks_TrackViralityEarnCredits();
    },

    /* Google event tracking */
    googleFunnelViewTrack:function (dataJson) {
        crowdparkHTML.consoleLog('>>> googleFunnelViewTrack');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        _gaq.push(['_trackPageview', dataObject.url]);
    },
    googleFunnelEventTrack:function (dataJson) {
        crowdparkHTML.consoleLog('>>> googleFunnelEventTrack');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        var googleData = [
            '_trackEvent',
            dataObject.category,
            dataObject.action
        ];
        if (dataObject.label !== undefined) {
            googleData[3] = dataObject.label;
        }
        if (dataObject.value !== undefined) {
            googleData[4] = parseInt(dataObject.value);
        }
        if (dataObject.noninteraction !== undefined) {
            googleData[5] = Boolean(dataObject.noninteraction);
        }

        _gaq.push(googleData);
    },

    /* HoneyTracks event tracking functions */
    HoneyTracks_TrackLogin:function (dataJson) {
        crowdparkHTML.consoleLog('>>> HoneyTracks_TrackLogin');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        _HoneyTracksTracking.push(function () {
            HoneyTracks_Tracker_Library.setOption('UniqueCustomerIdentifier', dataObject.facebookUserId);
            HoneyTracks_Tracker_Library.TrackLogin();
        });
    },
    HoneyTracks_TrackLogout:function () {
        crowdparkHTML.consoleLog('>>> HoneyTracks_TrackLogout');

        _HoneyTracksTracking.push(function () {
            HoneyTracks_Tracker_Library.TrackLogout();
        });
    },
    HoneyTracks_TrackUserGender:function (dataJson) {
        crowdparkHTML.consoleLog('>>> HoneyTracks_TrackUserGender');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        _HoneyTracksTracking.push(function () {
            HoneyTracks_Tracker_Library.TrackUserGender(dataObject.gender);
        });
    },
    HoneyTracks_TrackTableChange:function (dataJson) {
        crowdparkHTML.consoleLog('>>> HoneyTracks_TrackTableChange');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        var data = new Object;
        data.featureName = 'Game table';
        data.featureType = dataObject.tableId;
        var dataJson = JSON.stringify(data);
        crowdparkHTML.HoneyTracks_TrackFeatureUsage(dataJson);
    },
    HoneyTracks_TrackFeatureUsage:function (dataJson) {
        crowdparkHTML.consoleLog('>>> HoneyTracks_TrackFeatureUsage');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        _HoneyTracksTracking.push(function () {
            HoneyTracks_Tracker_Library.TrackFeatureUsage(dataObject.featureName, dataObject.featureType);
        });
    },
    HoneyTracks_TrackViralitySendGift:function () {
        crowdparkHTML.consoleLog('>>> HoneyTracks_TrackViralitySendGift');

        var data = new Object;
        data.featureName = 'Send gift';
        data.featureType = '';
        var dataJson = JSON.stringify(data);
        crowdparkHTML.HoneyTracks_TrackFeatureUsage(dataJson);
    },
    HoneyTracks_TrackViralityShare:function () {
        crowdparkHTML.consoleLog('>>> HoneyTracks_TrackViralityShare');

        var data = new Object;
        data.featureName = 'Share';
        data.featureType = '';
        var dataJson = JSON.stringify(data);
        crowdparkHTML.HoneyTracks_TrackFeatureUsage(dataJson);
    },
    HoneyTracks_TrackViralityEarnCredits:function () {
        crowdparkHTML.consoleLog('>>> HoneyTracks_TrackViralityEarnCredits');

        var data = new Object;
        data.featureName = 'TrialPay';
        data.featureType = '';
        var dataJson = JSON.stringify(data);
        crowdparkHTML.HoneyTracks_TrackFeatureUsage(dataJson);
    },
    HoneyTracks_TrackClick:function (dataJson) {
        crowdparkHTML.consoleLog('>>> HoneyTracks_TrackClick');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        _HoneyTracksTracking.push(function () {
            if (dataObject.content) {
                HoneyTracks_Tracker_Library.TrackClick(dataObject.title, dataObject.content);
            } else {
                HoneyTracks_Tracker_Library.TrackClick(dataObject.title);
            }
        });
    },
    HoneyTracks_TrackViralityInvitation:function (dataJson) {
        crowdparkHTML.consoleLog('>>> HoneyTracks_TrackViralityInvitation');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        _HoneyTracksTracking.push(function () {
            HoneyTracks_Tracker_Library.TrackViralityInvitation(dataObject.source, dataObject.type, 1);
        });
    },
    HoneyTracks_TrackViralityInvitationAcceptance:function (dataJson) {
        crowdparkHTML.consoleLog('>>> HoneyTracks_TrackViralityInvitationAcceptance');

        var dataObject = JSON.parse(dataJson);
        crowdparkHTML.consoleDebug(dataObject);

        _HoneyTracksTracking.push(function () {
            HoneyTracks_Tracker_Library.TrackViralityInvitationAcceptance(dataObject.source, dataObject.type, dataObject.requestParameters);
        });
    }
}

/**
 * @desc Game events & UI controls initialize after all the page elements are loaded
 */
$(window).load(function () {
    crowdparkHTML.initializeGameCallback();

    /* UI controls */
    $('div#topmenu > ul > li').click(function () {
        jQuery.topMenuClear();
        $(this).addClass('active');

        var actionType = $(this).find('a').attr('href');
        switch (actionType) {

            case '#!/game':
                crowdparkHTML.navbarGame();
                break;

            case '#!/buy-coins':
                crowdparkHTML.navbarBuyCoins();
                break;

            case '#!/earn-coins':
                crowdparkHTML.navbarEarnCoins();
                break;

            case '#!/free-gifts':
                crowdparkHTML.navbarFreeGifts();
                break;

            case '#!/invite-friends':
                crowdparkHTML.navbarInviteFriends();
                break;

            default:
                jQuery.topMenuSetDefault();
                break;
        }

        return false;
    });
});