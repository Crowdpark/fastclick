/**
 *
 * @desc Fastclick user interaction
 */

    const FACEBOOK_APP_ID = '300602210033160';
const TRIALPAY_CURRENCY_URL = 'http://52qx.localtunnel.com/petvegas-totally-awesome/htdocs/pv_coins.html';

var crowdparkFlash = {

    // Facebook Credits
    facebookCreditsPurchase:function (dataJson) {
        console.log('>>> facebookCreditsPurchase');

        dataObject = JSON.parse(dataJson);
        console.debug(dataObject);

        var flashObject = document.getElementById('Main');
        FB.Canvas.hideFlashElement(flashObject);

        FB.ui(
            {
                app_id:FACEBOOK_APP_ID,
                method:'pay',
                order_info:'{"id":' + dataObject.id + ',"type":' + dataObject.type + '}',
                purchase_type:'item',
                dev_purchase_params:{
                    'oscif':true
                }
            },

            function (response) {
                console.debug(response);
                FB.Canvas.showFlashElement(flashObject);

                // do callback
                if (response && response.order_id) {
                    swfobject.getObjectById('Main').facebookCreditsPurchase('settled');
                } else {
                    swfobject.getObjectById('Main').facebookCreditsPurchase('canceled');
                }
            }
        );
    },


    // Facebook Invite friends
    facebookInviteFriends:function (dataJson) {
        console.log('>>> facebookInviteFriends');

        dataObject = JSON.parse(dataJson);
        console.debug(dataObject);

        var flashObject = document.getElementById('Main');
        FB.Canvas.hideFlashElement(flashObject);

        FB.ui(
            {
                app_id:FACEBOOK_APP_ID,
                method:'apprequests',
                display:'iframe',
                title:'Select some of your friends',
                message:'Come and play Fastclick',
                data:{
                    'trackingUid':dataObject.trackingUid,
                    'swfaddress':'/assets/swf/MainApp.swf',
                    'type':'invite',
                    'model':'',
                    'id':dataObject.id
                },
                'filters':['app_non_users']
            },

            function (response) {
                FB.Canvas.showFlashElement(flashObject);
            }
        );
    },


    // Facebook Send Gift
    facebookSendGift:function (dataJson) {
        console.log('>>> facebookSendGift');

        dataObject = JSON.parse(dataJson);
        console.debug(dataObject);

        var flashObject = document.getElementById('Main');
        FB.Canvas.hideFlashElement(flashObject);

        FB.ui(
            {
                app_id:FACEBOOK_APP_ID,
                method:'apprequests',
                message:dataObject.message,
                data:{
                    'type':dataObject.type,
                    'amount':dataObject.amount
                },
                title:'Send Gift',
                to:dataObject.uid
            },

            function (response) {
                FB.Canvas.showFlashElement(flashObject);

                if (response) {
                    var data = parseFloat(response.request);
                } else {
                    var data = parseFloat(0);
                }

                var flashDataJson = JSON.stringify(data);
                swfobject.getObjectById('Main').facebookSendGift(flashDataJson);
            }
        );
    },


    // Facebook publish data on wall
    facebookShare:function (dataJson) {
        console.log('>>> facebookShare');

        dataObject = JSON.parse(dataJson);
        console.debug(dataObject);

        var flashObject = document.getElementById('Main');
        FB.Canvas.hideFlashElement(flashObject);

        /**
         * @todo Fix link value
         */
        var link = 'http://apps.facebook.com/petvegas-dev-mircea/&reward_id=' + dataObject.reward_id;
        var descriptionText = '';
        switch (parseInt(dataObject.type)) {
            case 1:
                if (!dataObject.amount) {
                    dataObject.amount = 100;
                }
                descriptionText = 'Get ' + dataObject.amount + ' Coins';
                break;
            case 3:
                descriptionText = 'Get ' + dataObject.amount + ' Free Spins';
                break;
        }
        FB.ui(
            {
                app_id:FACEBOOK_APP_ID,
                display:'iframe',
                method:'stream.publish',
                message:dataObject.message,
                attachment:{
                    name:dataObject.title,
                    description:dataObject.message,
                    href:link,
                    media:[
                        {
                            type:'image',
                            href:link,
                            src:'/assets/img/ico_pet90.png'
                        }
                    ]
                },
                action_links:[
                    {
                        text:descriptionText,
                        href:link
                    }
                ]
            },
            function (response) {
                FB.Canvas.showFlashElement(flashObject);

                var data = 1;

                var flashDataJson = JSON.stringify(data);
                swfobject.getObjectById('Main').facebookShare(flashDataJson);
            }
        );
    },


    // Increment level
    levelUp:function (dataJson) {
        dataObject = JSON.parse(dataJson);
        console.debug(dataObject);

        if (dataObject.level < 2 || dataObject.level > 5) {
            return;
        }
        this.track_brighteroption(dataObject.level + 2);
    },


    /**
     * @todo Refactor this code !
     *
     * @param lvl
     * @param sb_v
     */
    track_brighteroption:function (dataJson) {
        dataObject = JSON.parse(dataJson);
        console.debug(dataObject);

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

            var userData = new Objet();
            userData.location = window.location;
            userData.referrer = document.referrer;

            var u = (document.location.protocol) + "//track.brighteroption.com/b?"
                + "p=" + Config.samId
                + "&sb_src=" + Config.sb_src
                + "&l=" + dataObject.level
                + "&src=" + userData.location
                + "&sref=" + userData.referrer
                + "&rnd=" + (Math.random() * (1 << 30)).toString(16).replace('.', '');

            $.get(u);
        })();
    },


    // Change background color
    changeBackground:function (dataJson) {
        console.log('>>> changeBackground');

        dataObject = JSON.parse(dataJson);
        console.debug(dataObject);

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


    // User back to lobby room
    backToLobby:function () {
        console.log('>>> backToLobby');

        var data = "";

        var flashDataJson = JSON.stringify(data);
        swfobject.getObjectById('Main').backToLobby(flashDataJson);
    },


    // Get all client informations
    getClientInfo:function () {
        console.log('>>> getClientInfo');

        var _navigator = {};
        for (var i in navigator) {
            _navigator[i] = navigator[i];
        }
        var _screen = {};
        for (var i in screen) {
            _screen[i] = screen[i];
        }

        var data = new Object();
        data.navigator = _navigator;
        data.screen = _screen;

        var flashDataJson = JSON.stringify(data);
        swfobject.getObjectById('Main').sendClientInfoToFlash(flashDataJson);
    },


    /**
     * @desc TrialPay
     */
    trialpayEarnCredits:function (dataJson) {
        console.log('>>> trialpayEarnCredits');

        dataObject = JSON.parse(dataJson);
        console.debug(dataObject);

        // trialpay credits win
        var _onTransaction = function (data) {
            console.log('>>> handlerOnTransaction');
            console.debug(data);
            // some business logic here
        }
        var _onOpen = function () {
            console.log('>>> handlerOnOpen');
            // some business logic here
        }
        var _onClose = function () {
            console.log('>>> _onClose');
            // some business logic here
        }

        TRIALPAY.fb.show_overlay(
            FACEBOOK_APP_ID,
            'fbpayments',
            {
                sid: dataObject.fb_sig_user,
                //                    currency_url: TRIALPAY_CURRENCY_URL,
                onOpen:'handlerOnOpen',
                onClose:'handlerOnClose',
                onTransact:'handlerOnTransaction'
            }
        );
    },

    // Google event tracking
    googleFunnelViewTrack:function (dataJson) {
        console.log('>>> googleFunnelViewTrack');

        dataObject = JSON.parse(dataJson);
        console.debug(dataObject);

        _gaq.push(['_trackPageview', dataObject.url]);
    },
    googleFunnelEventTrack:function (dataJson) {
        console.log('>>> googleFunnelEventTrack');

        dataObject = JSON.parse(dataJson);
        console.debug(dataObject);

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
    }
}


/**
 * @desc Controls
 */
$(document).ready(function () {

    $('a[href$="#!/buy-coins"]').click(function () {
        var data = new Object();
        data.id = 3;
        data.type = 1;

        var dataJson = JSON.stringify(data);
        crowdparkFlash.facebookCreditsPurchase(dataJson);
    });

    $('a[href$="#!/invite-friends"]').click(function () {
        var data = new Object();
        data.id = 100003667239919;
        data.trackingUid = 100003667239919;

        var dataJson = JSON.stringify(data);
        crowdparkFlash.facebookInviteFriends(dataJson);
    });

    $('a[href$="#!/send-gift"]').click(function () {
        var data = new Object();
        data.message = 'test gift send';
        data.type = 1;
        data.ammont = 100;
        data.uid = 100003667239919;

        var dataJson = JSON.stringify(data);
        crowdparkFlash.facebookSendGift(dataJson);
    });

    $('a[href$="#!/share"]').click(function () {
        var data = new Object;
        data.reward_id = 1;
        data.type = 1;
        data.ammount = 100;
        data.message = 'share message here';
        data.title = 'share title here';

        var dataJson = JSON.stringify(data);
        crowdparkFlash.facebookShare(dataJson);
    });

    $('a[href$="#!/earn-coins"]').click(function () {
        var data = new Object();
        data.fb_sig_user = 100003667239919;

        var dataJson = JSON.stringify(data);
        crowdparkFlash.trialpayEarnCredits(dataJson);
    });

    $('a[href$="#!/bg-change"]').click(function () {
        var data = new Object;
        data.id = 1;
        data.url = "http://2.bp.blogspot.com/_2hWpVbqYkAY/SwSeLIsTvlI/AAAAAAAABCY/1PJa2QMKUh8/s1600/iStock_000005842793Medium.jpg";

        var dataJson = JSON.stringify(data);
        crowdparkFlash.changeBackground(dataJson);
    });

    $('a[href$="#!/lobby"]').click(function () {
        crowdparkFlash.backToLobby();
    });

    $('a[href$="#!/client-info"]').click(function () {
        crowdparkFlash.getClientInfo();
    });

});