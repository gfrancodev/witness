# language: pt
@checkout
Feature: Pagamento no checkout

  O cliente na tela Checkout confirma o pagamento e vê o pedido confirmado.
  Cada clique observado é um When próprio, na mesma ordem do fluxo.

  Background:
    Given estou na página "Checkout" em "/checkout"
    And vejo o formulário "Pagamento"

  @critical @smoke @desktop
  Scenario: Cliente confirma o pagamento no desktop
    When clico no botão "Confirmar pagamento"
    # intent: confirm_payment
    # surface: desktop
    # flow: checkout
    # step: 1
    Then vejo a confirmação do pedido
    And vejo o texto "Pedido confirmado"
