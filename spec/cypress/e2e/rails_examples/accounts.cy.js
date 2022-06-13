describe('Accounts', function() {
  beforeEach(() => {
    cy.app('clean')
    cy.appScenario('accounts')
  })

  it('happy path', function() {
    cy.visit('/acc_test')

    cy.contains('Published').should('be.visible')
    cy.contains('Draft').should('have.length', 0)
    cy.get('[data-test-id="edit_changelog"]').should('not.exist')
    cy.get('[data-test-id="destroy_changelog"]').should('not.exist')

    cy.get('[data-test-id="changelog_button"]').click()
    cy.get('[data-test-id="changelog_page"]').should('have.length.gt', 0)
    cy.contains('Published').should('be.visible')
    cy.get('[data-test-id="edit_changelog"]').should('not.exist')
    cy.get('[data-test-id="destroy_changelog"]').should('not.exist')
  })
})
