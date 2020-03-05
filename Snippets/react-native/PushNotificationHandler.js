const FCM = require('fcm-node');
const {Expo} = require('expo-server-sdk');
const config = global.config;
const logger = global.logger;

const CONFIG_FILE_PATH = config.googleCloud.filePath;
const fcm = new FCM(CONFIG_FILE_PATH);

const expo = new Expo();

//en ese escenario ya deberia haberse validado si el user tiene las notificaciones push activas
async function sendMessage(message, title, metadata, pushTokens){
    logger.debug(`Sending notification with message ${message} and title ${title} to ${pushTokens.length} deviceTokens ${pushTokens}`);
    let validatedMessages = [];
    for(let pushToken of pushTokens){
        // Check that all your push tokens appear to be valid Expo push tokens
        if (!Expo.isExpoPushToken(pushToken)) {
            logger.error(`Push token ${pushToken} is not a valid Expo push token`);
            continue;
        }
        // Construct a message (see https://docs.expo.io/versions/latest/guides/push-notifications.html)
        validatedMessages.push({
            to: pushToken,
            sound: 'default',
            title : title,
            body: message,
            data: metadata,
        })
    }

    if(validatedMessages){
        let chunks = expo.chunkPushNotifications(validatedMessages);
        let tickets = [];

        for (let chunk of chunks) {
            try {
                let ticketChunk = await expo.sendPushNotificationsAsync(chunk);
                logger.debug(ticketChunk);
                tickets.push(...ticketChunk);
                // NOTE: If a ticket contains an error code in ticket.details.error, you
                // must handle it appropriately. The error codes are listed in the Expo
                // documentation:
                // https://docs.expo.io/versions/latest/guides/push-notifications#response-format
            } catch (error) {
                logger.error(`Error while trying to send push notification ${error.message}`);
            }
        }


        let receiptIds = [];
        for (let ticket of tickets) {
            // NOTE: Not all tickets have IDs; for example, tickets for notifications
            // that could not be enqueued will have error information and no receipt ID.
            if (ticket.id) {
                receiptIds.push(ticket.id);
            }
        }

        let receiptIdChunks = expo.chunkPushNotificationReceiptIds(receiptIds);

        // Like sending notifications, there are different strategies you could use
        // to retrieve batches of receipts from the Expo service.
        for (let chunk of receiptIdChunks) {
            try {
                let receipts = await expo.getPushNotificationReceiptsAsync(chunk);
                logger.debug(receipts);

                // The receipts specify whether Apple or Google successfully received the
                // notification and information about an error, if one occurred.
                if(Array.isArray(receipts)){
                    for (let receipt of receipts) {
                        checkReceipt(receipt);
                    }
                }
                else{
                    checkReceipt(receipts);
                }
            } catch (error) {
                logger.error(error);
            }
        }

    }
}

function checkReceipt(receipt){
    for(let ticketId in receipt){
        if (receipt[ticketId].status === 'ok') {
            logger.debug(`Notification ${ticketId} sent successfully`);
        } else if (receipt[ticketId].status === 'error') {
            logger.error(`There was an error sending a notification: ${receipt[ticketId].message}`);
            if (receipt[ticketId].details && receipt[ticketId].details.error) {
                // The error codes are listed in the Expo documentation:
                // https://docs.expo.io/versions/latest/guides/push-notifications#response-format
                // You must handle the errors appropriately.
                logger.error(`The error code is ${receipt[ticketId].details.error}`);
            }
        }
    }
}
/*function sendMessage(message){
    logger.debug(`Sending notification message to ${message.to}`);
    return new Promise((resolve, reject) => {
       fcm.send(message, (error, response) => {
          if(error){
              logger.error(`Failed to send notification message: ${error.message}`);
              reject(error);
          }
          else{
              logger.debug('Successfully sent push message');
              resolve(response);
          }
       });
    });
}*/

module.exports = {sendMessage};
