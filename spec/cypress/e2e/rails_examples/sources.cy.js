describe('Sources', function() {
  beforeEach(() => {
    cy.app('clean')
  })

  it('happy path', function() {
    cy.appScenario('sources')

    cy.login({ email: 'john.doe@example.com' })
    cy.visit('/sources')
    cy.get('[data-test-id="repository"]').should('be.visible')

    cy.contains('Pull commits').should('be.visible')
    cy.get('[data-test-id="pull_commits"]').click()
    cy.get('[data-test-id="confirm_pull"]').click()
    cy.contains('Stop tracking').should('be.visible')

    cy.get('[data-test-id="stop_tracking"]').click()
    cy.get('[data-test-id="confirm_stop"]').click()
    cy.contains('Pull commits').should('be.visible')
  })

  it('unhappy path', function() {
    cy.appFactories([['create', 'user']]).then(users => {
      const user = users[0]

      cy.login({ email: user.email })
      cy.visit('/sources')
      cy.get('[data-test-id="intro"]').should('be.visible')
    })
  })
})
