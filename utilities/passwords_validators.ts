export const emailValidate = (email: string, reGex: RegExp = /^[^\s@]+@[^\s@]+\.[^\s@]+$/): boolean => {
  return reGex.test(email);
}

export const phoneNumberValidate = (phone: string, reGex: RegExp = /^\+?[1-9]\d{1,14}$/): boolean => {
  return reGex.test(phone);
}

export const strongPasswordValidate = (password: string, reGex: RegExp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/): boolean => {
  return reGex.test(password);
};