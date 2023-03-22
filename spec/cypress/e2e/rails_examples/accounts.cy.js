describe('Accounts', function() {
  beforeEach(() => {
    cy.app('clean')
    cy.appScenario('accounts')
  })

  it('happy path', function() {
    cy.visit('/acc_test')

    cy.contains('Published').should('be.visible')
    cy.contains('Draft').should('have.length', 0)
    cy.get('[data-test-id="edit_post"]').should('not.exist')
    cy.get('[data-test-id="destroy_post"]').should('not.exist')

    cy.get('[data-test-id="post_button"]').click()
    cy.get('[data-test-id="account"]').should('not.exist')
    cy.contains('Published').should('be.visible')
    cy.get('[data-test-id="edit_post"]').should('not.exist')
    cy.get('[data-test-id="destroy_post"]').should('not.exist')
  })
})
