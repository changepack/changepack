describe('Changelogs', function() {
  beforeEach(() => {
    cy.app('clean')
  })

  it('happy path', function() {
    cy.visit(`/`)

    cy.get('[data-test-id="new"]').click()
    cy.get('[data-test-id="new_page"]').should('have.length.gt', 0)
    cy.get('[data-test-id="title"]').type('Testing Changepack')
    cy.get('[data-test-id="content"]').type('We added Cypress to Changepack.')
    cy.get('[data-test-id="submit"]').click()
    cy.get('[data-test-id="show_page"]').should('have.length.gt', 0)
    cy.contains('Testing Changepack').should('be.visible')

    cy.get('[data-test-id="edit"]').click()
    cy.get('[data-test-id="content"]').clear().type('We added Cypress to Changepack to make the app more testable.')
    cy.get('[data-test-id="submit"]').click()
    cy.get('[data-test-id="show_page"]').should('have.length.gt', 0)
    cy.contains('We added Cypress to Changepack to make the app more testable.').should('be.visible')

    cy.get('[data-test-id="destroy"]').click()
    cy.get('[data-test-id="index_page"]').should('have.length.gt', 0)
    cy.get('[data-testid=changelog]').should('have.length', 0)
  })
})