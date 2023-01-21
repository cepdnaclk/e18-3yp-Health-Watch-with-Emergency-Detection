const {ONE_SIGNAL_CONFIG} = require("../config/app.config");
const pushNotificationService = require("../services/push-notification.services");

exports.SendNotificationPulseLow = (req, res, next) => {
    var message = {
        app_id: ONE_SIGNAL_CONFIG.APP_ID,
        contents: {en: "Medicare: Low heart rate"},
        included_segments: ["All"],
        content_available: true,
        small_icon: "ic_notification_icon",
        data:{
            PushTitle: "CUSTOM NOTIFICATION",
        },
    };

    pushNotificationService.SendNotification(message,(error, results) =>{
        if(error){
            return next(error);
        }
        return res.status(200).send({
            message: "Success",
            data: results,
        });
    });

};

exports.SendNotificationPulseHigh = (req, res, next) => {
    var message = {
        app_id: ONE_SIGNAL_CONFIG.APP_ID,
        contents: {en: "Medicare: High heart rate"},
        included_segments: ["All"],
        content_available: true,
        small_icon: "ic_notification_icon",
        data:{
            PushTitle: "CUSTOM NOTIFICATION",
        },
    };

    pushNotificationService.SendNotification(message,(error, results) =>{
        if(error){
            return next(error);
        }
        return res.status(200).send({
            message: "Success",
            data: results,
        });
    });

};

exports.SendNotificationTemp = (req, res, next) => {
    var message = {
        app_id: ONE_SIGNAL_CONFIG.APP_ID,
        contents: {en: "Medicare: High Temperature"},
        included_segments: ["All"],
        content_available: true,
        small_icon: "ic_notification_icon",
        data:{
            PushTitle: "CUSTOM NOTIFICATION",
        },
    };

    pushNotificationService.SendNotification(message,(error, results) =>{
        if(error){
            return next(error);
        }
        return res.status(200).send({
            message: "Success",
            data: results,
        });
    });

};

exports.SendNotificationOxy = (req, res, next) => {
    var message = {
        app_id: ONE_SIGNAL_CONFIG.APP_ID,
        contents: {en: "Medicare: Low Oxygen level"},
        included_segments: ["All"],
        content_available: true,
        small_icon: "ic_notification_icon",
        data:{
            PushTitle: "CUSTOM NOTIFICATION",
        },
    };

    pushNotificationService.SendNotification(message,(error, results) =>{
        if(error){
            return next(error);
        }
        return res.status(200).send({
            message: "Success",
            data: results,
        });
    });

};

exports.SendNotificationToDevice = (req, res, next) => {
    var message = {
        app_id: ONE_SIGNAL_CONFIG.APP_ID,
        contents: {en: "Medicare: Abnormal heart rate detected"},
        included_segments: ["included_player_id"],
        included_payer_ids: req.body.devices,
        content_available: true,
        small_icon: "ic_notification_icon",
        data:{
            PushTitle: "CUSTOM NOTIFICATION",
        },
    };

    pushNotificationService.SendNotification(message,(error, results) =>{
        if(error){
            return next(error);
        }
        return res.status(200).send({
            message: "Success",
            data: results,
        });
    });

};