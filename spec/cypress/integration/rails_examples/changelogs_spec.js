describe('Changelogs', function() {
  beforeEach(() => {
    cy.app('clean')
    cy.appFactories([['create', 'changelog', { title: 'A changelog from another account' }]])
    cy.appFactories([['create', 'user']]).then((records) => {
      cy.login({ email: records[0].email })
    })
  })

  it('happy path', function() {
    cy.visit('/')
    cy.get('[data-test-id="changelog"]').should('not.exist')

    cy.get('[data-test-id="new_changelog_button"]').click()
    cy.get('[data-test-id="new_changelog_page"]').should('have.length.gt', 0)
    cy.get('[data-test-id="title"]').type('Testing Changepack')
    cy.get('[data-test-id="content"]').type('We added Cypress to Changepack.')
    cy.get('[data-test-id="submit"]').click()
    cy.get('[data-test-id="changelog_page"]').should('have.length.gt', 0)
    cy.contains('Testing Changepack').should('be.visible')
    cy.contains('Draft').should('be.visible')

    cy.get('[data-test-id="edit_changelog"]').click()
    cy.get('[data-test-id="content"]').clear().type('We added Cypress to Changepack to make the app more testable.')
    cy.get('[data-test-id="toggle"]').click()
    cy.get('[data-test-id="submit"]').click()
    cy.get('[data-test-id="changelog_page"]').should('have.length.gt', 0)
    cy.contains('We added Cypress to Changepack to make the app more testable.').should('be.visible')
    cy.contains('Draft').should('have.length', 0)

    cy.get('[data-test-id="destroy_changelog"]').click()
    cy.get('[data-test-id="confirm_destroy"]').click()
    cy.get('[data-test-id="account_changelogs"]').should('have.length.gt', 0)
    cy.get('[data-test-id="changelog"]').should('have.length', 0)
  })
})
