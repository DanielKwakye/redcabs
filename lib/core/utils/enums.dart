enum Appearance {
  primary, secondary, clean, error, success, dark
}

enum Position {
  top, bottom
}

enum AppButtonType {
  primary, secondary
}

enum AccountType {
  driver, student, unknown
}

enum ImagePickerFileType {
  image, document
}

enum ScreenType {
  long, medium, small
}

enum ContactAdminChannels {
  viaEmail, viaPhone, viaChat
}

enum LayoutSize {
  matchParent, wrapContent, standard
}

enum LayoutWidth {
  wrap, expand
}

enum AnimateType {
  slideLeft, slideUp
}

enum VideoType {
  asset, network, file
}

enum PhotoVideoType {
  photo, video
}

enum BlocStatus {
  initial, loading, optimisticLoading, error, info, success,alreadyLoggedIn, alreadyLoggedOut,logIn,emailNotVerified,
  emailVerified,emailNotSent,emailSent,loginProgress, loginSuccessful, loginFailed,logOutUser,logOutInProgress,checkDriverExistProgress,
  checkDriverExistSuccess,checkDriverExistFailure,verificationInProgress,verificationSuccess,verificationError, resendVerificationInProgress,resendVerificationSuccess,resendVerificationError ,registrationInProgress, registrationSuccess,registrationFailure,
  setNetworkIpInProgress, setNetworkIpSuccessful, setNetworkIpFailed, sendMessageSuccessful, sendMessageInProgress, sendMessageFailed,
  fetchMessagesSuccessful, fetchMessagesInProgress, fetchMessagesFailed,otpVerificationInSuccessful,otpVerificationInProgress,otpVerificationInError,
  loadingDeviceIdSuccessful, loadingDeviceIdInProgress, loadingDeviceIdFailed, updatingMessagesInProgress, updatingMessagesSuccessful,
  chatMessagesLoaded, chatMessagesLoadInProgress,

  fetchNotificationsInProgress, fetchNotificationsError, fetchNotificationsSuccess,
  fetchNotificationsCountInProgress, fetchNotificationsCountError, fetchNotificationsCountSuccess,
  markNotificationsAsReadInProgress, markNotificationsAsReadError, markNotificationsAsReadSuccess,
  checkingDossierInProgress, checkingDossierError, checkingDossierSuccessful,
  setDriverPasswordInProgress, setDriverPasswordError, setDriverPasswordSuccessful

}

enum SearchUI {
  historySearch, topSearch, categorySearch
}

enum SharedErrorType {
  empty, error
}

enum Gender {
  any, male, female
}

enum LikeActionType {
  like, unlike
}

enum FilterType {
  stories, hookups
}


enum Features {
  stories, filters,
}

enum ChatType{
  receipt, support
}

