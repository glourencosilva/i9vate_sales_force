enum DomainError {
  unespected,
  invalidCredentials,
}

extension DomainErrorExtension on DomainError {
  String get description {
    switch (this) {
      case DomainError.invalidCredentials:
        return 'Credenciais inválidas.';
        break;
      case DomainError.unespected:
        return 'Erro inesperado. Algo deu errado. Tente novamente em breve.';
        break;
      default:
        return 'Error';
    }
  }
}
