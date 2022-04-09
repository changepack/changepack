describe('Accounts', function() {
  beforeEach(() => {
    cy.app('clean')
  })

  it('happy path', function() {
    cy.appFactories([['create', 'changelog', { title: 'A publicly available changelog' }]]).then(results => {
      const changelog = results[0]

      cy.visit(`/${changelog.account_id}`)

      cy.contains('A publicly available changelog').should('be.visible')
      cy.get('[data-test-id="edit"]').should('not.exist')
      cy.get('[data-test-id="delete"]').should('not.exist')

      cy.get('[data-test-id="show"]').click()
      cy.location('pathname').should('eq', `/changelogs/${changelog.id}`)
      cy.get('[data-test-id="edit"]').should('not.exist')
      cy.get('[data-test-id="delete"]').should('not.exist')
    })
  })
})
