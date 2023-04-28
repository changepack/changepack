describe('Posts', function() {
  beforeEach(() => {
    cy.app('clean')
  })

  it('happy path', function() {
    cy.appFactories([['create', 'post', { title: 'A post from another account' }]])
    cy.appFactories([['create', 'user']]).then((records) => {
      const user = records[0]
      cy.appFactories([['create', 'repository', { account_id: user.account_id }]]).then((records) => {
        const repository = records[0]
        cy.appFactories([['create', 'commit', { account_id: user.account_id, repository_id: repository.id }]]).then((records) => {
          const commit = records[0]

          cy.login({ email: user.email })
          cy.visit('/')
          cy.get('[data-test-id="post"]').should('not.exist')

          cy.get('[data-test-id="new_post_button"]').click()
          cy.get('[data-test-id="new_post_page"]').should('have.length.gt', 0)
          cy.get('[data-test-id="title"]').type('Testing Changepack')
          cy.get('[data-test-id="content"]').type('We added Cypress to Changepack.')
          cy.get(`[id="${commit.id}"]`).click()
          cy.get('[data-test-id="submit"]').click()
          cy.get('[data-test-id="post_page"]').should('have.length.gt', 0)
          cy.contains('Testing Changepack').should('be.visible')
          cy.contains('Draft').should('be.visible')

          cy.get('[data-test-id="edit_post"]').click()
          cy.get('[data-test-id="content"]').clear().type('We added Cypress to Changepack to make the app more testable.')
          cy.get('[data-test-id="toggle"]').click()
          cy.get('[data-test-id="submit"]').click()
          cy.get('[data-test-id="post_page"]').should('have.length.gt', 0)
          cy.contains('We added Cypress to Changepack to make the app more testable.').should('be.visible')
          cy.contains('Draft').should('have.length', 0)

          cy.get('[data-test-id="destroy_post"]').click()
          cy.get('[data-test-id="confirm_destroy"]').click()
          cy.get('[data-test-id="account"]').should('have.length.gt', 0)
          cy.get('[data-test-id="post"]').should('have.length', 0)
        })
      })
    })
  })
})
