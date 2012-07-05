const FACEBOOK_APP_ID = '300602210033160';
var APP_NAME = 'fastclick-game';

var crowdparkHTML = {
    _data:new Array(),


    consoleLog:function (content) {
        if (navigator.appName != 'Microsoft Internet Explorer') {
            console.log(content);
        }
    },
    consoleDebug:function (content) {
        if (navigator.appName != 'Microsoft Internet Explorer') {
            console.debug(content);
        }
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

    facebookInviteFriends:function (data) {
        console.log('>>> facebookInviteFriends');


        var dataJson = JSON.stringify(data);

        dataObject = JSON.parse(dataJson);
        console.debug(dataObject);


        FB.ui(
            {
                app_id:FACEBOOK_APP_ID,
                method:'apprequests',
                display:'iframe',
                title:'Select some of your friends',
                message:'Come and play Fastclick',
                data:{
                    'trackingUid':dataObject.trackingUid,
                    //    'swfaddress':'/assets/swf/MainApp.swf',
                    'type':'invite',
                    'model':'',
                    'id':dataObject.id
                },
                'filters':['app_non_users']
            },

            function (response) {
            }
        );
    },

    facebookSendGift:function (data) {
        console.log('>>> facebookSendGift');
        console.log(data);
        var dataJson = JSON.stringify(data);
        dataObject = JSON.parse(dataJson);

        var requestData = {
            app_id:FACEBOOK_APP_ID,
            method:'apprequests',
            message:dataObject.message,
            data:{
                'type':dataObject.type,
                'amount':dataObject.amount
            },
            title:'Send Gift',
            to:dataObject.uid
        };

        FB.ui(requestData,

            function (response) {
                console.log("[RESPONSE Callback]");
                var data;
                if (response) {
                    data = parseFloat(response.request);
                } else {
                    data = parseFloat(0);
                }
                console.log(response);

                window.swfobject.getObjectById('Testing').facebookSendGift(response);
            }
        );
    },

    facebookAppRequestHandler:function () {
        console.log('>>> facebookAppRequestsHandler');

        FB.api("/me/apprequests/", function (response) {
            console.debug(response);

            var appRequests = response.data;
            if (appRequests && appRequests.length) {

                var inviteRequests = [];
                var index;
                for (index in appRequests) {
                    inviteRequests.push({method:"DELETE", relative_url:appRequests[index].id});
                }

                /* Send delete batch request to Facebook */
                FB.api("/", "POST", {batch:inviteRequests}, function () {
                    console.log('>>> inviteRequestsBatchDelete callback!');
                });
            }
        });
    },

    facebookShare:function (dataJson) {
        console.log('>>> facebookShare');

        console.log(dataJson);


        /* build link (check for reward) */
        //var picture = crowdparkHTML.getProtocol() + crowdparkHTML.getImgUrl().replace('//', '') + 'fastclick_icon.gif';
        //var link = crowdparkHTML.getProtocol() + 'apps.facebook.com/' + APP_NAME;
        var link = 'https://apps.facebook.com/fastclick-game/';
        //if (dataJson.rewardId != 0) {
        //  link = link + '/?rewardToken=' + dataJson.rewardId;
        //}

        /* Prepare Facebook UI request parameters */
        var facebookRequestParams = {
            method:'feed',
            name:'FastClick',
            link:link,
            //picture:picture,

            caption:dataJson.title,
            description:dataJson.message
        };

        console.log(facebookRequestParams);
        FB.ui(facebookRequestParams, function (response) {
            console.log('>>> facebookShare response=');
            console.debug(response);


            if (response && response.post_id) {
                dataJson.openGraphId = response.post_id;
                dataJson.success = true;

                /* Flash callback */
                //var flashDataJson = JSON.stringify(dataJson);
                window.swfobject.getObjectById('Testing').facebookShare(response);

            }
        });

    }


}