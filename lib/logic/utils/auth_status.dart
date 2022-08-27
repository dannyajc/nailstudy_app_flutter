import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  unknown,
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case AuthStatus.invalidEmail:
        errorMessage = "U heeft een niet valide email ingevoerd.";
        break;
      case AuthStatus.weakPassword:
        errorMessage = "Je wachtwoord moet op zijn minst 6 karaters bevatten.";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "Je email of wachtwoord is fout.";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage =
            "Dit emailadres wordt al gebruikt door een ander account.";
        break;
      default:
        errorMessage = "Er is een fout opgetreden. Probeer het later opnieuw.";
    }
    return errorMessage;
  }
}
