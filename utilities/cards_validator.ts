export const creditCardNumberValidate = (
  cardNumber: string,
  reGex: RegExp | string = '',
): boolean => {
  // Regular expression patterns for common credit card formats
  let CARD_FORMATS: {[key: string]: RegExp} = {
    Visa: /^4[0-9]{12}(?:[0-9]{3})?$/,
    MasterCard: /^5[1-5][0-9]{14}$/,
    AmericanExpress: /^3[47][0-9]{13}$/,
    Discover: /^6(?:011|5[0-9]{2})[0-9]{12}$/,
    JCB: /^(?:2131|1800|35\d{3})\d{11}$/,
    DinersClub: /^3(?:0[0-5]|[68][0-9])[0-9]{11}$/,
    Maestro: /^(5018|5020|5038|6304|6759|6761|6762|6763)\d{8,15}$/,
    UnionPay: /^(62|88)[0-9]{14,17}$/,
    VisaElectron: /^(4026|417500|4508|4844|491(3|7))\d{10}$/,
    RuPay: /^6(?:0|5\d{2})\d{12}$/,
    // Add more as needed
  };

  // Convert reGex string to RegExp object if needed
  if (typeof reGex === 'string' && reGex.trim() !== '') {
    reGex = new RegExp(reGex);
  }

  // Add custom regex to CARD_FORMATS if provided
  if (reGex instanceof RegExp) {
    CARD_FORMATS['Others'] = reGex;
  }

  const formattedCardNumber = cardNumber.replace(/\s+/g, '').replace(/-/g, '');

  // Check if the card number matches any of the predefined formats
  const isValidFormat = Object.values(CARD_FORMATS).some(regex =>
    regex.test(formattedCardNumber),
  );

  return isValidFormat;
};

export const cvvValidate = (cvv: string, cardType: string): boolean => {
  const cvvLengths: any = {
    Visa: 3,
    MasterCard: 3,
    AmericanExpress: 4,
    Discover: 3,
    JCB: 3,
    DinersClub: 3,
    Maestro: 3, // Maestro CVV length can vary; typically 3 digits
    UnionPay: 3, // UnionPay CVV length can vary; typically 3 digits
    VisaElectron: 3, // Visa Electron CVV length can vary; typically 3 digits
    RuPay: 3, // RuPay CVV length can vary; typically 3 digits
    // Add more card types and their respective CVV lengths as needed
  };
  // Check if card type is supported
  if (!cvvLengths.hasOwnProperty(cardType)) {
    throw new Error(`Unsupported card type: ${cardType}`);
  }

  const expectedLength = cvvLengths[cardType];
  const trimmedCVV = cvv.trim();

  // Validate CVV length and digits
  if (trimmedCVV.length !== expectedLength || !/^\d+$/.test(trimmedCVV)) {
    return false;
  }

  return true;
};

export const getcardType = (cardNumber: string): string => {
  // Remove non-digit characters from the card number
  const cleanedCardNumber = cardNumber.replace(/\D/g, '');

  // Define regex patterns for each card type
  const cardPatterns: any = {
    Visa: /^4/,
    MasterCard: /^5[1-5]/,
    AmericanExpress: /^3[47]/,
    DinersClub: /^3(?:0[0-5]|[68][0-9])/,
    Discover: /^6(?:011|5[0-9]{2})/,
    JCB: /^(?:2131|1800|35\d{3})/,
    Maestro: /^(5018|5020|5038|6304|6759|676[1-3])/,
    UnionPay: /^(62|88)/,
    VisaElectron: /^(4026|417500|4508|4844|491(3|7))/,
    RuPay: /^(508[5-9]|6069|607|608[0-5])/,
    // Add more card types and their patterns as needed
  };

  // Check the card number against each pattern
  for (const cardType in cardPatterns) {
    if (cardPatterns[cardType].test(cleanedCardNumber)) {
      return cardType;
    }
  }

  return 'Unknown'; // Default to 'Unknown' if no card type matches
};
