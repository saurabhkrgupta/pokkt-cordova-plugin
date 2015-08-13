
var PokktExtension = function () {
    readPokktConfig();
};


// ------- POKKT SDK STATES/OPERATIONS -------

PokktExtension.prototype.setDebug = function (debug) {
    notifyNative('setDebug', undefined, debug);
};

PokktExtension.prototype.showLog = function (message) {
    notifyNative('showLog', undefined, message);
};

PokktExtension.prototype.showToast = function (message) {
    notifyNative('showToast', undefined, message);
};

PokktExtension.prototype.initPokkt = function () {
    notifyNative('initPokkt');
};

PokktExtension.prototype.checkIsVideoAvailable = function (callback) {
    notifyNative('isVideoAvailable', callback);
};

PokktExtension.prototype.getVideoVc = function (callback) {
    notifyNative('getVideoVc', callback);
};

PokktExtension.prototype.getPokktSDKVersion = function (callback) {
    notifyNative('getPokktSDKVersion', callback);
};


// ------- POKKT SESSION OPERATIONS -------

PokktExtension.prototype.startSession = function () {
    notifyNative('startSession');
};

PokktExtension.prototype.endSession = function () {
    notifyNative('endSession');
};


// ------- POKKT OFFERWALL OPERATIONS -------

PokktExtension.prototype.getCoins = function (assetValue) {
    if (assetValue != undefined || assetValue  != null)
        this.setOfferwallAssetValue(assetValue);
    notifyNative('getCoins');
};

PokktExtension.prototype.getPendingCoins = function () {
    notifyNative('getPendingCoins');
};

PokktExtension.prototype.checkOfferWallCampaign = function () {
    notifyNative('checkOfferWallCampaign');
};


// ------- POKKT VIDEO OPERATIONS -------

PokktExtension.prototype.getVideo = function (screenName) {
    this.setScreenName(screenName);
    this.setIncentivised(true);
    notifyNative('getVideo');
};

PokktExtension.prototype.getVideoNonIncent = function (screenName) {
    this.setScreenName(screenName);
    this.setIncentivised(false);
    notifyNative('getVideo');
};

PokktExtension.prototype.cacheVideoCampaign = function () {
    notifyNative('cacheVideoCampaign');
};


// ------- POKKT CONFIG STATES -------

PokktExtension.prototype.setSecurityKey = function (securityKey) {
    pokktConfig.securityKey = securityKey;
    savePokktConfig();
};

PokktExtension.prototype.setApplicationId = function (applicationId) {
    pokktConfig.applicationId = applicationId;
    savePokktConfig();
};

PokktExtension.prototype.setIntegrationType = function (integrationType) {
    pokktConfig.integrationType = integrationType;
    savePokktConfig();
};

PokktExtension.prototype.setAutoCaching = function (autoCaching) {
    pokktConfig.autoCaching = autoCaching;
    savePokktConfig();
};


PokktExtension.prototype.setOfferwallAssetValue = function (assetValue) {
    pokktConfig.offerwallAssetValue = assetValue;
    savePokktConfig();
};

PokktExtension.prototype.setScreenName = function (screenName) {
    pokktConfig.screenName = screenName;
    savePokktConfig();
};

PokktExtension.prototype.setIncentivised = function (incentivised) {
    pokktConfig.incentivised = incentivised;
    savePokktConfig();
};


PokktExtension.prototype.setThirdPartyUserId = function (id) {
    pokktConfig.thirdPartyUserId = id;
    savePokktConfig();
};

PokktExtension.prototype.setCloseOnSuccessFlag = function (flag) {
    pokktConfig.closeOnSuccessFlag = flag;
    savePokktConfig();
};

PokktExtension.prototype.setSkipEnabled = function (value) {
    pokktConfig.skipEnabled = value;
    savePokktConfig();
};

PokktExtension.prototype.setDefaultSkipTime = function (value) {
    pokktConfig.defaultSkipTime = value;
    savePokktConfig();
};

PokktExtension.prototype.setCustomSkipMessage = function (message) {
    pokktConfig.customSkipMessage = message;
    savePokktConfig();
};

PokktExtension.prototype.setBackButtonDisabled = function (value) {
    pokktConfig.backButtonDisabled = value;
    savePokktConfig();
};


PokktExtension.prototype.setName = function (name) {
    pokktConfig.name = name;
    savePokktConfig();
};

PokktExtension.prototype.setAge = function (age) {
    pokktConfig.age = age;
    savePokktConfig();
};

PokktExtension.prototype.setSex = function (sex) {
    pokktConfig.sex = sex;
    savePokktConfig();
};

PokktExtension.prototype.setMobileNo = function (mobileNo) {
    pokktConfig.mobileNo = mobileNo;
    savePokktConfig();
};

PokktExtension.prototype.setEmailAddress = function (email) {
    pokktConfig.emailAddress = email;
    savePokktConfig();
};

PokktExtension.prototype.setLocation = function (location) {
    pokktConfig.location = location;
    savePokktConfig();
};

PokktExtension.prototype.setBirthday = function (birthday) {
    pokktConfig.birthday = birthday;
    savePokktConfig();
};

PokktExtension.prototype.setMaritalStatus = function (maritalStatus) {
    pokktConfig.maritalStatus = maritalStatus;
    savePokktConfig();
};

PokktExtension.prototype.setFacebookId = function (fbId) {
    pokktConfig.facebookId = fbId;
    savePokktConfig();
};

PokktExtension.prototype.setTwitterHandle = function (handle) {
    pokktConfig.twitterHandle = handle;
    savePokktConfig();
};

PokktExtension.prototype.setEducation = function (education) {
    pokktConfig.education = education;
    savePokktConfig();
};

PokktExtension.prototype.setNationality = function (nationality) {
    pokktConfig.nationality = nationality;
    savePokktConfig();
};

PokktExtension.prototype.setEmployment = function (employment) {
    pokktConfig.employment = employment;
    savePokktConfig();
};

PokktExtension.prototype.setMaturityRating = function (rating) {
    pokktConfig.maturityRating = rating;
    savePokktConfig();
};

// ------------------------------

PokktExtension.prototype.getAutoCaching = function () {
    return pokktConfig.autoCaching;
};


// ------------------------------

/*
 IntegrationType:
     OfferwallAndVideo - 0
     OfferwallOnly - 1
     VideoOnly - 2
 */

var pokktConfig;

function createPokktConfig() {
    pokktConfig = {
        securityKey: '',
        applicationId: '',
        integrationType: 0,
        autoCaching: false,

        screenName: 'default',
        offerwallAssetValue: 0,
        incentivised: true,

        thirdPartyUserId: '',
        closeOnSuccessFlag: true,
        skipEnabled: true,
        defaultSkipTime: 10,
        customSkipMessage: '',
        backButtonDisabled: false,

        name: '',
        age: '',
        sex: '',
        mobileNo: '',
        emailAddress: '',
        location: '',
        birthday: '',
        maritalStatus: '',
        facebookId: '',
        twitterHandle: '',
        education: '',
        nationality: '',
        employment: '',
        maturityRating: ''
    };

    savePokktConfig();
}

function savePokktConfig() {
    if (pokktConfig == undefined || pokktConfig== null)
        return;

    localStorage.pokktConfig = JSON.stringify(pokktConfig);
}

function readPokktConfig() {
    if (localStorage.pokktConfig == undefined || localStorage.pokktConfig == null)
        createPokktConfig();

    pokktConfig = JSON.parse(localStorage.pokktConfig);
}


// ------- NATIVE NOTIFIERS -------

function notifyNative(operation, successCallback, optionalParam) {
    if (successCallback == null || successCallback == undefined) {
        successCallback = function (result) {
            console.log(operation + ' was successful! result: ' + result);
        };
    }

    var errorCallback = function(error) {
        console.log(operation + ' failed! error: ' + error);
    };

    console.log('executing operation: ' + operation + ' ...');
    if (optionalParam == undefined || optionalParam == null)
        cordova.exec(successCallback, errorCallback, 'PokktNativeExtension', operation, [pokktConfig]);
    else
        cordova.exec(successCallback, errorCallback, 'PokktNativeExtension', operation, [{ param:optionalParam }]);
}


// ------------------------------

if (!window.plugins) {
    window.plugins = {};
}

if (!window.plugins.pokktExtension) {
    window.plugins.pokktExtension = new PokktExtension();
}

if (typeof module != 'undefined' && module.exports) {
    module.exports = PokktExtension;
}
// ------------------------------
