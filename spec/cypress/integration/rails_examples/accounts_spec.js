describe('Accounts', function() {
  beforeEach(() => {
    cy.app('clean')
    cy.appScenario('accounts')
  })

  it('happy path', function() {
    cy.visit('/acc_test')

    cy.contains('Published').should('be.visible')
    cy.contains('Draft').should('have.length', 0)
    cy.get('[data-test-id="edit"]').should('not.exist')
    cy.get('[data-test-id="delete"]').should('not.exist')

    cy.get('[data-test-id="show"]').click()
    cy.location('pathname').should('eq', `/changelogs/log_published`)
    cy.get('[data-test-id="edit"]').should('not.exist')
    cy.get('[data-test-id="delete"]').should('not.exist')
  })
})
