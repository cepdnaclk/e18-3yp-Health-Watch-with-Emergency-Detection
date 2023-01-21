const pushNotificationController = require("../controllers/push-notification.controllers");

const express = require("express");
const router = express.Router();

router.get("/SendNotificationPulseHigh",pushNotificationController.SendNotificationPulseHigh);
router.get("/SendNotificationPulseLow",pushNotificationController.SendNotificationPulseLow);
router.get("/SendNotificationTemp",pushNotificationController.SendNotificationTemp);
router.get("/SendNotificationOxy",pushNotificationController.SendNotificationOxy);
// router.get("/SendNotification",pushNotificationController.SendNotification);

router.post("/SendNotificationToDevice", pushNotificationController.SendNotificationToDevice);


module.exports = router;