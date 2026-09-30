# language: pt
@security
Feature: Proteção anti-bot

  Scenario: Requisição legítima com validação válida
    Given que o captcha está habilitado no ambiente de teste
    When obtenho uma validação válida do provedor
    And submeto a operação
    Then a operação deve ser permitida

  Scenario: Token ausente
    When submeto a operação sem token de captcha
    Then a operação deve ser recusada

  Scenario: Token inválido
    When submeto um token inválido
    Then a operação deve ser recusada

  Scenario: Token expirado
    Given que possuo um token expirado
    When submeto a operação
    Then a operação deve ser recusada

  Scenario: Reutilização de token
    Given que um token já foi utilizado
    When tento reutilizá-lo
    Then a operação deve ser recusada
