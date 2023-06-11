describe('Changelogs', function() {
  beforeEach(() => {
    cy.app('clean')
    cy.appScenario('changelogs')
  })

  it('happy path', function() {
    cy.login({ email: 'john.doe@example.com' })
    cy.visit('/changelogs')
    cy.get('[data-test-id="changelog"]').should('be.visible')
  })
})
